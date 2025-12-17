<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String employee = (String) session.getAttribute("employee");
    if(employee == null){
        response.sendRedirect("employeeLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Employee Dashboard</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f4f6f9;
}

.container{
    width:900px;
    margin:80px auto;
    animation:fadeIn 0.8s ease;
}

@keyframes fadeIn{
    from{opacity:0;transform:translateY(20px)}
    to{opacity:1;transform:translateY(0)}
}

.header{
    text-align:center;
    margin-bottom:40px;
}

.cards{
    display:flex;
    justify-content:space-between;
}

.card{
    width:48%;
    padding:35px;
    border-radius:12px;
    color:white;
    box-shadow:0 12px 25px rgba(0,0,0,0.15);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-6px);
}

.casual{
    background:linear-gradient(135deg,#1abc9c,#16a085);
}

.sick{
    background:linear-gradient(135deg,#e67e22,#d35400);
}

.card h3{
    font-size:22px;
    margin-bottom:10px;
}

.card h1{
    font-size:52px;
    margin:0;
}
</style>
</head>

<body>

<%@ include file="employeeNavbar.jsp" %>

<div class="container">

    <div class="header">
        <h2>Welcome 👋</h2>
        <p><b><%= employee %></b></p>
        <p>Hope you’re having a great day!</p>
    </div>

    <!-- Leave Balance ONLY -->
    <div class="cards">
        <div class="card casual">
            <h3>Casual Leaves</h3>
            <h3>Total 24</h3>
            <h2>Balance ${casual}</h2>
        </div>

        <div class="card sick">
            <h3>Sick Leaves</h3>
            <h3>Total 12</h3>
            <h2>Balance ${sick}</h2>
        </div>
    </div>

</div>

</body>
</html>
