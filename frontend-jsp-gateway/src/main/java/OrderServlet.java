import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Import a JSON library (e.g., org.json)
import org.json.JSONObject;
import org.json.JSONArray;

@WebServlet("/submitOrder")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerId = request.getParameter("customer_id");
        String productsJson = request.getParameter("products"); 
        String totalAmount = request.getParameter("total_amount");

        HttpClient client = HttpClient.newHttpClient();

        /* =========================
           1️⃣ Create Order
        ========================= */
        String orderPayload = String.format(
                "{\"customer_id\": %s, \"products\": %s, \"total_amount\": %s}",
                customerId, productsJson, totalAmount
        );

        HttpRequest orderRequest = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5001/api/orders/create"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(orderPayload))
                .build();

        int orderId = 0;
        List<Object> itemsList = null;

        try {
            HttpResponse<String> orderResponse = client.send(orderRequest, HttpResponse.BodyHandlers.ofString());
            
            if (orderResponse.statusCode() == 201) {
                // PARSING THE RESPONSE FROM PYTHON
                JSONObject jsonRes = new JSONObject(orderResponse.body());
                orderId = jsonRes.getInt("order_id");
                
                // Get the items list (with names) that Python fetched from DB
                JSONArray itemsArray = jsonRes.getJSONArray("items");
                itemsList = itemsArray.toList(); 
            } else {
                System.out.println("Order Service Error: " + orderResponse.body());
            }
        } catch (InterruptedException e) {
            throw new ServletException(e);
        }

        /* =========================
           2️⃣ Update Loyalty Points
        ========================= */
        int loyaltyPoints = (int) (Double.parseDouble(totalAmount) / 10);
        String loyaltyPayload = String.format("{\"points\": %d}", loyaltyPoints);

        HttpRequest loyaltyRequest = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5004/api/customers/" + customerId + "/loyalty"))
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(loyaltyPayload))
                .build();

        try {
            client.send(loyaltyRequest, HttpResponse.BodyHandlers.ofString());
        } catch (InterruptedException e) {
            // We log this but don't stop the order flow
            e.printStackTrace();
        }

        /* =========================
           3️⃣ Send Notification (Using real orderId)
        ========================= */
        String notificationPayload = String.format(
                "{\"order_id\": %d, \"customer_id\": %s}", orderId, customerId
        );

        HttpRequest notificationRequest = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5005/api/notifications/send"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(notificationPayload))
                .build();

        try {
            client.send(notificationRequest, HttpResponse.BodyHandlers.ofString());
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        /* =========================
           4️⃣ Forward to UI
        ========================= */
        // We pass the specific objects instead of the raw JSON string
        request.setAttribute("orderId", orderId);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("loyaltyPoints", loyaltyPoints);
        request.setAttribute("itemsList", itemsList); 

        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
    }
}