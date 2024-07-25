/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DistrictDAO;
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
import dal.WardDAO;
import jakarta.servlet.http.HttpSession;
import model.District;
import model.Ward;

/**
 *
 * @author anhdo
 */
public class ActionAdmin extends HttpServlet {

    UserDAO ud = new UserDAO();
    DistrictDAO dd = new DistrictDAO();
    WardDAO wd = new WardDAO();

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
            case "districtManagement":
                getAllDistrict(request, response, 5);
                break;
            case "wardManagement":
                getAllWard(request, response, 5);
                break;
            case "deleteDistrict":
                deleteDistrict(request, response, 5);
                break;
            case "unDeleteDistrict":
                unDeleteDistrict(request, response, 5);
                break;
            case "deleteWard":
                deleteWard(request, response, 5);
                break;
            case "unDeleteWard":
                unDeleteWard(request, response, 5);
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
            case "addDistrict":
                addDistrict(request, response, 5);
                break;
            case "updateDistrict":
                updateDistrict(request, response, 5);
                break;
            case "addWard":
                addWard(request, response, 5);
                break;
            case "updateWard":
                updateWard(request, response, 5);
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

    private void getAllDistrict(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<District> listDistrict = dd.getAllDistrictManager();
        session.setAttribute("listDistrict", listDistrict);
        pagingForDistrict(request, response, numberPerPage, listDistrict);
        request.getRequestDispatcher("admin/manageDistrict.jsp").forward(request, response);
    }

    private void pagingForDistrict(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<District> listDistrict) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        List<District> districtOnCurrentPage = new ArrayList<>(listDistrict.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listDistrict.size())));
        int totalPages = (int) Math.ceil((double) listDistrict.size() / numberPerPage);
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("districtOnCurrentPage", districtOnCurrentPage);
    }

    private void getAllWard(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<District> listDistrict = dd.getAllDistrictCustomer();
        ArrayList<Ward> listWard = wd.getAllWard();
        session.setAttribute("listDistrict", listDistrict);
        session.setAttribute("listWard", listWard);
        pagingForWard(request, response, numberPerPage, listWard);
        request.getRequestDispatcher("admin/manageWard.jsp").forward(request, response);
    }

    private void pagingForWard(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Ward> listWard) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        List<Ward> wardOnCurrentPage = new ArrayList<>(listWard.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listWard.size())));
        int totalPages = (int) Math.ceil((double) listWard.size() / numberPerPage);
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("wardOnCurrentPage", wardOnCurrentPage);
    }

    private void addDistrict(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String errorDistrictName = "";
        String districtName = request.getParameter("districtName");
        if (!dd.checkDuplicateDistrict(districtName)) {
            errorDistrictName = "Tên quận huyện đã có rồi";
            request.setAttribute("errorDistrictName", errorDistrictName);
        }
        if (!errorDistrictName.isEmpty()) {
            request.getRequestDispatcher("admin/manageDistrict.jsp").forward(request, response);
        } else {
            dd.addDistrict(districtName);
            getAllDistrict(request, response, numberPerPage);
        }
    }

    private void updateDistrict(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String errorDistrictNameUpdate = "";
        String districtIdS = request.getParameter("districtId");
        int districtId = Integer.parseInt(districtIdS);
        String districtNameUpdate = request.getParameter("districtNameUpdate");
        if (!dd.checkDuplicateDistrictUpdate(districtNameUpdate, districtId)) {
            errorDistrictNameUpdate = "Tên quận huyện đã có rồi";
            request.setAttribute("errorDistrictNameUpdate", errorDistrictNameUpdate);
        }
        if (!errorDistrictNameUpdate.isEmpty()) {
            request.setAttribute("districtId", districtId);
            request.getRequestDispatcher("admin/manageDistrict.jsp").forward(request, response);
        } else {
            dd.updateDistrict(districtNameUpdate, districtId);
            getAllDistrict(request, response, numberPerPage);
        }
    }

    private void deleteDistrict(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String districtIdS = request.getParameter("deleteId");
        int districtId = Integer.parseInt(districtIdS);
        dd.deleteDistrict(districtId, 0);
        getAllDistrict(request, response, numberPerPage);
    }

    private void unDeleteDistrict(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String districtIdS = request.getParameter("deleteId");
        int districtId = Integer.parseInt(districtIdS);
        dd.deleteDistrict(districtId, 1);
        getAllDistrict(request, response, numberPerPage);
    }

    private void deleteWard(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String wardIdS = request.getParameter("deleteId");
        int wardId = Integer.parseInt(wardIdS);
        wd.deleteWard(wardId, 0);
        getAllWard(request, response, numberPerPage);
    }

    private void unDeleteWard(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String wardIdS = request.getParameter("deleteId");
        int wardId = Integer.parseInt(wardIdS);
        wd.deleteWard(wardId, 1);
        getAllWard(request, response, numberPerPage);
    }

    private void addWard(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String errorWardName = "";
        String wardName = request.getParameter("wardName");
        String districtIdS = request.getParameter("district");
        if (!wd.checkDuplicateWard(wardName)) {
            errorWardName = "Tên xã phường đã có rồi";
            request.setAttribute("errorWardName", errorWardName);
        }
        if (!errorWardName.isEmpty()) {
            request.getRequestDispatcher("admin/manageWard.jsp").forward(request, response);
        } else {
            int districtId = Integer.parseInt(districtIdS);
            wd.addWard(wardName, districtId);
            getAllWard(request, response, numberPerPage);
        }
    }

    private void updateWard(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String errorWardNameUpdate = "";
        String wardIdS = request.getParameter("wardId");
        String wardName = request.getParameter("wardNameUpdate");
        String districtUpdate = request.getParameter("districtUpdate");
        int districtId = Integer.parseInt(districtUpdate);
        int wardId = Integer.parseInt(wardIdS);
        if (!wd.checkDuplicateWardUpdate(wardName, wardId)) {
            errorWardNameUpdate = "Tên xã phường đã có rồi";
            request.setAttribute("errorWardNameUpdate", errorWardNameUpdate);
        }
        if (!errorWardNameUpdate.isEmpty()) {
            request.setAttribute("wardId", wardId);
            request.getRequestDispatcher("admin/manageWard.jsp").forward(request, response);
        } else {
            wd.updateWard(wardName, wardId, districtId);
            getAllWard(request, response, numberPerPage);
        }
    }
}
