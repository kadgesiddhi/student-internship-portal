package com.fsjp.portal.dao;

import com.fsjp.portal.model.Application;
import com.fsjp.portal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    public static boolean createApplication(int internshipId, int studentId) {
        String sql = "INSERT INTO applications (internship_id, student_id, company_id, applied_at, status) "
                + "SELECT ?, ?, company_id, NOW(), 'PENDING' FROM internships WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, internshipId);
            ps.setInt(2, studentId);
            ps.setInt(3, internshipId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean hasApplied(int internshipId, int studentId) {
        String sql = "SELECT 1 FROM applications WHERE internship_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, internshipId);
            ps.setInt(2, studentId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return true;
        }
    }

    public static List<Application> getByStudentId(int studentId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, i.title as internship_title, c.company_name, i.location FROM applications a JOIN internships i ON a.internship_id = i.id JOIN companies c ON i.company_id = c.id WHERE a.student_id = ? ORDER BY a.applied_at DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = mapRow(rs);
                list.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Application> getByCompanyId(int companyId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, i.title as internship_title, c.company_name, i.location, s.full_name as student_name, u.email, s.college, s.course, s.skills FROM applications a JOIN internships i ON a.internship_id = i.id JOIN companies c ON i.company_id = c.id JOIN students s ON a.student_id = s.id JOIN users u ON s.user_id = u.id WHERE c.id = ? ORDER BY a.applied_at DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, companyId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowDetailed(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Application> getAllApplications() {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, i.title as internship_title, c.company_name, i.location, s.full_name as student_name, u.email, s.college, s.course, s.skills FROM applications a JOIN internships i ON a.internship_id = i.id JOIN companies c ON i.company_id = c.id JOIN students s ON a.student_id = s.id JOIN users u ON s.user_id = u.id ORDER BY a.applied_at DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowDetailed(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean updateStatus(int applicationId, String status) {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static int countTotalApplications() {
        String sql = "SELECT COUNT(*) FROM applications";
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

    public static int countPendingForStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE student_id = ? AND status = 'PENDING'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int countSelectedForStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE student_id = ? AND status = 'SELECTED'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int countRejectedForStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE student_id = ? AND status = 'REJECTED'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int countSelectedStudentsForCompany(int companyId) {
        String sql = "SELECT COUNT(*) FROM applications a JOIN internships i ON a.internship_id = i.id WHERE i.company_id = ? AND a.status = 'SELECTED'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, companyId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private static Application mapRow(ResultSet rs) throws SQLException {
        Application app = new Application();
        app.setId(rs.getInt("id"));
        app.setInternshipId(rs.getInt("internship_id"));
        app.setStudentId(rs.getInt("student_id"));
        app.setAppliedDate(rs.getString("applied_at"));
        app.setStatus(rs.getString("status"));
        app.setInternshipTitle(rs.getString("internship_title"));
        app.setCompanyName(rs.getString("company_name"));
        app.setLocation(rs.getString("location"));
        return app;
    }

    private static Application mapRowDetailed(ResultSet rs) throws SQLException {
        Application app = mapRow(rs);
        app.setStudentName(rs.getString("student_name"));
        app.setEmail(rs.getString("email"));
        app.setCollege(rs.getString("college"));
        app.setCourse(rs.getString("course"));
        app.setSkills(rs.getString("skills"));
        return app;
    }
}
