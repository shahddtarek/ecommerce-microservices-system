<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container {
            max-width: 800px;
            margin: 40px auto;
        }
        h2 { color: #2E8B57; }
        pre { background-color: #f4f4f4; padding: 15px; border-radius: 5px; }
        .notice { color: #a00; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">

<h2>Order Confirmation</h2>
<pre>${order}</pre>

</div>
</body>
</html>
