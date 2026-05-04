<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Bookings — GymPulse Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="../header.jsp" %>

<div class="page-container">
    <div class="page-header">
        <h1>All Bookings</h1>
    </div>

    <div class="card">
        <c:choose>
            <c:when test="${not empty allBookings}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Member ID</th>
                                <th>Class</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Booked On</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${allBookings}" var="b">
                                <tr>
                                    <td>${b.bookingId}</td>
                                    <td>${b.userId}</td>
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
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p>No bookings found.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>
