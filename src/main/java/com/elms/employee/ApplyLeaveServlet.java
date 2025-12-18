package com.elms.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import com.elms.dao.LeaveDAO;
import com.elms.dao.EmployeeDAO;

@WebServlet("/applyLeave")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
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
            String duration = req.getParameter("duration");
            Part documentPart = req.getPart("document");

            // Set gender for JSP
            String gender = EmployeeDAO.getGender(email);
            req.setAttribute("gender", gender);

            // 🔴 Validation
            if (type == null || fromDate == null || toDate == null || reason == null ||
                type.isEmpty() || fromDate.isEmpty() || toDate.isEmpty() || reason.isEmpty()) {

                req.setAttribute("error", "All fields are required");
                req.getRequestDispatcher("applyLeave.jsp").forward(req, res);
                return;
            }

            // Check if fromDate is in the past
            LocalDate start = LocalDate.parse(fromDate);
            if (start.isBefore(LocalDate.now())) {
                req.setAttribute("error", "Leave cannot be applied for past dates.");
                req.getRequestDispatcher("applyLeave.jsp").forward(req, res);
                return;
            }

            // Check if toDate is before fromDate
            LocalDate end = LocalDate.parse(toDate);
            if (end.isBefore(start)) {
                req.setAttribute("error", "End date cannot be before start date.");
                req.getRequestDispatcher("applyLeave.jsp").forward(req, res);
                return;
            }

            // Check document for sick leave >2 days
            if ("SICK".equalsIgnoreCase(type) && fromDate != null && toDate != null) {
                long days = ChronoUnit.DAYS.between(start, end) + 1;
                if (days > 2 && (documentPart == null || documentPart.getSize() == 0)) {
                    req.setAttribute("error", "Medical certificate required for sick leave exceeding two days.");
                    req.getRequestDispatcher("applyLeave.jsp").forward(req, res);
                    return;
                }
            }

            boolean applied = LeaveDAO.applyLeave(
                    email, type, fromDate, toDate, reason, duration, documentPart);

            if (applied) {
                req.setAttribute("success", "Leave applied successfully");
            } else {
                req.setAttribute("error", "Leave already exists for the selected date(s).");
            }

            // ✅ STAY ON SAME PAGE
            req.getRequestDispatcher("applyLeave.jsp").forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong");
            req.getRequestDispatcher("applyLeave.jsp").forward(req, res);
        }
    }
}
