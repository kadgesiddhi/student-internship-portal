package com.fsjp.portal.dao;

import com.fsjp.portal.model.Student;
import com.fsjp.portal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public static boolean createStudent(Student student) {
        String sql = "INSERT INTO students (user_id, full_name, mobile, college, course, graduation_year, skills, resume_link, experience, address, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, student.getUserId());
            ps.setString(2, student.getFullName());
            ps.setString(3, student.getMobile());
            ps.setString(4, student.getCollege());
            ps.setString(5, student.getCourse());
            ps.setString(6, student.getGraduationYear());
            ps.setString(7, student.getSkills());
            ps.setString(8, student.getResumeLink());
            ps.setString(9, student.getExperience());
            ps.setString(10, student.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Student findByUserId(int userId) {
        String sql = "SELECT * FROM students WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Student findById(int id) {
        String sql = "SELECT * FROM students WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean updateStudent(Student student) {
        String sql = "UPDATE students SET full_name = ?, mobile = ?, college = ?, course = ?, graduation_year = ?, skills = ?, resume_link = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student.getFullName());
            ps.setString(2, student.getMobile());
            ps.setString(3, student.getCollege());
            ps.setString(4, student.getCourse());
            ps.setString(5, student.getGraduationYear());
            ps.setString(6, student.getSkills());
            ps.setString(7, student.getResumeLink());
            ps.setInt(8, student.getUserId());
            int updatedRows = ps.executeUpdate();
            return updatedRows > 0 || findByUserId(student.getUserId()) != null;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT s.*, u.email FROM students s JOIN users u ON s.user_id = u.id ORDER BY s.id DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student student = mapRow(rs);
                list.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Student> searchStudents(String term) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT s.*, u.email FROM students s JOIN users u ON s.user_id = u.id WHERE s.full_name LIKE ? OR s.college LIKE ? OR s.course LIKE ? OR u.email LIKE ? ORDER BY s.id DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            String likeTerm = "%" + term + "%";
            ps.setString(1, likeTerm);
            ps.setString(2, likeTerm);
            ps.setString(3, likeTerm);
            ps.setString(4, likeTerm);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean updateStatus(int userId, String status) {
        return UserDAO.updateStatus(userId, status);
    }

    public static int countStudents() {
        String sql = "SELECT COUNT(*) FROM students";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private static Student mapRow(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setUserId(rs.getInt("user_id"));
        student.setFullName(rs.getString("full_name"));
        student.setMobile(rs.getString("mobile"));
        student.setCollege(rs.getString("college"));
        student.setCourse(rs.getString("course"));
        student.setGraduationYear(rs.getString("graduation_year"));
        student.setSkills(rs.getString("skills"));
        student.setResumeLink(rs.getString("resume_link"));
        student.setExperience(rs.getString("experience"));
        student.setAddress(rs.getString("address"));
        student.setCreatedAt(rs.getString("created_at"));
        return student;
    }
}
