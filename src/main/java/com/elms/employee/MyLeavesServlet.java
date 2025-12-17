package com.elms.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.elms.dao.LeaveDAO;
import com.elms.model.Leave;

@WebServlet("/myLeaves")
public class MyLeavesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        try {
            HttpSession session = req.getSession(false);

            if (session == null || session.getAttribute("employee") == null) {
                res.sendRedirect("employeeLogin.jsp");
                return;
            }

            String email = session.getAttribute("employee").toString();

            List<Leave> leaves = LeaveDAO.getLeavesByEmployee(email);
            req.setAttribute("leaves", leaves);

            req.getRequestDispatcher("myLeaves.jsp")
               .forward(req, res);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
