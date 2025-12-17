<%
    if (session.getAttribute("employee") == null) {
        response.sendRedirect("employeeLogin.jsp");
        return;
    }
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Apply Leave</title>

<style>
/* ===== GLOBAL ===== */
body{
    font-family:'Segoe UI', sans-serif;
    background: linear-gradient(135deg,#eef2f7,#dfe7f3);
    margin:0;
}

/* ===== FORM CARD ===== */
.form-box{
    width:420px;
    margin:100px auto;
    background:white;
    padding:30px;
    border-radius:14px;
    box-shadow:0 15px 35px rgba(0,0,0,0.12);
    animation: slideUp 0.8s ease;
}

/* ===== ANIMATION ===== */
@keyframes slideUp{
    from{
        opacity:0;
        transform:translateY(40px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

h2{
    text-align:center;
    margin-bottom:25px;
    color:#2c3e50;
}

/* ===== INPUTS ===== */
input, select, textarea{
    width:100%;
    padding:12px;
    margin:12px 0;
    border-radius:8px;
    border:1px solid #ccc;
    font-size:14px;
    transition:0.3s ease;
}

input:focus,
select:focus,
textarea:focus{
    outline:none;
    border-color:#667eea;
    box-shadow:0 0 0 2px rgba(102,126,234,0.2);
}

/* ===== BUTTON ===== */
button{
    width:100%;
    padding:14px;
    margin-top:10px;
    background: linear-gradient(135deg,#667eea,#5a67d8);
    color:white;
    border:none;
    border-radius:10px;
    font-size:16px;
    cursor:pointer;
    transition:0.3s ease;
}

button:hover{
    transform:translateY(-2px);
    box-shadow:0 8px 20px rgba(102,126,234,0.4);
}

/* ===== MESSAGES ===== */
.success {
    color:#27ae60;
    text-align:center;
    margin-top:15px;
    font-weight:600;
    animation: fadeIn 0.6s ease;
}

.error {
    color:#e74c3c;
    text-align:center;
    margin-top:15px;
    font-weight:600;
    animation: fadeIn 0.6s ease;
}

@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}
</style>
</head>

<body>

<%@ include file="employeeNavbar.jsp" %>

<div class="form-box">
    <h2>Apply Leave</h2>

    <form action="applyLeave" method="post">

        <select name="type" required>
            <option value="">-- Select Leave Type --</option>
            <option value="CASUAL">Casual Leave</option>
            <option value="SICK">Sick Leave</option>
        </select>

        <input type="date" name="fromDate" required>
        <input type="date" name="toDate" required>

        <textarea name="reason" placeholder="Reason for leave" rows="4" required></textarea>

        <button type="submit">Apply Leave</button>
    </form>

    <!-- ✅ SUCCESS MESSAGE -->
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>

    <!-- ❌ ERROR MESSAGE -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
</div>

</body>
</html>
