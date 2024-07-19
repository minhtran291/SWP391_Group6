/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.User;
import dal.UserDAO;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author anhdo
 */
public class ActionAdmin extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ActionAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActionAdmin at " + request.getContextPath() + "</h1>");
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
        switch (action) {
            case "manageAcc":
                getAccount(request, response, 5);
                request.getRequestDispatcher("admin/manageAccount.jsp").forward(request, response);
                break;
            case "deleteAcc":
                deleteAccount(request, response, 5);
                break;
            case "searchByRole":
                searchByRole(request, response, 5);
                request.getRequestDispatcher("admin/manageAccount.jsp").forward(request, response);
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
        switch (action) {
            case "addAccount":
                addAccount(request, response, 5);
                break;
            case "updateAccount":
                updateAccount(request, response, 5);
                break;
        }
    }

    private void searchByRole(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
         String roleid = request.getParameter("roleid");
        ArrayList<User> listUserbyRole = new ArrayList<>();
        if (roleid.equalsIgnoreCase("all")) {
            listUserbyRole = ud.getAccount();
        } else {
            listUserbyRole = ud.getUserByRole(roleid);
        }
        request.setAttribute("listUserbyRole", listUserbyRole);
        request.setAttribute("roleid", roleid);
        pagingForEmp(request, response, numberPerPage, listUserbyRole);
    }

    private void addAccount(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String errorName = "";
        String errorEmail = "";
        String errorphone = "";

        String name = request.getParameter("username");
        String pass = request.getParameter("password");
        String gender = request.getParameter("gender");
        String empemail = request.getParameter("email");
        String empphone = request.getParameter("phone");
        String roleid = request.getParameter("roleid");

        if (!ud.checkEmpName(name)) {
            errorName = "Tên đăng nhập đã tồn tại";
            request.setAttribute("errorName", errorName);
        }
        if (!ud.checkEmail(empemail)) {
            errorEmail = "Email đã tồn tại";
            request.setAttribute("errorEmail", errorEmail);
        }
        if (!ud.checkPhone(empphone)) {
            errorphone = "Số điện thoại đã tồn tại";
            request.setAttribute("errorphone", errorphone);
        }

        if (!errorName.isEmpty() || !errorEmail.isEmpty() || !errorphone.isEmpty()) {
            request.getRequestDispatcher("admin/manageAccount.jsp").forward(request, response);
        } else {
            try {
                int roleidacc = Integer.parseInt(roleid);
                int genderimp = Integer.parseInt(gender);
                ud.addAcc(name, pass, genderimp, empemail, empphone, roleidacc);
                ArrayList<User> listacc = ud.getAccount();
                session.setAttribute("listacc", listacc);
                getAccount(request, response, numberPerPage);
                request.getRequestDispatcher("admin/manageAccount.jsp").forward(request, response);
            } catch (Exception e) {
            }
        }
    }

    private void updateAccount(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String errorNameUpdate = "";
        String errorEmailUpdate = "";
        String errorphoneUpdate = "";

        String name = request.getParameter("username");
        String pass = request.getParameter("password");
        String empemail = request.getParameter("email");
        String empphone = request.getParameter("phone");
        String id = request.getParameter("id");
        String roleid = request.getParameter("roleid");

        if (!ud.checkEmpNameUpdate(name, id)) {
            errorNameUpdate = "Tên đăng nhập đã tồn tại";
            request.setAttribute("errorNameUpdate", errorNameUpdate);
        }
        if (!ud.checkEmpEmailUpdate(empemail, id)) {
            errorEmailUpdate = "Email đã tồn tại";
            request.setAttribute("errorEmailUpdate", errorEmailUpdate);
        }
        if (!ud.checkEmpPhoneUpdate(empphone, id)) {
            errorphoneUpdate = "Số điện thoại đã tồn tại";
            request.setAttribute("errorphoneUpdate", errorphoneUpdate);
        }

        if (!errorNameUpdate.isEmpty() || !errorEmailUpdate.isEmpty() || !errorphoneUpdate.isEmpty()) {
            request.setAttribute("id", id);
            request.getRequestDispatcher("admin/manageAccount.jsp").forward(request, response);
        } else {

            try {
                int roleidud = Integer.parseInt(roleid);
                int empid = Integer.parseInt(id);
                ud.UpdateAcc(name, pass, roleidud, empemail, empphone, empid);

                ArrayList<User> listacc = ud.getAccount();
                session.setAttribute("listacc", listacc);
                getAccount(request, response, numberPerPage);
                request.getRequestDispatcher("admin/manageAccount.jsp").forward(request, response);
            } catch (Exception e) {
            }
        }
    }

    private void deleteAccount(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("deleteId");
        try {
            int idemp = Integer.parseInt(id);
            ud.deleteEmp(idemp);
            ArrayList<User> listacc = ud.getAccount();
            session.setAttribute("listacc", listacc);
            getAccount(request, response, numberPerPage);
            request.getRequestDispatcher("admin/manageAccount.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }

    private void getAccount(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<User> listacc = (ArrayList) session.getAttribute("listacc") == null ? ud.getAccount() : (ArrayList) session.getAttribute("listacc");
        ArrayList<User> rlist = (ArrayList) session.getAttribute("rlist") == null ? ud.getAllRole() : (ArrayList) session.getAttribute("rlist");
        session.setAttribute("listacc", listacc);
        session.setAttribute("rlist", rlist);
        /* bat buoc phai set cac thuoc tinh ben tren theo dung thu tu va dat cai
            phan trang o cuoi vi khi vao phan trang se chuyen sang trang luon
         */
        pagingForEmp(request, response, numberPerPage, listacc);

    }

    private void pagingForEmp(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<User> listAcc) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        List<User> empOnCurrentPage = new ArrayList<>(listAcc.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listAcc.size())));
        int totalPages = (int) Math.ceil((double) listAcc.size() / numberPerPage);
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("empOnCurrentPage", empOnCurrentPage);
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
