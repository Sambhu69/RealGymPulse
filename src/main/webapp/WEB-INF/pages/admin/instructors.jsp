<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Instructors — Admin — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">
    <div class="mb-8 flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
            <h1 class="text-3xl font-bold tracking-tight mb-1 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
                Manage Instructors
            </h1>
            <p class="text-zinc-400 text-sm">View, add, edit, and manage all instructor profiles.</p>
        </div>
        <button onclick="toggleAddForm()" class="px-5 py-2.5 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-xl hover:shadow-white/10 flex items-center gap-2 w-full md:w-auto justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
            Add New Instructor
        </button>
    </div>

    <!-- Add Instructor Form -->
    <div id="addInstructorForm" class="hidden mb-10 overflow-hidden">
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-blue-500/5 rounded-full blur-3xl pointer-events-none"></div>
            <h3 class="text-lg font-bold text-white mb-4">Add New Instructor</h3>
            
            <form action="${pageContext.request.contextPath}/admin/instructors" method="POST" class="space-y-4">
                <input type="hidden" name="action" value="add">
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Full Name</label>
                        <input type="text" name="fullName" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" required>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Email</label>
                        <input type="email" name="email" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" required>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Phone</label>
                        <input type="text" name="phone" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" required>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Initial Password</label>
                        <input type="password" name="password" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" required>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Specializations</label>
                        <input type="text" name="specializations" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" placeholder="e.g. Yoga, HIIT, Pilates" required>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Bio</label>
                        <textarea name="bio" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" rows="2" required></textarea>
                    </div>
                </div>
                
                <div class="pt-2 flex gap-3">
                    <button type="submit" class="px-5 py-2.5 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-lg">Create Instructor</button>
                    <button type="button" onclick="toggleAddForm()" class="px-5 py-2.5 bg-zinc-800 hover:bg-zinc-700 text-zinc-200 font-medium rounded-xl text-sm transition-colors border border-zinc-700">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Instructor Section -->
    <c:if test="${not empty selectedInstructor}">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-10">
            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden">
                <div class="absolute -top-10 -right-10 w-32 h-32 bg-blue-500/5 rounded-full blur-3xl pointer-events-none"></div>
                <div class="flex items-center justify-between mb-6 border-b border-zinc-800/50 pb-4">
                    <div>
                        <h3 class="text-lg font-bold text-white leading-tight">Edit Instructor Profile</h3>
                        <p class="text-xs text-zinc-400">Updating ${selectedInstructor.fullName}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/instructors" class="p-2 hover:bg-zinc-800 rounded-lg text-zinc-400 hover:text-white transition-colors">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
                    </a>
                </div>
                
                <form action="${pageContext.request.contextPath}/admin/instructors" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="profileId" value="${selectedInstructor.profileId}">
                    <input type="hidden" name="userId" value="${selectedInstructor.userId}">
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="md:col-span-2">
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Email (Account ID)</label>
                            <input type="text" class="w-full px-3 py-2 bg-zinc-950/50 border border-zinc-800/50 rounded-lg text-zinc-500 text-sm cursor-not-allowed" value="${selectedInstructor.email}" readonly>
                        </div>
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Full Name</label>
                            <input type="text" name="fullName" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" value="${selectedInstructor.fullName}" required>
                        </div>
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Phone</label>
                            <input type="text" name="phone" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" value="${selectedInstructor.phone}" required>
                            <p class="text-[10px] text-zinc-500 mt-1">Confirm or enter new phone</p>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Specializations</label>
                            <input type="text" name="specializations" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" value="${selectedInstructor.specializations}" required>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Bio</label>
                            <textarea name="bio" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" rows="3" required>${selectedInstructor.bio}</textarea>
                        </div>
                    </div>
                    
                    <div class="pt-2">
                        <button type="submit" class="w-full py-2.5 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-lg">Save Profile Changes</button>
                    </div>
                </form>
            </div>

            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden h-fit">
                <div class="absolute -top-10 -right-10 w-32 h-32 bg-red-500/5 rounded-full blur-3xl pointer-events-none"></div>
                <h3 class="text-lg font-bold text-white mb-6">Security & Account</h3>
                
                <c:if test="${selectedInstructor.status == 'locked'}">
                    <div class="mb-6 p-4 bg-amber-500/10 border border-amber-500/20 rounded-xl flex items-center justify-between gap-4">
                        <div>
                            <p class="text-amber-400 font-semibold text-sm">Account Locked</p>
                            <p class="text-zinc-400 text-xs mt-1">This instructor's account is locked.</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/instructors" method="POST">
                            <input type="hidden" name="action" value="unlock">
                            <input type="hidden" name="userId" value="${selectedInstructor.userId}">
                            <button type="submit" class="px-4 py-2 bg-amber-500/20 hover:bg-amber-500/30 text-amber-400 text-sm font-medium rounded-lg border border-amber-500/30 transition-colors">Unlock</button>
                        </form>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/instructors" method="POST" class="space-y-4 mb-8">
                    <input type="hidden" name="action" value="password">
                    <input type="hidden" name="userId" value="${selectedInstructor.userId}">
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1.5">Reset Password</label>
                        <div class="flex gap-2">
                            <input type="password" name="newPassword" class="flex-1 px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" placeholder="New password" required>
                            <button type="submit" class="px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-zinc-200 text-sm font-medium rounded-lg border border-zinc-700 transition-colors">Update</button>
                        </div>
                    </div>
                </form>
                
                <div class="space-y-4">
                    <div class="text-xs font-semibold text-red-500/80 uppercase tracking-wider">Danger Zone</div>
                    <div class="p-4 bg-red-500/5 border border-red-500/10 rounded-xl">
                        <form action="${pageContext.request.contextPath}/admin/instructors" method="POST" onsubmit="gpConfirm(event, 'Are you sure you want to permanently delete this instructor?', 'Delete Instructor');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="userId" value="${selectedInstructor.userId}">
                            <button type="submit" class="w-full py-2.5 bg-red-500/10 hover:bg-red-500/20 text-red-400 text-xs font-bold rounded-xl border border-red-500/20 transition-all">Delete Instructor Account</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-xl shadow-2xl">
        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm whitespace-nowrap">
                <thead class="bg-zinc-950/80 border-b border-zinc-800 text-zinc-400 text-xs uppercase tracking-wider">
                    <tr>
                        <th class="px-6 py-4 font-medium">Instructor Name</th>
                        <th class="px-6 py-4 font-medium">Specializations</th>
                        <th class="px-6 py-4 font-medium">Rating</th>
                        <th class="px-6 py-4 font-medium text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="text-zinc-300">
                    <c:forEach items="${instructors}" var="i">
                        <tr class="hover:bg-zinc-800/30 transition-colors group">
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 rounded-full bg-zinc-800 border border-zinc-700 flex items-center justify-center overflow-hidden">
                                        <img src="${pageContext.request.contextPath}/img/profiles/${i.profileImage}" onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.png'; this.onerror=null;" class="w-full h-full object-cover">
                                    </div>
                                    <span class="font-semibold text-white">${i.fullName}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-zinc-400 border-b border-zinc-800/50 group-last:border-0">${i.specializations}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">
                                <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-bold bg-blue-500/10 text-blue-400 border border-blue-500/20">⭐ ${i.rating}</span>
                            </td>
                            <td class="px-6 py-4 text-right border-b border-zinc-800/50 group-last:border-0">
                                <a href="${pageContext.request.contextPath}/admin/instructors?action=view&profileId=${i.profileId}" class="inline-flex items-center justify-center px-3 py-1.5 text-xs font-medium rounded-lg bg-zinc-800 text-zinc-200 hover:bg-zinc-700 transition-colors border border-zinc-700">Edit / Manage</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty instructors}">
                        <tr>
                            <td colspan="4" class="px-6 py-8 text-center text-zinc-500">
                                No instructors found.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</main>

<%@ include file="../footer.jsp" %>
<script>
    function toggleAddForm() {
        const form = document.getElementById('addInstructorForm');
        form.classList.toggle('hidden');
    }
</script>
</body>
</html>
