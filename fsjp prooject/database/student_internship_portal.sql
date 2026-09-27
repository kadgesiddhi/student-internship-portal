CREATE DATABASE IF NOT EXISTS student_internship_portal;
USE student_internship_portal;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('STUDENT','COMPANY','ADMIN') NOT NULL,
    status ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    mobile VARCHAR(30),
    college VARCHAR(255),
    course VARCHAR(255),
    graduation_year VARCHAR(20),
    skills TEXT,
    resume_link VARCHAR(500),
    experience TEXT,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE companies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(30),
    location VARCHAR(255),
    website VARCHAR(255),
    industry VARCHAR(255),
    description TEXT,
    approval_status ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE internships (
    id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    skills TEXT,
    location VARCHAR(255),
    internship_type VARCHAR(100),
    duration VARCHAR(100),
    stipend VARCHAR(100),
    requirements TEXT,
    benefits TEXT,
    deadline VARCHAR(50),
    status ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);

CREATE TABLE applications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    internship_id INT NOT NULL,
    company_id INT NOT NULL,
    status ENUM('PENDING','SELECTED','REJECTED') DEFAULT 'PENDING',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (internship_id) REFERENCES internships(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);

CREATE TABLE contact_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    subject VARCHAR(255),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (email, password, role, status) VALUES
('admin@portal.com', '$2b$10$8hp2hsoJ0wvcgUDjM2F3nOqH2a7F2yVu9qKe89iFHKmvO4fjyEVOm', 'ADMIN', 'ACTIVE'),
('student1@example.com', '$2b$10$8hp2hsoJ0wvcgUDjM2F3nOqH2a7F2yVu9qKe89iFHKmvO4fjyEVOm', 'STUDENT', 'ACTIVE'),
('company1@example.com', '$2b$10$8hp2hsoJ0wvcgUDjM2F3nOqH2a7F2yVu9qKe89iFHKmvO4fjyEVOm', 'COMPANY', 'ACTIVE');

INSERT INTO students (user_id, full_name, mobile, college, course, graduation_year, skills, resume_link, experience, address) VALUES
(2, 'Aarav Sharma', '9876543210', 'NIT Jaipur', 'B.Tech Computer Science', '2026', 'Java, SQL, Web Development', 'https://example.com/resume/aarav', '3 months internship in web development', 'Jaipur, Rajasthan');

INSERT INTO companies (user_id, company_name, contact_person, email, phone, location, website, industry, description, approval_status) VALUES
(3, 'TechNova Solutions', 'Ritika Mehta', 'company1@example.com', '9123456780', 'Bengaluru', 'https://technova.example', 'Software', 'Build smart software products for startups.', 'APPROVED');

INSERT INTO internships (company_id, title, description, skills, location, internship_type, duration, stipend, requirements, benefits, deadline, status) VALUES
(1, 'Java Developer Intern', 'Work on backend services and APIs for enterprise clients.', 'Java, Spring, MySQL, REST APIs', 'Bengaluru', 'Full Time', '6 Months', '₹15,000/month', 'Strong Java fundamentals and eagerness to learn', 'Certificate, PPO opportunity', '2026-12-31', 'APPROVED');

INSERT INTO applications (student_id, internship_id, company_id, status) VALUES
(1, 1, 1, 'PENDING');

INSERT INTO contact_messages (name, email, subject, message) VALUES
('Visitor', 'visitor@example.com', 'General Inquiry', 'I would like to know more about internship opportunities.');
