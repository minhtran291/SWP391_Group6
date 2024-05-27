/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.FoodDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Food;

/**
 *
 * @author Dell
 */
public class ActionCustomer extends HttpServlet {

    CategoryDAO cd = new CategoryDAO();
    FoodDAO fd = new FoodDAO();

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
            out.println("<title>Servlet ActionCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActionCustomer at " + request.getContextPath() + "</h1>");
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
            case "getListFood":
                getAllFood(request, response, 8);
                break;
            case "getFoodBySearch":
                getFoodBySearch(request, response, 5);
                break;
            case "getFoodByCategory":
                getFoodByCategory(request, response, 5);
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
        processRequest(request, response);
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

    private void getAllFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();

        ArrayList<Food> fList = (ArrayList)session.getAttribute("fList") == null ? fd.getAllFood() : (ArrayList)session.getAttribute("fList");
        ArrayList<Category> cList = (ArrayList)session.getAttribute("cList") == null ? cd.getAllCategory() : (ArrayList)session.getAttribute("cList");
        // ko phan phai lan dau tien chay ko can get all nua chi goi du lieu ve
        session.setAttribute("fList", fList);
        session.setAttribute("cList", cList);
        /* bat buoc phai set cac thuoc tinh ben tren theo dung thu tu va dat cai
            phan trang o cuoi vi khi vao phan trang se chuyen sang trang luon
         */
        pagingForFood(request, response, numberPerPage, fList);
        // lan dau tien chay trang web thi su dung get all de lay du lieu
    }

    private void pagingForFood(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Food> listFood) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        // lay trang hien tai

        // ko the ep kieu thanh arrayList tu list su dung phuong thuc subList
        // 
        List<Food> foodOnCurrentPage = new ArrayList<>(listFood.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listFood.size())));
        // lay san pham tren trang hien tai

        int totalPages = (int) Math.ceil((double) listFood.size() / numberPerPage);
        /* Math.ceil ko ap dung cho cho kieu int phai ep kieu sang double
         Math.ceil lam tron nen xong lai ep kieu ve int, trang ko le
        
         san pham dau tien tren trang hien tai = (trang hien tai - 1) * so san
        pham tren 1 trang
        san pham cuoi cung tren trang hien tai = (trang hien tai * so luong san
        pham tren 1 trang) - 1

        vi du trang 2, san pham dau tien trang 2 = (2 - 1) * 6 = 6
        doi tuong o chi muc thu 6 trong arrayList vi arrayList chay tu 0
        san pham cuoi trang 2 = 2 * 6 - 1 = 11
        doi tuong o chi muc thu 11 
        san pham cuoi o trang cuoi cung arrayList.size() - 1
         */
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("foodOnCurrentPage", foodOnCurrentPage);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    private void getFoodBySearch(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String search = request.getParameter("search");
        ArrayList<Food> listSearch = fd.getFoodBySearch(search);
        request.setAttribute("listSearch", listSearch);
        request.setAttribute("search", search);
        pagingForFood(request, response, numberPerPage, listSearch);
    }

    private void getFoodByCategory(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String categoryId = request.getParameter("cid");
        ArrayList<Food> listFoodByCategory = fd.getFoodByCategory(categoryId);
        request.setAttribute("listFoodByCategory", listFoodByCategory);
        request.setAttribute("cid", categoryId);
        pagingForFood(request, response, numberPerPage, listFoodByCategory);
    }

}
