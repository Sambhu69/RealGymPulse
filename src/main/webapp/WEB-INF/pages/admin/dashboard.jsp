<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <!-- Flash Messages -->
    <c:if test="${param.success != null}">
        <div class="mb-6 px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">Operation completed successfully!</p>
        </div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="mb-6 px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">An error occurred. Please try again.</p>
        </div>
    </c:if>

    <div class="mb-10">
        <h1 class="text-3xl md:text-4xl font-bold tracking-tight mb-2 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
            Admin Overview
        </h1>
        <p class="text-zinc-400 text-sm md:text-base">Monitor and manage the GymPulse ecosystem.</p>
    </div>

    <!-- Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-6 mb-12">
        
        <div class="relative overflow-hidden bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl group hover:border-zinc-700 transition-all">
            <div class="absolute -top-10 -right-10 w-24 h-24 bg-purple-500/10 rounded-full blur-2xl group-hover:bg-purple-500/20 transition-all"></div>
            <div class="w-12 h-12 bg-purple-500/10 border border-purple-500/20 rounded-xl flex items-center justify-center mb-4">
                <span class="text-xl">👥</span>
            </div>
            <h2 class="text-4xl font-bold text-white mb-1 group-hover:-translate-y-1 transition-transform">${totalMembers}</h2>
            <p class="text-sm font-medium text-zinc-500 uppercase tracking-wider">Total Members</p>
        </div>

        <div class="relative overflow-hidden bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl group hover:border-zinc-700 transition-all">
            <div class="absolute -top-10 -right-10 w-24 h-24 bg-blue-500/10 rounded-full blur-2xl group-hover:bg-blue-500/20 transition-all"></div>
            <div class="w-12 h-12 bg-blue-500/10 border border-blue-500/20 rounded-xl flex items-center justify-center mb-4">
                <span class="text-xl">🏋️</span>
            </div>
            <h2 class="text-4xl font-bold text-white mb-1 group-hover:-translate-y-1 transition-transform">${totalClasses}</h2>
            <p class="text-sm font-medium text-zinc-500 uppercase tracking-wider">Total Classes</p>
        </div>

        <div class="relative overflow-hidden bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl group hover:border-zinc-700 transition-all">
            <div class="absolute -top-10 -right-10 w-24 h-24 bg-emerald-500/10 rounded-full blur-2xl group-hover:bg-emerald-500/20 transition-all"></div>
            <div class="w-12 h-12 bg-emerald-500/10 border border-emerald-500/20 rounded-xl flex items-center justify-center mb-4">
                <span class="text-xl">📋</span>
            </div>
            <h2 class="text-4xl font-bold text-white mb-1 group-hover:-translate-y-1 transition-transform">${totalBookings}</h2>
            <p class="text-sm font-medium text-zinc-500 uppercase tracking-wider">Active Bookings</p>
        </div>

        <div class="relative overflow-hidden bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl group hover:border-zinc-700 transition-all">
            <div class="absolute -top-10 -right-10 w-24 h-24 bg-amber-500/10 rounded-full blur-2xl group-hover:bg-amber-500/20 transition-all"></div>
            <div class="w-12 h-12 bg-amber-500/10 border border-amber-500/20 rounded-xl flex items-center justify-center mb-4">
                <span class="text-xl">💳</span>
            </div>
            <h2 class="text-4xl font-bold text-white mb-1 group-hover:-translate-y-1 transition-transform">${totalPlans}</h2>
            <p class="text-sm font-medium text-zinc-500 uppercase tracking-wider">Active Plans</p>
        </div>
        
        <div class="relative overflow-hidden bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl group hover:border-emerald-500/50 hover:shadow-[0_0_30px_rgba(16,185,129,0.15)] transition-all">
            <div class="absolute -top-10 -right-10 w-24 h-24 bg-emerald-500/20 rounded-full blur-2xl group-hover:bg-emerald-500/30 transition-all"></div>
            <div class="w-12 h-12 bg-emerald-500/10 border border-emerald-500/30 rounded-xl flex items-center justify-center mb-4">
                <span class="text-xl">💰</span>
            </div>
            <h2 class="text-4xl font-bold text-emerald-400 mb-1 group-hover:-translate-y-1 transition-transform">$${totalRevenue}</h2>
            <p class="text-sm font-medium text-zinc-500 uppercase tracking-wider">Total Revenue</p>
        </div>
        
    </div>

    <!-- Quick Actions -->
    <h2 class="text-lg font-semibold tracking-tight text-white mb-6">Quick Actions</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        
        <a href="${pageContext.request.contextPath}/admin/members" 
           class="flex items-center justify-between p-4 bg-zinc-900/50 hover:bg-zinc-800/80 border border-zinc-800 hover:border-zinc-600 rounded-xl transition-all group">
            <div class="flex items-center gap-3">
                <div class="text-zinc-400 group-hover:text-white transition-colors">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </div>
                <span class="font-medium text-zinc-300 group-hover:text-white transition-colors">Manage Members</span>
            </div>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-600 group-hover:text-zinc-400 group-hover:translate-x-1 transition-all"><path d="m9 18 6-6-6-6"/></svg>
        </a>

        <a href="${pageContext.request.contextPath}/admin/classes" 
           class="flex items-center justify-between p-4 bg-zinc-900/50 hover:bg-zinc-800/80 border border-zinc-800 hover:border-zinc-600 rounded-xl transition-all group">
            <div class="flex items-center gap-3">
                <div class="text-zinc-400 group-hover:text-white transition-colors">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 14.899A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 2.5 8.242"/><path d="M12 12v9"/><path d="m8 17 4 4 4-4"/></svg>
                </div>
                <span class="font-medium text-zinc-300 group-hover:text-white transition-colors">Manage Classes</span>
            </div>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-600 group-hover:text-zinc-400 group-hover:translate-x-1 transition-all"><path d="m9 18 6-6-6-6"/></svg>
        </a>

        <a href="${pageContext.request.contextPath}/admin/plans" 
           class="flex items-center justify-between p-4 bg-zinc-900/50 hover:bg-zinc-800/80 border border-zinc-800 hover:border-zinc-600 rounded-xl transition-all group">
            <div class="flex items-center gap-3">
                <div class="text-zinc-400 group-hover:text-white transition-colors">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="14" x="2" y="5" rx="2"/><line x1="2" x2="22" y1="10" y2="10"/></svg>
                </div>
                <span class="font-medium text-zinc-300 group-hover:text-white transition-colors">Manage Plans</span>
            </div>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-600 group-hover:text-zinc-400 group-hover:translate-x-1 transition-all"><path d="m9 18 6-6-6-6"/></svg>
        </a>

        <a href="${pageContext.request.contextPath}/admin/trainers" 
           class="flex items-center justify-between p-4 bg-zinc-900/50 hover:bg-zinc-800/80 border border-zinc-800 hover:border-zinc-600 rounded-xl transition-all group">
            <div class="flex items-center gap-3">
                <div class="text-zinc-400 group-hover:text-white transition-colors">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4Z"/></svg>
                </div>
                <span class="font-medium text-zinc-300 group-hover:text-white transition-colors">Manage Trainers</span>
            </div>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-600 group-hover:text-zinc-400 group-hover:translate-x-1 transition-all"><path d="m9 18 6-6-6-6"/></svg>
        </a>
        
    </div>

</main>

<%@ include file="../footer.jsp" %>
</body>
</html>
