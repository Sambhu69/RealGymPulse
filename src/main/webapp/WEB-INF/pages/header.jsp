<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Google Fonts: Outfit -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<script src="https://cdn.tailwindcss.com"></script>
<script>
    tailwind.config = {
        darkMode: 'class',
        theme: {
            extend: {
                fontFamily: {
                    sans: ['Outfit', 'sans-serif'],
                },
                colors: {
                    background: '#09090b', // zinc-950
                }
            }
        }
    }
</script>

<!-- External CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">

<style>
    /* Global Scrollbar Reset for all elements */
    * {
        scrollbar-width: thin;
        scrollbar-color: #27272a #09090b;
    }

    ::-webkit-scrollbar {
        width: 10px;
        height: 10px;
    }

    ::-webkit-scrollbar-track {
        background: #09090b;
    }

    ::-webkit-scrollbar-thumb {
        background: #27272a;
        border-radius: 10px;
        border: 2px solid #09090b;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: #3f3f46;
    }
    
    .custom-scrollbar::-webkit-scrollbar {
        width: 6px;
    }

    /* ===== Responsive Navbar (Plain CSS — no Tailwind dependency) ===== */
    /* Desktop default: show full nav, hide hamburger */
    #gp-nav-links   { display: flex !important; }
    #gp-nav-divider { display: block !important; }
    #gp-nav-logout  { display: block !important; }
    #gp-nav-user    { display: flex !important; }
    #gp-nav-hamburger { display: none !important; }

    /* Mobile: hide full nav, show hamburger */
    @media (max-width: 767px) {
        #gp-nav-links   { display: none !important; }
        #gp-nav-divider { display: none !important; }
        #gp-nav-logout  { display: none !important; }
        #gp-nav-user    { display: none !important; }
        #gp-nav-hamburger { display: flex !important; }
    }
</style>

<% 
    String uri = request.getRequestURI();
    boolean isAdminDashboard = uri.endsWith("admin/dashboard");
    boolean isAdminMembers = uri.endsWith("admin/members");
    boolean isAdminClasses = uri.endsWith("admin/classes");
    boolean isAdminPlans = uri.endsWith("admin/plans");
    boolean isAdminTrainers = uri.endsWith("admin/trainers");
    boolean isAdminInstructors = uri.endsWith("admin/instructors");
    boolean isMemberDashboard = uri.endsWith("member/dashboard");
    boolean isMemberProfile = uri.endsWith("member/profile");
    boolean isInstructorProfile = uri.endsWith("instructor/profile");
    boolean isTrainerProfile = uri.endsWith("trainer/profile");
    boolean isTrainerDashboard = uri.endsWith("trainer/dashboard");
    boolean isNotices = uri.endsWith("notices");
%>

<div class="w-full flex justify-center py-6 fixed top-0 z-50 pointer-events-none">
    <!-- Ultra-Premium Pure CSS Pill Navbar -->
    <ul class="mx-auto flex items-center w-fit rounded-full border border-white/10 bg-zinc-950/70 backdrop-blur-xl p-1.5 pointer-events-auto shadow-2xl shadow-black/50">
        
        <!-- Logo Section -->
        <li class="flex items-center mr-2">
            <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2.5 px-3 py-1.5 rounded-full hover:bg-white/5 transition-all duration-300 group">
                <div class="h-7 w-7 bg-white rounded-full flex items-center justify-center p-1.5 shadow-[0_0_15px_rgba(255,255,255,0.15)] group-hover:shadow-[0_0_20px_rgba(255,255,255,0.3)] transition-shadow">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-full h-full text-black">
                        <path d="M2 12H5L8 4L12 20L16 12H22" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <span class="font-bold tracking-wider text-sm text-white uppercase pr-1 hidden sm:block">GymPulse</span>
            </a>
        </li>

        <div class="h-6 w-[1px] bg-white/10 mx-1"></div>

        <!-- Navigation Links (hidden on mobile, flex on desktop) -->
        <div id="gp-nav-links" class="items-center gap-1 px-2">
            <c:choose>
                <c:when test="${sessionScope.loggedUser.role == 'admin'}">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminDashboard ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/members" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminMembers ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Members
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/classes" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminClasses ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Classes
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/plans" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminPlans ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Plans
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/trainers" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminTrainers ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Trainers
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/instructors" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminInstructors ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Instructors
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/notices" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isNotices ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Notices
                        </a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.loggedUser.role == 'member'}">
                    <li>
                        <a href="${pageContext.request.contextPath}/member/dashboard" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isMemberDashboard ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/member/profile" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isMemberProfile ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Profile
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/notices" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isNotices ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Notices
                        </a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.loggedUser.role == 'trainer'}">
                    <li>
                        <a href="${pageContext.request.contextPath}/trainer/dashboard" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isTrainerDashboard ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/trainer/profile" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isTrainerProfile ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Profile
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/notices" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isNotices ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Notices
                        </a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.loggedUser.role == 'instructor'}">
                    <% boolean isInstructorDashboard = uri.endsWith("instructor/dashboard"); %>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/dashboard" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isInstructorDashboard ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/profile" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isInstructorProfile ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Profile
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/notices" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 
                           <%= isNotices ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Notices
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                     <li>
                        <a href="${pageContext.request.contextPath}/login" 
                           class="block px-2.5 xl:px-4 py-1.5 xl:py-2 text-[10px] xl:text-xs font-semibold uppercase tracking-wider xl:tracking-widest rounded-full transition-all duration-200 text-zinc-400 hover:text-white hover:bg-white/5">
                           Login
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${sessionScope.loggedUser != null}">
            <div id="gp-nav-divider" class="h-6 w-[1px] bg-white/10 mx-1"></div>
            
            <li class="flex items-center gap-2 pl-2 pr-1">
                <!-- Notification Bell -->
                <div class="relative" id="gp-notif-wrapper">
                    <button onclick="toggleNotifPanel()" class="relative p-2 rounded-full text-zinc-400 hover:text-white hover:bg-white/5 transition-all duration-200" title="Notifications">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9"/><path d="M10.3 21a1.94 1.94 0 0 0 3.4 0"/></svg>
                        <span id="gp-notif-dot" class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full hidden"></span>
                    </button>
                    
                    <!-- Notification Dropdown -->
                    <div id="gp-notif-panel" class="hidden absolute right-0 top-full mt-2 w-80 bg-zinc-900/95 backdrop-blur-xl border border-zinc-800 rounded-2xl shadow-2xl shadow-black/50 z-[60] overflow-hidden">
                        <div class="flex items-center justify-between px-4 py-3 border-b border-zinc-800">
                            <span class="text-xs font-bold text-zinc-300 uppercase tracking-widest">Recent Notices</span>
                            <div class="flex items-center gap-3">
                                <button onclick="clearNotices()" class="text-[10px] font-semibold text-zinc-500 hover:text-zinc-300 uppercase tracking-wider transition-colors">Clear All</button>
                                <a href="${pageContext.request.contextPath}/notices" class="text-[10px] font-semibold text-blue-400 hover:text-blue-300 uppercase tracking-wider transition-colors">View All</a>
                            </div>
                        </div>
                        <div id="gp-notif-list" class="max-h-72 overflow-y-auto custom-scrollbar">
                            <div class="px-4 py-6 text-center text-xs text-zinc-500">Loading...</div>
                        </div>
                    </div>
                </div>

                <a id="gp-nav-logout" href="${pageContext.request.contextPath}/logout" class="px-2 xl:px-3 py-1.5 xl:py-2 text-[10px] xl:text-xs font-bold uppercase tracking-wider xl:tracking-widest text-zinc-500 hover:text-red-400 hover:bg-red-500/10 rounded-full transition-all duration-200">
                    Logout
                </a>
                
                <div id="gp-nav-user" class="items-center gap-2.5 px-2 xl:px-3 py-1 xl:py-1.5 bg-zinc-900 rounded-full border border-white/5 shadow-inner">
                    <div class="relative flex items-center justify-center">
                        <div class="h-2 w-2 rounded-full bg-emerald-500 absolute animate-ping opacity-75"></div>
                        <div class="h-2 w-2 rounded-full bg-emerald-500 relative"></div>
                    </div>
                    <span class="text-[10px] xl:text-xs font-bold text-zinc-300 uppercase tracking-wider xl:tracking-widest truncate max-w-[80px] xl:max-w-[150px]">
                        ${sessionScope.loggedUser.fullName}
                    </span>
                </div>
            </li>
        </c:if>

        <!-- Mobile Menu Toggle Button (always visible on mobile) -->
        <li id="gp-nav-hamburger" class="items-center pl-2 border-l border-white/10">
            <button onclick="toggleMobileMenu()" class="p-2 rounded-full text-zinc-400 hover:text-white hover:bg-white/5 transition-all duration-200" title="Menu">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="4" x2="20" y1="12" y2="12"></line>
                    <line x1="4" x2="20" y1="6" y2="6"></line>
                    <line x1="4" x2="20" y1="18" y2="18"></line>
                </svg>
            </button>
        </li>

    </ul>
</div>

<!-- Mobile Drawer Menu Overlay -->
<div id="gp-mobile-menu" class="fixed inset-y-0 right-0 w-full sm:w-96 bg-zinc-950/98 backdrop-blur-2xl z-[998] flex flex-col justify-between p-8 pt-32 transition-transform duration-300 ease-out transform translate-x-full border-l border-white/5 hidden pointer-events-auto shadow-2xl">
    <!-- Mobile Menu Header -->
    <div class="flex items-center justify-between border-b border-white/5 pb-6">
        <div class="flex items-center gap-2.5">
            <div class="h-7 w-7 bg-white rounded-full flex items-center justify-center p-1.5 shadow-[0_0_15px_rgba(255,255,255,0.15)] animate-pulse">
                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-full h-full text-black">
                    <path d="M2 12H5L8 4L12 20L16 12H22" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <span class="font-bold tracking-wider text-sm text-white uppercase">GymPulse</span>
        </div>
        <button onclick="toggleMobileMenu()" class="p-2 rounded-full text-zinc-400 hover:text-white hover:bg-white/5 transition-all duration-200">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" x2="6" y1="6" y2="18"/><line x1="6" x2="18" y1="6" y2="18"/></svg>
        </button>
    </div>

    <!-- Navigation Links -->
    <div class="flex-grow flex flex-col justify-center space-y-6 my-8 py-4 overflow-y-auto custom-scrollbar">
        <c:choose>
            <c:when test="${sessionScope.loggedUser.role == 'admin'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isAdminDashboard ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/members" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isAdminMembers ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Members</a>
                <a href="${pageContext.request.contextPath}/admin/classes" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isAdminClasses ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Classes</a>
                <a href="${pageContext.request.contextPath}/admin/plans" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isAdminPlans ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Plans</a>
                <a href="${pageContext.request.contextPath}/admin/trainers" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isAdminTrainers ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Trainers</a>
                <a href="${pageContext.request.contextPath}/admin/instructors" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isAdminInstructors ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Instructors</a>
                <a href="${pageContext.request.contextPath}/notices" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isNotices ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Notices</a>
            </c:when>
            <c:when test="${sessionScope.loggedUser.role == 'member'}">
                <a href="${pageContext.request.contextPath}/member/dashboard" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isMemberDashboard ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Dashboard</a>
                <a href="${pageContext.request.contextPath}/member/profile" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isMemberProfile ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Profile</a>
                <a href="${pageContext.request.contextPath}/notices" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isNotices ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Notices</a>
            </c:when>
            <c:when test="${sessionScope.loggedUser.role == 'trainer'}">
                <a href="${pageContext.request.contextPath}/trainer/dashboard" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isTrainerDashboard ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Dashboard</a>
                <a href="${pageContext.request.contextPath}/trainer/profile" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isTrainerProfile ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Profile</a>
                <a href="${pageContext.request.contextPath}/notices" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isNotices ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Notices</a>
            </c:when>
            <c:when test="${sessionScope.loggedUser.role == 'instructor'}">
                <% boolean isInstructorDashboardMobile = uri.endsWith("instructor/dashboard"); %>
                <a href="${pageContext.request.contextPath}/instructor/dashboard" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isInstructorDashboardMobile ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Dashboard</a>
                <a href="${pageContext.request.contextPath}/instructor/profile" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isInstructorProfile ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Profile</a>
                <a href="${pageContext.request.contextPath}/notices" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider <%= isNotices ? "text-white bg-white/5 px-4 py-2.5 rounded-xl border border-white/10" : "text-zinc-500 hover:text-white px-4 py-2" %> transition-all duration-200">Notices</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" onclick="toggleMobileMenu()" class="block text-xl font-bold uppercase tracking-wider text-zinc-500 hover:text-white px-4 py-2 transition-all duration-200">Login</a>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Mobile Menu Footer -->
    <div class="border-t border-white/5 pt-6 animate-pulse">
        <c:choose>
            <c:when test="${sessionScope.loggedUser != null}">
                <div class="space-y-4">
                    <div class="flex items-center gap-3 p-4 bg-white/5 border border-white/5 rounded-2xl">
                        <div class="relative flex items-center justify-center">
                            <div class="h-2.5 w-2.5 rounded-full bg-emerald-500 absolute animate-ping opacity-75"></div>
                            <div class="h-2.5 w-2.5 rounded-full bg-emerald-500 relative"></div>
                        </div>
                        <div>
                            <div class="text-[10px] text-zinc-500 font-bold uppercase tracking-wider">${sessionScope.loggedUser.role}</div>
                            <div class="text-sm font-bold text-white">${sessionScope.loggedUser.fullName}</div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="w-full flex items-center justify-center gap-2 py-3.5 bg-red-500/10 hover:bg-red-500/20 text-red-400 border border-red-500/20 hover:border-red-500/30 text-xs font-bold uppercase tracking-widest rounded-2xl transition-all duration-300">
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg>
                        Logout
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="w-full flex items-center justify-center gap-2 py-3.5 bg-white text-black text-xs font-bold uppercase tracking-widest rounded-2xl hover:bg-zinc-200 transition-all duration-300 shadow-lg shadow-white/5">
                    Login
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="pt-28"></div>

<!-- Notification Bell Script -->
<script>
(function() {
    var panelOpen = false;
    var contextPath = '${pageContext.request.contextPath}';
    var currentUserId = '${sessionScope.loggedUser.userId}';
    var storageKey = 'gp_last_seen_notice_id_' + currentUserId;
    var clearKey = 'gp_cleared_notice_id_' + currentUserId;

    window.clearNotices = function() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', contextPath + '/api/notices', true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var data = JSON.parse(xhr.responseText);
                    if (data && data.length > 0) {
                        localStorage.setItem(clearKey, data[0].noticeId);
                        localStorage.setItem(storageKey, data[0].noticeId);
                    }
                    document.getElementById('gp-notif-list').innerHTML = '<div class="px-4 py-6 text-center text-xs text-zinc-500">No new notices.</div>';
                    document.getElementById('gp-notif-dot').classList.add('hidden');
                } catch(e) {}
            }
        };
        xhr.send();
    };

    window.toggleNotifPanel = function() {
        var panel = document.getElementById('gp-notif-panel');
        panelOpen = !panelOpen;
        if (panelOpen) {
            panel.classList.remove('hidden');
            loadNotifications(true); // pass true to indicate it was opened by user
        } else {
            panel.classList.add('hidden');
        }
    };

    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        var wrapper = document.getElementById('gp-notif-wrapper');
        if (wrapper && !wrapper.contains(e.target) && panelOpen) {
            document.getElementById('gp-notif-panel').classList.add('hidden');
            panelOpen = false;
        }
    });

    var categoryColors = {
        'class_cancellation': 'bg-red-500/10 text-red-400',
        'holiday': 'bg-amber-500/10 text-amber-400',
        'maintenance': 'bg-orange-500/10 text-orange-400',
        'event': 'bg-purple-500/10 text-purple-400',
        'general': 'bg-blue-500/10 text-blue-400'
    };
    var categoryLabels = {
        'class_cancellation': 'Cancellation',
        'holiday': 'Holiday',
        'maintenance': 'Maintenance',
        'event': 'Event',
        'general': 'General'
    };

    function loadNotifications(markAsSeen) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', contextPath + '/api/notices', true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var data = JSON.parse(xhr.responseText);
                    if (markAsSeen && data && data.length > 0) {
                        localStorage.setItem(storageKey, data[0].noticeId);
                        document.getElementById('gp-notif-dot').classList.add('hidden');
                    }
                    renderNotifications(data);
                } catch(e) {
                    document.getElementById('gp-notif-list').innerHTML = '<div class="px-4 py-6 text-center text-xs text-zinc-500">Failed to load.</div>';
                }
            }
        };
        xhr.send();
    }

    function escapeHTML(str) {
        if (!str) return "";
        var div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    }

    function renderNotifications(items) {
        var list = document.getElementById('gp-notif-list');
        var dot = document.getElementById('gp-notif-dot');

        var clearedId = parseInt(localStorage.getItem(clearKey) || '0');
        var filteredItems = [];
        for (var j = 0; j < items.length; j++) {
            if (items[j].noticeId > clearedId) {
                filteredItems.push(items[j]);
            }
        }

        if (filteredItems.length === 0) {
            list.innerHTML = '<div class="px-4 py-6 text-center text-xs text-zinc-500">No new notices.</div>';
            dot.classList.add('hidden');
            return;
        }

        items = filteredItems;

        var latestNoticeId = items[0].noticeId;
        var lastSeenId = localStorage.getItem(storageKey);
        
        if (!lastSeenId || parseInt(lastSeenId) < latestNoticeId) {
            dot.classList.remove('hidden');
        } else {
            dot.classList.add('hidden');
        }

        var html = '';
        for (var i = 0; i < items.length; i++) {
            var n = items[i];
            var catClass = categoryColors[n.category] || categoryColors['general'];
            var catLabel = categoryLabels[n.category] || 'General';
            html += '<a href="' + contextPath + '/notices" class="block px-4 py-3 hover:bg-zinc-800/50 transition-colors border-b border-zinc-800/50 last:border-0">';
            html += '<div class="flex items-center gap-2 mb-1">';
            html += '<span class="text-[9px] uppercase font-bold px-1.5 py-px rounded ' + catClass + '">' + catLabel + '</span>';
            html += '<span class="text-[10px] text-zinc-600">' + escapeHTML(n.authorName) + '</span>';
            html += '</div>';
            html += '<p class="text-xs font-medium text-zinc-200 truncate">' + escapeHTML(n.title) + '</p>';
            html += '<p class="text-[10px] text-zinc-500 mt-0.5">' + formatTime(n.createdAt) + '</p>';
            html += '</a>';
        }
        list.innerHTML = html;
    }

    function formatTime(ts) {
        if (!ts) return '';
        try {
            var d = new Date(ts.replace(' ', 'T'));
            var now = new Date();
            var diff = Math.floor((now - d) / 60000);
            if (diff < 1) return 'Just now';
            if (diff < 60) return diff + 'm ago';
            if (diff < 1440) return Math.floor(diff/60) + 'h ago';
            return Math.floor(diff/1440) + 'd ago';
        } catch(e) { return ts; }
    }

    // Pre-load on page ready to set dot indicator
    document.addEventListener('DOMContentLoaded', function() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', contextPath + '/api/notices', true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var data = JSON.parse(xhr.responseText);
                    if (data && data.length > 0) {
                        var clearedId = parseInt(localStorage.getItem(clearKey) || '0');
                        var latestNoticeId = data[0].noticeId;
                        if (latestNoticeId > clearedId) {
                            var lastSeenId = localStorage.getItem(storageKey);
                            if (!lastSeenId || parseInt(lastSeenId) < latestNoticeId) {
                                document.getElementById('gp-notif-dot').classList.remove('hidden');
                            }
                        }
                    }
                } catch(e) {}
            }
        };
        xhr.send();
    });
})();
</script>

<script>
function toggleMobileMenu() {
    var menu = document.getElementById('gp-mobile-menu');
    if (!menu) return;
    var isHidden = menu.classList.contains('hidden');
    if (isHidden) {
        menu.classList.remove('hidden');
        requestAnimationFrame(function() {
            menu.classList.remove('translate-x-full');
            menu.classList.add('translate-x-0');
        });
        document.body.style.overflow = 'hidden'; // Lock background scroll
    } else {
        menu.classList.remove('translate-x-0');
        menu.classList.add('translate-x-full');
        menu.addEventListener('transitionend', function handler() {
            menu.classList.add('hidden');
            menu.removeEventListener('transitionend', handler);
        }, { once: true });
        document.body.style.overflow = ''; // Unlock background scroll
    }
}
</script>

