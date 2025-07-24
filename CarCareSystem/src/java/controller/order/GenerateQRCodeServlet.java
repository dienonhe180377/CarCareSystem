/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.order;

import com.google.zxing.*;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
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
        try {
            
            String orderId = request.getParameter("orderId");
            String totalAmount = request.getParameter("totalAmount");
            String bankAccount = request.getParameter("bankAccount");
            String bankName = request.getParameter("bankName");
            String accountName = request.getParameter("accountName");
            
            
            if (orderId == null || totalAmount == null || bankAccount == null || bankName == null || accountName == null) {
                throw new IllegalArgumentException("Missing required parameters");
            }
            
            String qrContent = createBankTransferContent(bankName, bankAccount, accountName, totalAmount, orderId);
            
            String qrCodeImage = generateQRCodeImage(qrContent, 300, 300);

            request.setAttribute("qrCodeImage", qrCodeImage);
            request.setAttribute("currentOrderId", orderId);
            request.setAttribute("totalPrice", totalAmount);
            request.setAttribute("bankAccount", bankAccount);
            request.setAttribute("bankName", bankName);
            request.setAttribute("accountName", accountName);
            
            HttpSession session = request.getSession();
            session.setAttribute("currentOrderId", orderId);
            
            request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating QR code: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    private String createBankTransferContent(String bankName, String bankAccount, String accountName, String amount, String orderId) {
        
        StringBuilder builder = new StringBuilder();
        
        builder.append("bankTransfer=").append(bankName).append("|");
        builder.append("acc=").append(bankAccount).append("|");
        builder.append("name=").append(accountName).append("|");

        double amountValue = Double.parseDouble(amount);
        int amountInt = (int) Math.round(amountValue);
        builder.append("amount=").append(amountInt).append("|");

        builder.append("content=DH").append(orderId);

        return builder.toString();
        
    }
    
    private String getStandardBankCode(String bankName) {
        Map<String, String> bankCodes = new HashMap<>();
        bankCodes.put("Vietcombank", "VCB");
        bankCodes.put("Vietinbank", "CTG");
        bankCodes.put("Techcombank", "TCB");
        bankCodes.put("BIDV", "BIDV");
        bankCodes.put("Agribank", "AGB");
        bankCodes.put("MB Bank", "MB");
        bankCodes.put("Sacombank", "STB");
        bankCodes.put("VP Bank", "VPB");
        bankCodes.put("ACB", "ACB");
        bankCodes.put("SHB", "SHB");

        return bankCodes.getOrDefault(bankName, bankName);
        
    }
    
    private String generateQRCodeImage(String text, int width, int height) throws WriterException, IOException {
        
        if (text == null || text.isEmpty()) {
            throw new IllegalArgumentException("QR code content cannot be empty");
        }

        Map<EncodeHintType, Object> hints = new EnumMap<>(EncodeHintType.class);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M); // Mức sửa lỗi trung bình
        hints.put(EncodeHintType.MARGIN, 1); // Lề nhỏ hơn

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height, hints);

        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        image.createGraphics();

        Graphics2D graphics = (Graphics2D) image.getGraphics();
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, width, height);
        graphics.setColor(Color.BLACK);

        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                if (bitMatrix.get(i, j)) {
                    graphics.fillRect(i, j, 1, 1);
                }
            }
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "png", baos);
        byte[] imageBytes = baos.toByteArray();

        return Base64.getEncoder().encodeToString(imageBytes);
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
        processRequest(request, response);
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
