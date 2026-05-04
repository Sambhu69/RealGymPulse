<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Members — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <div class="mb-8 flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
            <h1 class="text-3xl font-bold tracking-tight mb-1 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
                Manage Members
            </h1>
            <p class="text-zinc-400 text-sm">View, edit, and assign plans to users.</p>
        </div>
        
        <!-- Search bar -->
        <div class="relative w-full md:w-72">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-4 w-4 text-zinc-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
            </div>
            <input type="text" id="memberSearch" placeholder="Search by name or email..." onkeyup="filterTable()" 
                   class="w-full pl-10 pr-4 py-2 bg-zinc-900/50 border border-zinc-800 rounded-xl focus:ring-2 focus:ring-zinc-700 outline-none text-sm text-white placeholder-zinc-500 transition-all backdrop-blur-md">
        </div>
    </div>

    <!-- Flash Messages -->
    <div class="space-y-3 mb-8">
        <c:if test="${param.success == 'deleted'}"><div class="px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md text-sm">Member deleted successfully.</div></c:if>
        <c:if test="${param.success == 'updated'}"><div class="px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md text-sm">Member updated successfully.</div></c:if>
        <c:if test="${param.success == 'password_changed'}"><div class="px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md text-sm">Password changed successfully.</div></c:if>
        <c:if test="${param.error == 'delete_failed'}"><div class="px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md text-sm">Failed to delete member.</div></c:if>
        <c:if test="${param.error == 'invalid_data'}"><div class="px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md text-sm">Invalid input data.</div></c:if>
        <c:if test="${param.error == 'weak_password'}"><div class="px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md text-sm">Password too weak. Min 8 chars, 1 upper, 1 number, 1 special char.</div></c:if>
    </div>

    <!-- Edit Form (shown when member is selected for view) -->
    <c:if test="${member != null}">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-10">
            <!-- Edit Member Profile -->
            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden">
                <div class="absolute -top-10 -right-10 w-24 h-24 bg-blue-500/5 rounded-full blur-2xl pointer-events-none"></div>
                
                <div class="flex items-center gap-3 mb-5 border-b border-zinc-800/50 pb-4 relative z-10">
                    <div class="h-10 w-10 rounded-full bg-blue-500/10 border border-blue-500/20 flex items-center justify-center">
                        <span class="text-blue-400 font-bold text-lg">${member.fullName.substring(0,1).toUpperCase()}</span>
                    </div>
                    <div>
                        <h3 class="text-base font-bold text-white leading-tight">Editing Profile</h3>
                        <p class="text-xs text-zinc-400">${member.fullName}</p>
                    </div>
                </div>
                
                <form action="${pageContext.request.contextPath}/admin/members" method="POST" class="space-y-4 relative z-10">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="userId" value="${member.userId}">
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Full Name</label>
                            <input type="text" name="fullName" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" value="${member.fullName}" required>
                        </div>
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Phone</label>
                            <input type="text" name="phone" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" value="${member.phone}" maxlength="10" required>
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Status</label>
                        <select name="status" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm">
                            <option value="active" ${member.status == 'active' ? 'selected' : ''}>Active</option>
                            <option value="locked" ${member.status == 'locked' ? 'selected' : ''}>Locked</option>
                            <option value="inactive" ${member.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    
                    <div class="pt-2">
                        <button type="submit" class="w-full py-2 bg-white hover:bg-zinc-200 text-black font-semibold rounded-lg text-sm transition-colors shadow-lg">Save Profile Changes</button>
                    </div>
                </form>

                <hr class="border-zinc-800 my-6">

                <h3 class="text-sm font-semibold text-zinc-300 mb-3">Security</h3>
                <form action="${pageContext.request.contextPath}/admin/members" method="POST" class="flex gap-2">
                    <input type="hidden" name="action" value="changePassword">
                    <input type="hidden" name="userId" value="${member.userId}">
                    <input type="password" name="newPassword" class="flex-1 w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" placeholder="New Password..." required>
                    <button type="submit" class="px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-zinc-200 text-sm font-medium rounded-lg transition-colors border border-zinc-700 hover:border-zinc-600">Reset</button>
                </form>
            </div>

            <!-- Membership Info & Assignment -->
            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden">
                <div class="absolute -top-10 -right-10 w-24 h-24 bg-emerald-500/5 rounded-full blur-2xl pointer-events-none"></div>
                <h3 class="text-lg font-bold text-white mb-4">Current Membership</h3>
                
                <c:choose>
                    <c:when test="${activeMembership != null}">
                        <div class="bg-emerald-500/5 border border-emerald-500/20 rounded-xl p-4 mb-6">
                            <div class="flex justify-between items-center mb-2">
                                <span class="font-medium text-emerald-400">${activeMembership.planName}</span>
                                <span class="flex h-2 w-2 rounded-full bg-emerald-500 animate-pulse"></span>
                            </div>
                            <p class="text-xs text-zinc-400">Valid Until: <span class="text-zinc-200">${activeMembership.endDate}</span></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-red-500/5 border border-red-500/20 rounded-xl p-4 mb-6">
                            <p class="text-sm text-red-400 font-medium text-center">No active membership.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <hr class="border-zinc-800 my-6">
                
                <h3 class="text-sm font-semibold text-zinc-300 mb-3">Assign New Plan</h3>
                <form action="${pageContext.request.contextPath}/admin/members" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="assignPlan">
                    <input type="hidden" name="userId" value="${member.userId}">
                    <div>
                        <select name="planId" class="w-full px-3 py-2.5 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" required>
                            <option value="">-- Choose a Plan --</option>
                            <c:forEach items="${allPlans}" var="plan">
                                <option value="${plan.planId}">${plan.planName} - $${plan.price} (${plan.durationMonths} Months)</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="w-full py-2 bg-emerald-600 hover:bg-emerald-500 text-white font-semibold rounded-lg text-sm transition-colors shadow-lg shadow-emerald-900/20">Assign Selected Plan</button>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Members Table -->
    <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-xl shadow-2xl">
        <div class="overflow-x-auto custom-scrollbar">
            <table id="membersTable" class="w-full text-left text-sm whitespace-nowrap">
                <thead class="bg-zinc-950/80 border-b border-zinc-800 text-zinc-400 text-xs uppercase tracking-wider">
                    <tr>
                        <th class="px-6 py-4 font-medium">ID</th>
                        <th class="px-6 py-4 font-medium">Full Name</th>
                        <th class="px-6 py-4 font-medium">Email</th>
                        <th class="px-6 py-4 font-medium">Phone</th>
                        <th class="px-6 py-4 font-medium">Status</th>
                        <th class="px-6 py-4 font-medium text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="text-zinc-300">
                    <c:forEach items="${members}" var="m">
                        <tr class="hover:bg-zinc-800/30 transition-colors group">
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">${m.userId}</td>
                            <td class="px-6 py-4 font-medium text-white border-b border-zinc-800/50 group-last:border-0">${m.fullName}</td>
                            <td class="px-6 py-4 text-zinc-500 border-b border-zinc-800/50 group-last:border-0">${m.userEmail}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">${m.phone}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">
                                <c:choose>
                                    <c:when test="${m.status == 'active'}"><span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">Active</span></c:when>
                                    <c:when test="${m.status == 'locked'}"><span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">Locked</span></c:when>
                                    <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-zinc-500/10 text-zinc-400 border border-zinc-500/20">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 text-right space-x-2 border-b border-zinc-800/50 group-last:border-0">
                                <a href="${pageContext.request.contextPath}/admin/members?action=view&userId=${m.userId}" class="inline-flex items-center justify-center px-3 py-1.5 text-xs font-medium rounded-lg bg-zinc-800 text-zinc-200 hover:bg-zinc-700 transition-colors border border-zinc-700">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/members?action=delete&userId=${m.userId}" class="inline-flex items-center justify-center px-3 py-1.5 text-xs font-medium rounded-lg bg-red-500/10 text-red-400 hover:bg-red-500/20 transition-colors border border-red-500/20" onclick="return confirm('Are you sure you want to delete this member?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<%@ include file="../footer.jsp" %>

<script>
function filterTable() {
    var input = document.getElementById('memberSearch').value.toLowerCase();
    var rows = document.querySelectorAll('#membersTable tbody tr');
    rows.forEach(function(row) {
        var name = row.cells[1].textContent.toLowerCase();
        var email = row.cells[2].textContent.toLowerCase();
        row.style.display = (name.includes(input) || email.includes(input)) ? '' : 'none';
    });
}
</script>
</body>
</html>
