package com.oe.ui;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.poly.dao.FavoriteDAO;
import com.poly.dao.ShareDAO;
import com.poly.dao.UserDAO;
import com.poly.dao.VideoDAO;
import com.poly.extensions.SendEmail;
import com.poly.extensions.StrongPasswordGenerator;
import com.poly.model.User;
import com.poly.model.Video;
import com.poly.model.VideoDTO;

@WebServlet({ "/user/sign-in", "/user/otp", "/user/favorite", "/user/edit-profile", "/user/index", "/user/demo", "/user/forgot-password",
		"/user/sign-up", "/user/sign-out", "/user/about", "/user/detail-video" })
public class UserHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		if (uri.contains("sign-in")) {
			this.doSignIn(req, resp);
		} else if (uri.contains("sign-up")) {
			this.doSignUp(req, resp);
		} else if (uri.contains("forgot-password")) {
			this.doForgotPassword(req, resp);
		} else if (uri.contains("otp")) {
			this.doVerifyOTP(req, resp);
		} else if (uri.contains("demo")) {
			this.doDemo(req, resp);
		} else if (uri.contains("edit-profile")) {
			this.doEditProfile(req, resp);
		} else if (uri.contains("index")) {
			this.doIndex(req, resp);
		} else if (uri.contains("favorite")) {
			this.doFavorite(req, resp);
		} else if (uri.contains("sign-out")) {
			this.doSignOut(req, resp);
		} else if (uri.contains("about")) {
			this.doAbout(req, resp);
		} else if (uri.contains("detail-video")) {
			this.doDetailVideo(req, resp);
		}
	}

	private void doSignIn(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			try {
				String email = req.getParameter("email");
				String pw = req.getParameter("password");

				if (email != null && pw != null) {
					System.out.println(email);
					System.out.println(pw);
					EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
					// Tạo EntityManager để bắt đầu làm việc với CSDL
					EntityManager em = emf.createEntityManager();
					String jpql = "SELECT u FROM User u WHERE u.email = :email";
					TypedQuery<User> query = em.createQuery(jpql, User.class);
					query.setParameter("email", email);
					User user = query.getSingleResult();
					System.out.println(user);
					if (!user.getAdmin()) {
						if (!user.getPassword().equals(pw)) {
							req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không hợp lệ");
						} else {
							createCookie(resp, "userId", user.getId(), 24 * 60 * 60);
							resp.sendRedirect("/Assignment2/user/index");
							return;
						}
					} else {
						req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không hợp lệ");
					}
				}
			} catch (Exception e) {
				System.out.println("Tên đăng nhập hoặc mật khẩu không hợp lệ");
				req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không hợp lệ");
			}
		} else if (method.equalsIgnoreCase("GET")) {
			String cookie = findCookieByName(req, "userId");
			if (cookie != null) {
				UserDAO dao = new UserDAO();
				User user = dao.findById(cookie);
				if (user != null && !user.getAdmin()) {
					resp.sendRedirect("/Assignment2/user/index");
					return;
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/user/login.jsp").forward(req, resp);
	}

	private boolean isValidPassword(String password) {
		String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,20}$";
		Pattern p = Pattern.compile(regex);
		if (password == null) {
			return false;
		}
		Matcher m = p.matcher(password);
		return m.matches();
	}

	private void doSignUp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			String rePassword = req.getParameter("repassword");
			if (!isValidPassword(password)) {
				req.setAttribute("error",
						"Mật khẩu phải chứa ít nhất 8 ký tự và nhiều nhất là 20 ký tự và phải chứa ít nhất một chữ số, một chữ cái viết in hoa, một chữ cái viết thường, một ký tự đặc biệt bao gồm  !@#$%&*()-+=^  và không chứa bất kỳ khoảng trắng nào.");
			} else if (!password.equals(rePassword)) {
				req.setAttribute("error", "Mật khẩu xác nhận không đúng");

			} else {
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
				// Tạo EntityManager để bắt đầu làm việc với CSDL
				EntityManager em = emf.createEntityManager();
				TypedQuery<Long> query = em.createQuery("SELECT COUNT(*) FROM User u WHERE u.email = :email",
						Long.class);
				query.setParameter("email", email);
				Long emailExists = query.getSingleResult();
				if (emailExists > 0) {
					req.setAttribute("error", "Email đã tồn tại");
				} else {
					try {
						String username = email.split("@")[0];
						User entity = new User();
						entity.setId(username);
						entity.setEmail(email);
						entity.setPassword(password);
						entity.setRegisteredDate(new Date());
						UserDAO dao = new UserDAO();
						dao.create(entity);
						req.setAttribute("success", "Đăng ký thành công!");
					} catch (Exception e) {
						req.setAttribute("error", "Lỗi đăng ký!");
					}

				}
			}

		}
		req.getRequestDispatcher("/views/jsp/user/signup.jsp").forward(req, resp);
	}

	private void doForgotPassword(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			String email = req.getParameter("email");
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
			// Tạo EntityManager để bắt đầu làm việc với CSDL
			EntityManager em = emf.createEntityManager();
			TypedQuery<Long> query = em
					.createQuery("SELECT COUNT(*) FROM User u WHERE u.email = :email AND u.admin = 0", Long.class);
			query.setParameter("email", email);
			Long emailExists = query.getSingleResult();
			if (emailExists <= 0) {
				req.setAttribute("error", "Không tìm thấy tài khoản của bạn");
			} else {
				String otp = SendEmail.sendEmail(email);
				if (otp == null) {
					req.setAttribute("error", "Không thể khôi phục tài khoản");
				} else {
					String encodedOtp = Base64.getEncoder().encodeToString(otp.getBytes());
					createCookie(resp, "emailVerify", email, 4 * 60);
					createCookie(resp, "otp", encodedOtp, 4 * 60);
					req.getRequestDispatcher("/user/otp").forward(req, resp);
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/user/forgot-password.jsp").forward(req, resp);
	}

	public void createCookie(HttpServletResponse response, String name, String value, int maxAge) {
		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(maxAge);
		response.addCookie(cookie);
	}

	private String findCookieByName(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(name)) {
					return cookie.getValue();
				}
			}
		}
		return null;
	}

	private void deleteCookie(HttpServletRequest request, HttpServletResponse response, String name) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(name)) {
					System.out.println("Hello");
					cookie.setValue("");
					cookie.setPath("/");
					cookie.setMaxAge(0);
					response.addCookie(cookie);
					break;
				}
			}
		}
	}

	private void doVerifyOTP(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			String otp = req.getParameter("otp");
			Cookie[] cookies = req.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("otp")) {
						String encodedOtp = cookie.getValue();
						String otpDecoded = new String(Base64.getDecoder().decode(encodedOtp));
						if (otpDecoded.equals(otp)) {
							String newPassword = StrongPasswordGenerator.generateStrongPassword(12);
							EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
							// Tạo EntityManager để bắt đầu làm việc với CSDL
							EntityManager em = emf.createEntityManager();
							String jpql = "SELECT u FROM User u WHERE u.email = :email";
							TypedQuery<User> query = em.createQuery(jpql, User.class);
							query.setParameter("email", findCookieByName(req, "emailVerify"));
							User user = query.getSingleResult();
							user.setPassword(newPassword);
							UserDAO dao = new UserDAO();
							dao.update(user);
							boolean reset = SendEmail.resetPassword(user.getEmail(), newPassword);
							if (reset == true) {
								req.setAttribute("success", "Mật khẩu mới được gửi qua email của bạn");
								deleteCookie(req, resp, "emailVerify");
								deleteCookie(req, resp, "otp");
								createCookie(resp, "verify", "true", 20);
							} else {
								req.setAttribute("error", "Khôi phục tài khoản thất bại");
							}
						} else {
							req.setAttribute("error", "Mã OTP không hợp lệ");
						}
						break;
					}
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/user/otp.jsp").forward(req, resp);
	}

	private void doDemo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			System.out.println(req.getParameter("demo"));
		}
		req.getRequestDispatcher("/views/demo.jsp").forward(req, resp);

	}

	private void doEditProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			if (req.getParameter("selected") != null && req.getParameter("selected").equals("tab1")) {
				UserDAO dao = new UserDAO();
				User user = dao.findById(findCookieByName(req, "userId"));
				String fullname = req.getParameter("fullname");
				String birthday = req.getParameter("birthday");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				try {
					Date birthdayDate = format.parse(birthday);
					String gender = req.getParameter("gender");
					user.setFullname(fullname);
					if (gender.equals("male")) {
						user.setGender(true);
					} else {
						user.setGender(false);
					}
					user.setBirthday(birthdayDate);
					dao.update(user);
					req.setAttribute("success", "Cập nhật thông tin tài khoản thành công");
				} catch (ParseException e) {
					e.printStackTrace();
				}
			} else if (req.getParameter("selected") != null && req.getParameter("selected").equals("tab2")) {
				UserDAO dao = new UserDAO();
				User user = dao.findById(findCookieByName(req, "userId"));
				String password = req.getParameter("password");
				String newpassword = req.getParameter("newpassword");
				String rePassword = req.getParameter("repassword");
				if (!isValidPassword(newpassword)) {
					req.setAttribute("error",
							"Mật khẩu phải chứa ít nhất 8 ký tự và nhiều nhất là 20 ký tự và phải chứa ít nhất một chữ số, một chữ cái viết in hoa, một chữ cái viết thường, một ký tự đặc biệt bao gồm  !@#$%&*()-+=^  và không chứa bất kỳ khoảng trắng nào.");
				} else if (!newpassword.equals(rePassword)) {
					req.setAttribute("error", "Mật khẩu xác nhận không đúng");

				} else if (!user.getPassword().equals(password)) {
					req.setAttribute("error", "Mật khẩu hiện tại không hợp lệ");
				} else {
					user.setPassword(newpassword);
					dao.update(user);
					req.setAttribute("success", "Cập nhật thông tin tài khoản thành công");
				}
			}
		}
		if (method.equalsIgnoreCase("GET")) {
			Cookie[] cookies = req.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("userId")) {
						String userId = cookie.getValue();
						User user = new User();
						UserDAO dao = new UserDAO();
						user = dao.findById(userId);
						req.setAttribute("user", user);
					}
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/user/account.jsp").forward(req, resp);
	}

	private void doIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			String like = req.getParameter("like");
			String share = req.getParameter("share");
			String movie = req.getParameter("movie-detail");
			if (movie != null && movie.equals("true")) {
				String videoId = req.getParameter("videoId");
				VideoDAO dao = new VideoDAO();
				Video video = dao.findById(videoId);
				video.setViews(video.getViews() + 1);
				dao.update(video);
				resp.sendRedirect("/Assignment2/user/detail-video" + "?" + "videoId=" + videoId);
				return;
			} else if (like != null && like.equals("true")) {
				String videoId = req.getParameter("videoId");
				String userId = findCookieByName(req, "userId");
				FavoriteDAO dao = new FavoriteDAO();
				dao.create(userId, videoId);
				resp.sendRedirect("/Assignment2/user/index");
				return;
			} else if (share != null && share.equals("true")) {
				String shareToEmail = req.getParameter("shareToEmail");
				String videoId = req.getParameter("videoId");
				String userId = findCookieByName(req, "userId");
				boolean shareVideo = SendEmail.shareVideo(shareToEmail, userId, videoId);
				if (shareVideo == true) {
					ShareDAO dao = new ShareDAO();
					dao.create(userId, videoId, shareToEmail);
					req.setAttribute("success", "Chia sẻ video thành công");
					resp.sendRedirect("/Assignment2/user/index");
					return;
				} else {
					req.setAttribute("error", "Chia sẻ video thất bại");
					resp.sendRedirect("/Assignment2/user/index");
					return;
				}
			}
		} else if (method.equalsIgnoreCase("GET")) {
			String userId = findCookieByName(req, "userId");
			if (userId == null) {
				resp.sendRedirect("/Assignment2/user/sign-in");
				return;
			} else {
				UserDAO dao = new UserDAO();
				User user = dao.findById(userId);
				if (user != null) {
					EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
					EntityManager em = emf.createEntityManager();
					String jpql = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE NOT EXISTS (SELECT 1 FROM Favorite WHERE user.id = :userId AND video.id = v.id) GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
					TypedQuery<VideoDTO> query = em.createQuery(jpql, VideoDTO.class);
					query.setParameter("userId", userId);
					List<VideoDTO> list = query.getResultList();
					req.setAttribute("videos", list);
				} else {
					resp.sendRedirect("/Assignment2/user/sign-in");
					return;
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/user/index.jsp").forward(req, resp);
	}

	private void doFavorite(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			String unlike = req.getParameter("unlike");
			String share = req.getParameter("share");
			String movie = req.getParameter("movie-detail");
			if (movie != null && movie.equals("true")) {
				String videoId = req.getParameter("videoId");
				VideoDAO dao = new VideoDAO();
				Video video = dao.findById(videoId);
				video.setViews(video.getViews() + 1);
				dao.update(video);
				resp.sendRedirect("/Assignment2/user/detail-video" + "?" + "videoId=" + videoId);
				return;
			} else if (unlike != null && unlike.equals("true")) {
				String videoId = req.getParameter("videoId");
				String userId = findCookieByName(req, "userId");
				FavoriteDAO dao = new FavoriteDAO();
				dao.delete(userId, videoId);
				resp.sendRedirect("/Assignment2/user/favorite");
				return;
			} else if (share != null && share.equals("true")) {
				String shareToEmail = req.getParameter("shareToEmail");
				String videoId = req.getParameter("videoId");
				String userId = findCookieByName(req, "userId");
				boolean shareVideo = SendEmail.shareVideo(shareToEmail, userId, videoId);
				if (shareVideo == true) {
					ShareDAO dao = new ShareDAO();
					dao.create(userId, videoId, shareToEmail);
					req.setAttribute("success", "Chia sẻ video thành công");
					resp.sendRedirect("/Assignment2/user/favorite");
					return;
				} else {
					req.setAttribute("error", "Chia sẻ video thất bại");
					resp.sendRedirect("/Assignment2/user/favorite");
					return;
				}
			}
		} else if (method.equalsIgnoreCase("GET")) {
			String userId = findCookieByName(req, "userId");
			if (userId == null) {
				resp.sendRedirect("/Assignment2/user/sign-in");
				return;
			} else {
				UserDAO dao = new UserDAO();
				User user = dao.findById(userId);
				System.out.println(user);
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
				EntityManager em = emf.createEntityManager();
				String jpql = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE EXISTS (SELECT 1 FROM Favorite WHERE user.id = :userId AND video.id = v.id) GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
				TypedQuery<VideoDTO> query = em.createQuery(jpql, VideoDTO.class);
				query.setParameter("userId", userId);
				List<VideoDTO> list = query.getResultList();
				req.setAttribute("videos", list);
			}
		}
		req.getRequestDispatcher("/views/jsp/user/favorite.jsp").forward(req, resp);
	}

	private void doSignOut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendRedirect("/Assignment2/user/sign-in");
	}

	private void doAbout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/jsp/user/about.jsp").forward(req, resp);
	}

	private void doDetailVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			String like = req.getParameter("like");
			String unlike = req.getParameter("unlike");
			String share = req.getParameter("share");
			String movie = req.getParameter("movie-detail");
			if (movie != null && movie.equals("true")) {
				String videoId = req.getParameter("videoId");
				VideoDAO dao = new VideoDAO();
				Video video = dao.findById(videoId);
				video.setViews(video.getViews() + 1);
				dao.update(video);
				resp.sendRedirect("/Assignment2/user/detail-video" + "?" + "videoId=" + videoId);
				return;
			} else if (like != null && like.equals("true")) {
				String videoId = req.getParameter("videoId");
				String userId = findCookieByName(req, "userId");
				FavoriteDAO dao = new FavoriteDAO();
				dao.create(userId, videoId);
				resp.sendRedirect("/Assignment2/user/detail-video" + "?" + "videoId=" + videoId);
				return;
			} else if (unlike != null && unlike.equals("true")) {
				String videoId = req.getParameter("videoId");
				String userId = findCookieByName(req, "userId");
				FavoriteDAO dao = new FavoriteDAO();
				dao.delete(userId, videoId);
				resp.sendRedirect("/Assignment2/user/detail-video" + "?" + "videoId=" + videoId);
				return;
			} else if (share != null && share.equals("true")) {
				String shareToEmail = req.getParameter("shareToEmail");
				String videoId = req.getParameter("videoId");
				String userId = findCookieByName(req, "userId");
				boolean shareVideo = SendEmail.shareVideo(shareToEmail, userId, videoId);
				if (shareVideo == true) {
					ShareDAO dao = new ShareDAO();
					dao.create(userId, videoId, shareToEmail);
					req.setAttribute("success", "Chia sẻ video thành công");
					resp.sendRedirect("/Assignment2/user/detail-video" + "?" + "videoId=" + videoId);
					return;
				} else {
					req.setAttribute("error", "Chia sẻ video thất bại");
					resp.sendRedirect("/Assignment2/user/detail-video" + "?" + "videoId=" + videoId);
					return;
				}
			}
		} else if (method.equalsIgnoreCase("GET")) {
			String videoId = req.getParameter("videoId");
			if (videoId != null) {
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
				EntityManager em = emf.createEntityManager();
				String jpql1 = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE v.id = :videoId AND NOT EXISTS (SELECT 1 FROM Favorite WHERE user.id = :userId AND video.id = v.id) GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
				TypedQuery<VideoDTO> query1 = em.createQuery(jpql1, VideoDTO.class);
				query1.setParameter("videoId", videoId);
				query1.setParameter("userId", findCookieByName(req, "userId"));
				try {
					VideoDTO videoDTO = query1.getSingleResult();
					req.setAttribute("v", videoDTO);
					String jpql2 = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE v.id <> :videoId AND NOT EXISTS (SELECT 1 FROM Favorite WHERE user.id = :userId AND video.id = v.id) GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
					TypedQuery<VideoDTO> query2 = em.createQuery(jpql2, VideoDTO.class);
					query2.setParameter("videoId", videoId);
					query2.setParameter("userId", findCookieByName(req, "userId"));
					List<VideoDTO> videos = query2.getResultList();
					req.setAttribute("videos", videos);
				} catch (NoResultException e) {
					String jpqlf1 = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE v.id = :videoId AND EXISTS (SELECT 1 FROM Favorite WHERE user.id = :userId AND video.id = v.id) GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
					TypedQuery<VideoDTO> queryf1 = em.createQuery(jpqlf1, VideoDTO.class);
					queryf1.setParameter("videoId", videoId);
					queryf1.setParameter("userId", findCookieByName(req, "userId"));
					VideoDTO videoDTOf1 = queryf1.getSingleResult();
					req.setAttribute("vf", videoDTOf1);
					String jpqlf2 = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE v.id <> :videoId AND EXISTS (SELECT 1 FROM Favorite WHERE user.id = :userId AND video.id = v.id) GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
					TypedQuery<VideoDTO> queryf2 = em.createQuery(jpqlf2, VideoDTO.class);
					queryf2.setParameter("videoId", videoId);
					queryf2.setParameter("userId", findCookieByName(req, "userId"));
					List<VideoDTO> videos = queryf2.getResultList();
					req.setAttribute("videos", videos);
				}

			}
		}
		req.getRequestDispatcher("/views/jsp/user/video-detail.jsp").forward(req, resp);
	}

}
