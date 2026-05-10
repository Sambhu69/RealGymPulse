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
<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-8">
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white tracking-tight">Book a Personal Trainer</h1>
        <p class="text-zinc-400 mt-1">Select a trainer and find a time slot that works for you.</p>
    </div>

    <!-- Flash messages are handled by the global toast system in footer.jsp -->


    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <c:forEach var="trainer" items="${trainers}">
            <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl flex flex-col sm:flex-row gap-6">
                <div class="flex-shrink-0 flex flex-col items-center">
                    <div class="w-24 h-24 rounded-full bg-zinc-800 overflow-hidden mb-3">
                        <img src="${pageContext.request.contextPath}/img/profiles/${trainer.profileImage}" onerror="this.src='${pageContext.request.contextPath}/img/default.png'" alt="${trainer.fullName}" class="w-full h-full object-cover">
                    </div>
                    <div class="flex items-center text-amber-400 text-sm font-bold">
                        <svg class="w-4 h-4 mr-1 fill-current" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/></svg>
                        ${trainer.rating}
                    </div>
                </div>
                <div class="flex-grow">
                    <h3 class="text-xl font-bold text-white mb-1">${trainer.fullName}</h3>
                    <p class="text-emerald-400 text-sm font-semibold mb-3">${trainer.specializations}</p>
                    <p class="text-zinc-400 text-sm mb-6">${trainer.bio}</p>
                    
                    <div>
                        <h4 class="text-sm font-semibold text-zinc-300 mb-3 uppercase tracking-wider">Available Slots</h4>
                        <c:set var="slotKey" value="slots_${trainer.userId}" />
                        <c:set var="slots" value="${requestScope[slotKey]}" />
                        
                        <c:choose>
                            <c:when test="${empty slots}">
                                <p class="text-zinc-500 text-sm italic">No available slots currently.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="flex flex-wrap gap-2">
                                    <c:forEach var="slot" items="${slots}">
                                        <form action="${pageContext.request.contextPath}/member/book-trainer" method="POST" class="inline">
                                            <input type="hidden" name="trainerId" value="${trainer.userId}">
                                            <input type="hidden" name="slotId" value="${slot.slotId}">
                                            <button type="submit" class="px-3 py-1.5 bg-zinc-800 hover:bg-white hover:text-black text-xs text-zinc-300 rounded-md transition-all border border-zinc-700 hover:border-white">
                                                ${slot.slotDate} • ${slot.startTime}
                                            </button>
                                        </form>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</main>
<%@ include file="../footer.jsp" %>
</body>
</html>
