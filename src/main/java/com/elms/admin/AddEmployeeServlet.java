
package com.elms.admin;
import jakarta.servlet.*;import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;import java.util.*;
import com.elms.dao.EmployeeDAO;
@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {

protected void doPost(HttpServletRequest req,HttpServletResponse res)
throws IOException,ServletException {

try{
    String name=req.getParameter("name");
    String dept=req.getParameter("department");
    String phone=req.getParameter("phone");
    String pemail=req.getParameter("personalEmail");
    String gender=req.getParameter("gender");

    String email=name.toLowerCase().replace(" ","")+"@company.com";
    String password="Emp@"+UUID.randomUUID().toString().substring(0,6);

    EmployeeDAO.addEmployee(name,email,password,dept,phone,pemail,gender);

    req.setAttribute("msg",
      "Employee Created<br>Email:"+email+"<br>Password:"+password);

    req.getRequestDispatcher("addEmployee.jsp").forward(req,res);

}catch(Exception e){
    throw new ServletException(e);
}
}
}

