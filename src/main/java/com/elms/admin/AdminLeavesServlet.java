package com.elms.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.elms.dao.LeaveDAO;
import com.elms.model.Leave;

@WebServlet("/adminLeaves")
public class AdminLeavesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        try {
            List<Leave> leaves = LeaveDAO.getAllLeaves();
            req.setAttribute("leaves", leaves);
            req.getRequestDispatcher("adminLeaves.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
