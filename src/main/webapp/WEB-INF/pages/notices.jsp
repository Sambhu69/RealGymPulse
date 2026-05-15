<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice Board — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="header.jsp" %>

<main class="flex-grow max-w-5xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <!-- Page Header -->
    <div class="mb-8 flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
            <h1 class="text-3xl font-bold tracking-tight mb-1 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
                Notice Board
            </h1>
            <p class="text-zinc-400 text-sm">Stay updated with the latest announcements from staff and trainers.</p>
        </div>
        <c:set var="userRole" value="${sessionScope.loggedUser.role.toLowerCase()}" />
        <c:if test="${canPost || userRole == 'admin' || userRole == 'trainer' || userRole == 'instructor'}">
            <button onclick="togglePostForm()" id="togglePostBtn" class="px-5 py-2.5 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-xl hover:shadow-white/10 flex items-center gap-2 w-full md:w-auto justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
                Post Notice
            </button>
        </c:if>
    </div>

    <!-- Feedback Alerts -->
    <c:if test="${not empty param.success}">
        <div class="mb-6 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-sm flex items-center gap-3 animate-in fade-in slide-in-from-top-4 duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
            <c:choose>
                <c:when test="${param.success == 'notice_posted'}">Notice published successfully!</c:when>
                <c:when test="${param.success == 'notice_deleted'}">Notice deleted successfully.</c:when>
                <c:when test="${param.success == 'notice_updated'}">Notice updated successfully!</c:when>
                <c:otherwise>Action completed successfully.</c:otherwise>
            </c:choose>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="mb-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/20 text-red-400 text-sm flex items-center gap-3 animate-in fade-in slide-in-from-top-4 duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
            <c:choose>
                <c:when test="${param.error == 'not_authorized'}">You are not authorized for this action.</c:when>
                <c:when test="${param.error == 'invalid_data'}">Please fill in all required fields.</c:when>
                <c:when test="${param.error == 'not_found'}">Notice not found.</c:when>
                <c:otherwise>An error occurred. Please try again.</c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- Post Form (collapsible) -->
    <c:if test="${canPost || userRole == 'admin' || userRole == 'trainer' || userRole == 'instructor'}">
        <div id="postNoticeForm" class="hidden mb-10">
            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 backdrop-blur-xl shadow-2xl relative overflow-hidden">
                <div class="absolute -top-10 -right-10 w-32 h-32 bg-blue-500/5 rounded-full blur-3xl pointer-events-none"></div>
                <h3 class="text-lg font-bold text-white mb-4">Create a New Notice</h3>

                <form action="${pageContext.request.contextPath}/notices" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="post">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Title</label>
                            <input type="text" name="title" maxlength="200" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" placeholder="e.g. Morning Yoga Cancelled" required>
                        </div>
                        <div>
                            <label class="block text-xs font-medium text-zinc-400 mb-1">Category</label>
                            <select name="category" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors">
                                <option value="general">General</option>
                                <option value="class_cancellation">Class Cancellation</option>
                                <option value="holiday">Public Holiday</option>
                                <option value="maintenance">Maintenance</option>
                                <option value="event">Event</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1">Message</label>
                        <textarea name="message" rows="3" class="w-full px-3 py-2 bg-zinc-950 border border-zinc-800 rounded-lg focus:border-zinc-600 outline-none text-white text-sm transition-colors" placeholder="Describe the notice..." required></textarea>
                    </div>

                    <div class="pt-2 flex gap-3">
                        <button type="submit" class="px-5 py-2.5 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-lg">Publish Notice</button>
                        <button type="button" onclick="togglePostForm()" class="px-5 py-2.5 bg-zinc-800 hover:bg-zinc-700 text-zinc-200 font-medium rounded-xl text-sm transition-colors border border-zinc-700">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Notices List -->
    <div class="space-y-4">
        <c:choose>
            <c:when test="${not empty notices}">
                <c:forEach items="${notices}" var="n">
                    <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-5 backdrop-blur-xl hover:border-zinc-700 transition-all relative overflow-hidden group">
                        <div class="flex items-start justify-between gap-4">
                            <div class="flex-1 min-w-0">
                                <div class="flex flex-wrap items-center gap-2 mb-2">
                                    <!-- Category badge -->
                                    <c:choose>
                                        <c:when test="${n.category == 'class_cancellation'}">
                                            <span class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-red-500/10 text-red-400 border border-red-500/20">Class Cancellation</span>
                                        </c:when>
                                        <c:when test="${n.category == 'holiday'}">
                                            <span class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-amber-500/10 text-amber-400 border border-amber-500/20">Holiday</span>
                                        </c:when>
                                        <c:when test="${n.category == 'maintenance'}">
                                            <span class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-orange-500/10 text-orange-400 border border-orange-500/20">Maintenance</span>
                                        </c:when>
                                        <c:when test="${n.category == 'event'}">
                                            <span class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/20">Event</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-blue-500/10 text-blue-400 border border-blue-500/20">General</span>
                                        </c:otherwise>
                                    </c:choose>

                                    <span class="text-[10px] text-zinc-500 uppercase tracking-wider font-medium">${n.authorRole}</span>
                                </div>

                                <h3 class="text-base font-bold text-white mb-1 truncate">${n.title}</h3>
                                <p class="text-sm text-zinc-400 leading-relaxed whitespace-pre-line">${n.message}</p>

                                <div class="mt-3 flex items-center gap-3 text-xs text-zinc-500">
                                    <span class="font-medium text-zinc-400">${n.authorName}</span>
                                    <span>&middot;</span>
                                    <span>${n.createdAt}</span>
                                </div>
                            </div>

                             <!-- Edit/Delete buttons (admin only, or own notices for trainers/instructors) -->
                             <c:if test="${sessionScope.loggedUser.role == 'admin' || sessionScope.loggedUser.userId == n.authorId}">
                                 <div class="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-all flex-shrink-0">
                                     <button type="button" 
                                             data-id="${n.noticeId}" 
                                             data-title="<c:out value='${n.title}'/>" 
                                             data-message="<c:out value='${n.message}'/>" 
                                             data-category="${n.category}"
                                             onclick="openEditModal(this)" 
                                             class="p-2 rounded-lg text-zinc-600 hover:text-blue-400 hover:bg-blue-500/10 transition-colors" 
                                             title="Edit Notice">
                                         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/></svg>
                                     </button>
                                     <form action="${pageContext.request.contextPath}/notices" method="POST" onsubmit="gpConfirm(event, 'Delete this notice permanently?', 'Delete Notice');">
                                         <input type="hidden" name="action" value="delete">
                                         <input type="hidden" name="noticeId" value="${n.noticeId}">
                                         <button type="submit" class="p-2 rounded-lg text-zinc-600 hover:text-red-400 hover:bg-red-500/10 transition-colors" title="Delete Notice">
                                             <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/></svg>
                                         </button>
                                     </form>
                                 </div>
                             </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="bg-zinc-900/30 border border-zinc-800 rounded-2xl p-10 text-center">
                    <div class="w-14 h-14 rounded-full bg-zinc-800 flex items-center justify-center mx-auto mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-500"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg>
                    </div>
                    <h3 class="text-zinc-300 font-semibold mb-1">No notices yet</h3>
                    <p class="text-sm text-zinc-500">When staff or trainers post announcements, they'll appear here.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</main>

<!-- Edit Notice Modal -->
<div id="editNoticeModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-4">
    <div class="absolute inset-0 bg-black/80 backdrop-blur-sm" onclick="closeEditModal()"></div>
    <div class="bg-zinc-900 border border-zinc-800 rounded-3xl p-6 w-full max-w-lg relative shadow-2xl shadow-black">
        <h3 class="text-xl font-bold text-white mb-6">Edit Notice</h3>
        
        <form action="${pageContext.request.contextPath}/notices" method="POST" class="space-y-4">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="noticeId" id="editNoticeId">

            <div>
                <label class="block text-xs font-medium text-zinc-400 mb-1">Title</label>
                <input type="text" name="title" id="editTitle" maxlength="200" class="w-full px-3 py-2.5 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors" required>
            </div>

            <div>
                <label class="block text-xs font-medium text-zinc-400 mb-1">Category</label>
                <select name="category" id="editCategory" class="w-full px-3 py-2.5 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors">
                    <option value="general">General</option>
                    <option value="class_cancellation">Class Cancellation</option>
                    <option value="holiday">Public Holiday</option>
                    <option value="maintenance">Maintenance</option>
                    <option value="event">Event</option>
                </select>
            </div>

            <div>
                <label class="block text-xs font-medium text-zinc-400 mb-1">Message</label>
                <textarea name="message" id="editMessage" rows="5" class="w-full px-3 py-2.5 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors" required></textarea>
            </div>

            <div class="pt-4 flex gap-3">
                <button type="submit" class="flex-grow py-3 bg-white hover:bg-zinc-200 text-black font-bold rounded-2xl text-sm transition-all shadow-xl">Update Notice</button>
                <button type="button" onclick="closeEditModal()" class="px-6 py-3 bg-zinc-800 hover:bg-zinc-700 text-zinc-300 font-bold rounded-2xl text-sm transition-colors border border-zinc-700">Cancel</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
<script>
    function togglePostForm() {
        var form = document.getElementById('postNoticeForm');
        form.classList.toggle('hidden');
    }

    function openEditModal(btn) {
        document.getElementById('editNoticeId').value = btn.getAttribute('data-id');
        document.getElementById('editTitle').value = btn.getAttribute('data-title');
        document.getElementById('editMessage').value = btn.getAttribute('data-message');
        document.getElementById('editCategory').value = btn.getAttribute('data-category');
        document.getElementById('editNoticeModal').classList.remove('hidden');
        document.body.style.overflow = 'hidden'; // Prevent scrolling
    }

    function closeEditModal() {
        document.getElementById('editNoticeModal').classList.add('hidden');
        document.body.style.overflow = ''; // Restore scrolling
    }
</script>
</body>
</html>
