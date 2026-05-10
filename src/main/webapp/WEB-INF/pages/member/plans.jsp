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
<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-12">
    <div class="text-center mb-12">
        <h1 class="text-4xl font-bold text-white tracking-tight mb-4">Choose Your Plan</h1>
        <p class="text-zinc-400 max-w-2xl mx-auto">Select a membership plan to unlock class booking, personal training, and more features tailored for your fitness journey.</p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-5xl mx-auto">
        <c:forEach var="plan" items="${plans}">
            <div class="bg-zinc-900/60 backdrop-blur-xl border border-zinc-800 rounded-3xl p-8 shadow-xl flex flex-col relative overflow-hidden transition-all hover:border-emerald-500/50 hover:shadow-emerald-500/10">
                <c:if test="${plan.planName.contains('Premium')}">
                    <div class="absolute top-0 right-0 bg-amber-500 text-black text-xs font-bold px-3 py-1 rounded-bl-lg uppercase tracking-widest">Recommended</div>
                </c:if>
                <h3 class="text-2xl font-bold text-white mb-2">${plan.planName}</h3>
                <div class="mb-6">
                    <span class="text-4xl font-extrabold text-white">$${plan.price}</span>
                    <span class="text-zinc-500 text-sm">/ ${plan.durationMonths} Mo</span>
                </div>
                <p class="text-zinc-400 text-sm mb-8 flex-grow">${plan.description}</p>
                <a href="${pageContext.request.contextPath}/member/checkout?planId=${plan.planId}" class="w-full text-center py-3 px-4 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl transition-colors duration-200">Select Plan</a>
            </div>
        </c:forEach>
    </div>
</main>
<%@ include file="../footer.jsp" %>
</body>
</html>
