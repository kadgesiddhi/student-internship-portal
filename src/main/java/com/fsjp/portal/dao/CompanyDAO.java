package com.fsjp.portal.dao;

import com.fsjp.portal.model.Company;
import com.fsjp.portal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO {

    public static boolean createCompany(Company company) {
        String sql = "INSERT INTO companies (user_id, company_name, mobile, location, website, description, approval_status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, company.getUserId());
            ps.setString(2, company.getCompanyName());
            ps.setString(3, company.getMobile());
            ps.setString(4, company.getLocation());
            ps.setString(5, company.getWebsite());
            ps.setString(6, company.getDescription());
            ps.setString(7, company.getApprovalStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Company findByUserId(int userId) {
        String sql = "SELECT * FROM companies WHERE user_id = ?";
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

    public static boolean updateCompany(Company company) {
        String sql = "UPDATE companies SET company_name = ?, mobile = ?, location = ?, website = ?, description = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, company.getCompanyName());
            ps.setString(2, company.getMobile());
            ps.setString(3, company.getLocation());
            ps.setString(4, company.getWebsite());
            ps.setString(5, company.getDescription());
            ps.setInt(6, company.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Company> getAllCompanies() {
        List<Company> companies = new ArrayList<>();
        String sql = "SELECT c.*, u.email FROM companies c JOIN users u ON c.user_id = u.id ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                companies.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return companies;
    }

    public static boolean updateApprovalStatus(int companyId, String status) {
        String sql = "UPDATE companies SET approval_status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, companyId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateStatus(int userId, String status) {
        return UserDAO.updateStatus(userId, status);
    }

    public static int countCompanies() {
        String sql = "SELECT COUNT(*) FROM companies";
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

    private static Company mapRow(ResultSet rs) throws SQLException {
        Company company = new Company();
        company.setId(rs.getInt("id"));
        company.setUserId(rs.getInt("user_id"));
        company.setCompanyName(rs.getString("company_name"));
        company.setMobile(rs.getString("mobile"));
        company.setLocation(rs.getString("location"));
        company.setWebsite(rs.getString("website"));
        company.setDescription(rs.getString("description"));
        company.setApprovalStatus(rs.getString("approval_status"));
        company.setCreatedAt(rs.getString("created_at"));
        return company;
    }
}
