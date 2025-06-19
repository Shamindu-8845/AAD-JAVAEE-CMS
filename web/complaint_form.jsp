<%--
  Created by IntelliJ IDEA.
  User: Yashoda
  Date: 6/14/2025
  Time: 10:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*, org.example.model.Complaint" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <title>New Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-light: #a7c7c7;
            --accent: #36454f;
            --light: #f0f8ff;
            --success: #2e8b57;
            --warning: #ffa500;
            --danger: #cd5c5c;
            --white: #ffffff;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --text-dark: #333333;
            --text-light: #666666;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light);
            color: var(--text-dark);
            line-height: 1.6;
        }

        header {
            background-color: var(--primary);
            padding: 1rem 2rem;
            color: var(--white);
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--white);
        }

        nav {
            display: flex;
            gap: 1.5rem;
        }

        nav a {
            color: var(--white);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .complaint-form {
            max-width: 800px;
            margin: 0 auto;
            border-radius: 8px;
            overflow: hidden;
        }

        .form-header {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: #006666;
            border-color: #006666;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 0.25rem rgba(0, 128, 128, 0.25);
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-resolved {
            background-color: #d4edda;
            color: #155724;
        }

    </style>
</head>
<body>

<header>

    <div class="logo">Complaint Management System</div>

    <nav>
        <a href="${pageContext.request.contextPath}/employee_dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/employee_dashboard.jsp?action=showComplaints">My Complaints</a>
        <a href="${pageContext.request.contextPath}/complaint_form.jsp">Add Complaint</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<div class="container py-5">
    <div class="complaint-form card shadow">
        <div class="card-header form-header">
            <div class="d-flex justify-content-between align-items-center">
                <h4 class="mb-0">📝 File a New Complaint</h4>
                <span class="badge bg-light text-dark">Employee ID: ${employeeId}</span>
            </div>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/addComplaint" method="post">
                <%
                    org.example.model.User user = (org.example.model.User) session.getAttribute("user");
                %>
                <input type="hidden" name="employeeId" value="<%= user.getId() %>">


                <!-- Complaint Title -->
                <div class="mb-4">
                    <label for="title" class="form-label fw-bold">Complaint Title</label>
                    <input type="text" class="form-control" id="title" name="title"
                           placeholder="Brief summary of your complaint" required>
                </div>

                <!-- Status Selection -->
                <div class="mb-4">
                    <label for="status" class="form-label fw-bold">Status</label>
                    <select class="form-select" id="status" name="status" required>
                        <option value="Pending" selected class="status-pending">Pending</option>
                        <option value="Resolved" class="status-resolved">Resolved</option>
                    </select>
                </div>

                <!-- Date Selection -->
                <div class="mb-4">
                    <label for="date" class="form-label fw-bold">Date</label>
                    <input type="date" class="form-control" id="date" name="date" required>
                </div>

                <!-- Detailed Description -->
                <div class="mb-4">
                    <label for="description" class="form-label fw-bold">Detailed Description</label>
                    <textarea class="form-control" id="description" name="description" rows="5"
                              placeholder="Please provide detailed information about your complaint..." required></textarea>
                </div>

                <!-- Form Actions -->
                <div class="d-flex justify-content-between mt-4">
                    <button type="reset" class="btn btn-outline-secondary">Clear Form</button>
                    <button type="submit" class="btn btn-primary px-4">Submit Complaint</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set default date to today
    document.getElementById('date').valueAsDate = new Date();

    // Update status badge color when selection changes
    document.getElementById('status').addEventListener('change', function() {
        const select = this;
        select.className = 'form-select';

        if(select.value === 'Pending') {
            select.classList.add('status-pending');
        } else {
            select.classList.add('status-resolved');
        }
    });
</script>
</body>
</html>
