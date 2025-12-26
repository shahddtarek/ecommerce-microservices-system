import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.json.JSONObject;
import org.json.JSONArray;

import java.io.IOException;
import java.net.URI;
import java.net.http.*;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdParam = request.getParameter("customer_id");
        if (customerIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing customer_id");
            return;
        }

        HttpClient client = HttpClient.newHttpClient();

        /* =========================
           1️⃣ Get Full Order History
           The Python service now returns the list with items & names
        ========================= */
        HttpRequest customerRequest = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5004/api/customers/" + customerIdParam + "/orders"))
                .GET()
                .build();

        try {
            HttpResponse<String> customerResponse = client.send(
                    customerRequest, 
                    HttpResponse.BodyHandlers.ofString());

            if (customerResponse.statusCode() == 200) {
                // FIX: Parse the body as an OBJECT first
                JSONObject jsonResponse = new JSONObject(customerResponse.body());
                
                // Get the "orders" array from the object
                JSONArray ordersArray = jsonResponse.getJSONArray("orders");

                /* =========================
                   2️⃣ Sort (Newest → Oldest)
                ========================= */
                List<Object> list = ordersArray.toList();
                list.sort((o1, o2) -> {
                    JSONObject a = new JSONObject((java.util.Map<?, ?>) o1);
                    JSONObject b = new JSONObject((java.util.Map<?, ?>) o2);
                    return b.getString("created_at").compareTo(a.getString("created_at"));
                });

                /* =========================
                   3️⃣ Forward to JSP
                ========================= */
                request.setAttribute("orders", list);
                request.getRequestDispatcher("orders.jsp").forward(request, response);
                
            } else {
                response.sendError(customerResponse.statusCode(), "Customer Service Error");
            }

        } catch (InterruptedException e) {
            throw new ServletException(e);
        }
    }
}