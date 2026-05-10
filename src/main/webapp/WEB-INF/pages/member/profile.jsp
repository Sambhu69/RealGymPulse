<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile — GymPulse</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-5xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <div class="mb-8">
        <h1 class="text-3xl font-bold tracking-tight mb-2 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
            Profile Settings
        </h1>
        <p class="text-zinc-400 text-sm">Manage your account details and security preferences.</p>
    </div>

    <!-- Flash messages are handled by the global toast system in footer.jsp -->


    <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-start">

        <!-- Profile Info Card -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-8 backdrop-blur-xl shadow-2xl relative overflow-hidden group">
            <div class="absolute -top-10 -left-10 w-32 h-32 bg-blue-500/5 rounded-full blur-3xl pointer-events-none group-hover:bg-blue-500/10 transition-colors duration-500"></div>
            <h3 class="text-xl font-bold text-white mb-6 flex items-center gap-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-blue-500"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                Basic Information
            </h3>
            
            <form action="${pageContext.request.contextPath}/member/profile" method="POST" enctype="multipart/form-data" class="space-y-5 relative z-10">
                <input type="hidden" name="action" value="updateProfile">

                <!-- Profile image preview -->
                <div class="flex items-center gap-6">
                    <div class="relative w-24 h-24 rounded-full border-2 border-zinc-700 overflow-hidden flex items-center justify-center bg-zinc-950 flex-shrink-0">
                        <c:if test="${not empty userProfile.profileImage}">
                            <img src="${pageContext.request.contextPath}/${userProfile.profileImage}" alt="Profile" class="w-full h-full object-cover">
                        </c:if>
                        <c:if test="${empty userProfile.profileImage}">
                            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-600"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        </c:if>
                    </div>
                    <div class="flex-1">
                        <label class="block text-xs font-medium text-zinc-400 mb-2">Update Photo</label>
                        <input type="file" name="profileImage" accept="image/*" class="w-full text-sm text-zinc-500 file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-sm file:font-semibold file:bg-zinc-800 file:text-zinc-200 hover:file:bg-zinc-700 transition-colors outline-none cursor-pointer">
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1.5">Full Name</label>
                    <input type="text" name="fullName" class="w-full px-4 py-3 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors shadow-inner" value="${userProfile.fullName}" required>
                </div>
                
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1.5 flex items-center gap-2">Email Address <span class="px-2 py-0.5 rounded text-[10px] font-medium bg-zinc-800/50 text-zinc-500">Read-only</span></label>
                        <p class="w-full px-4 py-3 bg-zinc-950/50 border border-zinc-800/50 rounded-xl text-zinc-500 text-sm cursor-not-allowed select-none">${userProfile.userEmail}</p>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-zinc-400 mb-1.5 flex items-center gap-2">Member Since <span class="px-2 py-0.5 rounded text-[10px] font-medium bg-zinc-800/50 text-zinc-500">Read-only</span></label>
                        <p class="w-full px-4 py-3 bg-zinc-950/50 border border-zinc-800/50 rounded-xl text-zinc-500 text-sm cursor-not-allowed select-none">${userProfile.createdAt}</p>
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1.5">Phone Number</label>
                    <input type="text" name="phone" class="w-full px-4 py-3 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors shadow-inner" value="${userProfile.phone}" maxlength="10" required>
                </div>

                <div class="pt-4">
                    <button type="submit" class="w-full py-3 bg-white hover:bg-zinc-200 text-black font-semibold rounded-xl text-sm transition-all shadow-xl hover:shadow-white/10">Save Profile Updates</button>
                </div>
            </form>
        </div>

        <!-- Change Password Card -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-8 backdrop-blur-xl shadow-2xl relative overflow-hidden group">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-purple-500/5 rounded-full blur-3xl pointer-events-none group-hover:bg-purple-500/10 transition-colors duration-500"></div>
            <h3 class="text-xl font-bold text-white mb-6 flex items-center gap-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-purple-500"><rect width="18" height="11" x="3" y="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                Security & Authentication
            </h3>
            
            <form action="${pageContext.request.contextPath}/member/profile" method="POST" id="passwordForm" onsubmit="return validatePasswords()" class="space-y-5 relative z-10">
                <input type="hidden" name="action" value="changePassword">
                
                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1.5">Current Password</label>
                    <input type="password" name="currentPassword" class="w-full px-4 py-3 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors shadow-inner" placeholder="••••••••" required>
                </div>
                
                <hr class="border-zinc-800 my-4">

                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1.5">New Password</label>
                    <input type="password" name="newPassword" id="newPassword" class="w-full px-4 py-3 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors shadow-inner" placeholder="••••••••" required>
                </div>
                <div>
                    <label class="block text-xs font-medium text-zinc-400 mb-1.5">Confirm New Password</label>
                    <input type="password" name="confirmPassword" id="confirmPassword" class="w-full px-4 py-3 bg-zinc-950 border border-zinc-800 rounded-xl focus:border-zinc-600 outline-none text-white text-sm transition-colors shadow-inner" placeholder="••••••••" required>
                </div>
                
                <div id="pwError" class="hidden px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md text-xs font-medium"></div>
                
                <div class="pt-4">
                    <button type="submit" class="w-full py-3 bg-zinc-800 hover:bg-zinc-700 text-white font-semibold rounded-xl text-sm transition-colors border border-zinc-700 shadow-lg">Update Password</button>
                </div>
            </form>
        </div>

    </div>
</main>

<%@ include file="../footer.jsp" %>

<script>
function validatePasswords() {
    var np = document.getElementById('newPassword').value;
    var cp = document.getElementById('confirmPassword').value;
    var errDiv = document.getElementById('pwError');
    if (np !== cp) {
        errDiv.textContent = 'Passwords do not match.';
        errDiv.classList.remove('hidden');
        errDiv.classList.add('block');
        return false;
    }
    errDiv.classList.add('hidden');
    errDiv.classList.remove('block');
    return true;
}
</script>
</body>
</html>
