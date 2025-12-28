<%@ page import="org.json.JSONArray,org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 500px;
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
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }
        select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            width: 100%;
            box-sizing: border-box;
        }
        button {
            background-color: #2E8B57;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
        }
        button:hover {
            background-color: #26734d;
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
    <h1 style="text-align:center; color:#2E8B57;">Enjoy Shopping!</h1>
    <h2>Select Customer</h2>

    <form action="products" method="get">
        <div>
            <label>Customer ID:</label>
            <select name="customer_id" required>
                <option value="">-- Select --</option>
                <%
                    JSONArray customers = (JSONArray) request.getAttribute("customers");
                    for (int i = 0; i < customers.length(); i++) {
                        JSONObject c = customers.getJSONObject(i);
                %>
                    <option value="<%= c.getInt("customer_id") %>">
                        Customer <%= c.getInt("customer_id") %>
                    </option>
                <%
                    }
                %>
            </select>
        </div>
        
        <button type="submit">Enter Store</button>
    </form>
</div>
</body>
</html>