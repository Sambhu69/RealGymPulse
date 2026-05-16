<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password — GymPulse</title>
    <meta name="description" content="Request a password reset for your GymPulse account.">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        background: '#09090b', // zinc-950
                    }
                }
            }
        }
    </script>
    <style>
        body { background-color: #09090b; color: white; }
    </style>
</head>
<body class="bg-background text-zinc-100 min-h-screen flex flex-col font-sans antialiased">

<%@ include file="header.jsp" %>

<main class="flex-grow flex items-center justify-center p-6">
    <div class="w-full max-w-md bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl shadow-2xl p-8 transform transition-all hover:scale-[1.01]">
        
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold tracking-tight text-white mb-2">
                Gym<span class="text-zinc-500">Pulse</span>
            </h2>
            <p class="text-sm text-zinc-400">Request Password Reset</p>
        </div>

        <c:if test="${not empty requestScope.error}">
            <div class="mb-6 p-4 rounded-lg bg-red-950/50 border border-red-900 text-red-200 text-sm">
                ${requestScope.error}
            </div>
        </c:if>

        <c:if test="${not empty requestScope.success}">
            <div class="mb-6 p-4 rounded-lg bg-emerald-950/50 border border-emerald-900 text-emerald-200 text-sm">
                ${requestScope.success}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="POST" class="space-y-5" autocomplete="off">
            <div>
                <label for="fullName" class="block text-sm font-medium text-zinc-300 mb-1.5">Full Name *</label>
                <input type="text" id="fullName" name="fullName" 
                       class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                       placeholder="John Doe" required>
            </div>
            
            <div>
                <label for="phone" class="block text-sm font-medium text-zinc-300 mb-1.5">Phone Number *</label>
                <input type="text" id="phone" name="phone" 
                       class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                       placeholder="555-0123" required>
            </div>

            <div>
                <label for="email" class="block text-sm font-medium text-zinc-300 mb-1.5">Email Address (Optional)</label>
                <input type="email" id="email" name="email" 
                       class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700 outline-none transition-all text-white placeholder-zinc-600 shadow-inner" 
                       placeholder="you@example.com">
                <p class="text-[10px] text-zinc-500 mt-1">If provided, we can find your account faster.</p>
            </div>

            <button type="submit" class="w-full py-2.5 px-4 bg-white hover:bg-zinc-200 text-black font-semibold rounded-lg shadow-md transition-colors duration-200 mt-2">
                Send Reset Request
            </button>
        </form>

        <div class="mt-8 space-y-3 text-center text-sm text-zinc-500">
            <p><a href="${pageContext.request.contextPath}/login" class="hover:text-white transition-colors">Back to Login</a></p>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>
