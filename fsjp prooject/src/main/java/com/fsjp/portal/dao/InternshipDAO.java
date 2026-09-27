package com.fsjp.portal.dao;

import com.fsjp.portal.model.Internship;
import com.fsjp.portal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InternshipDAO {

    public static boolean createInternship(Internship internship) {
        String sql = "INSERT INTO internships (company_id, title, description, skills, location, internship_type, duration, stipend, requirements, benefits, deadline, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, internship.getCompanyId());
            ps.setString(2, internship.getTitle());
            ps.setString(3, internship.getDescription());
            ps.setString(4, internship.getSkills());
            ps.setString(5, internship.getLocation());
            ps.setString(6, internship.getInternshipType());
            ps.setString(7, internship.getDuration());
            ps.setString(8, internship.getStipend());
            ps.setString(9, internship.getRequirements());
            ps.setString(10, internship.getBenefits());
            ps.setString(11, internship.getDeadline());
            ps.setString(12, internship.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Internship> getApprovedInternships(String search, String location, String skill, String type) {
        List<Internship> internships = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT i.*, c.company_name FROM internships i JOIN companies c ON i.company_id = c.id WHERE i.status = 'APPROVED' ");

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (i.title LIKE ? OR i.skills LIKE ? OR c.company_name LIKE ?) ");
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append("AND i.location LIKE ? ");
        }
        if (skill != null && !skill.trim().isEmpty()) {
            sql.append("AND i.skills LIKE ? ");
        }
        if (type != null && !type.trim().isEmpty()) {
            sql.append("AND i.internship_type = ? ");
        }
        sql.append("ORDER BY i.created_at DESC");

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                String likeTerm = "%" + search + "%";
                ps.setString(index++, likeTerm);
                ps.setString(index++, likeTerm);
                ps.setString(index++, likeTerm);
            }
            if (location != null && !location.trim().isEmpty()) {
                ps.setString(index++, "%" + location + "%");
            }
            if (skill != null && !skill.trim().isEmpty()) {
                ps.setString(index++, "%" + skill + "%");
            }
            if (type != null && !type.trim().isEmpty()) {
                ps.setString(index++, type);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                internships.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return internships;
    }

    public static List<Internship> getRecommended() {
        List<Internship> internships = new ArrayList<>();
        String sql = "SELECT i.*, c.company_name FROM internships i JOIN companies c ON i.company_id = c.id WHERE i.status = 'APPROVED' ORDER BY i.created_at DESC LIMIT 4";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                internships.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return internships;
    }

    public static List<Internship> getByCompanyId(int companyId) {
        List<Internship> internships = new ArrayList<>();
        String sql = "SELECT i.*, c.company_name FROM internships i JOIN companies c ON i.company_id = c.id WHERE i.company_id = ? ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, companyId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                internships.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return internships;
    }

    public static List<Internship> getAllForAdmin() {
        List<Internship> internships = new ArrayList<>();
        String sql = "SELECT i.*, c.company_name FROM internships i JOIN companies c ON i.company_id = c.id ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                internships.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return internships;
    }

    public static Internship getById(int id) {
        String sql = "SELECT i.*, c.company_name FROM internships i JOIN companies c ON i.company_id = c.id WHERE i.id = ?";
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

    public static boolean updateInternship(Internship internship) {
        String sql = "UPDATE internships SET title = ?, description = ?, skills = ?, location = ?, internship_type = ?, duration = ?, stipend = ?, requirements = ?, benefits = ?, deadline = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, internship.getTitle());
            ps.setString(2, internship.getDescription());
            ps.setString(3, internship.getSkills());
            ps.setString(4, internship.getLocation());
            ps.setString(5, internship.getInternshipType());
            ps.setString(6, internship.getDuration());
            ps.setString(7, internship.getStipend());
            ps.setString(8, internship.getRequirements());
            ps.setString(9, internship.getBenefits());
            ps.setString(10, internship.getDeadline());
            ps.setInt(11, internship.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteInternship(int internshipId) {
        String sql = "DELETE FROM internships WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, internshipId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateStatus(int internshipId, String status) {
        String sql = "UPDATE internships SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, internshipId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static int countTotalInternships() {
        String sql = "SELECT COUNT(*) FROM internships";
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

    public static int countActiveByCompany(int companyId) {
        String sql = "SELECT COUNT(*) FROM internships WHERE company_id = ? AND status = 'APPROVED'";
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

    private static Internship mapRow(ResultSet rs) throws SQLException {
        Internship internship = new Internship();
        internship.setId(rs.getInt("id"));
        internship.setCompanyId(rs.getInt("company_id"));
        internship.setTitle(rs.getString("title"));
        internship.setDescription(rs.getString("description"));
        internship.setSkills(rs.getString("skills"));
        internship.setLocation(rs.getString("location"));
        internship.setInternshipType(rs.getString("internship_type"));
        internship.setDuration(rs.getString("duration"));
        internship.setStipend(rs.getString("stipend"));
        internship.setRequirements(rs.getString("requirements"));
        internship.setBenefits(rs.getString("benefits"));
        internship.setDeadline(rs.getString("deadline"));
        internship.setStatus(rs.getString("status"));
        internship.setCreatedAt(rs.getString("created_at"));
        internship.setCompanyName(rs.getString("company_name"));
        return internship;
    }
}
