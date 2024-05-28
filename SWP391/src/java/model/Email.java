/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
/**
 *
 * @author phamc
 */
public class Email {

    public Email() {
    }
    
    public void sendEmail(String to, String text, String subject){
        String fromEmail = "cuonganh2k3@gmail.com";
        String password = "jkmg vttq aaxt arbs";
        
        String toEmail = to;
        
        Properties pros = new Properties();
        pros.put("mail.smtp.auth", "true");
        pros.put("mail.smtp.starttls.enable", "true");
        pros.put("mail.smtp.host", "smtp.gmail.com");
        pros.put("mail.smtp.port", "587");
        
        
        // authenticator thuoc javax.mail
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(fromEmail, password);
            }
        };
        
        Session session = Session.getInstance(pros, auth);
        
        try{
            MimeMessage message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress(fromEmail));
            
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            
            message.setSubject(subject);
            
            message.setText(text);
            
            Transport.send(message);
            
            System.out.println("Gửi email thành công!");
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
    
    
}
