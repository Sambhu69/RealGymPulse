<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 — Page Not Found | GymPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="error-container">
    <h1>404</h1>
    <h2>Page Not Found</h2>
    <p>Sorry, the page you're looking for doesn't exist or has been moved. Let's get you back on track.</p>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Go to Login</a>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
