<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<%@ page contentType="text/html;charset=UTF-8" %>
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
</style>
</head>

<body>

<!-- ✅ COMMON NAVBAR -->
<%@ include file="adminNavbar.jsp" %>

<div class="dashboard-card">
    <h2>Welcome Admin 👋</h2>
    <p>Use the navigation bar above to manage employees and leave requests.</p>
</div>

</body>
</html>
