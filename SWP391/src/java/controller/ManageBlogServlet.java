/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Blog;
import model.Discount;

/**
 *
 * @author admin
 */
@MultipartConfig
public class ManageBlogServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BlogDAO blogDAO;

    public ManageBlogServlet() {
        this.blogDAO = new BlogDAO();
    }
    private static final String UPLOAD_DIRECTORY = "img";

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
            out.println("<title>Servlet ManageBlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageBlogServlet at " + request.getContextPath() + "</h1>");
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
        ArrayList<Blog> manageblogs = blogDAO.listAllBlogs();
        pagingForBlog(request, response, 6, manageblogs);  // Sử dụng hàm phân trang cho Blog
        request.setAttribute("blogs", manageblogs);
        request.getRequestDispatcher("shop/manageBlog.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("shop/manageBlog.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.getBlogById(blogId);
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("shop/manageBlog.jsp").forward(request, response);
    }

    private void addBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String author = request.getParameter("author");
        Date date = new Date(); // Lấy ngày hiện tại

        Part filePart = request.getPart("blogImage");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadDir = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        Path filePath = uploadPath.resolve(fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
        }

        String imagePath = UPLOAD_DIRECTORY + File.separator + fileName;

        Blog newBlog = new Blog(title, content, author, date, imagePath); // ID sẽ được sinh tự động trong DAO
        blogDAO.addBlog(newBlog);
        response.sendRedirect("manageblog");
//        request.getRequestDispatcher("shop/manageBlog.jsp").forward(request, response);
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int blogId = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("titleUpdate");
        String content = request.getParameter("contentUpdate");
        String author = request.getParameter("authorUpdate");
        Date dateCreated = new Date(); // Lấy ngày hiện tại

        Part filePart = request.getPart("imageUpdate");
        String imagePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Xác định đường dẫn lưu trữ tệp
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            Path uploadDir = Paths.get(uploadPath);
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
            }

            // Tạo tên tệp duy nhất
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            Path filePath = uploadDir.resolve(fileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            // Lưu đường dẫn ảnh vào biến
            imagePath = UPLOAD_DIRECTORY + File.separator + fileName;
        } else {
            // Nếu không có tệp mới, giữ lại hình ảnh cũ
            Blog existingBlog = blogDAO.getBlogById(blogId);
            imagePath = existingBlog.getImagePath();
        }

        // Cập nhật blog
        Blog updatedBlog = new Blog(blogId, title, content, author, dateCreated, imagePath);
        blogDAO.updateBlog(updatedBlog);

        response.sendRedirect("manageblog");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("id"));
        blogDAO.deleteBlog(blogId);
        response.sendRedirect("manageblog");

    }

    private void pagingForBlog(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Blog> listBlog) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Blog> blogOnCurrentPage = new ArrayList<>(listBlog.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage, listBlog.size())));

        int totalPages = (int) Math.ceil((double) listBlog.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("blogOnCurrentPage", blogOnCurrentPage);
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
