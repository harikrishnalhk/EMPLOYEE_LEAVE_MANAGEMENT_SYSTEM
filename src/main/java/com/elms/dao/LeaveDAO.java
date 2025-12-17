package com.elms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import com.elms.model.Leave;
import com.elms.util.DBConnection;

public class LeaveDAO {

    // =====================================================
    // APPLY LEAVE (EMPLOYEE) — DEDUCT ON APPLY
    // =====================================================
    public static boolean applyLeave(
            String email,
            String type,
            String fromDate,
            String toDate,
            String reason) throws Exception {

        Connection con = DBConnection.getConnection();

        if (type == null || fromDate == null || toDate == null) {
            con.close();
            return false;
        }

        // 1️⃣ Calculate days
        LocalDate start = LocalDate.parse(fromDate);
        LocalDate end = LocalDate.parse(toDate);
        int days = (int) ChronoUnit.DAYS.between(start, end) + 1;

        // 2️⃣ Choose column
        String column = type.equalsIgnoreCase("CASUAL")
                ? "casual_leaves"
                : "sick_leaves";

        // 3️⃣ Check balance
        PreparedStatement ps1 = con.prepareStatement(
            "SELECT " + column + " FROM employee WHERE email=?"
        );
        ps1.setString(1, email);
        ResultSet rs = ps1.executeQuery();

        if (!rs.next()) {
            con.close();
            return false;
        }

        int balance = rs.getInt(1);
        if (balance < days) {
            con.close();
            return false; // ❌ NO LEAVES
        }

        // 4️⃣ DEDUCT IMMEDIATELY ✅
        PreparedStatement ps2 = con.prepareStatement(
            "UPDATE employee SET " + column + " = " + column + " - ? WHERE email=?"
        );
        ps2.setInt(1, days);
        ps2.setString(2, email);
        ps2.executeUpdate();

        // 5️⃣ INSERT LEAVE REQUEST
        PreparedStatement ps3 = con.prepareStatement(
            "INSERT INTO leave_request " +
            "(employee_email, leave_type, start_date, end_date, reason, status) " +
            "VALUES (?, ?, ?, ?, ?, 'PENDING')"
        );

        ps3.setString(1, email);
        ps3.setString(2, type);
        ps3.setString(3, fromDate);
        ps3.setString(4, toDate);
        ps3.setString(5, reason);
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
