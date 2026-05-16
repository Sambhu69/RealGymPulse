<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Queries — Admin</title>
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="../header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-36">

    <!-- Flash Messages -->
    <c:if test="${param.success != null}">
        <div class="mb-6 px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">
                <c:choose>
                    <c:when test="${param.success == 'query_resolved'}">Query marked as resolved.</c:when>
                    <c:when test="${param.success == 'query_deleted'}">Query deleted successfully.</c:when>
                    <c:otherwise>Operation completed successfully!</c:otherwise>
                </c:choose>
            </p>
        </div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="mb-6 px-4 py-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl backdrop-blur-md">
            <p class="font-medium text-sm">An error occurred. Please try again.</p>
        </div>
    </c:if>

    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
        <div>
            <h1 class="text-3xl font-bold tracking-tight text-white mb-1">Customer Queries</h1>
            <p class="text-zinc-400 text-sm">View and resolve messages submitted through the Contact Us form.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="inline-flex items-center gap-2 px-4 py-2 bg-zinc-800 hover:bg-zinc-700 text-white rounded-lg transition-colors text-sm font-medium">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
            Back to Dashboard
        </a>
    </div>

    <!-- Queries List -->
    <div class="space-y-4">
        <c:choose>
            <c:when test="${not empty queries}">
                <c:forEach items="${queries}" var="q">
                    <div class="bg-zinc-900/50 border border-zinc-800 hover:border-zinc-700 rounded-2xl p-6 transition-all relative overflow-hidden group">
                        
                        <!-- Status indicator -->
                        <div class="absolute top-0 left-0 w-1 h-full 
                            <c:choose>
                                <c:when test="${q.status == 'unread'}">bg-amber-500</c:when>
                                <c:when test="${q.status == 'resolved'}">bg-emerald-500</c:when>
                                <c:otherwise>bg-blue-500</c:otherwise>
                            </c:choose>
                        "></div>

                        <div class="flex flex-col md:flex-row md:items-start justify-between gap-4">
                            <div class="flex-grow pl-3">
                                <div class="flex items-center gap-3 mb-2">
                                    <h3 class="text-lg font-bold text-white">${q.name}</h3>
                                    <span class="text-xs px-2 py-0.5 rounded-full font-medium uppercase tracking-wider
                                        <c:choose>
                                            <c:when test="${q.status == 'unread'}">bg-amber-500/10 text-amber-500 border border-amber-500/20</c:when>
                                            <c:when test="${q.status == 'resolved'}">bg-emerald-500/10 text-emerald-500 border border-emerald-500/20</c:when>
                                            <c:otherwise>bg-blue-500/10 text-blue-500 border border-blue-500/20</c:otherwise>
                                        </c:choose>
                                    ">${q.status}</span>
                                </div>
                                
                                <div class="flex items-center gap-2 text-sm text-zinc-400 mb-4">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>
                                    <a href="mailto:${q.email}" class="hover:text-amber-400 transition-colors">${q.email}</a>
                                    <span class="mx-2">&middot;</span>
                                    <span>${q.createdAt}</span>
                                </div>

                                <div class="bg-zinc-950/50 rounded-xl p-4 text-zinc-300 text-sm leading-relaxed border border-zinc-800/50">
                                    ${q.message}
                                </div>
                            </div>

                            <div class="flex flex-row md:flex-col items-center gap-2 pl-3 md:pl-0 mt-4 md:mt-0">
                                <c:if test="${q.status != 'resolved'}">
                                    <form action="${pageContext.request.contextPath}/admin/queries" method="post" class="w-full">
                                        <input type="hidden" name="action" value="resolve">
                                        <input type="hidden" name="queryId" value="${q.queryId}">
                                        <button type="submit" class="w-full px-4 py-2 bg-emerald-500/10 hover:bg-emerald-500/20 text-emerald-400 border border-emerald-500/30 hover:border-emerald-500/50 rounded-lg transition-colors text-sm font-medium whitespace-nowrap">
                                            Mark Resolved
                                        </button>
                                    </form>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/admin/queries" method="post" class="w-full">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="queryId" value="${q.queryId}">
                                    <button type="button" onclick="gpConfirmSubmit(this.form, 'Are you sure you want to delete this query?', 'Delete Query')" class="w-full px-4 py-2 bg-red-500/10 hover:bg-red-500/20 text-red-400 border border-red-500/30 hover:border-red-500/50 rounded-lg transition-colors text-sm font-medium whitespace-nowrap">
                                        Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="bg-zinc-900/30 border border-zinc-800 rounded-3xl p-12 text-center">
                    <div class="w-16 h-16 rounded-full bg-zinc-800/50 flex items-center justify-center mx-auto mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-500"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">No Queries Found</h3>
                    <p class="text-zinc-500 max-w-md mx-auto">You're all caught up! There are no messages from the Contact Us form at the moment.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</main>

<%@ include file="../footer.jsp" %>
</body>
</html>
