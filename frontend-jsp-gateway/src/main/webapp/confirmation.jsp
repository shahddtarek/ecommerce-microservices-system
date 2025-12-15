<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #2E8B57; }
        pre { background-color: #f4f4f4; padding: 15px; border-radius: 5px; }
        .notice { color: #a00; font-weight: bold; }
    </style>
</head>
<body>

<h2>Inventory Result</h2>
<pre>${inventory}</pre>

<h2>Pricing Result</h2>
<pre>${pricing}</pre>

<h2>Order Result</h2>
<pre>${order}</pre>
</body>
</html>
