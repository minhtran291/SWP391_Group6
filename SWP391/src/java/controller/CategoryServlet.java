/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
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

/**
 *
 * @author admin
 */
public class CategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "updateStatus":
                updateCategoryStatus(request, response);
                break;
            case "list":
            default:
                listCategory(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "manageCategory";
        }

        switch (action) {
            case "insert":
                insertCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            default:
                listCategory(request, response);
                break;
        }
    }

    private void listCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> listCategory = categoryDAO.getCategoryManagerment();
        pagingListCategory(request, response, 5, listCategory);
        request.setAttribute("categoryList", listCategory);
        request.getRequestDispatcher("shop/manageCategory.jsp").forward(request, response);
    }

    private void pagingListCategory(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, List<Category> listCategory) throws ServletException, IOException {
//        if (listOrderConfirm == null) {
//            return;
//        }
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Category> categoryOnCurrentPage = new ArrayList<>(listCategory.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listCategory.size())));

        int totalPages = (int) Math.ceil((double) listCategory.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("categoryOnCurrentPage", categoryOnCurrentPage);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("shop/addCategory.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category existingCategory = categoryDAO.getCategoryById(id);
        request.setAttribute("category", existingCategory);
        request.getRequestDispatcher("shop/editCategory.jsp").forward(request, response);
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String errorCategoryName = "";
        if(!categoryDAO.checkCategoryName(name)){
            errorCategoryName = "Tên thể loại đã có rồi";
            request.setAttribute("errorCategoryName", errorCategoryName);
            request.getRequestDispatcher("shop/manageCategory.jsp").forward(request, response);
        }
        
        categoryDAO.addCategory(name);
//        ArrayList<Category> cList = (ArrayList) categoryDAO.getAllCategory();
//        session.setAttribute("cList", cList);
        listCategory(request, response);
        response.sendRedirect("CategoryServlet?action=manageCategory");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String errorCategoryNameUpdate = "";
        if(!categoryDAO.checkCategoryNameUpdate(name, id)){
            errorCategoryNameUpdate = "Tên thể loại đã có rồi";
            request.setAttribute("id", id);
            request.setAttribute("errorCategoryNameUpdate", errorCategoryNameUpdate);
            request.getRequestDispatcher("shop/manageCategory.jsp").forward(request, response);
        }
        categoryDAO.updateCategory(id, name);
//        ArrayList<Category> cList = (ArrayList) categoryDAO.getAllCategory();
//        session.setAttribute("cList", cList);
        listCategory(request, response);
        response.sendRedirect("CategoryServlet?action=manageCategory");
    }

    private void updateCategoryStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));
        categoryDAO.updateCategoryStatus(id, status);
        ArrayList<Category> cList = (ArrayList) categoryDAO.getAllCategory();
        session.setAttribute("cList", cList);
        request.getRequestDispatcher("CategoryServlet?action=manageCategory").forward(request, response);
    }
}
