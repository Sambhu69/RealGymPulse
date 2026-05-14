<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-8">
    
    <!-- Monday Holiday Notice -->
    <c:if test="${isMonday}">
        <div class="mb-8 p-6 bg-amber-500/10 border border-amber-500/20 rounded-3xl backdrop-blur-xl flex items-center gap-4 animate-pulse">
            <div class="w-12 h-12 rounded-full bg-amber-500/20 flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-amber-400"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/><path d="M8 14h.01"/><path d="M12 14h.01"/><path d="M16 14h.01"/><path d="M8 18h.01"/><path d="M12 18h.01"/><path d="M16 18h.01"/></svg>
            </div>
            <div>
                <h3 class="text-lg font-bold text-amber-400">Monday Holiday!</h3>
                <p class="text-sm text-amber-400/80">Relax and recharge. No classes are scheduled for today.</p>
            </div>
        </div>
    </c:if>

    <div class="mb-8 flex items-center justify-between">
        <div>
            <h1 class="text-3xl font-bold text-white tracking-tight">Instructor Dashboard</h1>
            <p class="text-zinc-400 mt-1">Welcome back, <span class="text-white font-semibold">${sessionScope.loggedUser.fullName}</span></p>
        </div>
    </div>

    <%-- Stats Row --%>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl relative overflow-hidden group">
            <div class="absolute inset-0 bg-gradient-to-br from-blue-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
            <h3 class="text-sm font-medium text-zinc-400 uppercase tracking-wider mb-2">Upcoming Classes</h3>
            <p class="text-4xl font-bold text-white">${upcomingCount}</p>
        </div>
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl relative overflow-hidden group">
            <div class="absolute inset-0 bg-gradient-to-br from-emerald-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
            <h3 class="text-sm font-medium text-zinc-400 uppercase tracking-wider mb-2">In Progress</h3>
            <p class="text-4xl font-bold text-emerald-400">${activeCount}</p>
        </div>
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl relative overflow-hidden group">
            <div class="absolute inset-0 bg-gradient-to-br from-zinc-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
            <h3 class="text-sm font-medium text-zinc-400 uppercase tracking-wider mb-2">Completed Classes</h3>
            <p class="text-4xl font-bold text-white">${completedCount}</p>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        <%-- Class Management List --%>
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl overflow-hidden shadow-xl">
                <div class="p-6 border-b border-zinc-800 flex justify-between items-center">
                    <h2 class="text-xl font-bold text-white">Your Assigned Classes</h2>
                </div>
                <div class="divide-y divide-zinc-800">
                    <c:choose>
                        <c:when test="${not empty classes}">
                            <c:forEach var="c" items="${classes}">
                                <div class="p-5 hover:bg-zinc-800/30 transition-colors flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                                    <div class="flex items-center gap-4">
                                        <div class="w-12 h-12 rounded-xl bg-zinc-800 flex flex-col items-center justify-center text-center">
                                            <span class="text-[10px] text-zinc-500 font-bold uppercase">${c.scheduleDate.substring(5,7)}</span>
                                            <span class="text-lg font-bold text-white">${c.scheduleDate.substring(8,10)}</span>
                                        </div>
                                        <div>
                                            <h5 class="font-bold text-white text-lg">${c.className}</h5>
                                            <div class="flex items-center gap-3 text-sm text-zinc-400 mt-0.5">
                                                <span class="flex items-center gap-1">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                                                    ${c.scheduleTime}
                                                </span>
                                                <span class="flex items-center gap-1">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                                                    ${c.enrolled}/${c.capacity}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center gap-3">
                                        <c:choose>
                                            <c:when test="${c.status == 'available'}">
                                                <form action="${pageContext.request.contextPath}/instructor/dashboard" method="POST">
                                                    <input type="hidden" name="action" value="open">
                                                    <input type="hidden" name="classId" value="${c.classId}">
                                                    <button type="submit" class="px-4 py-2 bg-emerald-500 hover:bg-emerald-600 text-white text-xs font-bold rounded-lg transition-colors shadow-lg shadow-emerald-500/20">
                                                        Open Class
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:when test="${c.status == 'in_progress'}">
                                                <div class="flex items-center gap-2">
                                                    <span class="flex h-2 w-2 rounded-full bg-emerald-500 animate-pulse"></span>
                                                    <span class="text-xs font-bold text-emerald-400 uppercase">Live</span>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/instructor/dashboard" method="POST">
                                                    <input type="hidden" name="action" value="close">
                                                    <input type="hidden" name="classId" value="${c.classId}">
                                                    <button type="submit" class="px-4 py-2 bg-zinc-700 hover:bg-zinc-600 text-white text-xs font-bold rounded-lg transition-colors">
                                                        End Session
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:when test="${c.status == 'completed'}">
                                                <span class="px-3 py-1 bg-zinc-800 text-zinc-500 text-[10px] font-bold uppercase rounded-full border border-zinc-700/50">Completed</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 bg-red-500/10 text-red-400 text-[10px] font-bold uppercase rounded-full border border-red-500/20">${c.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="p-12 text-center text-zinc-500">
                                <div class="w-16 h-16 bg-zinc-800/50 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/></svg>
                                </div>
                                <p>You have no classes assigned yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <%-- Right Sidebar: Schedule & Rating --%>
        <div class="space-y-6">
            <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl">
                <h3 class="text-sm font-semibold text-zinc-400 uppercase tracking-widest mb-4">Quick Calendar</h3>
                <div class="grid grid-cols-7 gap-1 text-center text-[10px] text-zinc-600 mb-2">
                    <span>M</span><span>T</span><span>W</span><span>T</span><span>F</span><span>S</span><span>S</span>
                </div>
                <div class="grid grid-cols-7 gap-1">
                    <c:forEach var="i" begin="1" end="31">
                        <div class="aspect-square flex items-center justify-center text-xs rounded-lg transition-colors border border-transparent
                                    ${i == 10 || i == 11 || i == 12 ? 'bg-blue-500/10 text-blue-400 border-blue-500/20' : 'text-zinc-500 hover:bg-zinc-800/50'}">
                            ${i}
                        </div>
                    </c:forEach>
                </div>
                <p class="mt-4 text-[10px] text-zinc-500 italic">* Highlighted dates indicate class days.</p>
            </div>

            <div class="bg-gradient-to-br from-emerald-500/10 to-blue-500/10 backdrop-blur-xl border border-white/5 rounded-2xl p-6 shadow-xl">
                <h3 class="text-sm font-semibold text-zinc-400 uppercase tracking-widest mb-4">Performance</h3>
                <div class="flex items-center gap-4">
                    <div class="text-3xl font-bold text-white">4.9</div>
                    <div class="flex gap-0.5 text-amber-400">
                        <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                    </div>
                </div>
                <p class="text-[10px] text-zinc-500 mt-2 uppercase tracking-tighter">Excellent instructor rating!</p>
            </div>
        </div>

    </div>
</main>

<%@ include file="../footer.jsp" %>
</body>
</html>
