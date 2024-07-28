/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dal.CommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import model.User;

/**
 *
 * @author Dell
 */
public class RatingStar extends HttpServlet {

    CommentDAO cd = new CommentDAO();

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
            out.println("<title>Servlet RatingStar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RatingStar at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String foodId = request.getParameter("foodId");
        int fId = Integer.parseInt(foodId);
        User u = (User) session.getAttribute("acc");
        int rating = cd.getRatingbyFoodID(fId, u.getUsername());

        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("rating", rating);

        response.setContentType("application/json");
        response.getWriter().write(responseJson.toString());
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
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        // Phân tích dữ liệu JSON
        String requestBody = sb.toString();
        JsonObject jsonObject = JsonParser.parseString(requestBody).getAsJsonObject();
        int foodId = jsonObject.get("foodId").getAsInt();
        String username = jsonObject.get("username").getAsString();
        int rating = jsonObject.get("rating").getAsInt();

        // Lưu đánh giá
//        RatingDAO ratingDAO = new RatingDAO();
        cd.addRating(foodId, username, rating);

        // Gửi phản hồi
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("message", "Đánh giá đã được lưu thành công");

        response.setContentType("application/json");
        response.getWriter().write(responseJson.toString());
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
