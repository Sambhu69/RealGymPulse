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

<!-- External CSS (professor's guideline: use external CSS, avoid inline styles) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<% 
    String uri = request.getRequestURI();
    boolean isAdminDashboard = uri.endsWith("admin/dashboard");
    boolean isAdminMembers = uri.endsWith("admin/members");
    boolean isAdminClasses = uri.endsWith("admin/classes");
    boolean isAdminPlans = uri.endsWith("admin/plans");
    boolean isAdminTrainers = uri.endsWith("admin/trainers");
    boolean isMemberDashboard = uri.endsWith("member/dashboard");
    boolean isMemberProfile = uri.endsWith("member/profile");
    boolean isTrainerDashboard = uri.endsWith("trainer/dashboard");
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

        <!-- Navigation Links -->
        <div class="flex items-center gap-1 px-2">
            <c:choose>
                <c:when test="${sessionScope.loggedUser.role == 'admin'}">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminDashboard ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/members" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminMembers ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Members
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/classes" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminClasses ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Classes
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/plans" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminPlans ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Plans
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/trainers" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isAdminTrainers ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Trainers
                        </a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.loggedUser.role == 'member'}">
                    <li>
                        <a href="${pageContext.request.contextPath}/member/dashboard" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isMemberDashboard ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/member/profile" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isMemberProfile ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Profile
                        </a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.loggedUser.role == 'trainer'}">
                    <li>
                        <a href="${pageContext.request.contextPath}/trainer/dashboard" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 
                           <%= isTrainerDashboard ? "nav-tab-active" : "text-zinc-400 hover:text-white hover:bg-white/5" %>">
                           Dashboard
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                     <li>
                        <a href="${pageContext.request.contextPath}/login" 
                           class="block px-4 py-2 text-xs font-semibold uppercase tracking-widest rounded-full transition-all duration-200 text-zinc-400 hover:text-white hover:bg-white/5">
                           Login
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${sessionScope.loggedUser != null}">
            <div class="h-6 w-[1px] bg-white/10 mx-1"></div>
            
            <li class="flex items-center gap-2 pl-2 pr-1">
                <a href="${pageContext.request.contextPath}/logout" class="block px-3 py-2 text-[10px] md:text-xs font-bold uppercase tracking-widest text-zinc-500 hover:text-red-400 hover:bg-red-500/10 rounded-full transition-all duration-200">
                    Logout
                </a>
                
                <div class="flex items-center gap-2.5 px-3 py-1.5 bg-zinc-900 rounded-full border border-white/5 shadow-inner">
                    <div class="relative flex items-center justify-center">
                        <div class="h-2 w-2 rounded-full bg-emerald-500 absolute animate-ping opacity-75"></div>
                        <div class="h-2 w-2 rounded-full bg-emerald-500 relative"></div>
                    </div>
                    <span class="text-[10px] md:text-xs font-bold text-zinc-300 uppercase tracking-widest truncate max-w-[100px] md:max-w-[150px]">
                        ${sessionScope.loggedUser.fullName}
                    </span>
                </div>
            </li>
        </c:if>

    </ul>
</div>

<div class="pt-28"></div>

