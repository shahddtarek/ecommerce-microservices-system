<%-- 
    Document   : checkout
    Created on : Nov 26, 2025
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Checkout</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            width: 400px;
            margin: 60px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #2E8B57;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background-color: #2E8B57;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #246b45;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Checkout</h2>

        <form action="submitOrder" method="post">
            <label>Customer ID</label>
            <input type="text" name="customer_id">

            <label>Product ID</label>
            <input type="text" name="product_id">

            <label>Quantity</label>
            <input type="text" name="quantity">

            <input type="submit" value="Submit Order">
        </form>
    </div>
</body>
</html>
