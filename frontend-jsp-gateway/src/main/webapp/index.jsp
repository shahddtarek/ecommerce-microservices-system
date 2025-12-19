<%@ page import="java.net.http.*, java.net.URI" %>
<%@ page import="org.json.*" %>

<%
    String productsJson = "[]";

    try {
        HttpClient client = HttpClient.newHttpClient();

        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create("http://localhost:5002/api/inventory/all"))
                .GET()
                .build();

        HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());

        productsJson = httpResponse.body();

    } catch (Exception e) {
        out.println("Error fetching products: " + e.getMessage());
    }

    JSONArray products = new JSONArray(productsJson);
%>

<h1>Product Catalog</h1>
<table border="1">
<tr>
<th>Product ID</th>
<th>Name</th>
<th>Available</th>
<th>Price</th>
</tr>

<% for (int i = 0; i < products.length(); i++) {
        JSONObject p = products.getJSONObject(i); %>
<tr>
    <td><%= p.getInt("product_id") %></td>
    <td><%= p.getString("product_name") %></td>
    <td><%= p.getInt("quantity_available") %></td>
    <td>$<%= p.getDouble("unit_price") %></td>
</tr>
<% } %>
</table>
