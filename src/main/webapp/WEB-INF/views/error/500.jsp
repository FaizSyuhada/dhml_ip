<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>500 - Server Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5 text-center">
        <h1 class="display-1">500</h1>
        <h2>Internal Server Error</h2>
        <p>Something went wrong. Please try again later.</p>
        <a href="<%= request.getContextPath() %>/login" class="btn btn-primary">Go Home</a>
    </div>
</body>
</html>

