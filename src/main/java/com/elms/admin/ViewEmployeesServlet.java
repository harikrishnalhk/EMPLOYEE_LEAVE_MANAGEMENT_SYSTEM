package com.elms.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import com.elms.dao.EmployeeDAO;
import com.elms.model.Employee;

@WebServlet("/viewEmployees")
public class ViewEmployeesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        try {
            List<Employee> employees = EmployeeDAO.getAllEmployees();
            req.setAttribute("employees", employees);
            req.getRequestDispatcher("viewEmployees.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
