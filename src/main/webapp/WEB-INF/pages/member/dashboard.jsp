<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Dashboard — GymPulse</title>
    <!-- We no longer load the old style.css here to avoid conflicts, Tailwind handles everything through header.jsp -->
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <!-- Flash Messages -->
    <c:if test="${param.success == 'booked'}">
        <div class="mb-6 px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">Class booked successfully!</p>
        </div>
    </c:if>
    <c:if test="${param.success == 'cancelled'}">
        <div class="mb-6 px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">Booking cancelled.</p>
        </div>
    </c:if>
    <c:if test="${param.error == 'alreadybooked'}">
        <div class="mb-6 px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">You have already booked this class.</p>
        </div>
    </c:if>
    <c:if test="${param.error == 'cancel_failed'}">
        <div class="mb-6 px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">Failed to cancel booking.</p>
        </div>
    </c:if>

    <!-- Welcome Header -->
    <div class="mb-10">
        <h1 class="text-3xl md:text-4xl font-bold tracking-tight mb-2 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
            Welcome back, ${loggedUser.fullName}!
        </h1>
        <p class="text-zinc-400 text-sm md:text-base">Ready for your next workout? Browse and manage your classes below.</p>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        <!-- Left Column (Wider for classes) -->
        <div class="lg:col-span-2 space-y-8">
            
            <!-- Available Classes Section -->
            <section>
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-semibold tracking-tight text-zinc-100 flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-400"><path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4Z"/></svg>
                        Available Classes
                    </h2>
                </div>

                <c:choose>
                    <c:when test="${not empty availableClasses}">
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <c:forEach items="${availableClasses}" var="cls">
                                <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-2xl p-5 hover:bg-zinc-800/50 hover:border-zinc-700 transition-all group">
                                    <h4 class="text-lg font-bold text-white mb-2 group-hover:text-zinc-300 transition-colors">${cls.className}</h4>
                                    
                                    <div class="space-y-1 mb-4 text-sm text-zinc-400">
                                        <p class="flex items-center gap-2"><span class="w-4 h-4 text-zinc-500">👨‍🏫</span> ${cls.instructor}</p>
                                        <p class="flex items-center gap-2"><span class="w-4 h-4 text-zinc-500">📅</span> ${cls.scheduleDate} at ${cls.scheduleTime}</p>
                                    </div>
                                    
                                    <p class="text-xs text-zinc-500 mb-5 line-clamp-2">${cls.description}</p>
                                    
                                    <div class="flex items-center justify-between mt-auto pt-4 border-t border-zinc-800">
                                        <span class="text-xs font-medium text-zinc-400 bg-zinc-950 px-2.5 py-1 rounded-full border border-zinc-800">
                                            ${cls.enrolled}/${cls.capacity} Enrolled
                                        </span>

                                        <c:set var="alreadyBooked" value="false" />
                                        <c:forEach items="${myBookings}" var="b">
                                            <c:if test="${b.classId == cls.classId && b.status != 'cancelled'}">
                                                <c:set var="alreadyBooked" value="true" />
                                            </c:if>
                                        </c:forEach>

                                        <c:choose>
                                            <c:when test="${alreadyBooked == 'true'}">
                                                <button disabled class="text-xs font-semibold px-3 py-1.5 rounded-lg bg-zinc-800 text-zinc-500 cursor-not-allowed">
                                                    Booked
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/member/book" method="POST">
                                                    <input type="hidden" name="classId" value="${cls.classId}">
                                                    <button type="submit" class="text-xs font-semibold px-3 py-1.5 rounded-lg bg-white text-black hover:bg-zinc-200 transition-colors shadow-sm">
                                                        Book Now
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-zinc-900/30 border border-zinc-800 rounded-2xl p-8 text-center">
                            <p class="text-zinc-500 text-sm">No classes available at the moment.<br>Check back later!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

        </div> <!-- End Left Column -->

        <!-- Right Column (Sidebar) -->
        <div class="space-y-8">
            
            <!-- Membership Status Widget -->
            <section>
                <c:choose>
                    <c:when test="${activeMembership != null}">
                        <div class="relative overflow-hidden bg-zinc-900 border border-zinc-800 rounded-3xl p-6 shadow-2xl">
                            <div class="absolute -top-12 -right-12 w-32 h-32 bg-emerald-500/20 rounded-full blur-3xl"></div>
                            
                            <div class="flex items-center justify-between mb-4 relative z-10">
                                <h3 class="text-sm font-semibold text-zinc-400 uppercase tracking-widest">Active Plan</h3>
                                <span class="bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 text-xs px-2.5 py-0.5 rounded-full font-medium flex items-center gap-1.5">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span> Active
                                </span>
                            </div>
                            
                            <h2 class="text-2xl font-bold text-white mb-6 relative z-10">${activeMembership.planName}</h2>
                            
                            <div class="space-y-3 text-sm relative z-10">
                                <div class="flex justify-between items-center border-b border-zinc-800 pb-3">
                                    <span class="text-zinc-500">Started</span>
                                    <span class="text-zinc-200 font-medium">${activeMembership.startDate}</span>
                                </div>
                                <div class="flex justify-between items-center">
                                    <span class="text-zinc-500">Renews</span>
                                    <span class="text-zinc-200 font-medium">${activeMembership.endDate}</span>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-zinc-950 bg-opacity-50 border border-red-500/20 rounded-3xl p-6 text-center shadow-lg relative overflow-hidden">
                            <div class="absolute inset-0 bg-gradient-to-br from-red-500/5 to-transparent pointer-events-none"></div>
                            <div class="w-12 h-12 rounded-full bg-red-500/10 flex items-center justify-center mx-auto mb-3">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-red-400"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><path d="M12 9v4"/><path d="M12 17h.01"/></svg>
                            </div>
                            <h3 class="text-zinc-200 font-semibold mb-1">No Active Plan</h3>
                            <p class="text-xs text-zinc-500 mb-4">Contact admin to unlock features.</p>
                            <a href="${pageContext.request.contextPath}/contact" class="inline-block px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-white text-xs font-medium rounded-lg transition-colors">Contact Support</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Small Bookings List -->
            <section>
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-lg font-semibold tracking-tight text-white flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-500"><rect width="18" height="18" x="3" y="4" rx="2" ry="2"/><line x1="16" x2="16" y1="2" y2="6"/><line x1="8" x2="8" y1="2" y2="6"/><line x1="3" x2="21" y1="10" y2="10"/></svg>
                        Your Bookings
                    </h3>
                </div>
                
                <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-sm">
                    <c:choose>
                        <c:when test="${not empty myBookings}">
                            <div class="divide-y divide-zinc-800/50 max-h-96 overflow-y-auto custom-scrollbar">
                                <c:forEach items="${myBookings}" var="b">
                                    <div class="p-4 hover:bg-zinc-800/30 transition-colors flex flex-col gap-2">
                                        <div class="flex justify-between items-start">
                                            <div>
                                                <h5 class="text-sm font-semibold text-zinc-200">${b.className}</h5>
                                                <span class="text-xs text-zinc-500">${b.scheduleDate} at ${b.scheduleTime}</span>
                                            </div>
                                            <c:choose>
                                                <c:when test="${b.status == 'confirmed'}">
                                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mt-1"></span>
                                                </c:when>
                                                <c:when test="${b.status == 'cancelled'}">
                                                    <span class="w-1.5 h-1.5 rounded-full bg-red-500 mt-1"></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="w-1.5 h-1.5 rounded-full bg-zinc-500 mt-1"></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <c:if test="${b.status == 'confirmed'}">
                                            <div class="mt-1 flex justify-end">
                                                <a href="${pageContext.request.contextPath}/member/book?action=cancel&bookingId=${b.bookingId}&classId=${b.classId}"
                                                   class="text-[10px] uppercase tracking-wider font-semibold text-zinc-400 hover:text-red-400 transition-colors px-2 py-1 rounded bg-zinc-800/50 hover:bg-red-500/10 border border-transparent hover:border-red-500/20"
                                                   onclick="return confirm('Cancel this booking?');">Cancel Booking</a>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="p-6 text-center text-sm text-zinc-600">
                                You haven't booked any classes.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

        </div> <!-- End Right Column -->
    </div>
</main>

<%@ include file="../footer.jsp" %>
</body>
</html>
