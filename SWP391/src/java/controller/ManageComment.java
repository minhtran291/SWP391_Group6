/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Comment;
import model.User;

/**
 *
 * @author anhdo
 */
public class ManageComment extends HttpServlet {
   CommentDAO cmtd = new CommentDAO();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ManageComment</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageComment at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {           
            case "viewcomment":
                ViewComment(request, response, 5);
                request.getRequestDispatcher("managecomment.jsp").forward(request, response);
                break;
            case "deleteCmt":
                deleteCmt(request, response, 5);
                break;          
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String action = request.getParameter("action");
        switch (action) {          
            case "updateCmt":
                updateCmt(request, response, 5);
                break;
        }
    }
     private void updateCmt(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        
        String comment = request.getParameter("comment");
        String cmtId = request.getParameter("cmtId");
        User u = (User)session.getAttribute("acc");
        String name = u.getUsername();
         try {
                int cmid = Integer.parseInt(cmtId);
                cmtd.UpdateCmt(comment, cmid);
                ArrayList<Comment> ulist = cmtd.getCommentByUserName(name);
                session.setAttribute("ulist", ulist);
                ViewComment(request, response, numberPerPage);
                request.getRequestDispatcher("managecomment.jsp").forward(request, response);
            } catch (Exception e) {
            
            }
    }
     private void deleteCmt(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String cmtId = request.getParameter("deleteId");
        User u = (User)session.getAttribute("acc");
        String name = u.getUsername();
        try {
            int cmid = Integer.parseInt(cmtId);
            cmtd.deleteCmt(cmid);
            ArrayList<Comment> ulist = cmtd.getCommentByUserName(name);
            session.setAttribute("ulist", ulist);
            ViewComment(request, response, numberPerPage);
            request.getRequestDispatcher("managecomment.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }
    

    private void pagingForEmp(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Comment> listcmt) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        List<Comment> cmtOnCurrentPage = new ArrayList<>(listcmt.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listcmt.size())));
        int totalPages = (int) Math.ceil((double) listcmt.size() / numberPerPage);
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("cmtOnCurrentPage", cmtOnCurrentPage);
    }
private void ViewComment(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("acc");
        String name = u.getUsername();
        String foodid =request.getParameter("foodId");
        ArrayList<Comment> listcmt = (ArrayList) session.getAttribute("listcmt") == null ? cmtd.getCommentByUserName(name) : (ArrayList) session.getAttribute("listcmt");

        pagingForEmp(request, response, numberPerPage, listcmt);
    }
  
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
