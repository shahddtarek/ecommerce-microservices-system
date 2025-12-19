import java.net.http.*;
import java.net.URI;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/submitOrder")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {

        String customerIdStr = request.getParameter("customer_id");
        String productIdStr  = request.getParameter("product_id");
        String quantityStr   = request.getParameter("quantity");


        if (customerIdStr == null || productIdStr == null || quantityStr == null ||
            customerIdStr.isEmpty() || productIdStr.isEmpty() || quantityStr.isEmpty()) {

            request.setAttribute("error", "Missing input values");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
            return;
        }

        int customerId, productId, quantity;
        try {
            customerId = Integer.parseInt(customerIdStr);
            productId  = Integer.parseInt(productIdStr);
            quantity   = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid numeric values");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
            return;
        }

        HttpClient client = HttpClient.newHttpClient();

        try {
            HttpRequest invReq = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:5002/api/inventory/check/" + productId))
                    .GET()
                    .build();
            HttpResponse<String> invRes = client.send(invReq, HttpResponse.BodyHandlers.ofString());

            JSONObject pricingPayload = new JSONObject();
            JSONArray productsArr = new JSONArray();
            JSONObject prodObj = new JSONObject();
            prodObj.put("product_id", productId);
            prodObj.put("quantity", quantity);
            productsArr.put(prodObj);
            pricingPayload.put("products", productsArr);

            HttpRequest priceReq = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:5003/api/pricing/calculate"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(pricingPayload.toString()))
                    .build();
            HttpResponse<String> priceRes = client.send(priceReq, HttpResponse.BodyHandlers.ofString());

            JSONObject orderPayload = new JSONObject();
            orderPayload.put("customer_id", customerId);
            orderPayload.put("products", productsArr);

            HttpRequest orderReq = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:5001/api/orders/create"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(orderPayload.toString()))
                    .build();
            HttpResponse<String> orderRes = client.send(orderReq, HttpResponse.BodyHandlers.ofString());

            request.setAttribute("inventory", invRes.body());
            request.setAttribute("pricing", priceRes.body());
            request.setAttribute("order", orderRes.body());

            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
        }
    }
}
