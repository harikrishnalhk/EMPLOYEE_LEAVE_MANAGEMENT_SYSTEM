<%
    if (session.getAttribute("employee") == null) {
        response.sendRedirect("employeeLogin.jsp");
        return;
    }
%>

<%@ page contentType="text/html;charset=UTF-8" %>

<style>
/* RESET */
*{
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

/* NAVBAR */
.emp-navbar{
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;              /* ✅ FULL SCREEN WIDTH */
    height: 64px;
    background: linear-gradient(135deg,#2c3e50,#34495e);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    z-index: 1000;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}

/* LEFT TITLE */
.emp-navbar .brand{
    color: white;
    font-size: 20px;
    font-weight: 600;
    letter-spacing: 0.5px;
}

/* RIGHT MENU */
.emp-navbar .menu{
    display: flex;
    align-items: center;
    gap: 25px;
}

/* LINKS */
.emp-navbar a{
    color: white;
    text-decoration: none;
    font-size: 15px;
    padding: 6px 10px;
    border-radius: 5px;
    transition: 0.3s ease;
}

.emp-navbar a:hover{
    background: rgba(255,255,255,0.15);
}

/* DASHBOARD LABEL */
.emp-navbar .dashboard-text{
    font-weight: 600;
    opacity: 0.9;
}

/* LOGOUT */
.emp-navbar .logout{
    background: #e74c3c;
    padding: 8px 16px;
    border-radius: 6px;
}

.emp-navbar .logout:hover{
    background: #c0392b;
}
</style>

<div class="emp-navbar">

    <!-- LEFT -->
    <div class="brand">ELMS Employee</div>

    <!-- RIGHT -->
    <div class="menu">
        
        <a href="employeeDashboard">Home</a>
        <a href="applyLeave.jsp">Apply Leave</a>
        <a href="myLeaves">Leave Requests</a>
        <a href="logout.jsp" class="logout">Logout</a>
    </div>

</div>

<!-- SPACE BELOW FIXED NAVBAR -->
<div style="height:70px;"></div>
