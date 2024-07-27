/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DiscountDAO;
import dal.FoodDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Discount;

import java.text.ParseException;
import java.util.ArrayList;
import model.Food;

/**
 *
 * @author admin
 */
public class DiscountServlet extends HttpServlet {

    private DiscountDAO discountDAO;
    DiscountDAO dd = new DiscountDAO();
    FoodDAO fd = new FoodDAO();

    public DiscountServlet() {
        super();
        discountDAO = new DiscountDAO();
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
            action = "list"; // Nếu không có action được chỉ định, mặc định là hiển thị danh sách giảm giá
        }

        switch (action) {
            case "list":
                listDiscounts(request, response);
                break;
            case "showAddForm":
                showAddForm(request, response);
                break;
            case "showUpdateForm":
                showUpdateForm(request, response);
                break;
            case "delete":
                deleteDiscount(request, response);
                break;
            default:
                listDiscounts(request, response);
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
            action = "list"; // Nếu không có action được chỉ định, mặc định là hiển thị danh sách giảm giá
        }

        switch (action) {
            case "add":
                addDiscount(request, response);
                break;
            case "update":
                updateDiscount(request, response);
                break;
            default:
                listDiscounts(request, response);
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

    private void listDiscounts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Discount> discounts = discountDAO.getAllDiscounts();
        pagingForDiscount(request, response, 6, discounts);
        request.setAttribute("discounts", discounts);
        request.getRequestDispatcher("shop/manageDiscount.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("shop/manageDiscount.jsp").forward(request, response);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Discount discount = discountDAO.getDiscountById(id);
        request.setAttribute("discount", discount);
        request.getRequestDispatcher("shop/manageDiscount.jsp").forward(request, response);
    }

    private void addDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String errorFoodId = "";
        String errorStartDate = "";
        String errorEndDate = "";
        String errorDate = "";
//        String errorFood = "";

        String foodId = request.getParameter("foodId");
//        String description = request.getParameter("description");
        String discountRate = request.getParameter("discountRate");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        // Validate input data
        if (foodId == null || foodId.trim().isEmpty()) {
            errorFoodId = "Tên món ăn được giảm giá không được để trống";
            request.setAttribute("errorFoodId", errorFoodId);
        }

        try {
//            if (foodId == null || foodId.trim().isEmpty()) {
//            errorFoodId = "Tên món ăn được giảm giá không được để trống";
//            request.setAttribute("errorFoodId", errorFoodId);
//            }
//            
            int food = Integer.parseInt(foodId);
            if (!dd.checkFoodId(food)) {
                errorFoodId = "Mã món ăn đã có giảm giá";
                request.setAttribute("errorFoodId", errorFoodId);

            } else if (fd.checkFoodId(food)) {
                errorFoodId = "Mã món ăn không tồn tại";
                request.setAttribute("errorFoodId", errorFoodId);
            }
        } catch (NumberFormatException e) {
            errorFoodId = "Mã món ăn không hợp lệ";
            request.setAttribute("errorFoodId", errorFoodId);
        }

        int percentage = 0;
        percentage = Integer.parseInt(discountRate);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            if (startDateStr == null || startDateStr.trim().isEmpty()) {
                errorStartDate = "Ngày bắt đầu không được để trống";
                request.setAttribute("errorStartDate", errorStartDate);
            } else {
                startDate = dateFormat.parse(startDateStr);

            }

            if (endDateStr == null || endDateStr.trim().isEmpty()) {
                errorEndDate = "Ngày kết thúc không được để trống";
                request.setAttribute("errorEndDate", errorEndDate);
            } else {
                endDate = dateFormat.parse(endDateStr);

            }

            // Validate start date and end date
            if (startDate != null && endDate != null && startDate.after(endDate)) {
                errorDate = "Ngày bắt đầu không được sau ngày kết thúc";
                request.setAttribute("errorDate", errorDate);
            }
        } catch (ParseException e) {
            errorDate = "Định dạng ngày không hợp lệ";
            request.setAttribute("errorDate", errorDate);
        }

        if (!errorFoodId.isEmpty() || !errorStartDate.isEmpty() || !errorEndDate.isEmpty() || !errorDate.isEmpty()) {
            request.getRequestDispatcher("shop/manageDiscount.jsp").forward(request, response);
        } else {
            int fid = Integer.parseInt(foodId);
            java.sql.Date sqlStartDate = new java.sql.Date(startDate.getTime());
            java.sql.Date sqlEndDate = new java.sql.Date(endDate.getTime());
            Discount discount = new Discount(fid, percentage, sqlStartDate, sqlEndDate);
            discountDAO.addDiscount(discount);
            ArrayList<Food> fList = fd.getAllFoodCustomer();
            HttpSession session = request.getSession();
            session.setAttribute("fList", fList);
            listDiscounts(request, response);

        }
    }

    private void updateDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String errorFoodIdUpdate = "";
        String errorStartDateUpdate = "";
        String errorEndDateUpdate = "";
        String errorDateUpdate = "";

        String discountId = request.getParameter("discountId");
        String foodId = request.getParameter("foodIdUpdate");
//        String description = request.getParameter("description");
        String discountRate = request.getParameter("discountRateUpdate");
        String startDateStr = request.getParameter("startDateUpdate");
        String endDateStr = request.getParameter("endDateUpdate");

        // Validate input data
        if (foodId == null || foodId.trim().isEmpty()) {
            errorFoodIdUpdate = "Tên món ăn được giảm giá không được để trống";
            request.setAttribute("errorFoodId", errorFoodIdUpdate);
        }

        int percentage = 0;
        percentage = Integer.parseInt(discountRate);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            if (startDateStr == null || startDateStr.trim().isEmpty()) {
                errorStartDateUpdate = "Ngày bắt đầu không được để trống";
                request.setAttribute("errorStartDate", errorStartDateUpdate);
            } else {
                startDate = dateFormat.parse(startDateStr);

            }

            if (endDateStr == null || endDateStr.trim().isEmpty()) {
                errorEndDateUpdate = "Ngày kết thúc không được để trống";
                request.setAttribute("errorEndDateUpdate", errorEndDateUpdate);
            } else {
                endDate = dateFormat.parse(endDateStr);

            }

            // Validate start date and end date
            if (startDate != null && endDate != null && startDate.after(endDate)) {
                errorDateUpdate = "Ngày bắt đầu không được sau ngày kết thúc";
                request.setAttribute("errorDateUpdate", errorDateUpdate);
            }
        } catch (ParseException e) {
            errorDateUpdate = "Định dạng ngày không hợp lệ";
            request.setAttribute("errorDate", errorDateUpdate);
        }

        if (!errorFoodIdUpdate.isEmpty() || !errorStartDateUpdate.isEmpty() || !errorEndDateUpdate.isEmpty() || !errorDateUpdate.isEmpty()) {
            request.setAttribute("discountId", discountId);
            request.getRequestDispatcher("shop/manageDiscount.jsp").forward(request, response);
        } else {
            int fid = Integer.parseInt(foodId);
            java.sql.Date sqlStartDate = new java.sql.Date(startDate.getTime());
            java.sql.Date sqlEndDate = new java.sql.Date(endDate.getTime());
            Discount discount = new Discount(fid, percentage, sqlStartDate, sqlEndDate);
            discountDAO.updateDiscount(discount);
            ArrayList<Food> fList = fd.getAllFoodCustomer();
            HttpSession session = request.getSession();
            session.setAttribute("fList", fList);
            listDiscounts(request, response);
        }
    }

    private void deleteDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("discountId"));
        discountDAO.deleteDiscount(id);
        ArrayList<Food> fList = fd.getAllFoodCustomer();
        HttpSession session = request.getSession();
        session.setAttribute("fList", fList);
        listDiscounts(request, response);
    }

    private void pagingForDiscount(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Discount> listDiscount) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Discount> discountOnCurrentPage = new ArrayList<>(listDiscount.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listDiscount.size())));

        int totalPages = (int) Math.ceil((double) listDiscount.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("discountOnCurrentPage", discountOnCurrentPage);
    }

}
