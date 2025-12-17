package com.elms.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.elms.dao.LeaveDAO;

@WebServlet("/leaveAction")
public class LeaveActionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String action = req.getParameter("action");

            if ("APPROVE".equals(action)) {
                LeaveDAO.approveLeave(id);
            }
            else if ("REJECT".equals(action)) {
                String reason = req.getParameter("reason");
                LeaveDAO.rejectLeave(id, reason);
            }

            // 🔁 Reload admin leaves page
            res.sendRedirect("adminLeaves");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
