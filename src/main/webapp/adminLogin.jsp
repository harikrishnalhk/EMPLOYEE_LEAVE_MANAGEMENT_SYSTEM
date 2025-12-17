<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>

    <style>
        /* ===== GLOBAL RESET ===== */
        * {
            box-sizing: border-box;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        /* ===== BACKGROUND ===== */
        body {
            margin: 0;
            height: 100vh;
            background: linear-gradient(135deg, #667eea, #764ba2, #f857a6);
            background-size: 300% 300%;
            animation: gradientMove 10s ease infinite;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* ===== LOGIN CARD ===== */
        .login-box {
            width: 360px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            animation: fadeInUp 0.8s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ===== TITLE ===== */
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2c3e50;
            letter-spacing: 1px;
        }

        /* ===== INPUTS ===== */
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            outline: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 2px rgba(102,126,234,0.2);
        }

        /* ===== BUTTON ===== */
        button {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.25);
        }

        button:active {
            transform: scale(0.98);
        }

        /* ===== ERROR MESSAGE ===== */
        .error {
            margin-top: 15px;
            text-align: center;
            color: #e74c3c;
            font-weight: bold;
            animation: shake 0.4s ease;
        }

        @keyframes shake {
            0% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            50% { transform: translateX(5px); }
            75% { transform: translateX(-5px); }
            100% { transform: translateX(0); }
        }
    </style>
</head>

<body>

<div class="login-box">
    <h2>Admin Login</h2>

    <!-- ⚠️ FUNCTIONALITY UNCHANGED -->
    <form action="adminLogin" method="post">
        <input type="text" name="username" placeholder="Admin Username" required>
        <input type="password" name="password" placeholder="Admin Password" required>
        <button type="submit">Login</button>
    </form>

    <div class="error">
        ${error}
    </div>
</div>

</body>
</html>
