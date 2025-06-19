<%@ page import="org.example.dao.UserDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: Yashoda
  Date: 6/13/2025
  Time: 10:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title> Login </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">

    <style>
        :root {
            --primary: #008080;        /* Professional Teal */
            --primary-light: #a7c7c7;  /* Soft Teal */
            --accent: #36454f;        /* Slate Gray */
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
            position: relative;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 20% 30%, var(--primary-light) 0%, transparent 15%) 0 0,
                    radial-gradient(circle at 80% 20%, var(--accent) 0%, transparent 15%) 0 0,
                    radial-gradient(circle at 40% 70%, var(--primary) 0%, transparent 15%) 0 0;
            background-size: 600px 600px;
            opacity: 0.6;
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0% { background-position: 0 0, 100px 150px, 300px 300px; }
            50% { background-position: 300px 400px, 400px 100px, 200px 300px; }
            100% { background-position: 0 0, 100px 150px, 300px 300px; }
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            background: white;
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            position: relative;
            z-index: 1;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
        }

        .login-content {
            padding: 45px 40px 40px;
        }

        .logo {
            text-align: center;
            margin-bottom: 35px;
            position: relative;
        }

        .logo h1 {
            color: var(--primary);
            font-weight: 600;
            font-size: 40px;
            margin-bottom: 8px;
            letter-spacing: 0.7px;
        }

        .logo p {
            color: var(--accent);
            font-size: 14px;
            font-weight: 400;
        }

        .logo::after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            margin: 20px auto 0;
            border-radius: 3px;
            opacity: 0.7;
        }

        .form-group {
            margin-bottom: 22px;
            position: relative;
        }

        .form-group label {
            display: block;
            color: var(--accent);
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 14px 18px;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            background: rgba(248, 249, 250, 0.5);
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(26, 82, 118, 0.2),
            inset 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .form-group .icon {
            position: absolute;
            right: 15px;
            top: 38px;
            color: var(--primary);
            font-size: 18px;
        }

        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 15px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(26, 82, 118, 0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(26, 82, 118, 0.4);
        }

        .btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }

        .btn:hover::after {
            left: 100%;
        }

        .error-message {
            color: #d62828;
            background: #ffefef;
            padding: 14px;
            border-radius: 10px;
            font-size: 14px;
            margin: 25px 0;
            text-align: center;
            display: <%= request.getAttribute("errorMessage") != null ? "block" : "none" %>;
            border: 1px solid #ffd6d6;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .footer-links {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color: var(--primary);
            position: relative;
        }

        .footer-links::before {
            content: '';
            display: block;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, transparent, #e9ecef, transparent);
            margin-bottom: 25px;
        }

        .footer-links a {
            color: var(--primary);
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .footer-links a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 1px;
            background: var(--primary);
            transition: width 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--accent);
        }

        .footer-links a:hover::after {
            width: 100%;
            background: var(--accent);
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-content">
        <div class="logo">
            <h1>Sign In</h1>
            <p>Welcome back! Please enter your credentials to continue.</p>
        </div>

        <!-- Error Message -->
        <div class="error-message" style="display: <%= request.getAttribute("errorMessage") != null ? "block" : "none" %>;">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </div>


        <form method="post" action="${pageContext.request.contextPath}/login">

        <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" class="form-control" name="email" id="email" placeholder="example@123gmail.com" required>
                <div class="icon"><i class="far fa-envelope"></i></div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="••••••••" required>
                <div class="icon"><i class="fas fa-lock"></i></div>
            </div>

<%--            <div class="form-group">--%>
<%--                <label for="role">User Role</label>--%>
<%--                <select class="form-control" name="role" id="role" required>--%>
<%--                    <option value="" disabled selected>Select your role</option>--%>
<%--                    <option value="Employee">Employee</option>--%>
<%--                    <option value="Admin">Admin</option>--%>
<%--                </select>--%>
<%--                <div class="icon"><i class="fas fa-user-tag"></i></div>--%>
<%--            </div>--%>

            <button type="submit" class="btn">SignIn to Dashboard</button>
        </form>

        <div class="footer-links">
            Need an account? <a href="register">Request Access</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
</body>
</html>



