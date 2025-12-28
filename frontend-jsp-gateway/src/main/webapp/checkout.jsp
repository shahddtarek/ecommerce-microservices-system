<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
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
            margin-bottom: 30px;
        }
        h3 {
            color: #2c3e50;
            margin: 30px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            border-left: 4px solid #2E8B57;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th {
            background-color: #2E8B57;
            color: white;
            padding: 14px;
            text-align: center;
            font-weight: bold;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid #eee;
        }
        input[type="submit"] {
            background-color: #2E8B57;
            color: white;
            border: none;
            padding: 14px 40px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
            min-width: 150px;
        }
        input[type="submit"]:hover {
            background-color: #26734d;
        }
        .cancel-btn {
            background-color: #6c757d !important;
        }
        .cancel-btn:hover {
            background-color: #5a6268 !important;
        }
        .price-cell {
            color: #2c3e50;
            font-weight: bold;
        }
        .final-price {
            color: #2E8B57;
            font-weight: bold;
        }
        .total-amount {
            font-size: 24px;
            color: #2E8B57;
            margin-left: 10px;
        }
        .total-section {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
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
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Final Price</th>
            </tr>
        </thead>
        <tbody>
            <%
            for (int i = 0; i < items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
            %>
            <tr>
                <td><%= item.getInt("product_id") %></td>
                <td><%= item.getInt("quantity") %></td>
                <td class="price-cell">$<%= item.getDouble("unit_price") %></td>
                <td class="final-price">$<%= item.getDouble("final_price") %></td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>

    <h3>Total Amount: <span class="total-amount">$<%= String.format("%.2f", totalAmount) %></span></h3>

    <div class="actions">
        <form action="submitOrder" method="post">
            <input type="hidden" name="customer_id" value="<%= customerId %>">
            <input type="hidden" name="products" value='<%= products.toString() %>'>
            <input type="hidden" name="total_amount" value="<%= String.format("%.2f", totalAmount) %>">
            <input type="submit" value="Submit Order">
        </form>
    </div>
</div>
</body>
</html>