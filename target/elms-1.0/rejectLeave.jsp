<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Reject Leave</title>
<style>
body{
    font-family:Arial;
    background:#f4f6f8;
}
.box{
    width:400px;
    margin:100px auto;
    background:white;
    padding:20px;
    border-radius:6px;
    box-shadow:0 0 10px rgba(0,0,0,.1);
}
textarea{
    width:100%;
    height:80px;
}
button{
    padding:10px;
    background:#c0392b;
    color:white;
    border:none;
    width:100%;
    border-radius:4px;
}
</style>
</head>
<body>

<div class="box">
<h3>Reject Leave</h3>

<form action="rejectLeave" method="post">
    <input type="hidden" name="id" value="${param.id}">
    <label>Reason for rejection</label><br><br>
    <textarea name="reason" required></textarea><br><br>
    <button type="submit">Reject Leave</button>
</form>

</div>

</body>
</html>
