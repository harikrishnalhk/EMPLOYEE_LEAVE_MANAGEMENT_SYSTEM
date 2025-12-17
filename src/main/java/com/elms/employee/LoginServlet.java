package com.elms.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.elms.dao.EmployeeDAO;

@WebServlet("/employeeLogin")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        try {
            // 1️⃣ Read login details
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // 2️⃣ Validate credentials from DB
            boolean valid = EmployeeDAO.validate(email, password);

            if (valid) {
                // 3️⃣ Create session
                HttpSession session = req.getSession();
                session.setAttribute("employee", email);

                // 4️⃣ Redirect to employee dashboard
                res.sendRedirect("employeeDashboard");

            } else {
                // 5️⃣ Invalid login
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("employeeLogin.jsp")
                   .forward(req, res);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
