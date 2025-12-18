package com.elms.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final String ADMIN_USER = "admin@iamneo.ai";
    private static final String ADMIN_PASS = "admin123";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (ADMIN_USER.equals(username) && ADMIN_PASS.equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("admin", "true");
            res.sendRedirect("adminDashboard");

        } else {
            req.setAttribute("error", "Invalid Admin Credentials");
            req.getRequestDispatcher("adminLogin.jsp").forward(req, res);
        }
    }
}
