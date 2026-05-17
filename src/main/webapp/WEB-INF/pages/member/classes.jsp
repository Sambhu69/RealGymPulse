<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classes — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <!-- Header -->
    <div class="mb-10 flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-400"><path d="m12 19 7-7 3 3-7 7-3-3z"/><path d="m18 13-1.5-7.5L2 2l3.5 14.5L13 18l5-5z"/><path d="m2 2 7.586 7.586"/><circle cx="11" cy="11" r="2"/></svg>
        <h1 class="text-3xl md:text-4xl font-bold tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
            Available Classes
        </h1>
    </div>

    <!-- Classes Grid -->
    <c:choose>
        <c:when test="${not empty availableClasses}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-6 max-w-5xl">
                <c:forEach items="${availableClasses}" var="cls">
                    <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 hover:bg-zinc-800/40 transition-all flex flex-col relative overflow-hidden">
                        <c:if test="${cls.enrolled >= cls.capacity}">
                            <div class="absolute top-4 right-4 bg-red-500/10 text-red-400 border border-red-500/20 text-[10px] uppercase font-bold px-2.5 py-0.5 rounded-full tracking-wider">
                                Full
                            </div>
                        </c:if>
                        <h4 class="text-xl font-bold text-white mb-4">${cls.className}</h4>
                        
                        <div class="space-y-2 mb-6 text-sm text-zinc-400 flex-grow">
                            <p class="flex items-center gap-2"><span class="w-4 h-4 text-zinc-500 flex items-center justify-center">👨‍🏫</span> ${cls.instructor}</p>
                            <p class="flex items-center gap-2"><span class="w-4 h-4 text-zinc-500 flex items-center justify-center">📅</span> ${cls.scheduleDate} at ${cls.scheduleTime}</p>
                            <p class="text-zinc-500 mt-4">${cls.description}</p>
                        </div>
                        
                        <div class="pt-4 border-t border-zinc-800/50 flex items-center justify-between mt-auto">
                            <span class="text-xs font-semibold px-4 py-2 bg-zinc-950 rounded-full text-zinc-400 border border-zinc-800/50 shadow-inner">
                                ${cls.enrolled}/${cls.capacity} Enrolled
                            </span>
                            <form action="${pageContext.request.contextPath}/member/book" method="POST">
                                <input type="hidden" name="classId" value="${cls.classId}">
                                <c:choose>
                                    <c:when test="${cls.enrolled >= cls.capacity}">
                                        <button type="submit" class="px-5 py-2 bg-zinc-800 hover:bg-red-500/10 text-zinc-400 hover:text-red-400 border border-zinc-700/50 hover:border-red-500/20 font-bold text-sm rounded-xl transition-all shadow-md">Class Full</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="px-5 py-2 bg-white text-black font-bold text-sm rounded-xl hover:bg-zinc-200 transition-colors shadow-lg shadow-white/10">Book Now</button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="p-8 text-center text-zinc-500 bg-zinc-900/30 rounded-2xl border border-zinc-800/50 max-w-5xl">
                No classes available at the moment. Please check back later.
            </div>
        </c:otherwise>
    </c:choose>

</main>

<%@ include file="../footer.jsp" %>
</body>
</html>
