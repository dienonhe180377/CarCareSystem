/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import dao.UserDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Collections;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="GoogleCallbackServlet", urlPatterns={"/auth/google/callback"})
public class GoogleCallbackServlet extends HttpServlet {
    
    private static final String CLIENT_ID = "884347704813-pu1smm1tbd294u0v11ois9tu8b9e8p35.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8081/CarCareSystem/auth/google/callback";
   
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GoogleCallbackServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GoogleCallbackServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("login?error=missing_google_code");
            return;
        }

        try {
            // Exchange authorization code for tokens
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                    new NetHttpTransport(),
                    new GsonFactory(),
                    CLIENT_ID,
                    CLIENT_SECRET,
                    code,
                    REDIRECT_URI)
                    .execute();

            // Verify ID token
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    new NetHttpTransport(),
                    new GsonFactory())
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(tokenResponse.getIdToken());
            if (idToken == null) {
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_token");
                return;
            }

            // Get user information
            GoogleIdToken.Payload payload = idToken.getPayload();
            String email = payload.getEmail();
            String name = (String) payload.get("name");
            String googleId = payload.getSubject();

            // Check if user exists in your database
            UserDAO userDAO = new UserDAO();
            User user = userDAO.checkUserExistByEmail(email);

            if (user == null) {
                // Register new user with Google
                String username = email.split("@")[0]; // or generate a username
                // You might want to generate a random password or use a placeholder
                String password = "google_" + googleId;

                // Register the new user
                userDAO.registerUser(username, password, email, "", "");
                user = userDAO.checkUserExistByEmail(email);

                if (user == null) {
                    response.sendRedirect(request.getContextPath() + "/login?error=registration_failed");
                    return;
                }
            }

            // Create session and login
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("roleID", user.getUserRole());

            // Redirect based on role
            if ("customer".equals(user.getUserRole())) {
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                response.sendRedirect(request.getContextPath() + "/authorization");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=auth_failed");
        }

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
