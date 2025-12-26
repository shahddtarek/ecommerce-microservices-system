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
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            color: #2E8B57;
            margin-bottom: 25px;
        }
        .profile-field {
            margin: 15px 0;
            display: flex;
            justify-content: space-between;
        }
        .label {
            font-weight: bold;
            color: #555;
        }
        .value {
            color: #333;
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
    <h2>Customer Profile</h2>

    <%
        // جلب JSON String من الـ Servlet
        String profileStr = (String) request.getAttribute("profileData");
        JSONObject profile = new JSONObject(profileStr); // تحويل الـ String لـ JSONObject
    %>

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
        <span class="value"><%= profile.getInt("loyalty_points") %></span>
    </div>

    <a href="products">Back to Products</a>
</div>
</body>
</html>
