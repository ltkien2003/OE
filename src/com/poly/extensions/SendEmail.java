package com.poly.extensions;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {
	@SuppressWarnings("unused")
	public static String sendEmail(String email) {
		String otp = OtpGenerator.generateOtp("otp_key");
		String from = "kien21265@gmail.com";
		String to = email;
		String subject = "KHÔI PHỤC TÀI KHOẢN";
		String body = "Mã OTP của bạn là: " + otp;
		String email_pattern = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		Session session = Session.getInstance(props, new Authenticator() {
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication("kien21265@gmail.com", "opqmahmxyrhpngme");
			}
		});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(body);
			Transport.send(message);
			return otp;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public static boolean resetPassword(String email, String password) {
		String newPassword = password;
		String from = "kien21265@gmail.com";
		String to = email;
		String subject = "KHÔI PHỤC TÀI KHOẢN";
		String body = "Mật khẩu mới của bạn là: " + newPassword;
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		Session session = Session.getInstance(props, new Authenticator() {
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication("kien21265@gmail.com", "opqmahmxyrhpngme");
			}
		});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(body);
			Transport.send(message);
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
	public static boolean shareVideo(String email, String userId, String videoId) {
		String from = "kien21265@gmail.com";
		String to = email;
		String subject = "CHIA SẺ VIDEO";
		String body = userId +" đã chia sẻ video đến bạn: " + "https://www.youtube.com/watch?v=" + videoId;
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		Session session = Session.getInstance(props, new Authenticator() {
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication("kien21265@gmail.com", "opqmahmxyrhpngme");
			}
		});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(body);
			Transport.send(message);
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
}
