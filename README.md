# Student Internship Portal

A full-stack Java web application built with Java, JSP, Servlets, JDBC, MySQL, Maven, and Tomcat. It supports student, company, and admin roles with secure login, internship posting, applications, and admin approval workflows.

## Features
- Student registration and profile management
- Company registration and internship posting
- Admin approval of companies and internships
- Student internship applications
- Contact form and dashboard views
- Role-based access control

## Tech stack
- Java 17
- JSP / Servlets
- JDBC + MySQL
- Bootstrap 5
- Font Awesome
- Maven Webapp
- Tomcat 9+

## Project structure
- `src/main/java` – Java source files
- `src/main/webapp` – JSP pages and static assets
- `database` – SQL database script

## Setup
1. Install MySQL 8 and make sure the MySQL service is running.
2. Create a MySQL user and database named `student_internship_portal`.
3. Import the SQL script from `database/student_internship_portal.sql`.
4. Set environment variables before running Tomcat:
   ```powershell
   $env:DB_URL = "jdbc:mysql://localhost:3306/student_internship_portal?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
   $env:DB_USERNAME = "portal"
   $env:DB_PASSWORD = "portal123"
   ```
5. Run:
   ```bash
   mvn clean package
   ```
6. Deploy the generated WAR file from `target/` to Tomcat.

## MySQL setup commands
```sql
CREATE DATABASE student_internship_portal;
CREATE USER 'portal'@'localhost' IDENTIFIED BY 'portal123';
GRANT ALL PRIVILEGES ON student_internship_portal.* TO 'portal'@'localhost';
FLUSH PRIVILEGES;
```

## Default credentials
- Admin: admin@portal.com / password123
- Student: student1@example.com / password123
- Company: company1@example.com / password123

## Notes
This project intentionally uses the standard Java EE servlet/JSP approach without Spring Boot, matching the requested stack.
