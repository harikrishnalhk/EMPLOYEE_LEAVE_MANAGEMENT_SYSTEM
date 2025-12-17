package com.elms.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.elms.dao.LeaveDAO;

@WebServlet("/applyLeave")
public class ApplyLeaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("employee") == null) {
            res.sendRedirect("employeeLogin.jsp");
            return;
        }

        try {
            String email = session.getAttribute("employee").toString();

            String type = req.getParameter("type");
            String fromDate = req.getParameter("fromDate");
            String toDate = req.getParameter("toDate");
            String reason = req.getParameter("reason");

            // 🔴 Validation
            if (type == null || fromDate == null || toDate == null || reason == null ||
                type.isEmpty() || fromDate.isEmpty() || toDate.isEmpty() || reason.isEmpty()) {

                req.setAttribute("error", "All fields are required");
                req.getRequestDispatcher("applyLeave.jsp").forward(req, res);
                return;
            }

            boolean applied = LeaveDAO.applyLeave(
                    email, type, fromDate, toDate, reason);

            if (applied) {
                req.setAttribute("success", "Leave applied successfully");
            } else {
                req.setAttribute("error", "Not enough leave balance");
            }

            // ✅ STAY ON SAME PAGE
            req.getRequestDispatcher("applyLeave.jsp").forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong");
            req.getRequestDispatcher("applyLeave.jsp").forward(req, res);
        }
    }
}
