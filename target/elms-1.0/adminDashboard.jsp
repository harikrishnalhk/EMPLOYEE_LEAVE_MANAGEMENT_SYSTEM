<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #f4f6f8;
    margin: 0;
}

/* ===== DASHBOARD CARD ===== */
.dashboard-card {
    width: 450px;
    margin: 100px auto;
    background: #ffffff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    text-align: center;
    animation: fadeUp 0.6s ease;
}

.dashboard-card.full-width {
    width: 90%;
    max-width: 1200px;
    margin: 30px auto;
    text-align: left;
}

.dashboard-card h2 {
    margin-bottom: 10px;
    color: #2c3e50;
}

.dashboard-card p {
    color: #666;
}

/* ===== ANIMATION ===== */
@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* ===== STATS CONTAINER ===== */
.stats-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
    max-width: 1200px;
    margin-left: auto;
    margin-right: auto;
}

.stat-card {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 20px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
    transition: transform 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
}

.stat-card h3 {
    margin: 0 0 10px 0;
    font-size: 16px;
    font-weight: 500;
    opacity: 0.9;
}

.stat-number {
    font-size: 36px;
    font-weight: 700;
    margin: 0;
}

/* ===== SIMPLE TABLE ===== */
table{
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    font-size: 14px;
}

th, td{
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}

th{
    background-color: #f2f2f2;
    font-weight: 600;
    color: #333;
}

tr:nth-child(even){
    background-color: #f9f9f9;
}

tr:hover{
    background-color: #f5f5f5;
}
</style>
</head>

<body>

<!-- ✅ COMMON NAVBAR -->
<%@ include file="adminNavbar.jsp" %>

<div class="dashboard-card">
    <h2>Welcome Admin 👋</h2>
    <p>Use the navigation bar above to manage employees and leave requests.</p>
</div>

<% if (success != null) { %>
    <div class="message success"><%= success %></div>
<% } %>
<% if (error != null) { %>
    <div class="message error"><%= error %></div>
<% } %>

<!-- Stats Cards -->
<div class="stats-container">
    <div class="stat-card">
        <h3>Total Employees</h3>
        <div class="stat-number">${totalEmployees}</div>
    </div>
    <div class="stat-card">
        <h3>On Leave Today</h3>
        <div class="stat-number">${leavesToday}</div>
    </div>
    <div class="stat-card">
        <h3>Pending Requests</h3>
        <div class="stat-number">${pendingRequests}</div>
    </div>
</div>

<c:if test="${not empty employeesOnLeave}">
<div class="dashboard-card full-width">
    <h2>Employees Currently on Leave</h2>
    <div style="overflow-x: auto;">
        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Leave Type</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Duration</th>
            </tr>
            <c:forEach var="emp" items="${employeesOnLeave}">
            <tr>
                <td>${emp.name}</td>
                <td>${emp.email}</td>
                <td>${emp.type}</td>
                <td>${emp.start}</td>
                <td>${emp.end}</td>
                <td>
                    <c:choose>
                        <c:when test="${emp.duration == 'FULL'}">Full Day</c:when>
                        <c:when test="${emp.duration == 'FIRST'}">Half Day (First)</c:when>
                        <c:when test="${emp.duration == 'SECOND'}">Half Day (Second)</c:when>
                        <c:otherwise>Full Day</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>
</div>
</c:if>

<c:if test="${empty employeesOnLeave}">
<div class="dashboard-card full-width">
    <h2>Employees Currently on Leave</h2>
    <p style="text-align: center; color: #666; font-style: italic;">No employees are currently on leave.</p>
</div>
</c:if>

</body>
</html>
