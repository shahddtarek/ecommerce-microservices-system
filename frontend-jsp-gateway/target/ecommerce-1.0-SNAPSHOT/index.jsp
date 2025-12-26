<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>

<html>
<head>
    <title>Product Catalog</title>
    <style>
        table { border-collapse: collapse; width: 80%; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

<h1>Product Catalog</h1>

<a href="profile?customer_id=1">Profile</a> |
<a href="orders?customer_id=1">Orders History</a>

<br><br>

<%
    JSONArray products = (JSONArray) request.getAttribute("products");
    if (products == null) {
%>
    <p>No products available.</p>
<%
        return;
    }
%>

<form action="checkOrder" method="post">

<table>
<tr>
    <th>Select</th>
    <th>ID</th>
    <th>Name</th>
    <th>Available</th>
    <th>Price</th>
    <th>Quantity</th>
</tr>

<%
for (int i = 0; i < products.length(); i++) {
    JSONObject p = products.getJSONObject(i);

    int available = p.getInt("quantity_available");
    if (available > 0) {
%>
<tr>
    <td>
        <input type="checkbox" name="product_id"
               value="<%= p.getInt("product_id") %>">
    </td>
    <td><%= p.getInt("product_id") %></td>
    <td><%= p.getString("product_name") %></td>
    <td><%= available %></td>
    <td>$<%= p.getDouble("unit_price") %></td>
    <td>
        <input type="number"
               name="quantity_<%= p.getInt("product_id") %>"
               min="1"
               max="<%= available %>">
    </td>
</tr>
<%
    }
}
%>

</table>

<br>
<input type="hidden" name="customer_id" value="1">
<input type="submit" value="Make Order">

</form>

</body>
</html>
