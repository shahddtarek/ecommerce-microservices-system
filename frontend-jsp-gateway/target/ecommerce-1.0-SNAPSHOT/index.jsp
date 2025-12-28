<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Catalog</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1100px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        h1 {
            text-align: center;
            color: #2E8B57;
            margin-bottom: 25px;
        }
        .nav-links {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .nav-links a {
            text-decoration: none;
            color: #2E8B57;
            font-weight: bold;
            margin: 0 15px;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .nav-links a:hover {
            background-color: #f0f9f4;
            text-decoration: none;
        }
        .no-products {
            text-align: center;
            color: #777;
            font-style: italic;
            padding: 40px;
            font-size: 18px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0 30px 0;
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
            vertical-align: middle;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        input[type="checkbox"] {
            transform: scale(1.2);
            cursor: pointer;
        }
        input[type="number"] {
            width: 70px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
        }
        .submit-section {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
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
        }
        input[type="submit"]:hover {
            background-color: #26734d;
        }
        .product-name {
            font-weight: bold;
            color: #333;
        }
        .available-stock {
            color: #2E8B57;
            font-weight: bold;
        }
        .price {
            color: #2c3e50;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Product Catalog</h1>
    
    <div class="nav-links">
        <%
            String customerId = (String) request.getAttribute("customerId");
        %>
        <a href="profile?customer_id=<%= customerId %>">Profile</a>
        <a href="orders?customer_id=<%= customerId %>">Orders History</a>
    </div>

    <%
        JSONArray products = (JSONArray) request.getAttribute("products");
        if (products == null || products.length() == 0) {
    %>
        <div class="no-products">
            No products available at the moment.
        </div>
    <%
            return;
        }
    %>

    <form action="checkOrder" method="post">
        <table>
            <thead>
                <tr>
                    <th>Select</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Available</th>
                    <th>Price</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
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
                    <td class="product-name"><%= p.getString("product_name") %></td>
                    <td class="available-stock"><%= available %></td>
                    <td class="price">$<%= p.getDouble("unit_price") %></td>
                    <td>
                        <input type="number"
                               name="quantity_<%= p.getInt("product_id") %>"
                               min="1"
                               max="<%= available %>"
                               value="1">
                    </td>
                </tr>
                <%
                    }
                }
                %>
            </tbody>
        </table>

        <div class="submit-section">
            <input type="hidden" name="customer_id" value="<%= customerId %>">
            <input type="submit" value="Make Order">
        </div>
    </form>
</div>
</body>
</html>