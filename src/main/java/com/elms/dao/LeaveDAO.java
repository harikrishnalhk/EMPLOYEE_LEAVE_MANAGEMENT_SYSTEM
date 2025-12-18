package com.elms.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.Part;

import com.elms.model.Leave;
import com.elms.util.DBConnection;

public class LeaveDAO {

    // =====================================================
    // CHECK OVERLAPPING LEAVE
    // =====================================================
    public static boolean hasOverlappingLeave(String email, String fromDate, String toDate) throws Exception {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT id FROM leave_request WHERE employee_email = ? AND status != 'REJECTED' " +
            "AND start_date <= ? AND end_date >= ?"
        );
        ps.setString(1, email);
        ps.setDate(2, Date.valueOf(toDate));
        ps.setDate(3, Date.valueOf(fromDate));

        ResultSet rs = ps.executeQuery();
        boolean overlap = rs.next();
        con.close();
        return overlap;
    }

    // =====================================================
    // APPLY LEAVE (EMPLOYEE) — DEDUCT ON APPLY
    // =====================================================
    public static boolean applyLeave(
            String email,
            String type,
            String fromDate,
            String toDate,
            String reason,
            String duration,
            Part documentPart) throws Exception {

        Connection con = DBConnection.getConnection();

        if (type == null || fromDate == null || toDate == null || reason == null) {
            con.close();
            return false;
        }

        // 1️⃣ Calculate days
        LocalDate start = LocalDate.parse(fromDate);
        LocalDate end = LocalDate.parse(toDate);
        double days = ChronoUnit.DAYS.between(start, end) + 1;
        if ("FIRST".equals(duration) || "SECOND".equals(duration)) {
            days = 0.5;
        }

        // 2️⃣ Check overlap
        if (hasOverlappingLeave(email, fromDate, toDate)) {
            con.close();
            return false; // Overlap
        }

        // 3️⃣ Choose column (only for Casual and Sick)
        String column = null;
        if ("CASUAL".equalsIgnoreCase(type)) {
            column = "casual_leaves";
        } else if ("SICK".equalsIgnoreCase(type)) {
            column = "sick_leaves";
        }

        // 4️⃣ Check balance if applicable
        if (column != null) {
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT " + column + " FROM employee WHERE email=?"
            );
            ps1.setString(1, email);
            ResultSet rs = ps1.executeQuery();

            if (!rs.next()) {
                con.close();
                return false;
            }

            double balance = rs.getInt(1);
            if (balance < days) {
                con.close();
                return false; // ❌ NO LEAVES
            }

            // 5️⃣ DEDUCT
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE employee SET " + column + " = " + column + " - ? WHERE email=?"
            );
            ps2.setDouble(1, days);
            ps2.setString(2, email);
            ps2.executeUpdate();
        }

        // 6️⃣ Handle document
        String documentPath = null;
        if (documentPart != null && documentPart.getSize() > 0) {
            // Save file
            String fileName = email.replace("@", "_") + "_" + System.currentTimeMillis() + "_" + documentPart.getSubmittedFileName();
            String uploadPath = "C:/ELMS/uploads/"; // Adjust path as needed
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            documentPart.write(uploadPath + fileName);
            documentPath = uploadPath + fileName;
        }

        // 7️⃣ INSERT LEAVE REQUEST
        PreparedStatement ps3 = con.prepareStatement(
            "INSERT INTO leave_request " +
            "(employee_email, leave_type, start_date, end_date, reason, status, duration, document_path) " +
            "VALUES (?, ?, ?, ?, ?, 'PENDING', ?, ?)"
        );

        ps3.setString(1, email);
        ps3.setString(2, type);
        ps3.setDate(3, Date.valueOf(start));
        ps3.setDate(4, Date.valueOf(end));
        ps3.setString(5, reason);
        ps3.setString(6, duration);
        ps3.setString(7, documentPath);
        ps3.executeUpdate();

        con.close();
        return true;
    }

    // =====================================================
    // ADMIN: VIEW ALL LEAVES
    // =====================================================
    public static List<Leave> getAllLeaves() throws Exception {

        List<Leave> list = new ArrayList<>();
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM leave_request"
        );

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Leave l = new Leave();
            l.setId(rs.getInt("id"));
            l.setEmail(rs.getString("employee_email"));
            l.setType(rs.getString("leave_type"));
            l.setFromDate(rs.getString("start_date"));
            l.setToDate(rs.getString("end_date"));
            l.setReason(rs.getString("reason"));
            l.setStatus(rs.getString("status"));
            l.setRejectionReason(rs.getString("rejection_reason"));
            l.setDuration(rs.getString("duration"));
            l.setDocumentPath(rs.getString("document_path"));
            list.add(l);
        }

        con.close();
        return list;
    }

    // =====================================================
    // EMPLOYEE: VIEW MY LEAVES
    // =====================================================
    public static List<Leave> getLeavesByEmployee(String email) throws Exception {

        List<Leave> list = new ArrayList<>();
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM leave_request WHERE employee_email=?"
        );
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Leave l = new Leave();
            l.setType(rs.getString("leave_type"));
            l.setFromDate(rs.getString("start_date"));
            l.setToDate(rs.getString("end_date"));
            l.setStatus(rs.getString("status"));
            l.setRejectionReason(rs.getString("rejection_reason"));
            l.setDuration(rs.getString("duration"));
            l.setDocumentPath(rs.getString("document_path"));
            list.add(l);
        }

        con.close();
        return list;
    }

    // =====================================================
    // ADMIN: APPROVE LEAVE (NO BALANCE CHANGE)
    // =====================================================
    public static void approveLeave(int id) throws Exception {

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "UPDATE leave_request SET status='APPROVED', rejection_reason=NULL WHERE id=?"
        );
        ps.setInt(1, id);
        ps.executeUpdate();

        con.close();
    }

    // =====================================================
    // ADMIN: REJECT LEAVE + REFUND LEAVES ✅
    // =====================================================
    public static void rejectLeave(int id, String reason) throws Exception {

        Connection con = DBConnection.getConnection();

        // 1️⃣ Get leave details
        PreparedStatement ps1 = con.prepareStatement(
            "SELECT employee_email, leave_type, start_date, end_date " +
            "FROM leave_request WHERE id=?"
        );
        ps1.setInt(1, id);
        ResultSet rs = ps1.executeQuery();

        if (rs.next()) {

            String email = rs.getString("employee_email");
            String type = rs.getString("leave_type");

            int days = (int) ChronoUnit.DAYS.between(
                    rs.getDate("start_date").toLocalDate(),
                    rs.getDate("end_date").toLocalDate()
            ) + 1;

            String column = type.equalsIgnoreCase("CASUAL")
                    ? "casual_leaves"
                    : "sick_leaves";

            // 2️⃣ REFUND LEAVE
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE employee SET " + column + " = " + column + " + ? WHERE email=?"
            );
            ps2.setInt(1, days);
            ps2.setString(2, email);
            ps2.executeUpdate();

            // 3️⃣ UPDATE STATUS
            PreparedStatement ps3 = con.prepareStatement(
                "UPDATE leave_request SET status='REJECTED', rejection_reason=? WHERE id=?"
            );
            ps3.setString(1, reason);
            ps3.setInt(2, id);
            ps3.executeUpdate();
        }

        con.close();
    }
}
