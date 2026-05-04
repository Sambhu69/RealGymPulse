<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Plans — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <div class="mb-8 flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
            <h1 class="text-3xl font-bold tracking-tight mb-1 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
                Membership Plans
            </h1>
            <p class="text-zinc-400 text-sm">Create and organize platform subscription tiers.</p>
        </div>
        <button onclick="toggleAddForm()" class="px-5 py-2.5 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-xl hover:shadow-white/10 flex items-center gap-2 w-full md:w-auto justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
            Add New Plan
        </button>
    </div>

    <!-- Flash Messages -->
    <div class="space-y-3 mb-8">
        <c:if test="${param.success == 'added'}"><div class="px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md text-sm">Plan added successfully!</div></c:if>
        <c:if test="${param.success == 'updated'}"><div class="px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md text-sm">Plan updated successfully!</div></c:if>
        <c:if test="${param.success == 'deleted'}"><div class="px-4 py-3 bg-amber-500/10 border border-amber-500/20 text-amber-400 rounded-xl backdrop-blur-md text-sm">Plan deactivated successfully!</div></c:if>
        <c:if test="${param.error == 'invalid_data'}"><div class="px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md text-sm">Invalid data. Check all fields.</div></c:if>
    </div>

    <!-- Add Plan Form (collapsible) -->
    <div id="addPlanForm" class="hidden mb-10 overflow-hidden">
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-amber-500/5 rounded-full blur-3xl pointer-events-none"></div>
            <h3 class="text-lg font-bold text-white mb-4">Create New Plan</h3>
            
            <form action="${pageContext.request.contextPath}/admin/plans" method="POST" class="space-y-4">
                <input type="hidden" name="action" value="add">
                
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Plan Name</label>
                        <input type="text" name="planName" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" required>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Duration (Months)</label>
                        <input type="number" name="durationMonths" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" min="1" required>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Price ($)</label>
                        <input type="number" name="price" step="0.01" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" min="0.01" required>
                    </div>
                </div>
                
                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1">Description</label>
                    <input type="text" name="description" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors">
                </div>
                
                <div class="pt-2 flex gap-3">
                    <button type="submit" class="px-5 py-2.5 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-lg">Save Plan</button>
                    <button type="button" onclick="toggleAddForm()" class="px-5 py-2.5 bg-zinc-800 hover:bg-zinc-700 text-zinc-200 font-medium rounded-xl text-sm transition-colors border border-zinc-700">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Plans Table -->
    <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-xl shadow-2xl">
        <div class="overflow-x-auto custom-scrollbar">
            <table class="w-full text-left text-sm whitespace-nowrap">
                <thead class="bg-zinc-950/80 border-b border-zinc-800 text-zinc-400 text-xs uppercase tracking-wider">
                    <tr>
                        <th class="px-6 py-4 font-medium">Plan Name</th>
                        <th class="px-6 py-4 font-medium">Duration</th>
                        <th class="px-6 py-4 font-medium">Price</th>
                        <th class="px-6 py-4 font-medium">Description</th>
                        <th class="px-6 py-4 font-medium">Status</th>
                        <th class="px-6 py-4 font-medium text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="text-zinc-300">
                    <c:forEach items="${plans}" var="plan">
                        <tr class="hover:bg-zinc-800/30 transition-colors group">
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">
                                <div class="font-medium text-white flex items-center gap-2">
                                    <span class="h-2 w-2 rounded-full bg-amber-500"></span>
                                    ${plan.planName}
                                </div>
                            </td>
                            <td class="px-6 py-4 text-zinc-400 border-b border-zinc-800/50 group-last:border-0">${plan.durationMonths} months</td>
                            <td class="px-6 py-4 text-zinc-200 font-semibold border-b border-zinc-800/50 group-last:border-0">$${plan.price}</td>
                            <td class="px-6 py-4 text-zinc-400 truncate max-w-[200px] border-b border-zinc-800/50 group-last:border-0" title="${plan.description}">
                                ${plan.description}
                            </td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">
                                <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">Active</span>
                            </td>
                            <td class="px-6 py-4 text-right space-x-2 border-b border-zinc-800/50 group-last:border-0">
                                <button onclick="toggleEditForm('edit-${plan.planId}')" class="inline-flex items-center justify-center px-3 py-1.5 text-xs font-medium rounded-lg bg-zinc-800 text-zinc-200 hover:bg-zinc-700 transition-colors border border-zinc-700">Edit</button>
                                <form action="${pageContext.request.contextPath}/admin/plans" method="POST" class="inline-block" onsubmit="return confirm('Deactivate this plan?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="planId" value="${plan.planId}">
                                    <button type="submit" class="inline-flex items-center justify-center px-3 py-1.5 text-xs font-medium rounded-lg bg-amber-500/10 text-amber-400 hover:bg-amber-500/20 transition-colors border border-amber-500/20">Deactivate</button>
                                </form>
                            </td>
                        </tr>
                        
                        <!-- Inline Edit Row -->
                        <tr id="edit-${plan.planId}" class="hidden bg-zinc-950/50 border-t-0 p-0 m-0">
                            <td colspan="6" class="p-0 border-b border-zinc-800">
                                <div class="p-6 bg-zinc-900/50 shadow-inner block w-full">
                                    <form action="${pageContext.request.contextPath}/admin/plans" method="POST" class="space-y-4">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="planId" value="${plan.planId}">
                                        
                                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                            <div>
                                                <label class="block text-xs font-medium text-zinc-400 mb-1">Plan Name</label>
                                                <input type="text" name="planName" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" value="${plan.planName}" required>
                                            </div>
                                            <div>
                                                <label class="block text-xs font-medium text-zinc-400 mb-1">Duration (Months)</label>
                                                <input type="number" name="durationMonths" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" value="${plan.durationMonths}" min="1">
                                            </div>
                                            <div>
                                                <label class="block text-xs font-medium text-zinc-400 mb-1">Price ($)</label>
                                                <input type="number" name="price" step="0.01" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" value="${plan.price}" min="0.01">
                                            </div>
                                        </div>
                                        
                                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                            <div class="md:col-span-2">
                                                <label class="block text-xs font-medium text-zinc-400 mb-1">Description</label>
                                                <input type="text" name="description" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm" value="${plan.description}">
                                            </div>
                                            <div>
                                                <label class="block text-xs font-medium text-zinc-400 mb-1">Status</label>
                                                <select name="status" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm">
                                                    <option value="active">Active</option>
                                                    <option value="inactive">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="flex items-center gap-3 justify-end pt-2">
                                            <button type="button" class="px-4 py-2 bg-transparent text-zinc-400 hover:text-white font-medium rounded-lg text-sm transition-colors" onclick="toggleEditForm('edit-${plan.planId}')">Cancel Edit</button>
                                            <button type="submit" class="px-4 py-2 bg-white hover:bg-zinc-200 text-black font-semibold rounded-lg text-sm transition-colors">Save Changes</button>
                                        </div>
                                    </form>
                                </div>
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
function toggleAddForm() {
    var form = document.getElementById('addPlanForm');
    if (form.classList.contains('hidden')) {
        form.classList.remove('hidden');
        form.classList.add('block');
    } else {
        form.classList.add('hidden');
        form.classList.remove('block');
    }
}
function toggleEditForm(id) {
    var form = document.getElementById(id);
    if (form.classList.contains('hidden')) {
        form.classList.remove('hidden');
        form.classList.add('table-row');
    } else {
        form.classList.add('hidden');
        form.classList.remove('table-row');
    }
}
</script>
</body>
</html>
