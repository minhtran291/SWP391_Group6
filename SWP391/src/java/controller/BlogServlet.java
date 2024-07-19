/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import model.Blog;

/**
 *
 * @author admin
 */
public class BlogServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BlogDAO blogDAO;

    public BlogServlet() {
        this.blogDAO = new BlogDAO();
    }

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
            out.println("<title>Servlet BlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Mặc định là hiển thị danh sách blog
        }

        switch (action) {
            case "list":
                listAllBlogs(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBlog(request, response);
                break;
            default:
                listAllBlogs(request, response);
                break;
        }
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

        if (action == null) {
            action = "list"; // Mặc định là hiển thị danh sách blog
        }

        switch (action) {
            case "add":
                addBlog(request, response);
                break;
            case "update":
                updateBlog(request, response);
                break;
            default:
                listAllBlogs(request, response);
                break;
        }
    }

    private void listAllBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Blog> blogs = blogDAO.listAllBlogs();
        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("blog.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("shop/manageBlog.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        Blog blog = blogDAO.getBlogById(blogId);
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("manageBlog.jsp").forward(request, response);
    }

    private void addBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String author = request.getParameter("author");
        String dateCreated = request.getParameter("dateCreated");
        Date date = new Date(); // Lấy ngày hiện tại
        Blog newBlog = new Blog(title, content, author, date);// ID sẽ được sinh tự động trong DAO
        blogDAO.addBlog(newBlog);
        response.sendRedirect("blog?action=edit");
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        String title = request.getParameter("titleUpdate");
        String content = request.getParameter("contentUpdate");
        String author = request.getParameter("authorUpdate");
        Date dateCreated = new Date(); // Lấy ngày hiện tại
        Blog updatedBlog = new Blog(blogId, title, content, author, dateCreated);
        blogDAO.updateBlog(updatedBlog);
        response.sendRedirect("blog?action=edit");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        blogDAO.deleteBlog(blogId);
        response.sendRedirect("blog?action=edit");
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
