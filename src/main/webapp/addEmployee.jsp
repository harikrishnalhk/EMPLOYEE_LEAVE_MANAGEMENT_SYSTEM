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
<title>Add Employee</title>

<style>
/* ===== RESET ===== */
* {
    box-sizing: border-box;
    font-family: "Segoe UI", Arial, sans-serif;
}

/* ===== BACKGROUND ===== */
body {
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #667eea, #764ba2);
    margin: 0;
    padding-top: 100px; /* 🔥 space for navbar */
}


/* ===== CARD ===== */
.card {
    width: 420px;
    margin: 0 auto;
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 20px 40px rgba(0,0,0,.2);
    animation: slideUp 0.6s ease;
}


/* ===== ANIMATION ===== */
@keyframes fadeSlide {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes slideUp {
    from {
        transform: translateY(40px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}


/* ===== TITLE ===== */
.card h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #2c3e50;
    letter-spacing: 1px;
}

/* ===== INPUTS & SELECT ===== */
input, select {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 14px;
    outline: none;
    transition: all 0.3s ease;
}

input:focus, select:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 2px rgba(102,126,234,0.25);
}

/* ===== BUTTON ===== */
button {
    width: 100%;
    padding: 12px;
    margin-top: 15px;
    background: linear-gradient(135deg, #2c3e50, #4b6584);
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 15px;
    cursor: pointer;
    transition: all 0.3s ease;
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.25);
}

button:active {
    transform: scale(0.98);
}

/* ===== MESSAGE ===== */
.card p {
    margin-top: 15px;
    text-align: center;
    color: green;
    font-weight: bold;
}
</style>

</head>
<body>
    <%@ include file="adminNavbar.jsp" %>
<div class="card">
    <h2>Add Employee</h2>

    <!-- 🔒 FUNCTIONALITY UNCHANGED -->
    <form method="post" action="addEmployee">
        <input name="name" placeholder="Employee Name" required>
        <input name="department" placeholder="Department" required>
        <input name="phone" placeholder="Phone Number" pattern="[0-9]{10}" required>
        <input name="personalEmail" placeholder="Personal Email" required>

        <select name="gender" required>
            <option value="">Select Gender</option>
            <option>Male</option>
            <option>Female</option>
            <option>Other</option>
        </select>

        <button type="submit">Add Employee</button>
    </form>

    <p>${msg}</p>
</div>

</body>
</html>
