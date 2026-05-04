<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 — Server Error | GymPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="error-container">
    <h1>500</h1>
    <h2>Something Went Wrong</h2>
    <p>An unexpected error occurred on our end. Please try again shortly or contact the administrator if the problem persists.</p>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Go to Login</a>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
