<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            color: #2E8B57;
            margin-bottom: 35px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }
        .profile-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 30px;
            border-left: 4px solid #2E8B57;
        }
        .profile-field {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .profile-field:last-child {
            border-bottom: none;
        }
        .profile-field:hover {
            background-color: #f0f9f4;
            margin: 0 -10px;
            padding: 12px 10px;
            border-radius: 5px;
        }
        .label {
            font-weight: bold;
            color: #555;
            font-size: 16px;
            min-width: 140px;
        }
        .value {
            color: #333;
            font-size: 16px;
            text-align: right;
            padding: 6px 12px;
            background-color: white;
            border-radius: 5px;
            border: 1px solid #eaeaea;
            min-width: 200px;
        }
        .loyalty-points {
            color: #2E8B57;
            font-weight: bold;
            font-size: 18px;
        }
        .customer-id {
            text-align: center;
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 20px;
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 5px;
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
            font-size: 16px;
            transition: all 0.3s ease;
            min-width: 180px;
        }
        .btn:hover {
            background-color: #26734d;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(46, 139, 87, 0.2);
        }
        .customer-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
        }
        .customer-icon {
            font-size: 40px;
            color: #2E8B57;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="customer-header">
        <div class="customer-icon">👤</div>
        <h2>Customer Profile</h2>
    </div>

    <%
        String profileStr = (String) request.getAttribute("profileData");
        JSONObject profile = new JSONObject(profileStr);
        
        // Extract customer ID if available
        String customerId = "";
        if (profile.has("customer_id")) {
            customerId = "Customer ID: #" + profile.getInt("customer_id");
        }
    %>

    <% if (!customerId.isEmpty()) { %>
    <div class="customer-id">
        <%= customerId %>
    </div>
    <% } %>

    <div class="profile-section">
        <div class="profile-field">
            <span class="label">Name:</span>
            <span class="value"><%= profile.getString("name") %></span>
        </div>

        <div class="profile-field">
            <span class="label">Email:</span>
            <span class="value"><%= profile.getString("email") %></span>
        </div>

        <div class="profile-field">
            <span class="label">Phone:</span>
            <span class="value"><%= profile.getString("phone") %></span>
        </div>

        <div class="profile-field">
            <span class="label">Loyalty Points:</span>
            <span class="value loyalty-points"><%= profile.getInt("loyalty_points") %> points</span>
        </div>
    </div>

    <div class="actions">
        <a href="products?customer_id=${customerId}" class="btn">Back to Products</a>
    </div>
</div>
</body>
</html>