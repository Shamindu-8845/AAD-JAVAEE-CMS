<%--
  Created by IntelliJ IDEA.
  User: Yashoda
  Date: 6/15/2025
  Time: 10:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Complaint" %>
<%@ page import="org.example.model.User" %>
<%@ page import="org.example.dao.ComplaintDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String action = request.getParameter("action");
    boolean showTable = "showComplaints".equals(action);
    List<Complaint> complaints = ComplaintDAO.getAllComplaints(application);
%>

<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
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

        .container {
            max-width: 1500px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .welcome-section {
            background-color: var(--white);
            padding: 2rem;
            border-radius: 8px;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-left: 5px solid var(--accent);
        }

        .welcome-text h1 {
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .welcome-text p {
            color: var(--text-light);
        }

        .stats-card {
            background-color: var(--accent);
            color: var(--white);
            padding: 1rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: var(--shadow);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
            background-color: var(--white);
            box-shadow: var(--shadow);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--primary-light);
        }

        th {
            background-color: var(--accent);
            color: var(--white);
            font-weight: 500;
        }

        tr:hover {
            background-color: var(--primary-light);
        }

        option {
            padding: 0.5rem;
            background-color: var(--white);
            color: var(--accent);
        }

        option:hover {
            background-color: var(--primary-light) !important;
        }

        option[value="Pending"] {
            color: var(--warning);
            font-weight: 500;
        }

        option[value="In Progress"] {
            color: var(--accent);
            font-weight: 500;
        }

        option[value="Resolved"] {
            color: var(--success);
            font-weight: 500;
        }

        option:checked {
            background-color: var(--primary-light);
            font-weight: 500;
        }

        .action-group {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-sm {
            padding: 0.3rem 0.6rem;
            font-size: 0.85rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--white);
        }

        .btn-primary:hover {
            background-color: #006666;
            transform: translateY(-1px);
        }

     /*   .btn-success {
            background-color: var(--success);
            color: var(--white);
        }

        .btn-success:hover {
            background-color: #26734d;
            transform: translateY(-1px);
        }*/

        .btn-danger {
            background-color: var(--danger);
            color: var(--white);
        }

        .btn-danger:hover {
            background-color: #b35252;
            transform: translateY(-1px);
        }

        select, input[type="text"] {
            padding: 0.5rem;
            border: 1px solid var(--primary-light);
            border-radius: 4px;
            margin-right: 0.5rem;
            background-color: var(--white);
        }

        .form-inline {
            display: inline;
        }

        .empty-dashboard {
            text-align: center;
            padding: 3rem;
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: var(--shadow);
            margin-top: 2rem;
            border: 1px dashed var(--primary-light);
        }

        .empty-icon {
            font-size: 4rem;
            color: var(--primary);
            margin-bottom: 1rem;
            opacity: 0.7;
        }

        .empty-message {
            font-size: 1.2rem;
            color: var(--accent);
            margin-bottom: 1.5rem;
        }

        .empty-subMessage {
            color: var(--text-light);
            margin-bottom: 2rem;
        }

        .empty-action {
            display: inline-block;
            background-color: var(--primary);
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .empty-action:hover {
            background-color: #006666;
            transform: translateY(-2px);
        }

    </style>
</head>
<body>

<!-- HEADER + NAVIGATION BAR -->
<header>
    <div class="logo">Complaint Management System</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin_dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin_dashboard.jsp?action=showComplaints">All Complaints</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<div class="container">
    <!-- Welcome Section -->
    <section class="welcome-section">
        <div class="welcome-text">
            <h1>Welcome, <%= user.getName() %></h1>
            <p>Admin Dashboard - Manage complaints and system settings</p>
        </div>
        <div class="stats-card">
            Total Complaints: <%= complaints != null ? complaints.size() : 0 %>
        </div>
    </section>

    <!-- MAIN CONTENT -->
    <% if (showTable) { %>
    <h2>All Complaints</h2>

    <% if (complaints != null && !complaints.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>Complaint ID</th>
            <th>Employee ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Date</th>
            <th>Remark</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Complaint c : complaints) {
            String status = (c.getStatus() != null) ? c.getStatus().toLowerCase() : "unknown";
            String statusClass = switch (status) {
                case "pending" -> "status-pending";
                case "in progress" -> "status-in-progress";
                case "resolved" -> "status-resolved";
                default -> "status-unknown";
            };
        %>
        <tr>
            <td><%= c.getComplaintId() %></td>
            <td><%= c.getEmployeeId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getDescription() %></td>
            <td class="<%= statusClass %>"><%= c.getStatus() != null ? c.getStatus() : "Unknown" %></td>
            <td><%= c.getDate() %></td>
<%--            <td><%= c.getRemarks() != null ? c.getRemarks() : "" %></td>--%>
            <td>
            <!-- Add Remarks Form -->
                <form action="${pageContext.request.contextPath}/updateStatus" method="post" class="form-inline">
                    <input type="hidden" name="complaintId" value="<%= c.getComplaintId() %>" />

                    <!-- Add Remarks Input -->
                    <input type="text" name="remarks" placeholder="Remarks" class="btn-sm"
                           value="<%= c.getRemarks() != null ? c.getRemarks() : "" %>" />

                    <!-- Optional: Add dropdown to change status -->
                    <select name="status" class="btn-sm">
                        <option value="Pending" <%= "Pending".equalsIgnoreCase(c.getStatus()) ? "selected" : "" %>>Pending</option>
                        <option value="In Progress" <%= "In Progress".equalsIgnoreCase(c.getStatus()) ? "selected" : "" %>>In Progress</option>
                        <option value="Resolved" <%= "Resolved".equalsIgnoreCase(c.getStatus()) ? "selected" : "" %>>Resolved</option>
                    </select>

                    <!-- Update Form -->
                    <form action="${pageContext.request.contextPath}/updateStatus" method="post" class="form-inline">
                        <input type="hidden" name="complaintId" value="<%= c.getComplaintId() %>" />
                        <button type="submit" class="btn btn-primary btn-sm">Update</button>
                    </form>
                </form>

            </td>

            <td>
                <div class="action-group">


                    <!-- Delete Form -->
                    <form action="${pageContext.request.contextPath}/deleteComplaint" method="post" class="form-inline">
                        <input type="hidden" name="complaintId" value="<%= c.getComplaintId() %>" />
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure to delete this complaint?');">Delete</button>
                    </form>
                </div>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <% } else { %>
    <div class="empty-dashboard">
        <div class="empty-icon">📊</div>
        <h2 class="empty-message">Your Dashboard is Quiet Today</h2>
        <p class="empty-subMessage">No complaints have been submitted yet. Enjoy the peace while it lasts!</p>
        <div>
            <a href="${pageContext.request.contextPath}/admin_dashboard.jsp?action=showComplaints" class="empty-action">
                Refresh Complaints
            </a>
        </div>
    </div>
    <% } %>
    <% } %>
</div>

</body>
</html>