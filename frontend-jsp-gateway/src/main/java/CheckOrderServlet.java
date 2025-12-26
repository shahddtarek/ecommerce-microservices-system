import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/checkOrder")
public class CheckOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerId = request.getParameter("customer_id");
        String[] productIds = request.getParameterValues("product_id");

        if (productIds == null || productIds.length == 0) {
            request.setAttribute("error", "No products selected!");
            response.sendRedirect("products");
            return;
        }

        HttpClient client = HttpClient.newHttpClient();
        JSONArray productsForPricing = new JSONArray();

        try {
            for (String pid : productIds) {
                String qtyStr = request.getParameter("quantity_" + pid);
                int quantity = Integer.parseInt(qtyStr);

                // 1️⃣ Check inventory
                HttpRequest invReq = HttpRequest.newBuilder()
                        .uri(URI.create("http://localhost:5002/api/inventory/check/" + pid))
                        .GET()
                        .build();

                HttpResponse<String> invRes =
                        client.send(invReq, HttpResponse.BodyHandlers.ofString());

                JSONObject inventory = new JSONObject(invRes.body());
                int available = inventory.getInt("quantity_available");

                if (quantity > available) {
                    request.setAttribute(
                        "error",
                        "Product " + pid + " does not have enough stock"
                    );
                    response.sendRedirect("products");
                    return;
                }

                // 2️⃣ Prepare pricing payload
                JSONObject item = new JSONObject();
                item.put("product_id", Integer.parseInt(pid));
                item.put("quantity", quantity);

                productsForPricing.put(item);
            }

            // 3️⃣ Call Pricing Service
            JSONObject pricingPayload = new JSONObject();
            pricingPayload.put("products", productsForPricing);

            HttpRequest pricingReq = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:5003/api/pricing/calculate"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(pricingPayload.toString()))
                    .build();

            HttpResponse<String> pricingRes =
                    client.send(pricingReq, HttpResponse.BodyHandlers.ofString());

            // 4️⃣ Forward to checkout.jsp
            request.setAttribute("pricingResult", pricingRes.body());
            request.setAttribute("products", productsForPricing);
            request.setAttribute("customer_id", customerId);

            request.getRequestDispatcher("checkout.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing order");
            response.sendRedirect("products");
        }
    }
}
