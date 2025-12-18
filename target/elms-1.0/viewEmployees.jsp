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
<title>View Employees</title>

<style>
/* ===== PAGE BACKGROUND ===== */
body{
    font-family: "Segoe UI", Arial, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    margin: 0;
    padding-top: 80px; /* For navbar */
}

/* ===== CARD ===== */
.card{
    width: 90%;
    max-width: 1200px;
    margin: 40px auto;
    background: #ffffff;
    padding: 30px;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.15);
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
    margin-bottom: 30px;
    color: #333;
    font-size: 28px;
    font-weight: 600;
}

/* ===== TABLE ===== */
table{
    width:100%;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

/* ===== HEADER ===== */
th{
    background: linear-gradient(90deg, #667eea, #764ba2);
    color: white;
    padding: 15px;
    font-size: 16px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-weight: 600;
}

/* ===== CELLS ===== */
td{
    padding: 15px;
    text-align: center;
    font-size: 15px;
    color: #333;
    border-bottom: 1px solid #eee;
}

/* ===== ROW STYLING ===== */
tr:nth-child(even){
    background: #f8f9fa;
}

tr:nth-child(odd){
    background: #ffffff;
}

/* ===== HOVER EFFECT ===== */
tbody tr{
    transition: all 0.3s ease;
}

tbody tr:hover{
    background: #e9ecef;
    transform: scale(1.01);
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

/* ===== EMPTY STATE ===== */
.no-data{
    text-align: center;
    padding: 40px;
    font-size: 18px;
    color: #666;
    font-style: italic;
}

/* ===== DELETE BUTTON ===== */
.delete-btn {
    background: #dc3545;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: all 0.3s ease;
}

.delete-btn:hover {
    background: #c82333;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(220, 53, 69, 0.3);
}

/* ===== MESSAGES ===== */
.success, .error {
    text-align: center;
    margin-bottom: 20px;
    padding: 12px;
    border-radius: 8px;
    font-weight: 500;
    animation: fadeIn 0.6s ease;
}

.success {
    color: #155724;
    background: #d4edda;
    border: 1px solid #c3e6cb;
}

.error {
    color: #721c24;
    background: #f8d7da;
    border: 1px solid #f5c6cb;
}

@keyframes fadeIn{
    from{opacity: 0; transform: translateY(10px);}
    to{opacity: 1; transform: translateY(0);}
}

/* ===== RESPONSIVE ===== */
@media (max-width: 768px) {
    .card {
        width: 95%;
        padding: 20px;
    }
    
    th, td {
        padding: 10px;
        font-size: 14px;
    }
    
    table {
        font-size: 14px;
    }
}
</style>

</head>

<body>

<!-- ✅ NAVBAR -->
<%@ include file="adminNavbar.jsp" %>

<div class="card">
    <h2>Employee List</h2>

    <% if (success != null) { %>
        <p class="success"><%= success %></p>
    <% } %>
    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>

    <table>
        <tr>
            <th>Name</th>
            <th>Department</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Gender</th>
            <th>Actions</th>
        </tr>

        <c:forEach var="e" items="${employees}">
            <tr>
                <td>${e.name}</td>
                <td>${e.department}</td>
                <td>${e.email}</td>
                <td>${e.phone}</td>
                <td>${e.gender}</td>
                <td>
                    <form action="deleteEmployee" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this employee? This action cannot be undone.');">
                        <input type="hidden" name="email" value="${e.email}">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty employees}">
            <tr>
                <td colspan="6" class="no-data">No Employees Found</td>
            </tr>
        </c:if>
    </table>
</div>

</body>
</html>
