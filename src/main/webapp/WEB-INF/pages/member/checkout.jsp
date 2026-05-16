<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - GymPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>body { background-color: #09090b; color: white; }</style>
</head>
<body class="bg-zinc-950 text-zinc-100 min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>
<main class="flex-grow flex items-center justify-center p-6 py-12">
    <div class="w-full max-w-2xl grid grid-cols-1 md:grid-cols-2 gap-8">
        
        <!-- Plan Summary -->
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-8">
            <h2 class="text-xl font-bold text-white mb-6">Order Summary</h2>
            <div class="flex justify-between items-center mb-4 border-b border-zinc-800 pb-4">
                <div>
                    <h3 class="font-bold text-lg text-zinc-200">${plan.planName}</h3>
                    <p class="text-xs text-zinc-500">${plan.durationMonths} Month(s)</p>
                </div>
                <span class="font-bold text-xl text-white">Rs.${plan.price}</span>
            </div>
            <div class="flex justify-between items-center font-bold text-lg text-emerald-400">
                <span>Total Due</span>
                <span>Rs.${plan.price}</span>
            </div>
        </div>

        <!-- Payment Mock Form -->
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-8">
            <h2 class="text-xl font-bold text-white mb-6 flex items-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path></svg>
                Payment Details
            </h2>
            
            <c:if test="${not empty param.error}">
                <div class="mb-4 p-3 bg-red-950 border border-red-900 text-red-400 rounded-lg text-sm">
                    Payment failed. Please try again.
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/member/checkout" method="POST" class="space-y-4">
                <input type="hidden" name="planId" value="${plan.planId}">
                
                <div class="bg-blue-900/20 border border-blue-800/50 p-4 rounded-xl mb-4 text-xs text-blue-300">
                    <p><strong>TEST MODE:</strong> This is a mock payment gateway. Your real card will not be charged. Just click pay to simulate success.</p>
                </div>

                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1">Card Number</label>
                    <input type="text" value="**** **** **** 4242" disabled class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg text-zinc-500 cursor-not-allowed">
                </div>
                
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Expiry</label>
                        <input type="text" value="12/30" disabled class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg text-zinc-500 cursor-not-allowed">
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">CVC</label>
                        <input type="text" value="***" disabled class="w-full px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg text-zinc-500 cursor-not-allowed">
                    </div>
                </div>

                <button type="submit" class="w-full mt-4 py-3 px-4 bg-emerald-500 hover:bg-emerald-600 text-white font-bold rounded-xl shadow-md transition-colors duration-200">
                    Pay Rs.${plan.price}
                </button>
            </form>
        </div>
    </div>
</main>
<%@ include file="../footer.jsp" %>
</body>
</html>
