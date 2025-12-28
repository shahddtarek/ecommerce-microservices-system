

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@WebServlet("/")
public class CustomersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpClient client = HttpClient.newHttpClient();

        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5004/api/customers"))
                .GET()
                .build();

        try {
            HttpResponse<String> res = client.send(req, HttpResponse.BodyHandlers.ofString());

                    // 1. Parse the response as a JSONObject because it starts with '{'
            JSONObject jsonResponse = new JSONObject(res.body());

            // 2. Get the specific array named "customers" from that object
            JSONArray customersArray = jsonResponse.getJSONArray("customers");

            // 3. Set the array as the attribute for your JSP
            request.setAttribute("customers", customersArray);

            request.getRequestDispatcher("select_customer.jsp").forward(request, response);

        } catch (InterruptedException e) {
            throw new ServletException(e);
        }
    }
}
