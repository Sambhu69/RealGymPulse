<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upgrade Required - GymPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>body { background-color: #09090b; color: white; }</style>
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>
<main class="flex-grow flex items-center justify-center p-6">
    <div class="w-full max-w-lg bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl shadow-2xl p-8 text-center">
        <div class="mb-6 flex justify-center">
            <div class="h-16 w-16 bg-amber-500/10 rounded-full flex items-center justify-center">
                <svg class="w-8 h-8 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
            </div>
        </div>
        <h2 class="text-2xl font-bold text-white mb-2">Premium Feature</h2>
        <p class="text-zinc-400 mb-8">${requestScope.error}</p>
        <div class="flex flex-col gap-3">
            <a href="${pageContext.request.contextPath}/member/plans" class="w-full py-3 px-4 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold rounded-lg shadow-md transition-colors duration-200">Upgrade to Premium Annual</a>
            <a href="${pageContext.request.contextPath}/member/dashboard" class="w-full py-3 px-4 bg-zinc-800 hover:bg-zinc-700 text-white font-semibold rounded-lg shadow-md transition-colors duration-200">Return to Dashboard</a>
        </div>
    </div>
</main>
<%@ include file="../footer.jsp" %>
</body>
</html>
