<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }
        h1 {
            color: green;
        }
        ul {
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <h1>✅Order Confirmed</h1>

    <%
        Integer orderId = (Integer) request.getAttribute("orderId");
        String totalAmount = (String) request.getAttribute("totalAmount");
        java.util.List<?> itemsList = (java.util.List<?>) request.getAttribute("itemsList");
    %>


    <h3>Order Items:</h3>
    <hr>


        <%
    if (itemsList != null) {
        for (Object obj : itemsList) {
            java.util.Map item = (java.util.Map) obj;
%>
            <div style="margin-bottom:15px;">
                <p><strong>Product Name:</strong> <%= item.get("product_name") %></p>
                <p><strong>Quantity:</strong> <%= item.get("quantity") %></p>
                <p><strong>Price:</strong> <%= item.get("price") %></p>
                <hr>
            </div>
<%
        }
    } else {
%>
        <p>No items found</p>
<%
    }
%>


    <p><strong>Total Amount:</strong> <%= totalAmount %></p>

</body>
</html>
