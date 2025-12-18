package com.elms.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.elms.util.DBConnection;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            res.sendRedirect("adminLogin.jsp");
            return;
        }

        try {
            List<Map<String, String>> employeesOnLeave = getEmployeesOnLeave();
            int totalEmployees = getTotalEmployees();
            int leavesToday = getLeavesToday();
            int pendingRequests = getPendingRequests();
            req.setAttribute("employeesOnLeave", employeesOnLeave);
            req.setAttribute("totalEmployees", totalEmployees);
            req.setAttribute("leavesToday", leavesToday);
            req.setAttribute("pendingRequests", pendingRequests);
            req.getRequestDispatcher("adminDashboard.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private List<Map<String, String>> getEmployeesOnLeave() throws Exception {
        List<Map<String, String>> list = new ArrayList<>();
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT e.name, e.email, l.leave_type, l.start_date, l.end_date, l.duration " +
            "FROM leave_request l JOIN employee e ON l.employee_email = e.email " +
            "WHERE l.status = 'APPROVED' AND CURRENT_DATE BETWEEN l.start_date AND l.end_date " +
            "ORDER BY l.start_date"
        );

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, String> map = new HashMap<>();
            map.put("name", rs.getString("name"));
            map.put("email", rs.getString("email"));
            map.put("type", rs.getString("leave_type"));
            map.put("start", rs.getString("start_date"));
            map.put("end", rs.getString("end_date"));
            map.put("duration", rs.getString("duration"));
            list.add(map);
        }

        con.close();
        return list;
    }

    private int getTotalEmployees() throws Exception {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM employee");
        ResultSet rs = ps.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        con.close();
        return count;
    }

    private int getLeavesToday() throws Exception {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT COUNT(*) FROM leave_request WHERE status = 'APPROVED' AND CURRENT_DATE BETWEEN start_date AND end_date"
        );
        ResultSet rs = ps.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        con.close();
        return count;
    }

    private int getPendingRequests() throws Exception {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT COUNT(*) FROM leave_request WHERE status = 'PENDING'"
        );
        ResultSet rs = ps.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        con.close();
        return count;
    }
}