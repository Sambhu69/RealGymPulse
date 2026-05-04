<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — GymPulse</title>
    <meta name="description" content="Create your GymPulse account to start your fitness journey.">
    <!-- Tailwind handles styling via header.jsp -->
</head>
<body class="bg-background text-zinc-100 min-h-screen flex flex-col font-sans antialiased">

<%@ include file="header.jsp" %>

<main class="flex-grow flex items-center justify-center p-6 py-12 pb-36">
    <div class="w-full max-w-lg bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl shadow-2xl p-8 transform transition-all hover:scale-[1.01]">
        
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold tracking-tight text-white mb-2">
                Gym<span class="text-zinc-500">Pulse</span>
            </h2>
            <p class="text-sm text-zinc-400">Create your account</p>
        </div>

        <c:if test="${not empty requestScope.error}">
            <div class="mb-6 p-4 rounded-lg bg-red-950/50 border border-red-900 text-red-200 text-sm">
                ${requestScope.error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="POST" id="registerForm" onsubmit="return validateForm()" class="space-y-5">
            <div>
                <label for="fullName" class="block text-sm font-medium text-zinc-300 mb-1.5">Full Name</label>
                <input type="text" id="fullName" name="fullName" 
                       class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                       placeholder="John Doe" required>
            </div>
            
            <div>
                <label for="email" class="block text-sm font-medium text-zinc-300 mb-1.5">Email Address</label>
                <input type="email" id="email" name="email" 
                       class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                       placeholder="you@example.com" required>
            </div>
            
            <div>
                <label for="phone" class="block text-sm font-medium text-zinc-300 mb-1.5">Phone Number</label>
                <input type="text" id="phone" name="phone" maxlength="10" 
                       class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                       placeholder="10-digit number" required>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label for="password" class="block text-sm font-medium text-zinc-300 mb-1.5">Password</label>
                    <input type="password" id="password" name="password" 
                           class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                           placeholder="••••••••" required>
                </div>
                <div>
                    <label for="confirmPassword" class="block text-sm font-medium text-zinc-300 mb-1.5">Confirm</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                           placeholder="••••••••" required>
                </div>
            </div>

            <div id="jsError" class="hidden mb-6 p-4 rounded-lg bg-red-950/50 border border-red-900 text-red-200 text-sm"></div>

            <button type="submit" class="w-full py-2.5 px-4 bg-white hover:bg-zinc-200 text-black font-semibold rounded-lg shadow-md transition-colors duration-200 mt-4">
                Create Account
            </button>
        </form>

        <div class="mt-8 text-center text-sm text-zinc-500">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-white hover:underline transition-colors">Sign in</a></p>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script>
function validateForm() {
    var pw = document.getElementById('password').value;
    var cpw = document.getElementById('confirmPassword').value;
    var errDiv = document.getElementById('jsError');
    if (pw !== cpw) {
        errDiv.textContent = 'Passwords do not match.';
        errDiv.style.display = 'block';
        return false;
    }
    errDiv.style.display = 'none';
    return true;
}
</script>
</body>
</html>
