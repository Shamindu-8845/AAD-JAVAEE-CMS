# 🌟 Complaint Management System (CMS)

## 📌 Project Overview
The Complaint Management System (CMS) is a robust, research-oriented Java web application developed as an individual assignment for the Municipal IT Division. The project’s core objective is to demonstrate the practical application of Jakarta EE (formerly Java EE) and JavaServer Pages (JSP) in delivering a real-world, enterprise-grade solution for managing internal grievances and operational concerns.

This system streamlines the internal communication process between employees and administrative staff by offering a centralized digital platform for:
- 📩 Submitting structured complaints related to operations, resources, or services.📩 Submitting structured complaints related to operations, resources, or services.
- 📊 Tracking the status of each complaint across various resolution stages.
- 🛠️ Managing, updating, and resolving issues with clear documentation and status logs.

## Key Characteristics:
- ✅ Built following the MVC (Model-View-Controller) design pattern, ensuring clear separation of presentation, control, and data logic layers.
- ✅ Entire system operates over traditional HTTP GET/POST form submissions, fully synchronous, without reliance on AJAX or modern frontend frameworks. This aligns with classic JSP-Servlet architecture, making it ideal for Jakarta EE-based enterprise environments.
-  ✅ Designed for intranet deployment within municipal administrative offices, prioritizing simplicity, maintainability, and server-side processing integrity.

## ⚙️ Setup and Configuration Guide
### 🔧  Prerequisites
| Tool/Technology   | Recommended Version |
| ----------------- | ------------------- |
| Java JDK          | 11+                 |
| Apache Tomcat     | 10.x (Jakarta EE)   |
| MySQL             | 8.x                 |
| IntelliJ IDEA     | Latest              |
| Git               | Latest              |
| MySQL Connector/J | Included in `/lib`  |


## 📌 Deployment Philosophy
#### This system was built under the assumption of:
- Server-side rendering: All UI rendering happens through JSP pages served via Tomcat.
-  Simplicity-first stack: Avoiding JavaScript-heavy interactivity ensures compatibility, security, and reduced browser dependency.
-  Ease of installation: The project is designed for quick deployment on any Jakarta EE-compatible servlet container (e.g., Apache Tomcat 10+).

## 🛠️ Installation Steps
### 1️⃣ Clone the Repository
- 1️⃣ Clone the Repository
-  git clone https://github.com/<your-username>/cms.git
-   cd cms
### 2️⃣ Configure the Database
- CREATE DATABASE cms_db;
 
### 3️⃣ Set Up Database Connection (DBCP)
- ds.setUrl("jdbc:mysql://localhost:3306/cms_db");
- ds.setUsername("your_mysql_user");
- ds.setPassword("your_mysql_password");

### 4️⃣ Deploy the Application
- Open project in IntelliJ IDEA.
- Add Apache Tomcat server configuration.
- Deploy the .war file or run the project directly using “Run on Server”.

### 5️⃣ Run the Application
- http://localhost:8080/cms/


## 🗂️ Structured Source Code Layout
<pre>
cms/
├── src/
│   ├── controller/          # Java Servlets (LoginServlet, ComplaintServlet)
│   ├── model/               # JavaBeans and DAO classes (User, Complaint, UserDAO, ComplaintDAO)
│   ├── db/                  # DB connection pool (DBCP.java)
│
├── web/
│   ├── view/                # JSP files (login.jsp, dashboard.jsp, complaintForm.jsp)
│   ├── css/                 # CSS styles
│   ├── js/                  # JavaScript (form validation only)
│   └── WEB-INF/
│       └── web.xml          # Deployment descriptor
│
├── db/
│   └── schema.sql           # SQL dump for database
│
└── README.md
</pre>

##  Default Users (for testing)
insert into user(name,email,password,role)values("sasanka","silvakssd@gmail.com","1234","Employee");

insert into user(name,email,password,role)values("shamindu","kssds1212@gmail.com","1234","Admin");

insert into complaint(complaint_id,employee_id,title,description,status,remarks,date)values (1,1,"nothing",'none',"pending",'none','2024-12-10');

## Login
- 📝 Navigate to the login page:
- http://localhost:8080/API_JavaEE_CMS_Web_exploded/login.jsp

- ✅ Test logins:
- Employee: silvakssd@gmail.com / 1234
- Admin: kssds1212@gmail.com / 1234

##  Troubleshooting
- ❗ Common issues:
- DB connection failed? → Check URL, username/password, MySQL server status. 
- App not starting? → Verify WAR deployed correctly. Check Tomcat logs. 
- JDBC driver missing? → Download MySQL Connector/J and add to lib.

## 📌 Features & Functionalities
### 🔐 Authentication Module
- The authentication module is a crucial component of the Complaint Management System, ensuring that only authorized users can access and perform operations based on their assigned roles.
- 🔑 Key Capabilities:
- User Login with Session Management:
-   Secure login via email and password.
-   Session-based tracking to maintain logged-in state.
-   Redirects unauthorized access attempts to the login page.
- Role-Based Access Control:
-   The system distinguishes users based on their role (Admin or Employee) after login.
-   UI components and functionalities are conditionally displayed depending on the role.

- 👤 Employee Access:
-  Can log in using personal credentials.
-  Allowed to:
-   Submit new complaints.
-   View a personal complaint history.
-   Edit or delete complaints only if unresolved.

- 🛡️ Admin Access:
- Admins are given extended privileges.
- Allowed to:
-   View all complaints from all employees.
-   Modify complaint statuses (Pending, In Progress, Resolved, Closed).
-   Add remarks and delete complaints when needed.

- 🔐 Security Practices (Prototype Level):
- Passwords are stored in plain text for simplicity in this prototype.
- In production, implement hashing (e.g., BCrypt) and secure session handling.
- Session timeout and logout functions can be added for enhanced security.

## 🖼️ Project Screenshots

### 🔐 Login Page
![Login](screenshots/login.png)

### 🧾 Complaint Submission Form
![Complaint Form](screenshots/complaint_submission.png)

### 🛠️ Admin Dashboard
![Admin Dashboard](screenshots/admin_dashboard.png)


