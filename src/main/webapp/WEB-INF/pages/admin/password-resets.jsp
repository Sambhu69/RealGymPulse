<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset Requests — Admin Dashboard</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        background: '#09090b', // zinc-950
                    }
                }
            }
        }
    </script>
    <style>
        body { background-color: #09090b; color: white; }
    </style>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">

<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <div class="mb-10 flex items-center justify-between">
        <div>
            <h1 class="text-3xl md:text-4xl font-bold tracking-tight mb-2 bg-clip-text text-transparent bg-gradient-to-r from-white to-zinc-400">
                Password Reset Requests
            </h1>
            <p class="text-zinc-400 text-sm md:text-base">Manage and respond to user account recovery requests.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-white text-sm font-medium rounded-lg transition-colors border border-zinc-700">Back to Dashboard</a>
    </div>

    <!-- Requests Table -->
    <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl overflow-hidden backdrop-blur-xl shadow-2xl">
        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm whitespace-nowrap">
                <thead class="bg-zinc-950/80 border-b border-zinc-800 text-zinc-400 text-xs uppercase tracking-wider">
                    <tr>
                        <th class="px-6 py-4 font-medium">Request ID</th>
                        <th class="px-6 py-4 font-medium">Full Name</th>
                        <th class="px-6 py-4 font-medium">Phone</th>
                        <th class="px-6 py-4 font-medium">Email (Optional)</th>
                        <th class="px-6 py-4 font-medium">Date</th>
                        <th class="px-6 py-4 font-medium">Status</th>
                        <th class="px-6 py-4 font-medium text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="text-zinc-300">
                    <c:forEach items="${resetRequests}" var="req">
                        <tr class="hover:bg-zinc-800/30 transition-colors group">
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0 text-zinc-500">#${req.requestId}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0 font-semibold text-white">${req.fullName}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0 text-zinc-400">${req.phone}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0 text-zinc-400">${req.email != null ? req.email : 'N/A'}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0 text-zinc-500">${req.createdAt}</td>
                            <td class="px-6 py-4 border-b border-zinc-800/50 group-last:border-0">
                                <c:choose>
                                    <c:when test="${req.status == 'pending'}">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-bold bg-amber-500/10 text-amber-400 border border-amber-500/20">Pending</span>
                                    </c:when>
                                    <c:when test="${req.status == 'resolved'}">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-bold bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">Resolved</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-bold bg-red-500/10 text-red-400 border border-red-500/20">Rejected</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 text-right border-b border-zinc-800/50 group-last:border-0 flex justify-end gap-2">
                                <c:if test="${req.status == 'pending'}">
                                    <form action="${pageContext.request.contextPath}/admin/password-resets" method="POST">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="requestId" value="${req.requestId}">
                                        <input type="hidden" name="status" value="resolved">
                                        <button type="submit" class="px-3 py-1.5 bg-emerald-500/10 hover:bg-emerald-500/20 text-emerald-400 text-xs font-medium rounded-lg border border-emerald-500/20 transition-colors">Mark Resolved</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/password-resets" method="POST">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="requestId" value="${req.requestId}">
                                        <input type="hidden" name="status" value="rejected">
                                        <button type="submit" class="px-3 py-1.5 bg-red-500/10 hover:bg-red-500/20 text-red-400 text-xs font-medium rounded-lg border border-red-500/20 transition-colors">Reject</button>
                                    </form>
                                </c:if>
                                <c:if test="${req.status != 'pending'}">
                                    <span class="text-xs text-zinc-600 italic px-3 py-1.5">Completed</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty resetRequests}">
                        <tr>
                            <td colspan="7" class="px-6 py-8 text-center text-zinc-500">
                                No password reset requests found.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</main>

<%@ include file="../footer.jsp" %>
</body>
</html>
