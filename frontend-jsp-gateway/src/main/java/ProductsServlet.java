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

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpClient client = HttpClient.newHttpClient();

            HttpRequest httpRequest = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:5002/api/inventory/all"))
                    .GET()
                    .build();

            HttpResponse<String> httpResponse =
                    client.send(httpRequest, HttpResponse.BodyHandlers.ofString());

            JSONArray products = new JSONArray(httpResponse.body());


            request.setAttribute("products", products);

            request.getRequestDispatcher("index.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load products");
            request.getRequestDispatcher("index.jsp")
                   .forward(request, response);
        }
    }
}
