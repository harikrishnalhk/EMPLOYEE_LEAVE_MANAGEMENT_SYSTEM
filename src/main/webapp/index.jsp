<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ELMS - Employee Leave Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #eef2f7, #dfe7f3);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .home-container {
            background: white;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
            text-align: center;
            animation: fadeIn 0.8s ease;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        p {
            color: #7f8c8d;
            margin-bottom: 30px;
        }
        .login-options {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        a {
            display: inline-block;
            padding: 12px 24px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background 0.3s;
        }
        a:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
    <div class="home-container">
        <h1>Welcome to ELMS</h1>
        <p>Employee Leave Management System</p>
        <div class="login-options">
            <a href="adminLogin.jsp">Admin Login</a>
            <a href="employeeLogin.jsp">Employee Login</a>
        </div>
    </div>
</body>
</html>