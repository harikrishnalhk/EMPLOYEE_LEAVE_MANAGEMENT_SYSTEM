<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<style>
body{
    font-family: Arial;
    background:#f4f6f8;
}
.dashboard{
    width:420px;
    margin:80px auto;
    background:#fff;
    padding:25px;
    border-radius:8px;
    box-shadow:0 0 10px rgba(0,0,0,.1);
    text-align:center;
}
a{
    display:block;
    padding:12px;
    margin:10px 0;
    background:#2c3e50;
    color:white;
    text-decoration:none;
    border-radius:4px;
}
a:hover{
    background:#34495e;
}
</style>
</head>
<body>

<div class="dashboard">
<h2>Admin Dashboard</h2>

<a href="addEmployee.jsp">➕ Add Employee</a>
<a href="viewEmployees">👥 View Employees</a>
<a href="adminLeaves">📄 Leave Requests</a>

</div>

</body>
</html>
