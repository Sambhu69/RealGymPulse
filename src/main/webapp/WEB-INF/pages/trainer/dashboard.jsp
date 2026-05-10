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
    <div class="mb-8 flex items-center justify-between">
        <div>
            <h1 class="text-3xl font-bold text-white tracking-tight">Trainer Dashboard</h1>
            <p class="text-zinc-400 mt-1">Welcome back, <span class="text-white font-semibold">${sessionScope.loggedUser.fullName}</span></p>
        </div>
    </div>

    <!-- Flash messages are handled by the global toast system in footer.jsp -->


    <%-- Stats Row --%>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl">
            <h3 class="text-sm font-medium text-zinc-400 uppercase tracking-wider mb-2">Upcoming Sessions</h3>
            <p class="text-4xl font-bold text-white">${upcomingSessions}</p>
        </div>
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl">
            <h3 class="text-sm font-medium text-zinc-400 uppercase tracking-wider mb-2">Completed Sessions</h3>
            <p class="text-4xl font-bold text-white">${completedSessions}</p>
        </div>
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-6 shadow-xl">
            <h3 class="text-sm font-medium text-zinc-400 uppercase tracking-wider mb-2">Average Rating</h3>
            <p class="text-4xl font-bold text-emerald-400">⭐ ${avgRating}</p>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

        <%-- Upcoming Booked Sessions --%>
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl overflow-hidden shadow-xl">
            <div class="p-6 border-b border-zinc-800">
                <h2 class="text-xl font-bold text-white">Upcoming Client Sessions</h2>
            </div>
            <div class="divide-y divide-zinc-800">
                <c:choose>
                    <c:when test="${not empty sessions}">
                        <c:forEach var="s" items="${sessions}">
                            <div class="p-5 hover:bg-zinc-800/30 transition-colors">
                                <div class="flex justify-between items-center">
                                    <div>
                                        <p class="font-semibold text-white">${s.memberName}</p>
                                        <p class="text-sm text-zinc-400 mt-0.5">${s.date} &bull; ${s.time}</p>
                                    </div>
                                    <span class="px-3 py-1 text-xs font-bold rounded-full bg-amber-500/10 text-amber-400 border border-amber-500/20 uppercase">
                                        ${s.status}
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="p-8 text-center text-zinc-500 text-sm">No upcoming sessions scheduled.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- Add Availability Slot --%>
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl overflow-hidden shadow-xl">
            <div class="p-6 border-b border-zinc-800">
                <h2 class="text-xl font-bold text-white">Manage My Availability</h2>
                <p class="text-sm text-zinc-400 mt-1">Add new open slots for members to book.</p>
            </div>
            <div class="p-6">
                <form action="${pageContext.request.contextPath}/trainer/schedule" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="add">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-zinc-400 mb-1">Date</label>
                            <input type="date" name="slotDate" required class="w-full px-3 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg text-white focus:border-zinc-600 outline-none">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-400 mb-1">Start Time</label>
                            <input type="time" name="startTime" required class="w-full px-3 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg text-white focus:border-zinc-600 outline-none">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-400 mb-1">End Time</label>
                            <input type="time" name="endTime" required class="w-full px-3 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg text-white focus:border-zinc-600 outline-none">
                        </div>
                    </div>
                    <button type="submit" class="w-full py-2.5 px-4 bg-white hover:bg-zinc-200 text-black font-bold rounded-xl shadow-md transition-colors duration-200">
                        + Add Slot
                    </button>
                </form>

                <c:if test="${not empty mySlots}">
                    <div class="mt-6">
                        <h3 class="text-sm font-semibold text-zinc-400 uppercase tracking-wider mb-3">My Open Slots</h3>
                        <div class="space-y-2 max-h-64 overflow-y-auto">
                            <c:forEach var="slot" items="${mySlots}">
                                <div class="flex items-center justify-between px-4 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg text-sm">
                                    <span class="text-zinc-300">${slot.slotDate}</span>
                                    <span class="text-zinc-400">${slot.startTime} → ${slot.endTime}</span>
                                    <span class="px-2 py-0.5 text-xs font-bold rounded-full bg-emerald-500/10 text-emerald-400">Open</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

    </div>
</main>

<%@ include file="../footer.jsp" %>
</body>
</html>
