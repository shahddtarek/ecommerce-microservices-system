<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.Map, java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 700px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        .success-icon {
            text-align: center;
            font-size: 60px;
            color: #2E8B57;
            margin-bottom: 20px;
        }
        h1 {
            text-align: center;
            color: #2E8B57;
            margin-bottom: 25px;
        }
        .order-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border-left: 4px solid #2E8B57;
        }
        .order-info p {
            margin: 10px 0;
            font-size: 16px;
        }
        .order-info strong {
            color: #555;
            min-width: 120px;
            display: inline-block;
        }
        h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
        }
        .items-list {
            margin: 25px 0;
        }
        .item-card {
            background-color: #fff;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }
        .item-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-color: #2E8B57;
        }
        .item-card p {
            margin: 8px 0;
            display: flex;
            justify-content: space-between;
        }
        .item-label {
            font-weight: bold;
            color: #555;
            min-width: 120px;
        }
        .item-value {
            color: #333;
            text-align: right;
        }
        .price-value {
            color: #2E8B57;
            font-weight: bold;
        }
        .total-section {
            background-color: #f0f9f4;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
            text-align: center;
            border: 2px solid #2E8B57;
        }
        .total-label {
            font-size: 18px;
            color: #555;
            margin-bottom: 10px;
        }
        .total-amount {
            font-size: 28px;
            color: #2E8B57;
            font-weight: bold;
        }
        .actions {
            text-align: center;
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #eee;
        }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background-color: #2E8B57;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            margin: 0 10px;
        }
        .btn:hover {
            background-color: #26734d;
            text-decoration: none;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .no-items {
            text-align: center;
            color: #777;
            font-style: italic;
            padding: 30px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="success-icon">✅</div>
    <h1>Order Confirmed Successfully!</h1>

    <%
        Integer orderId = (Integer) request.getAttribute("orderId");
        String totalAmount = (String) request.getAttribute("totalAmount");
        List<?> itemsList = (List<?>) request.getAttribute("itemsList");
    %>

    <div class="order-info">
        <p><strong>Status:</strong> <span style="color: #2E8B57; font-weight: bold;">Confirmed</span></p>
        <p><strong>Date:</strong> <%= new java.util.Date() %></p>
    </div>

    <h3>Order Items:</h3>
    
    <div class="items-list">
        <%
            if (itemsList != null && !itemsList.isEmpty()) {
                for (Object obj : itemsList) {
                    Map<String, Object> item = (Map<String, Object>) obj;
        %>
        <div class="item-card">
            <p>
                <span class="item-label">Product Name:</span>
                <span class="item-value"><%= item.get("product_name") %></span>
            </p>
            <p>
                <span class="item-label">Quantity:</span>
                <span class="item-value"><%= item.get("quantity") %></span>
            </p>
            <p>
                <span class="item-label">Price:</span>
                <span class="item-value price-value">$<%= item.get("price") %></span>
            </p>
        </div>
        <%
                }
            } else {
        %>
        <div class="no-items">
            No items found in this order
        </div>
        <%
            }
        %>
    </div>

    <div class="total-section">
        <div class="total-label">Total Amount:</div>
        <div class="total-amount">$<%= totalAmount %></div>
    </div>

    <div class="actions">
        <a href="products?customer_id=${customerId}" class="btn">Continue Shopping</a>
        <a href="orders?customer_id=${customerId}" class="btn btn-secondary">View All Orders</a>
    </div>
</div>
</body>
</html>