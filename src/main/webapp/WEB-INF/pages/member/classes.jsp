<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Classes — GymPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../header.jsp" %>

<div class="page-container">
    <div class="page-header">
        <h1>Available Fitness Classes</h1>
    </div>

    <c:if test="${param.success == 'booked'}"><div class="alert alert-success">Class booked successfully!</div></c:if>
    <c:if test="${param.error == 'alreadybooked'}"><div class="alert alert-error">You have already booked this class.</div></c:if>

    <c:choose>
        <c:when test="${not empty availableClasses}">
            <div class="class-grid">
                <c:forEach items="${availableClasses}" var="cls">
                    <div class="class-card">
                        <h4>${cls.className}</h4>
                        <p class="class-meta">🧑‍🏫 <strong>Instructor:</strong> ${cls.instructor}</p>
                        <p class="class-meta">📅 ${cls.scheduleDate} at ${cls.scheduleTime}</p>
                        <p class="class-meta">${cls.description}</p>
                        <div class="class-capacity">
                            <span>${cls.enrolled}/${cls.capacity} enrolled</span>
                            <form action="${pageContext.request.contextPath}/member/book" method="POST">
                                <input type="hidden" name="classId" value="${cls.classId}">
                                <button type="submit" class="btn btn-small btn-primary">Book Now</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card">
                <p>No fitness classes are available at the moment. Please check back later.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>
