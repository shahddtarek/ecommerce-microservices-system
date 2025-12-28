<%@ page import="java.util.List,java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Orders History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            color: #2E8B57;
            margin-bottom: 25px;
        }
        .no-orders {
            text-align: center;
            color: #777;
            font-style: italic;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background-color: #2E8B57;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            vertical-align: top;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .items-container {
            max-height: 200px;
            overflow-y: auto;
            padding: 10px;
        }
        .item {
            padding: 8px 0;
            border-bottom: 1px dashed #eee;
        }
        .item:last-child {
            border-bottom: none;
        }
        .item b {
            color: #555;
        }
        a {
            display: block;
            text-align: center;
            margin-top: 25px;
            text-decoration: none;
            color: #2E8B57;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Orders History</h2>

    <%
        List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");
        
        if (orders == null || orders.isEmpty()) {
    %>
        <p class="no-orders">No orders found.</p>
    <%
        } else {
    %>

    <table>
        <thead>
            <tr>
                <th>Total Amount</th>
                <th>Items</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Map<String, Object> order : orders) {
            %>
            <tr>
                
                <td>$<%= order.get("total_amount") %></td>
                <td>
                    <div class="items-container">
                        <%
                            List<Map<String, Object>> items = (List<Map<String, Object>>) order.get("items");
                            if (items != null) {
                                for (Map<String, Object> item : items) {
                        %>
                        <div class="item">
                            <b>Product:</b> <%= item.get("product_name") %><br>
                            <b>Quantity:</b> <%= item.get("quantity") %><br>
                            <b>Price:</b> $<%= item.get("price") %><br>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
        }
    %>

    <a href="products?customer_id=${customerId}">Back to Products</a>
</div>
</body>
</html>