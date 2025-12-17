<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" %>

<style>
    /* ===== NAVBAR BASE ===== */
    .admin-navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 64px;
        background: linear-gradient(90deg, #1f2933, #3e4c59);
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 32px;
        z-index: 1000;
        box-shadow: 0 4px 15px rgba(0,0,0,0.25);
        box-sizing: border-box;
    }

    /* ===== LEFT BRAND ===== */
    .nav-left {
        font-size: 20px;
        font-weight: 700;
        color: #ffffff;
        letter-spacing: 0.5px;
        user-select: none;
    }

    /* ===== RIGHT LINKS ===== */
    .nav-right {
        display: flex;
        align-items: center;
        gap: 22px;
    }

    .nav-right a {
        color: #e5e7eb;
        text-decoration: none;
        font-size: 15px;
        padding: 8px 14px;
        border-radius: 6px;
        transition: all 0.3s ease;
    }

    .nav-right a:hover {
        background: rgba(255,255,255,0.15);
        transform: translateY(-1px);
    }

    /* ===== LOGOUT BUTTON ===== */
    .nav-right .logout {
        background: #ef4444;
        color: white;
        font-weight: 600;
    }

    .nav-right .logout:hover {
        background: #dc2626;
    }

    /* ===== BODY OFFSET (IMPORTANT) ===== */
    body {
        margin: 0;
        padding-top: 80px; /* space for fixed navbar */
    }
</style>

<!-- ===== NAVBAR HTML ===== -->
<div class="admin-navbar">

    <!-- LEFT -->
    <div class="nav-left">
        ELMS Admin
    </div>

    <!-- RIGHT -->
    <div class="nav-right">
        <a href="adminDashboard.jsp">Home</a>
        <a href="addEmployee.jsp">Add Employee</a>
        <a href="viewEmployees">View Employees</a>
        <a href="adminLeaves">Leave Requests</a>
        <a href="adminLogin.jsp" class="logout">Logout</a>
    </div>

</div>
