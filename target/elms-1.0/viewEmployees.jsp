<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>View Employees</title>

<style>
/* ===== PAGE BACKGROUND ===== */
body{
    font-family: "Segoe UI", Arial, sans-serif;
    background: linear-gradient(120deg, #667eea, #764ba2);
    min-height: 100vh;
}

/* ===== CARD ===== */
.card{
    width: 88%;
    margin: 40px auto;
    background: #ffffff;
    padding: 25px;
    border-radius: 14px;
    box-shadow: 0 25px 45px rgba(0,0,0,0.2);
    animation: fadeUp 0.8s ease;
}

/* ===== ANIMATION ===== */
@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(25px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* ===== TITLE ===== */
h2{
    text-align: center;
    margin-bottom: 25px;
    color: #2c3e50;
    font-size: 26px;
}

/* ===== TABLE ===== */
table{
    width:100%;
    border-collapse: collapse;
    overflow: hidden;
    border-radius: 10px;
}

/* ===== HEADER ===== */
th{
    background: linear-gradient(90deg, #2c3e50, #34495e);
    color: white;
    padding: 14px;
    font-size: 15px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* ===== CELLS ===== */
td{
    padding: 14px;
    text-align: center;
    font-size: 14.5px;
    color: #2c3e50;
}

/* ===== ROW STYLING ===== */
tr:nth-child(even){
    background: #f7f9fc;
}

tr:nth-child(odd){
    background: #ffffff;
}

/* ===== HOVER EFFECT ===== */
tbody tr{
    transition: all 0.25s ease;
}

tbody tr:hover{
    background: #eef2ff;
    transform: scale(1.01);
}

/* ===== EMPTY STATE ===== */
.no-data{
    text-align: center;
    padding: 20px;
    font-size: 16px;
    color: #555;
}
</style>

</head>

<body>

<!-- ✅ NAVBAR -->
<%@ include file="adminNavbar.jsp" %>

<div class="card">
    <h2>Employee List</h2>

    <table>
        <tr>
            <th>Name</th>
            <th>Department</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Gender</th>
        </tr>

        <c:forEach var="e" items="${employees}">
            <tr>
                <td>${e.name}</td>
                <td>${e.department}</td>
                <td>${e.email}</td>
                <td>${e.phone}</td>
                <td>${e.gender}</td>
            </tr>
        </c:forEach>

        <c:if test="${empty employees}">
            <tr>
                <td colspan="5" class="no-data">No Employees Found</td>
            </tr>
        </c:if>
    </table>
</div>

</body>
</html>
