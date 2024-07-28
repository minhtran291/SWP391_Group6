/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author admin
 */
public class Register extends HttpServlet {
   
    UserDAO ud = new UserDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        response.sendRedirect("register.jsp");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        String account = request.getParameter("account");
        String genders = request.getParameter("gender");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String errorAccount = "";
        String errorPhone = "";
        String errorEmail = "";
        if (!ud.duplicateAccount(account)) {
            errorAccount = "Tên đăng nhập đã tồn tại";
            request.setAttribute("errorAccount", errorAccount);
        }
        if (!ud.duplicateEmail(email)) {
            errorEmail = "Email đã tồn tại";
            request.setAttribute("errorEmail", errorEmail);
        }
        if (!ud.duplicatePhone(phone)) {
            errorPhone = "Số điện thoại đã tồn tại";
            request.setAttribute("errorPhone", errorPhone);
        }
        if(!errorAccount.isEmpty() || !errorEmail.isEmpty() || !errorPhone.isEmpty()){
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }else{
            int gender = Integer.parseInt(genders);
            User u =new User(account, password, gender, email, phone);
            ud.addUser(u);
            session.setAttribute("acc", u);
//            request.getRequestDispatcher("actioncustomer?action=getListFood").forward(request, response);
//            response.sendRedirect("home");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>


}
