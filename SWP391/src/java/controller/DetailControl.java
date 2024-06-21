/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CommentDAO;
import dal.FoodDAO;
import dal.ImageDAO;
import dal.ReviewDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Food;
import model.Image;
import model.Review;
import model.User;
import model.Comment;

/**
 *
 * @author anhdo
 */
public class DetailControl extends HttpServlet {

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
        String action = request.getParameter("action");
        switch (action) {
            case "detail":
                doGet_Detail(request,response);
                break;
            
        }
    }
     protected void doGet_Detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String foodId = request.getParameter("foodId");

        FoodDAO dao = new FoodDAO();
        ImageDAO imgdao = new ImageDAO();
        CommentDAO cdao = new CommentDAO();
        Food f = dao.getFoodByID(foodId);
        Image img1 = imgdao.getImgbyFoodId1(foodId);
        Image img2 = imgdao.getImgbyFoodId2(foodId);
        Image img3 = imgdao.getImgbyFoodId3(foodId);
        List<Food> sameF = dao.getsameFood(foodId);
        Comment cmt1 = cdao.getCommentbyFoodID(foodId,1);
        Comment cmt2 = cdao.getCommentbyFoodID(foodId,2);
        Comment cmt3 = cdao.getCommentbyFoodID(foodId,3);
        Comment cmt4 = cdao.getCommentbyFoodID(foodId,4);
        Comment cmt5 = cdao.getCommentbyFoodID(foodId,5);
        Comment cmt6 = cdao.getCommentbyFoodID(foodId,6);
        Comment cmt7 = cdao.getCommentbyFoodID(foodId,7);
        Comment cmt8 = cdao.getCommentbyFoodID(foodId,8);
        Comment cmt9 = cdao.getCommentbyFoodID(foodId,9);
        Comment cmt10 = cdao.getCommentbyFoodID(foodId,10);

        
        request.setAttribute("cmt1", cmt1);
        request.setAttribute("cmt2", cmt2);
        request.setAttribute("cmt3", cmt3);
        request.setAttribute("cmt4", cmt4);
        request.setAttribute("cmt5", cmt5);
        request.setAttribute("cmt6", cmt6);
        request.setAttribute("cmt7", cmt7);
        request.setAttribute("cmt8", cmt8);
        request.setAttribute("cmt9", cmt9);
        request.setAttribute("cmt10", cmt10);
        request.setAttribute("img1", img1);
        request.setAttribute("img2", img2);
        request.setAttribute("img3", img3);
        request.setAttribute("sameF", sameF);
        request.setAttribute("detail", f);
        request.getRequestDispatcher("detail.jsp").forward(request, response);
    
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
        String action = request.getParameter("action");
        switch (action) {
            case "send":
                doPost_Send(request,response);
                break;
            
        }
        
        }
     protected void doPost_Send(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String content = request.getParameter("content");
        String foodId =request.getParameter("foodId");
        
        HttpSession session = request.getSession();
        User a = (User) session.getAttribute("acc");
        String name = a.getUsername();
        CommentDAO cdao = new CommentDAO();
       // ArrayList<model.Comment> listcmt = cdao.getAllCmt();      
        
         cdao.addComment(foodId, name, content);
        //request.setAttribute("listcmt", listcmt);
        response.sendRedirect("detail?action=detail&foodId="+request.getParameter("foodId"));
       // request.getRequestDispatcher("detail?action=detail&foodId="+request.getParameter("foodId")).forward(request, response);
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
