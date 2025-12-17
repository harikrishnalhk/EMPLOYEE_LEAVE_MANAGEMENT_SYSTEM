<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Employee Login</title>

<style>
body{
    margin:0;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#667eea,#764ba2);
    font-family:'Segoe UI',sans-serif;
}

.login-box{
    width:380px;
    background:#fff;
    padding:30px;
    border-radius:10px;
    box-shadow:0 15px 30px rgba(0,0,0,0.2);
    animation:slideIn 0.8s ease;
}

@keyframes slideIn{
    from{transform:translateY(40px);opacity:0;}
    to{transform:translateY(0);opacity:1;}
}

.login-box h2{
    text-align:center;
    margin-bottom:25px;
    color:#333;
}

input{
    width:100%;
    padding:12px;
    margin:12px 0;
    border-radius:5px;
    border:1px solid #ccc;
    font-size:14px;
}

input:focus{
    border-color:#667eea;
    outline:none;
}

button{
    width:100%;
    padding:12px;
    background:#667eea;
    border:none;
    color:white;
    font-size:16px;
    border-radius:5px;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    background:#5563d6;
    transform:scale(1.02);
}

.error{
    color:red;
    text-align:center;
    margin-top:10px;
    animation:shake 0.4s;
}

@keyframes shake{
    0%{transform:translateX(0)}
    25%{transform:translateX(-5px)}
    50%{transform:translateX(5px)}
    75%{transform:translateX(-5px)}
    100%{transform:translateX(0)}
}
</style>
</head>

<body>

<div class="login-box">
    <h2>Employee Login</h2>

    <form action="employeeLogin" method="post">
        <input type="email" name="email" placeholder="Enter Email" required />
        <input type="password" name="password" placeholder="Enter Password" required />
        <button type="submit">Login</button>
    </form>

    <%
        String error = (String) request.getAttribute("error");
        if(error != null){
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>
</div>

</body>
</html>
