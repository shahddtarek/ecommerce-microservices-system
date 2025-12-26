<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>

<html>
<head>
    <title>Checkout</title>
    <style>
        table { border-collapse: collapse; width: 70%; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #eee; }
    </style>
</head>
<body>

<h2>Checkout</h2>

<%
    String pricingJson = (String) request.getAttribute("pricingResult");
    JSONArray products = (JSONArray) request.getAttribute("products");
    String customerId = (String) request.getAttribute("customer_id");

    JSONObject pricing = new JSONObject(pricingJson);
    JSONArray items = pricing.getJSONArray("items");
    double totalAmount = pricing.getDouble("total_amount");
%>

<table>
<tr>
    <th>Product ID</th>
    <th>Quantity</th>
    <th>Unit Price</th>
    <th>Final Price</th>
</tr>

<%
for (int i = 0; i < items.length(); i++) {
    JSONObject item = items.getJSONObject(i);
%>
<tr>
    <td><%= item.getInt("product_id") %></td>
    <td><%= item.getInt("quantity") %></td>
    <td>$<%= item.getDouble("unit_price") %></td>
    <td>$<%= item.getDouble("final_price") %></td>
</tr>
<%
}
%>

</table>

<h3>Total Amount: $<%= totalAmount %></h3>

<form action="submitOrder" method="post">
    <input type="hidden" name="customer_id" value="<%= customerId %>">
    <input type="hidden" name="products" value='<%= products.toString() %>'>
    <input type="hidden" name="total_amount" value="<%= totalAmount %>">
    <input type="submit" value="submit Order">
</form>

<br>

<form action="products" method="get">
    <input type="submit" value="Cancel">
</form>

</body>
</html>
