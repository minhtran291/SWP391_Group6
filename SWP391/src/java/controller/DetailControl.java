/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CommentDAO;
import dal.FavoriteDAO;
import dal.FoodDAO;
import dal.ImageDAO;
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
import model.FoodDetail;
import model.Image;
import model.User;
import model.Comment;
import model.Favorite;
import model.Food;

/**
 *
 * @author anhdo
 */
public class DetailControl extends HttpServlet {
    FavoriteDAO fdao = new FavoriteDAO();

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
           
            request.getRequestDispatcher("myfavorite.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }
     protected void doGet_Detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        String foodId = request.getParameter("foodId");
        int fId = Integer.parseInt(foodId);
        
        FoodDAO dao = new FoodDAO();
        ImageDAO imgdao = new ImageDAO();
        CommentDAO cdao = new CommentDAO();
        FoodDetail fd = dao.getFoodDetailByID(foodId);
        Image img1 = imgdao.getImgbyFoodId1(foodId);
        Image img2 = imgdao.getImgbyFoodId2(foodId);
        Image img3 = imgdao.getImgbyFoodId3(foodId);
        List<Food> sameF = dao.getsameFood(fId);
        List<Comment> listcmt = cdao.getCommentbyFoodID(foodId);
        
        request.setAttribute("img1", img1);
        request.setAttribute("img2", img2);
        request.setAttribute("img3", img3);
        request.setAttribute("sameF", sameF);
        request.setAttribute("listcmt", listcmt);
        request.setAttribute("detail", fd);
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
            case "save":
                doPost_Save(request,response);
                break;
            
        }
        
        }
     protected void doPost_Send(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String content = request.getParameter("content");
        String foodId =request.getParameter("foodId");
//          int rating = Integer.parseInt(request.getParameter("rating"));
        HttpSession session = request.getSession();
        User a = (User) session.getAttribute("acc");
        String name = a.getUsername();
        CommentDAO cdao = new CommentDAO();
 
        cdao.addComment(foodId, name, content);
//        cdao.addRating(foodId, name, rating);
        response.sendRedirect("detail?action=detail&foodId="+request.getParameter("foodId"));
     }
 protected void doPost_Save(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     String errorphone = "";
        String foodid = request.getParameter("foodId");
        String foodname = request.getParameter("foodname");
        String image = request.getParameter("image");
         HttpSession session = request.getSession();
          if (!fdao.checkFoodName(foodname)) {
            errorphone = "Số điện thoại đã tồn tại";
            request.setAttribute("errorphone", errorphone);
        }
          if (!errorphone.isEmpty() ) {
              fdao.deleteFoodFavoritebyName(foodname);
              request.setAttribute("errorphone", errorphone);
             response.sendRedirect("detail?action=detail&foodId="+request.getParameter("foodId"));
          }else{
         User u = (User)session.getAttribute("acc");
        String name = u.getUsername();
        fdao.addtoFavoite(foodid, name, foodname, image);
          response.sendRedirect("detail?action=detail&foodId="+request.getParameter("foodId"));
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
