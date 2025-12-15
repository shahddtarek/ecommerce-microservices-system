<%-- 
    Document   : checkout
    Created on : Nov 26, 2025, 3:57:40 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="submitOrder" method="post">
            Customer ID: <input type="text" name="customer_id"><br>
            Product ID: <input type="text" name="product_id"><br>
            Quantity: <input type="text" name="quantity"><br>
            <input type="submit" value="Submit Order">
        </form>

    </body>
</html>
