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

        <body
            class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
            <%@ include file="../header.jsp" %>

                <main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

                    <!-- Flash messages are handled by the global toast system in footer.jsp -->


                    <!-- Welcome Header -->
                    <div class="mb-10">
                        <h1
                            class="text-3xl md:text-4xl font-bold tracking-tight mb-2 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
                            Welcome back, ${loggedUser.fullName}!
                        </h1>
                        <p class="text-zinc-400 text-sm md:text-base mb-6">Ready for your next workout? Browse and
                            manage your classes below.</p>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                        <!-- Left Column (Wider for classes) -->
                        <div class="lg:col-span-2 space-y-8">

                            <!-- Quick Actions -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                <!-- Book a Class -->
                                <a href="${pageContext.request.contextPath}/member/classes"
                                    class="block p-5 bg-blue-500/5 hover:bg-blue-500/10 border border-blue-500/20 rounded-2xl transition-all group">
                                    <div class="flex items-center gap-2.5 mb-3 text-blue-400 group-hover:text-blue-300">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <rect width="18" height="18" x="3" y="4" rx="2" ry="2" />
                                            <line x1="16" x2="16" y1="2" y2="6" />
                                            <line x1="8" x2="8" y1="2" y2="6" />
                                            <line x1="3" x2="21" y1="10" y2="10" />
                                            <path d="m9 16 2 2 4-4" />
                                        </svg>
                                        <h3 class="text-lg font-bold">Book a Class</h3>
                                    </div>
                                    <p
                                        class="text-sm text-zinc-400 group-hover:text-zinc-300 transition-colors leading-relaxed">
                                        Click here to browse the schedule and book an upcoming group fitness class.
                                    </p>
                                </a>

                                <!-- Book a Trainer -->
                                <a href="${pageContext.request.contextPath}/member/trainers"
                                    class="block p-5 bg-amber-500/5 hover:bg-amber-500/10 border border-amber-500/20 rounded-2xl transition-all group">
                                    <div
                                        class="flex items-center gap-2.5 mb-3 text-amber-400 group-hover:text-amber-300">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                                            <circle cx="9" cy="7" r="4" />
                                            <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                                            <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                                        </svg>
                                        <h3 class="text-lg font-bold">Book a Trainer</h3>
                                    </div>
                                    <p
                                        class="text-sm text-zinc-400 group-hover:text-zinc-300 transition-colors leading-relaxed">
                                        Click here to schedule a personalized 1-on-1 session with our expert trainers.
                                    </p>
                                </a>
                            </div>

                            <!-- Notice Board Section -->
                            <section>
                                <div class="flex items-center justify-between mb-6">
                                    <div>
                                        <h2
                                            class="text-xl font-semibold tracking-tight text-zinc-100 flex items-center gap-2">
                                            Notice Board
                                        </h2>
                                        <p class="text-zinc-400 text-sm mt-1">Stay updated with the latest announcements
                                            from staff and trainers.</p>
                                    </div>
                                </div>

                                <!-- Notices List -->
                                <div class="space-y-4 max-h-[600px] overflow-y-auto custom-scrollbar pr-2">
                                    <c:choose>
                                        <c:when test="${not empty notices}">
                                            <c:forEach items="${notices}" var="n">
                                                <div
                                                    class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-5 backdrop-blur-xl hover:border-zinc-700 transition-all relative overflow-hidden">
                                                    <div class="flex items-start justify-between gap-4">
                                                        <div class="flex-1 min-w-0">
                                                            <div class="flex flex-wrap items-center gap-2 mb-2">
                                                                <!-- Category badge -->
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${n.category == 'class_cancellation'}">
                                                                        <span
                                                                            class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-red-500/10 text-red-400 border border-red-500/20">Class
                                                                            Cancellation</span>
                                                                    </c:when>
                                                                    <c:when test="${n.category == 'holiday'}">
                                                                        <span
                                                                            class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-amber-500/10 text-amber-400 border border-amber-500/20">Holiday</span>
                                                                    </c:when>
                                                                    <c:when test="${n.category == 'maintenance'}">
                                                                        <span
                                                                            class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-orange-500/10 text-orange-400 border border-orange-500/20">Maintenance</span>
                                                                    </c:when>
                                                                    <c:when test="${n.category == 'event'}">
                                                                        <span
                                                                            class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/20">Event</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-blue-500/10 text-blue-400 border border-blue-500/20">General</span>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <span
                                                                    class="text-[10px] text-zinc-500 uppercase tracking-wider font-medium">${n.authorRole}</span>
                                                            </div>

                                                            <h3 class="text-base font-bold text-white mb-1 truncate">
                                                                ${n.title}</h3>
                                                            <p
                                                                class="text-sm text-zinc-400 leading-relaxed whitespace-pre-line">
                                                                ${n.message}</p>

                                                            <div
                                                                class="mt-3 flex items-center gap-3 text-xs text-zinc-500">
                                                                <span
                                                                    class="font-medium text-zinc-400">${n.authorName}</span>
                                                                <span>&middot;</span>
                                                                <span>${n.createdAt}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div
                                                class="bg-zinc-900/30 border border-zinc-800 rounded-2xl p-10 text-center">
                                                <div
                                                    class="w-14 h-14 rounded-full bg-zinc-800 flex items-center justify-center mx-auto mb-4">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                        class="text-zinc-500">
                                                        <path
                                                            d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z" />
                                                        <polyline points="14 2 14 8 20 8" />
                                                    </svg>
                                                </div>
                                                <h3 class="text-zinc-300 font-semibold mb-1">No notices yet</h3>
                                                <p class="text-sm text-zinc-500">When staff or trainers post
                                                    announcements, they'll appear here.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </section>

                        </div> <!-- End Left Column -->

                        <!-- Right Column (Sidebar) -->
                        <div class="space-y-8">

                            <!-- Membership Status Widget -->
                            <section>
                                <c:choose>
                                    <c:when test="${activeMembership != null}">
                                        <div
                                            class="relative overflow-hidden bg-zinc-900 border border-zinc-800 rounded-3xl p-6 shadow-2xl">
                                            <div
                                                class="absolute -top-12 -right-12 w-32 h-32 bg-emerald-500/20 rounded-full blur-3xl">
                                            </div>

                                            <div class="flex items-center justify-between mb-4 relative z-10">
                                                <h3
                                                    class="text-sm font-semibold text-zinc-400 uppercase tracking-widest">
                                                    Active Plan</h3>
                                                <span
                                                    class="bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 text-xs px-2.5 py-0.5 rounded-full font-medium flex items-center gap-1.5">
                                                    <span
                                                        class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                                                    Active
                                                </span>
                                            </div>

                                            <h2 class="text-2xl font-bold text-white mb-6 relative z-10">
                                                ${activeMembership.planName}</h2>

                                            <div class="space-y-3 text-sm relative z-10">
                                                <div
                                                    class="flex justify-between items-center border-b border-zinc-800 pb-3">
                                                    <span class="text-zinc-500">Started</span>
                                                    <span
                                                        class="text-zinc-200 font-medium">${activeMembership.startDate}</span>
                                                </div>
                                                <div class="flex justify-between items-center">
                                                    <span class="text-zinc-500">Renews</span>
                                                    <span
                                                        class="text-zinc-200 font-medium">${activeMembership.endDate}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div
                                            class="bg-zinc-950 bg-opacity-50 border border-red-500/20 rounded-3xl p-6 text-center shadow-lg relative overflow-hidden">
                                            <div
                                                class="absolute inset-0 bg-gradient-to-br from-red-500/5 to-transparent pointer-events-none">
                                            </div>
                                            <div
                                                class="w-12 h-12 rounded-full bg-red-500/10 flex items-center justify-center mx-auto mb-3">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                    class="text-red-400">
                                                    <path
                                                        d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z" />
                                                    <path d="M12 9v4" />
                                                    <path d="M12 17h.01" />
                                                </svg>
                                            </div>
                                            <h3 class="text-zinc-200 font-semibold mb-1">No Active Plan</h3>
                                            <p class="text-xs text-zinc-500 mb-4">Upgrade your plan to unlock features.
                                            </p>
                                            <a href="${pageContext.request.contextPath}/member/plans"
                                                class="inline-block px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-white text-xs font-medium rounded-lg transition-colors">Upgrade
                                                Plan</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </section>

                            <!-- Small Bookings List -->
                            <section>
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-lg font-semibold tracking-tight text-white flex items-center gap-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round" class="text-zinc-500">
                                            <rect width="18" height="18" x="3" y="4" rx="2" ry="2" />
                                            <line x1="16" x2="16" y1="2" y2="6" />
                                            <line x1="8" x2="8" y1="2" y2="6" />
                                            <line x1="3" x2="21" y1="10" y2="10" />
                                        </svg>
                                        Your Bookings
                                    </h3>
                                    <c:if test="${not empty myBookings}">
                                        <a href="${pageContext.request.contextPath}/member/book?action=cancelAll"
                                            class="text-xs px-3 py-1.5 bg-zinc-800 hover:bg-red-500/10 text-zinc-400 hover:text-red-400 border border-transparent hover:border-red-500/20 font-medium rounded-lg transition-colors shadow-sm"
                                            onclick="gpConfirm(event, 'Are you sure you want to cancel ALL your class bookings?', 'Cancel All Bookings')">Cancel
                                            All</a>
                                    </c:if>
                                </div>

                                <div
                                    class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-sm">
                                    <c:choose>
                                        <c:when test="${not empty myBookings}">
                                            <div
                                                class="divide-y divide-zinc-800/50 max-h-96 overflow-y-auto custom-scrollbar">
                                                <c:forEach items="${myBookings}" var="b">
                                                    <div
                                                        class="p-4 hover:bg-zinc-800/30 transition-colors flex flex-col gap-2">
                                                        <div class="flex justify-between items-start">
                                                            <div>
                                                                <h5 class="text-sm font-semibold text-zinc-200">
                                                                    ${b.className}</h5>
                                                                <span class="text-xs text-zinc-500">${b.scheduleDate} at
                                                                    ${b.scheduleTime}</span>
                                                            </div>
                                                            <c:choose>
                                                                <c:when test="${b.status == 'confirmed'}">
                                                                    <span
                                                                        class="w-1.5 h-1.5 rounded-full bg-emerald-500 mt-1"></span>
                                                                </c:when>
                                                                <c:when test="${b.status == 'cancelled'}">
                                                                    <span
                                                                        class="w-1.5 h-1.5 rounded-full bg-red-500 mt-1"></span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="w-1.5 h-1.5 rounded-full bg-zinc-500 mt-1"></span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <c:if test="${b.status == 'confirmed'}">
                                                            <div class="mt-1 flex justify-end">
                                                                <a href="${pageContext.request.contextPath}/member/book?action=cancel&bookingId=${b.bookingId}&classId=${b.classId}"
                                                                    class="text-[10px] uppercase tracking-wider font-semibold text-zinc-400 hover:text-red-400 transition-colors px-2 py-1 rounded bg-zinc-800/50 hover:bg-red-500/10 border border-transparent hover:border-red-500/20"
                                                                    onclick="gpConfirm(event, 'Are you sure you want to cancel this booking?', 'Cancel Booking')">Cancel
                                                                    Booking</a>
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

                            <!-- Trainer Sessions List -->
                            <section class="mt-8">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-lg font-semibold tracking-tight text-white flex items-center gap-2">
                                        <svg class="text-emerald-500 w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                        </svg>
                                        Trainer Sessions
                                    </h3>
                                    <c:if test="${not empty trainerBookings}">
                                        <a href="${pageContext.request.contextPath}/member/book-trainer?action=cancelAll"
                                            class="text-xs px-3 py-1.5 bg-zinc-800 hover:bg-red-500/10 text-zinc-400 hover:text-red-400 border border-transparent hover:border-red-500/20 font-medium rounded-lg transition-colors shadow-sm"
                                            onclick="gpConfirm(event, 'Are you sure you want to cancel ALL your trainer sessions?', 'Cancel All Sessions')">Cancel
                                            All</a>
                                    </c:if>
                                </div>
                                <div
                                    class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-sm">
                                    <c:choose>
                                        <c:when test="${not empty trainerBookings}">
                                            <div
                                                class="divide-y divide-zinc-800/50 max-h-96 overflow-y-auto custom-scrollbar">
                                                <c:forEach items="${trainerBookings}" var="tb">
                                                    <div
                                                        class="p-4 hover:bg-zinc-800/30 transition-colors flex flex-col gap-1">
                                                        <div class="flex justify-between items-start">
                                                            <div>
                                                                <h5 class="text-sm font-semibold text-emerald-400">
                                                                    Trainer: ${tb.trainerName}</h5>
                                                                <span class="text-xs text-zinc-400">${tb.date} at
                                                                    ${tb.time}</span>
                                                            </div>
                                                            <span
                                                                class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full ${tb.status == 'scheduled' ? 'bg-amber-500/10 text-amber-500' : 'bg-zinc-800 text-zinc-500'}">
                                                                ${tb.status}
                                                            </span>
                                                        </div>
                                                        <c:if test="${tb.status == 'scheduled'}">
                                                            <div class="mt-1 flex justify-end">
                                                                <a href="${pageContext.request.contextPath}/member/book-trainer?action=cancel&bookingId=${tb.bookingId}"
                                                                    class="text-[10px] uppercase tracking-wider font-semibold text-zinc-400 hover:text-red-400 transition-colors px-2 py-1 rounded bg-zinc-800/50 hover:bg-red-500/10 border border-transparent hover:border-red-500/20"
                                                                    onclick="gpConfirm(event, 'Are you sure you want to cancel this trainer session?', 'Cancel Session')">Cancel
                                                                    Session</a>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="p-6 text-center text-sm text-zinc-600">
                                                No upcoming trainer sessions.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </section>

                        </div> <!-- End Right Column -->
                    </div>

                    <!-- Upgrade Membership Modal -->
                    <c:if test="${param.error == 'membership_required'}">
                        <div id="upgrade-modal"
                            class="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm opacity-0 transition-opacity duration-300">
                            <div
                                class="bg-zinc-900 border border-amber-500/30 rounded-2xl shadow-2xl w-full max-w-md p-6 transform scale-95 transition-transform duration-300 relative overflow-hidden">
                                <div
                                    class="absolute -top-10 -right-10 w-32 h-32 bg-amber-500/10 rounded-full blur-3xl pointer-events-none">
                                </div>

                                <div class="flex items-start gap-4 mb-6">
                                    <div
                                        class="flex-shrink-0 w-12 h-12 rounded-full bg-amber-500/10 flex items-center justify-center border border-amber-500/20">
                                        <svg class="w-6 h-6 text-amber-400" fill="none" viewBox="0 0 24 24"
                                            stroke="currentColor" stroke-width="2">
                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                d="M13 10V3L4 14h7v7l9-11h-7z" />
                                        </svg>
                                    </div>
                                    <div>
                                        <h3 class="text-xl font-bold text-white mb-1">Upgrade Required</h3>
                                        <p class="text-sm text-zinc-400">Your current Basic plan doesn't include access
                                            to fitness classes.</p>
                                    </div>
                                </div>

                                <div class="bg-black/30 rounded-xl p-4 mb-6 border border-zinc-800">
                                    <p class="text-sm text-zinc-300 mb-2">Upgrade to a <strong>Standard</strong> or
                                        <strong>Premium</strong> plan to unlock:</p>
                                    <ul class="text-sm text-zinc-400 space-y-1.5 ml-1">
                                        <li class="flex items-center gap-2"><svg class="w-4 h-4 text-emerald-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M5 13l4 4L19 7"></path>
                                            </svg> Unlimited Fitness Classes</li>
                                        <li class="flex items-center gap-2"><svg class="w-4 h-4 text-emerald-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M5 13l4 4L19 7"></path>
                                            </svg> Priority Booking Access</li>
                                        <li class="flex items-center gap-2"><svg class="w-4 h-4 text-emerald-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M5 13l4 4L19 7"></path>
                                            </svg> Personal Trainer Sessions</li>
                                    </ul>
                                </div>

                                <div class="flex justify-end gap-3 mt-4">
                                    <button onclick="closeUpgradeModal()"
                                        class="px-5 py-2.5 rounded-xl text-sm font-medium text-zinc-300 hover:bg-zinc-800 transition-colors">Cancel</button>
                                    <a href="${pageContext.request.contextPath}/member/plans"
                                        class="px-5 py-2.5 rounded-xl text-sm font-bold bg-gradient-to-r from-amber-500 to-orange-500 hover:from-amber-400 hover:to-orange-400 text-white transition-all shadow-lg shadow-amber-500/25">View
                                        Plans</a>
                                </div>
                            </div>
                        </div>

                        <script>
                            // Suppress the global toast by replacing the URL state before footer.jsp runs
                            if (window.history.replaceState) {
                                const url = new URL(window.location.href);
                                url.searchParams.delete('error');
                                window.history.replaceState({ path: url.href }, '', url.href);
                            }

                            // Show modal with animation
                            setTimeout(() => {
                                const modal = document.getElementById('upgrade-modal');
                                if (modal) {
                                    modal.classList.remove('opacity-0');
                                    modal.children[0].classList.remove('scale-95');
                                }
                            }, 10);

                            function closeUpgradeModal() {
                                const modal = document.getElementById('upgrade-modal');
                                if (modal) {
                                    modal.classList.add('opacity-0');
                                    modal.children[0].classList.add('scale-95');
                                    setTimeout(() => modal.remove(), 300);
                                }
                            }
                        </script>
                    </c:if>

                </main>

                <%@ include file="../footer.jsp" %>
        </body>

        </html>