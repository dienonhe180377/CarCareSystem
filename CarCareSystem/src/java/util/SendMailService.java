/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Xác nhận OTP");
            message.setText("Mã OTP của bạn là: " + otp);
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
