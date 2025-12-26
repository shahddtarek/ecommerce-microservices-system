

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URI;
import java.net.http.*;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final HttpClient client = HttpClient.newHttpClient();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("customer_id"));

        HttpRequest profileRequest = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5004/api/customers/" + customerId))
                .GET()
                .build();

        HttpResponse<String> profileResponse;
        try {
            profileResponse = client.send(
                    profileRequest,
                    HttpResponse.BodyHandlers.ofString()
            );
        } catch (InterruptedException e) {
            throw new ServletException(e);
        }

        request.setAttribute("profileData", profileResponse.body());
        request.getRequestDispatcher("profile.jsp")
                .forward(request, response);
    }
}
