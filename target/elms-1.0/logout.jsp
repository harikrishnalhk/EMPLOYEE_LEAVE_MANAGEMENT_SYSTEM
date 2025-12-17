<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Invalidate session
    if (session != null) {
        session.invalidate();
    }

    String role = request.getParameter("role");
    String loginPage = "employeeLogin.jsp";
    if ("admin".equals(role)) {
        loginPage = "adminLogin.jsp";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logged Out</title>
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
        .logout-box {
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
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        p {
            color: #7f8c8d;
            margin-bottom: 30px;
        }
        a {
            display: inline-block;
            padding: 10px 20px;
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
    <div class="logout-box">
        <h2>Logged Out Successfully</h2>
        <p>Thank you for using ELMS. Visit again!</p>
        <a href="<%= loginPage %>">Login Again</a>
    </div>
</body>
</html>