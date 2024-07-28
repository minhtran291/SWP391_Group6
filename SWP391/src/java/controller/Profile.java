/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
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
import java.nio.file.Paths;
import model.User;

/**
 *
 * @author Dell
 */
@MultipartConfig
public class Profile extends HttpServlet {

    UserDAO ud = new UserDAO();
    private static final String UPLOAD_DIRECTORY = "img"; // Thay đổi đường dẫn theo yêu cầu

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
            out.println("<title>Servlet Profile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Profile at " + request.getContextPath() + "</h1>");
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
        getProfile(request, response);
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
        updateUserProfile(request, response);

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

    private void getProfile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
//        session.setAttribute("acc", u);
        if (u.getRoleid() == 1) {
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
        } else if (u.getRoleid() == 3) {
            request.getRequestDispatcher("/shipper/profileShipper.jsp").forward(request, response);
        } else if(u.getRoleid() == 4){
            request.getRequestDispatcher("/admin/profileAdmin.jsp").forward(request, response);
        }

    }

    private void updateUserProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String errorEmailUpdate = "";
        String errorPhoneUpdate = "";

        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String empemail = request.getParameter("email");
        String empphone = request.getParameter("phone");
        String id = request.getParameter("id");
        String avt = null;

        User currentUser = (User) session.getAttribute("acc"); // SỬA Ở ĐÂY

        // Kiểm tra lỗi email và số điện thoại
        if (ud.checkEmailUpdate(empemail, id)) {
            errorEmailUpdate = "Email đã tồn tại";
            request.setAttribute("errorEmailUpdate", errorEmailUpdate);
        }
        if (ud.checkPhoneUpdate(empphone, id)) {
            errorPhoneUpdate = "Số điện thoại đã tồn tại";
            request.setAttribute("errorPhoneUpdate", errorPhoneUpdate);
        }

        // Nếu có lỗi, quay lại trang cập nhật
        if (!errorEmailUpdate.isEmpty() || !errorPhoneUpdate.isEmpty()) {
            request.setAttribute("id", id);
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            return;
        }

        // Xử lý ảnh đại diện
        Part filePart = request.getPart("avatar"); // Đảm bảo form có enctype="multipart/form-data"
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            avt = UPLOAD_DIRECTORY + "/" + fileName;
        } else {
            // Sử dụng avatar hiện tại nếu không có ảnh mới được tải lên
            avt = currentUser.getAvatar(); // SỬA Ở ĐÂY
        }

        try {
            int empid = Integer.parseInt(id);
            int genderimp = Integer.parseInt(gender);
            ud.updateUserProfile(genderimp, empemail, empphone, avt, empid); // Cập nhật thông tin người dùng
            User u = (User) ud.getUser(username);
            session.setAttribute("acc", u);
            if (u.getRoleid() == 1) {
                request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
            } else if (u.getRoleid() == 2) {
                request.getRequestDispatcher("/shop/profileShop.jsp").forward(request, response);
            } else if (u.getRoleid() == 3) {
                request.getRequestDispatcher("/shipper/profileShipper.jsp").forward(request, response);
            } else if (u.getRoleid() == 4) {
                request.getRequestDispatcher("/admin/profileAdmin.jsp").forward(request, response);
            } 
//        request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
            // Redirect để cập nhật trang cá nhân
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình cập nhật.");
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
        }
    }
}
