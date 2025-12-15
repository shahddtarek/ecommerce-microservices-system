import java.net.http.*;
import java.net.URI;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/submitOrder")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {

        String customerId = request.getParameter("customer_id");
        String productId  = request.getParameter("product_id");
        String quantity   = request.getParameter("quantity");

        if (customerId == null || productId == null || quantity == null ||
            customerId.isEmpty() || productId.isEmpty() || quantity.isEmpty()) {

            request.setAttribute("error", "Missing input values");
            request.getRequestDispatcher("/confirmation.jsp")
                   .forward(request, response);
            return;
        }

        HttpClient client = HttpClient.newHttpClient();

        try {
            /* 1️⃣ Inventory Service */
            HttpRequest invReq = HttpRequest.newBuilder()
                .uri(URI.create(
                    "http://localhost:5002/api/inventory/check/" + productId))
                .GET()
                .build();

            HttpResponse<String> invRes =
                client.send(invReq, HttpResponse.BodyHandlers.ofString());

            /* 2️⃣ Pricing Service */
            String pricingPayload = String.format(
                "{\"products\":[{\"product_id\":%s,\"quantity\":%s}]}",
                productId, quantity
            );

            HttpRequest priceReq = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5003/api/pricing/calculate"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(pricingPayload))
                .build();

            HttpResponse<String> priceRes =
                client.send(priceReq, HttpResponse.BodyHandlers.ofString());

            /* 3️⃣ Order Service */
            String orderPayload = String.format(
                "{\"customer_id\":\"%s\",\"products\":[{\"product_id\":\"%s\",\"quantity\":%s}]}",
                customerId, productId, quantity
            );

            HttpRequest orderReq = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5001/api/orders/create"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(orderPayload))
                .build();

            HttpResponse<String> orderRes =
                client.send(orderReq, HttpResponse.BodyHandlers.ofString());

            /* 4️⃣ إرسال النتائج للـ JSP */
            request.setAttribute("inventory", invRes.body());
            request.setAttribute("pricing", priceRes.body());
            request.setAttribute("order", orderRes.body());

            request.getRequestDispatcher("/confirmation.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                e.getMessage()
            );
        }
    }
}
