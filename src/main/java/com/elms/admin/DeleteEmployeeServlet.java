package com.elms.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.elms.util.DBConnection;

@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            res.sendRedirect("adminLogin.jsp");
            return;
        }

        String email = req.getParameter("email");
        if (email == null || email.isEmpty()) {
            req.setAttribute("error", "Invalid employee");
            req.getRequestDispatcher("viewEmployees").forward(req, res);
            return;
        }

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Delete leave requests
            PreparedStatement ps1 = con.prepareStatement(
                "DELETE FROM leave_request WHERE employee_email = ?"
            );
            ps1.setString(1, email);
            ps1.executeUpdate();

            // Delete employee
            PreparedStatement ps2 = con.prepareStatement(
                "DELETE FROM employee WHERE email = ?"
            );
            ps2.setString(1, email);
            int rows = ps2.executeUpdate();

            if (rows > 0) {
                con.commit();
                res.sendRedirect("viewEmployees?success=Employee deleted successfully");
            } else {
                con.rollback();
                res.sendRedirect("viewEmployees?error=Employee not found");
            }

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (Exception ex) {}
            }
            res.sendRedirect("viewEmployees?error=Failed to delete employee: " + e.getMessage());
        } finally {
            if (con != null) {
                try { con.close(); } catch (Exception e) {}
            }
        }
    }
}