<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Trainers — Admin — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">
    <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between mb-10 gap-4">
        <div>
            <h1 class="text-3xl md:text-4xl font-bold tracking-tight mb-2 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
                Manage Trainers
            </h1>
            <p class="text-zinc-400 text-sm md:text-base">View, add, edit, and manage all trainer profiles.</p>
        </div>
        <div>
            <button onclick="toggleAddForm()" class="px-4 py-2 bg-white text-black font-semibold rounded-lg shadow-md hover:bg-zinc-200 transition-colors">
                + Add Trainer
            </button>
        </div>
    </div>

    <!-- Flash messages are handled by the global toast system in footer.jsp -->


    <!-- Add Trainer Form (Hidden by default) -->
    <div id="addTrainerForm" class="hidden bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden mb-8">
        <h3 class="text-lg font-bold text-white mb-4">Add New Trainer</h3>
        <form action="${pageContext.request.contextPath}/admin/trainers" method="POST" class="space-y-4">
            <input type="hidden" name="action" value="add">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1">Full Name</label>
                    <input type="text" name="fullName" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white" required>
                </div>
                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1">Email</label>
                    <input type="email" name="email" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white" required>
                </div>
                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1">Phone</label>
                    <input type="text" name="phone" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white" required>
                </div>
                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1">Initial Password</label>
                    <input type="password" name="password" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white" required>
                </div>
                <div class="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Specializations</label>
                        <input type="text" name="specializations" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white" placeholder="e.g. Strength, Cardio" required>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Bio</label>
                        <textarea name="bio" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white" rows="1" required></textarea>
                    </div>
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="toggleAddForm()" class="px-4 py-2 bg-zinc-800 text-zinc-300 rounded-lg">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-white text-black font-semibold rounded-lg">Create Trainer</button>
            </div>
        </form>
    </div>

    <!-- Edit Trainer Section -->
    <c:if test="${not empty selectedTrainer}">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-10">
            <!-- Edit Trainer Profile -->
            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden">
                <div class="flex items-center justify-between mb-5 border-b border-zinc-800/50 pb-4">
                    <div>
                        <h3 class="text-base font-bold text-white leading-tight">Editing Trainer Profile</h3>
                        <p class="text-xs text-zinc-400">${selectedTrainer.fullName}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/trainers" class="text-zinc-400 hover:text-white">&times; Close</a>
                </div>
                
                <form action="${pageContext.request.contextPath}/admin/trainers" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="profileId" value="${selectedTrainer.profileId}">
                    <input type="hidden" name="userId" value="${selectedTrainer.userId}">
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Full Name</label>
                            <input type="text" name="fullName" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" value="${selectedTrainer.fullName}" required>
                        </div>
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Phone</label>
                            <input type="text" name="phone" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" required>
                            <p class="text-[10px] text-zinc-500 mt-1">Please enter current or new phone</p>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Specializations</label>
                            <input type="text" name="specializations" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" value="${selectedTrainer.specializations}" required>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Bio</label>
                            <textarea name="bio" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" rows="3" required>${selectedTrainer.bio}</textarea>
                        </div>
                    </div>
                    
                    <div class="pt-2">
                        <button type="submit" class="w-full py-2 bg-white hover:bg-zinc-200 text-black font-semibold rounded-lg text-sm transition-colors shadow-lg">Save Profile Changes</button>
                    </div>
                </form>
            </div>

            <!-- Trainer Security -->
            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden h-fit">
                <h3 class="text-lg font-bold text-white mb-4">Security & Account</h3>
                
                <form action="${pageContext.request.contextPath}/admin/trainers" method="POST" class="space-y-4 mb-6">
                    <input type="hidden" name="action" value="password">
                    <input type="hidden" name="userId" value="${selectedTrainer.userId}">
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Set New Password</label>
                        <div class="flex gap-2">
                            <input type="password" name="newPassword" class="flex-1 px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg text-white text-sm" placeholder="New password" required>
                            <button type="submit" class="px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-zinc-200 text-sm font-medium rounded-lg border border-zinc-700">Update</button>
                        </div>
                    </div>
                </form>

                <hr class="border-zinc-800 my-4">

                <div class="p-4 bg-red-500/5 border border-red-500/20 rounded-xl">
                    <h4 class="text-red-400 font-bold mb-2">Danger Zone</h4>
                    <p class="text-xs text-zinc-400 mb-4">Deleting this trainer will permanently remove their profile and all associated data.</p>
                    <form action="${pageContext.request.contextPath}/admin/trainers" method="POST" onsubmit="return confirm('Are you sure you want to permanently delete this trainer?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" value="${selectedTrainer.userId}">
                        <button type="submit" class="px-4 py-2 bg-red-500/10 hover:bg-red-500/20 text-red-400 text-sm font-bold rounded-lg border border-red-500/20 w-full">Delete Trainer Account</button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-xl">
        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm whitespace-nowrap">
                <thead class="bg-zinc-950/50 text-zinc-400 uppercase tracking-wider text-xs border-b border-zinc-800">
                    <tr>
                        <th class="px-6 py-4 font-semibold">Trainer Name</th>
                        <th class="px-6 py-4 font-semibold">Specializations</th>
                        <th class="px-6 py-4 font-semibold">Rating</th>
                        <th class="px-6 py-4 font-semibold text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-zinc-800/50 text-zinc-300">
                    <c:forEach items="${trainers}" var="t">
                        <tr class="hover:bg-zinc-800/30 transition-colors">
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 rounded-full bg-zinc-800 flex items-center justify-center overflow-hidden">
                                        <img src="${pageContext.request.contextPath}/img/profiles/${t.profileImage}" onerror="this.style.display='none'" class="w-full h-full object-cover">
                                    </div>
                                    <span class="font-medium text-white">${t.fullName}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-zinc-400">${t.specializations}</td>
                            <td class="px-6 py-4 text-emerald-400 font-bold">⭐ ${t.rating}</td>
                            <td class="px-6 py-4 text-right">
                                <a href="${pageContext.request.contextPath}/admin/trainers?action=view&profileId=${t.profileId}" class="px-3 py-1 bg-zinc-800 hover:bg-zinc-700 text-white rounded transition text-xs border border-zinc-700">Edit / Manage</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty trainers}">
                        <tr>
                            <td colspan="4" class="px-6 py-8 text-center text-zinc-500">
                                No trainers found in the system.
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
        const form = document.getElementById('addTrainerForm');
        form.classList.toggle('hidden');
    }
</script>
</body>
</html>
