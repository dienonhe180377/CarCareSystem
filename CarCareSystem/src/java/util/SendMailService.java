/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

/**
 *
 * @author TRAN ANH HAI
 */
public class SendMailService {

    public static boolean sendOTP(String to, String otp) {
        final String from = "haitthe187108@fpt.edu.vn"; // Gmail bạn
        final String password = "xfjv boec dxrw vmim"; // App Password từ Gmail

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("=?UTF-8?B?" + Base64.getEncoder().encodeToString("Xác nhận OTP".getBytes(StandardCharsets.UTF_8)) + "?=");
            
            String htmlContent = "<html>"
                + "<body style=\"font-family: Arial, sans-serif; font-size: 14px;\">"
                + "<p>Mã OTP của bạn là: <strong>" + otp + "</strong></p>"
                + "<p>Vui lòng không chia sẻ mã này với bất kỳ ai.</p>"
                + "</body></html>";
            
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText("Mã OTP của bạn là: " + otp, "UTF-8");
            
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(htmlContent, "text/html; charset=UTF-8");

            Multipart multipart = new MimeMultipart("alternative");
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(htmlPart);

            message.setContent(multipart);
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean sendNotification(String to, String notiMessage) {
        final String from = "haitthe187108@fpt.edu.vn";
        final String password = "xfjv boec dxrw vmim";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        // Thiết lập encoding UTF-8 cho toàn bộ email
        props.put("mail.mime.charset", "UTF-8");

        Session session = Session.getInstance(props,
                new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session); // Sử dụng MimeMessage

            // Thiết lập người gửi với encoding
            message.setFrom(new InternetAddress(from, "Người gửi", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

            // Thiết lập tiêu đề với encoding UTF-8
            message.setSubject("Thông báo: ", "UTF-8");

            // Thiết lập nội dung với kiểu MIME và encoding
            message.setText(notiMessage, "UTF-8", "plain"); // Plain text
            // Hoặc dành cho HTML: 
            // message.setContent(notiMessage, "text/html; charset=UTF-8");

            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
