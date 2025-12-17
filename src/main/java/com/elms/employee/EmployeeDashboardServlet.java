package com.elms.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.elms.dao.EmployeeDAO;
import com.elms.dao.LeaveDAO;

@WebServlet("/employeeDashboard")
public class EmployeeDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // 🔐 1. SESSION CHECK
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("employee") == null) {
            res.sendRedirect("employeeLogin.jsp");
            return;
        }

        try {
            // 2. LOGGED-IN EMPLOYEE
            String email = session.getAttribute("employee").toString();

            // ====================================================
            // ✅ THIS IS THE EXACT PLACE WHERE COUNTS UPDATE
            // ====================================================
            int sickLeaves = EmployeeDAO.getSickLeaves(email);
            int casualLeaves = EmployeeDAO.getCasualLeaves(email);

            req.setAttribute("sick", sickLeaves);
            req.setAttribute("casual", casualLeaves);

            // Employee leave history
            req.setAttribute("leaves", LeaveDAO.getLeavesByEmployee(email));
            // ====================================================

            // 3. FORWARD TO JSP
            req.getRequestDispatcher("employeeDashboard.jsp")
               .forward(req, res);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
