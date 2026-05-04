<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password — GymPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="auth-container">
    <div class="auth-card">
        <h2>Gym<span class="brand-accent">Pulse</span></h2>
        <p class="subtitle">Reset your password</p>
        <form>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="Enter your registered email" required>
            </div>
            <button type="button" class="btn btn-primary btn-block" onclick="alert('Password reset instructions sent to your email.')">Send Reset Link</button>
        </form>
        <div class="auth-footer">
            <p><a href="${pageContext.request.contextPath}/login">Back to Login</a></p>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
