package com.elms.dao;

import java.sql.*;
import java.util.*;
import com.elms.model.Employee;
import com.elms.util.DBConnection;

public class EmployeeDAO {

    /* =========================
       ADD EMPLOYEE (ADMIN)
       ========================= */
    public static void addEmployee(
            String name,
            String email,
            String password,
            String department,
            String phone,
            String personalEmail,
            String gender) throws Exception {

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO employee " +
            "(name, email, password, department, phone, personal_email, gender, casual_leaves, sick_leaves) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, department);
        ps.setString(5, phone);
        ps.setString(6, personalEmail);
        ps.setString(7, gender);
        ps.setInt(8, 24); // Casual leaves default
        ps.setInt(9, 12); // Sick leaves default

        ps.executeUpdate();
        con.close();
    }

    /* =========================
       EMPLOYEE LOGIN
       ========================= */
    public static boolean validate(String email, String password) throws Exception {

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT id FROM employee WHERE email=? AND password=?"
        );

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();
        boolean result = rs.next();

        con.close();
        return result;
    }

    /* =========================
       VIEW EMPLOYEES (ADMIN)
       ========================= */
    public static List<Employee> getAllEmployees() throws Exception {

        List<Employee> list = new ArrayList<>();
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT name, department, email, phone, gender FROM employee"
        );

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Employee e = new Employee();
            e.setName(rs.getString("name"));
            e.setDepartment(rs.getString("department"));
            e.setEmail(rs.getString("email"));
            e.setPhone(rs.getString("phone"));
            e.setGender(rs.getString("gender"));
            list.add(e);
        }

        con.close();
        return list;
    }

    /* =========================
       GET CASUAL LEAVES
       ========================= */
    public static double getCasualLeaves(String email) throws Exception {

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT casual_leaves FROM employee WHERE email=?"
        );
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        double casual = 0;
        if (rs.next()) {
            casual = rs.getDouble("casual_leaves");
        }

        con.close();
        return casual;
    }

    /* =========================
       GET SICK LEAVES
       ========================= */
    public static double getSickLeaves(String email) throws Exception {

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT sick_leaves FROM employee WHERE email=?"
        );
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        double sick = 0;
        if (rs.next()) {
            sick = rs.getDouble("sick_leaves");
        }

        con.close();
        return sick;
    }

    /* =========================
       GET GENDER
       ========================= */
    public static String getGender(String email) throws Exception {

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT gender FROM employee WHERE email=?"
        );
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        String gender = null;
        if (rs.next()) {
            gender = rs.getString("gender");
        }

        con.close();
        return gender;
    }
}
