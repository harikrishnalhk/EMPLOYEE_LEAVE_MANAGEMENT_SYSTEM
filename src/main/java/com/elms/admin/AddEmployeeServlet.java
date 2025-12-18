
package com.elms.admin;
import jakarta.servlet.*;import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;import java.util.*;
import java.sql.*;
import com.elms.dao.EmployeeDAO;
import com.elms.util.DBConnection;

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

    String email = generateUniqueEmail(name);
    String password="Emp@"+UUID.randomUUID().toString().substring(0,6);

    EmployeeDAO.addEmployee(name,email,password,dept,phone,pemail,gender);

    req.setAttribute("msg",
      "Employee Created<br>Email:"+email+"<br>Password:"+password);

    req.getRequestDispatcher("addEmployee.jsp").forward(req,res);

}catch(Exception e){
    throw new ServletException(e);
}
}

private String generateUniqueEmail(String name) throws Exception {
    String base = name.toLowerCase().replaceAll("\\s+", "").replaceAll("[^a-z]", "");
    String email = base + "@iamneo.ai";
    
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT id FROM employee WHERE email = ?");
    
    // Check if base exists
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    if (!rs.next()) {
        con.close();
        return email;
    }
    
    // If exists, add _ in middle
    int mid = base.length() / 2;
    String modified = base.substring(0, mid) + "_" + base.substring(mid);
    email = modified + "@iamneo.ai";
    
    // Check again
    ps.setString(1, email);
    rs = ps.executeQuery();
    if (!rs.next()) {
        con.close();
        return email;
    }
    
    // If still exists, add another _
    mid = modified.length() / 2;
    modified = modified.substring(0, mid) + "_" + modified.substring(mid);
    email = modified + "@iamneo.ai";
    
    con.close();
    return email;
}
}

