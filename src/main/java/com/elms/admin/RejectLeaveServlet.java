package com.elms.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import com.elms.dao.LeaveDAO;

@WebServlet("/rejectLeave")
public class RejectLeaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String reason = req.getParameter("reason");

            LeaveDAO.rejectLeave(id, reason);   
            res.sendRedirect("adminLeaves");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
