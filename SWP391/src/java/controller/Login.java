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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Dell
 */
public class Login extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
//        processRequest(request, response);
        response.sendRedirect("login.jsp");
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        Cookie cuser = new Cookie("cuser", username);
        Cookie cpass = new Cookie("cpass", password);
        Cookie cremem = new Cookie("cremem", remember);

        if (remember != null) {
            cuser.setMaxAge(60 * 60 * 24 * 7);
            cpass.setMaxAge(60 * 60 * 24 * 7);
            cremem.setMaxAge(60 * 60 * 24 * 7);
        } else {
            cuser.setMaxAge(0);
            cpass.setMaxAge(0);
            cremem.setMaxAge(0);
        }
        response.addCookie(cuser);
        response.addCookie(cpass);
        response.addCookie(cremem);

        UserDAO dao = new UserDAO();
        User acc = dao.login(username, password);
        if (acc == null) {
            request.setAttribute("mess", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("acc", acc);
            if (acc.getRoleid() == 1) {
                response.sendRedirect("actioncustomer?action=getListFood");
            } else if (acc.getRoleid() == 2) {
                response.sendRedirect("actionshop?action=dashBoard");
            } else if (acc.getRoleid() == 3) {
                response.sendRedirect("actionshipper?action=homeShipper");
            
            } else if (acc.getRoleid() == 4) {
                response.sendRedirect("actionadmin?action=manageAcc");
            }
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
