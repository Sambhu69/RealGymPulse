<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings — GymPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../header.jsp" %>

<div class="page-container">
    <div class="page-header">
        <h1>My Bookings</h1>
    </div>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-error">${requestScope.error}</div>
    </c:if>

    <div class="card">
        <c:choose>
            <c:when test="${not empty myBookings}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Class</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Booked On</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${myBookings}" var="b">
                                <tr>
                                    <td>${b.className}</td>
                                    <td>${b.scheduleDate}</td>
                                    <td>${b.scheduleTime}</td>
                                    <td>${b.bookingDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status == 'confirmed'}"><span class="badge badge-success">Confirmed</span></c:when>
                                            <c:when test="${b.status == 'cancelled'}"><span class="badge badge-danger">Cancelled</span></c:when>
                                            <c:otherwise><span class="badge badge-secondary">${b.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${b.status == 'confirmed'}">
                                            <a href="${pageContext.request.contextPath}/member/book?action=cancel&bookingId=${b.bookingId}&classId=${b.classId}"
                                               class="btn btn-small btn-danger"
                                               onclick="gpConfirm(event, 'Are you sure you want to cancel this booking?', 'Cancel Booking')">Cancel</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p>You haven't booked any classes yet. <a href="${pageContext.request.contextPath}/member/dashboard">Browse available classes</a>.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>
