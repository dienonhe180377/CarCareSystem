/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.order;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.*;
import javax.imageio.ImageIO;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="GenerateQRCodeServlet", urlPatterns={"/GenerateQRCode"})
public class GenerateQRCodeServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);
        String orderIdParam = request.getParameter("orderId");
        String amountParam = request.getParameter("totalAmount"); 

        // Kiểm tra đầu vào
        if (orderIdParam == null || amountParam == null || orderIdParam.isEmpty() || amountParam.isEmpty()) {
            request.setAttribute("message", "Thiếu thông tin đơn hàng hoặc số tiền.");
            request.getRequestDispatcher("/views/order/error.jsp").forward(request, response);
            return;
        }

        // Cấu hình thông tin chuyển khoản
        String bankId = "VCB";                     // Mã ngân hàng theo chuẩn VietQR
        String accountNumber = "1013367685";       // Số tài khoản nhận tiền
        String accountName = "TRAN THANH HAI";       // Tên tài khoản
        String transferContent = "DH" + orderIdParam; // Nội dung chuyển khoản

        // Tạo URL ảnh QR từ VietQR
        String qrUrl = String.format(
                "https://img.vietqr.io/image/%s-%s-compact2.png?amount=%s&addInfo=%s&accountName=%s",
                bankId,
                accountNumber,
                amountParam,
                URLEncoder.encode(transferContent, "UTF-8"),
                URLEncoder.encode(accountName, "UTF-8")
        );

        
        request.setAttribute("vietQrUrl", qrUrl);
        request.setAttribute("bankName", "Ngân hàng Vietcombank");
        request.setAttribute("bankAccount", accountNumber);
        request.setAttribute("accountName", accountName);
        request.setAttribute("currentOrderId", orderIdParam);
        request.setAttribute("totalPrice", amountParam);

        
        request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
        
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
