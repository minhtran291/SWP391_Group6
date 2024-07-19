/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.FavoriteDAO;
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
import model.Favorite;
import model.User;

/**
 *
 * @author anhdo
 */
public class ManageFavorite extends HttpServlet {
    FavoriteDAO fdao = new FavoriteDAO();
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
            out.println("<title>Servlet ManageFavorite</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageFavorite at " + request.getContextPath () + "</h1>");
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
            case "viewfavorite":
                ViewFavorite(request, response, 5);
                request.getRequestDispatcher("myfavorite.jsp").forward(request, response);
                break;
            case "deleteFood":
                deleteFood(request, response, 5);
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
        processRequest(request, response);
    }
     private void deleteFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String wishid = request.getParameter("deleteId");
        User u = (User)session.getAttribute("acc");
        String name = u.getUsername();
        try {
            int cmid = Integer.parseInt(wishid);
            fdao.deleteFoodFavorite(cmid);
            ArrayList<Favorite> ulist = fdao.getFoodbyUserName(name);
            session.setAttribute("ulist", ulist);
            ViewFavorite(request, response, numberPerPage);
            request.getRequestDispatcher("myfavorite.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }
    

    private void pagingForEmp(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Favorite> listfood) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        List<Favorite> FavoriteOnCurrentPage = new ArrayList<>(listfood.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listfood.size())));
        int totalPages = (int) Math.ceil((double) listfood.size() / numberPerPage);
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("FavoriteOnCurrentPage", FavoriteOnCurrentPage);
    }
private void ViewFavorite(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("acc");
        String name = u.getUsername();
        String foodid =request.getParameter("foodId");
        ArrayList<Favorite> listfood = (ArrayList) session.getAttribute("listfood") == null ? fdao.getFoodbyUserName(name) : (ArrayList) session.getAttribute("listfood");

        pagingForEmp(request, response, numberPerPage, listfood);
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
