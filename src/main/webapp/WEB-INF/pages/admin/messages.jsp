<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Direct Messages — Admin</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <!-- Flash Messages -->
    <c:if test="${param.success != null}">
        <div class="mb-6 px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">Direct message sent successfully!</p>
        </div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="mb-6 px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">An error occurred. Please try again.</p>
        </div>
    </c:if>

    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
        <div>
            <h1 class="text-3xl font-bold tracking-tight text-white mb-1">Direct Messages</h1>
            <p class="text-zinc-400 text-sm">Send private messages to any member, trainer, or instructor.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="inline-flex items-center gap-2 px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-white rounded-lg transition-colors text-sm font-medium">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
            Back to Dashboard
        </a>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Search and List Panel -->
        <div class="lg:col-span-1 bg-zinc-900/50 border border-zinc-800 rounded-2xl flex flex-col h-[600px] overflow-hidden backdrop-blur-md">
            <div class="p-4 border-b border-zinc-800">
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-500"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
                    </div>
                    <input type="text" id="userSearch" placeholder="Search users by name..." class="w-full pl-10 pr-4 py-2 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors" onkeyup="filterUsers()">
                </div>
            </div>
            
            <div class="flex-1 overflow-y-auto p-2 space-y-1 custom-scrollbar" id="userList">
                <c:forEach items="${usersList}" var="u">
                    <button type="button" id="user-btn-${u.userId}" onclick="selectUser('${u.userId}', '${u.fullName}', '${u.role}', '${u.userEmail}')" class="user-item w-full flex items-center gap-3 p-3 rounded-xl hover:bg-zinc-800/80 transition-colors text-left border border-transparent" data-name="${u.fullName.toLowerCase()}">
                        <div class="w-10 h-10 rounded-full bg-zinc-800 flex items-center justify-center flex-shrink-0 text-zinc-400 font-bold uppercase overflow-hidden">
                            <c:if test="${u.profileImage != null && u.profileImage != 'default.png'}">
                                <img src="${pageContext.request.contextPath}/uploads/${u.profileImage}" alt="avatar" class="w-full h-full object-cover">
                            </c:if>
                            <c:if test="${u.profileImage == null || u.profileImage == 'default.png'}">
                                ${u.fullName.substring(0, 1)}
                            </c:if>
                        </div>
                        <div class="flex-1 min-w-0">
                            <h4 class="text-sm font-semibold text-white truncate">${u.fullName}</h4>
                            <div class="flex items-center gap-2 mt-0.5">
                                <span class="text-[10px] uppercase tracking-wider font-bold px-1.5 py-0.5 rounded-md
                                    <c:choose>
                                        <c:when test="${u.role == 'admin'}">bg-red-500/10 text-red-400</c:when>
                                        <c:when test="${u.role == 'trainer'}">bg-purple-500/10 text-purple-400</c:when>
                                        <c:when test="${u.role == 'instructor'}">bg-blue-500/10 text-blue-400</c:when>
                                        <c:otherwise>bg-emerald-500/10 text-emerald-400</c:otherwise>
                                    </c:choose>
                                ">${u.role}</span>
                            </div>
                        </div>
                    </button>
                </c:forEach>
            </div>
        </div>

        <!-- Messaging Panel -->
        <div class="lg:col-span-2 bg-zinc-900/50 border border-zinc-800 rounded-2xl flex flex-col h-[600px] backdrop-blur-md relative overflow-hidden">
            <div id="noUserSelected" class="absolute inset-0 flex flex-col items-center justify-center text-center p-8 z-10 bg-zinc-900/50 backdrop-blur-sm">
                <div class="w-16 h-16 rounded-full bg-zinc-800 flex items-center justify-center mb-4 text-zinc-500">
                    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                </div>
                <h3 class="text-xl font-bold text-white mb-2">Select a Recipient</h3>
                <p class="text-zinc-400">Search and select a user from the list to start composing a direct message.</p>
            </div>


            <div class="flex-1 p-6 overflow-y-auto">
                <form action="${pageContext.request.contextPath}/admin/messages" method="post" id="messageForm" class="space-y-5 h-full flex flex-col">
                    <input type="hidden" name="action" value="send">
                    <input type="hidden" name="receiverIds" id="formReceiverIds">

                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Send To</label>
                        <div id="selectedUsersContainer" class="w-full min-h-[50px] px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-xl flex flex-wrap items-center gap-2">
                            <span class="text-sm text-zinc-500 italic px-1">Select users from the list on the left...</span>
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Message Title</label>
                        <input type="text" name="title" id="formTitle" class="w-full px-4 py-3 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white transition-colors" placeholder="e.g. Follow-up on your membership" required>
                    </div>

                    <div class="flex-1 flex flex-col">
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Message Content</label>
                        <textarea name="message" id="formMessage" class="flex-1 w-full px-4 py-3 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white transition-colors resize-none" placeholder="Type your message here..." required></textarea>
                    </div>

                    <div class="flex justify-end pt-2">
                        <button type="submit" class="px-6 py-3 bg-white hover:bg-zinc-200 text-black font-bold rounded-xl transition-all shadow-lg shadow-white/10 flex items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="22" x2="11" y1="2" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
                            Send Message
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</main>

<%@ include file="../footer.jsp" %>
<style>
    .custom-scrollbar::-webkit-scrollbar {
        width: 6px;
    }
    .custom-scrollbar::-webkit-scrollbar-track {
        background: transparent;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb {
        background-color: #3f3f46;
        border-radius: 10px;
    }
</style>
<script>
    function filterUsers() {
        const input = document.getElementById('userSearch');
        const filter = input.value.toLowerCase();
        const items = document.getElementsByClassName('user-item');

        for (let i = 0; i < items.length; i++) {
            const name = items[i].getAttribute('data-name');
            if (name.indexOf(filter) > -1) {
                items[i].style.display = "";
            } else {
                items[i].style.display = "none";
            }
        }
    }

    let selectedUsers = {};

    function selectUser(id, name, role, email) {
        document.getElementById('noUserSelected').classList.add('hidden');
        
        const btnId = 'user-btn-' + id;
        const btn = document.getElementById(btnId);

        if (selectedUsers[id]) {
            delete selectedUsers[id];
            if(btn) {
                btn.classList.remove('bg-blue-500/10', 'border-blue-500/50');
                btn.classList.add('border-transparent');
            }
        } else {
            selectedUsers[id] = { name: name, role: role, email: email };
            if(btn) {
                btn.classList.add('bg-blue-500/10', 'border-blue-500/50');
                btn.classList.remove('border-transparent');
            }
        }

        updateSelectedUI();
    }

    function removeUser(id) {
        delete selectedUsers[id];
        const btn = document.getElementById('user-btn-' + id);
        if (btn) {
            btn.classList.remove('bg-blue-500/10', 'border-blue-500/50');
            btn.classList.add('border-transparent');
        }
        updateSelectedUI();
    }

    function escapeHTML(str) {
        if (!str) return "";
        const div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    }

    function updateSelectedUI() {
        const container = document.getElementById('selectedUsersContainer');
        const hiddenInput = document.getElementById('formReceiverIds');
        const ids = Object.keys(selectedUsers);
        
        hiddenInput.value = ids.join(',');

        if (ids.length === 0) {
            container.innerHTML = '<span class="text-sm text-zinc-500 italic px-1">Select users from the list on the left...</span>';
            document.getElementById('noUserSelected').classList.remove('hidden');
            return;
        }

        container.innerHTML = '';
        ids.forEach(id => {
            const u = selectedUsers[id];
            const badge = document.createElement('div');
            badge.className = 'flex items-center gap-2 bg-zinc-800 hover:bg-zinc-700 transition-colors border border-zinc-700 px-3 py-1 rounded-lg text-sm text-white animate-in zoom-in duration-200 shadow-sm';
            badge.innerHTML = `
                <span class="font-medium">${escapeHTML(u.name)}</span>
                <span class="text-[9px] font-bold text-zinc-400 tracking-wider uppercase bg-zinc-900 px-1.5 py-0.5 rounded-md">${u.role}</span>
                <button type="button" onclick="removeUser('${id}')" class="text-zinc-400 hover:text-red-400 focus:outline-none ml-1 transition-colors">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                </button>
            `;
            container.appendChild(badge);
        });
    }
</script>
</body>
</html>
