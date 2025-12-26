<%@ page import="java.util.List,java.util.Map" %>

<h2>Orders History</h2>

<%
List<Map<String, Object>> orders =
        (List<Map<String, Object>>) request.getAttribute("orders");

if (orders == null || orders.isEmpty()) {
%>
    <p>No orders found.</p>
<%
} else {
%>

<table border="1" cellpadding="8">
    <tr>
        <th>Order ID</th>
        <th>Total Amount</th>
        <th>Items</th>
    </tr>

<%
for (Map<String, Object> order : orders) {
%>
    <tr>
        <td><%= order.get("order_id") %></td>
        <td>$<%= order.get("total_amount") %></td>

        <td>
            <%
            List<Map<String, Object>> items =
                    (List<Map<String, Object>>) order.get("items");

            if (items != null) {
                for (Map<String, Object> item : items) {
            %>
                <b>Product:</b> <%= item.get("product_name") %><br>
                <b>Quantity:</b> <%= item.get("quantity") %><br>
                <b>Price:</b> $<%= item.get("price") %><br>
                <hr>
            <%
                }
            }
            %>
        </td>
    </tr>
<%
}
%>

</table>

<%
}
%>

<br>
<a href="products">Back to Products</a>
