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
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.poly.dao.UserDAO;
import com.poly.dao.VideoDAO;
import com.poly.extensions.SendEmail;
import com.poly.extensions.StrongPasswordGenerator;
import com.poly.extensions.YouTubeAPI;
import com.poly.model.Favorite;
import com.poly.model.Report;
import com.poly.model.Share;
import com.poly.model.User;
import com.poly.model.Video;
import com.poly.model.VideoDTO;

@WebServlet({ "/admin/sign-in", "/admin/index", "/admin/about", "/admin/detail-video", "/admin/edit-profile",
		"/admin/forgot-password", "/admin/otp", "/admin/sign-out" })
public class AdminHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String uri = req.getRequestURI();
		if (uri.contains("sign-in")) {
			this.doSignIn(req, resp);
		} else if (uri.contains("index")) {
			this.doIndex(req, resp);
		} else if (uri.contains("about")) {
			this.doAbout(req, resp);
		} else if (uri.contains("detail-video")) {
			this.doDetailVideo(req, resp);
		} else if (uri.contains("edit-profile")) {
			this.doEditProfile(req, resp);
		} else if (uri.contains("forgot-password")) {
			this.doForgotPassword(req, resp);
		} else if (uri.contains("otp")) {
			this.doVerifyOTP(req, resp);
		} else if (uri.contains("sign-out")) {
			this.doSignOut(req, resp);
		}
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

	private void doSignIn(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			try {
				String email = req.getParameter("email");
				String pw = req.getParameter("password");

				if (email != null && pw != null) {
					EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
					// Tạo EntityManager để bắt đầu làm việc với CSDL
					EntityManager em = emf.createEntityManager();
					String jpql = "SELECT u FROM User u WHERE u.email = :email";
					TypedQuery<User> query = em.createQuery(jpql, User.class);
					query.setParameter("email", email);
					User user = query.getSingleResult();
					System.out.println(user);
					if (user.getAdmin()) {
						if (!user.getPassword().equals(pw)) {
							req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không hợp lệ");
						} else {
							createCookie(resp, "adminId", user.getId(), 24 * 60 * 60);
							resp.sendRedirect("/Assignment2/admin/index");
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
			String cookie = findCookieByName(req, "adminId");
			if (cookie != null) {
				UserDAO dao = new UserDAO();
				User user = dao.findById(cookie);
				if (user != null && user.getAdmin()) {
					resp.sendRedirect("/Assignment2/admin/index");
					return;
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/admin/login.jsp").forward(req, resp);
	}

	private void doIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		if (method.equalsIgnoreCase("POST")) {
			String movie = req.getParameter("movie-detail");
			if (movie != null && movie.equals("true")) {
				String videoId = req.getParameter("videoId");
				resp.sendRedirect("/Assignment2/admin/detail-video" + "?" + "videoId=" + videoId);
				return;
			} else {
				doPostData(req, resp);
			}
		} else if (method.equalsIgnoreCase("GET")) {
			String userId = findCookieByName(req, "adminId");
			if (userId == null) {
				resp.sendRedirect("/Assignment2/admin/sign-in");
				return;
			} else {
				UserDAO dao = new UserDAO();
				User user = dao.findById(userId);
				if (user != null) {
					EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
					EntityManager em = emf.createEntityManager();
					String jpql = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
					TypedQuery<VideoDTO> query = em.createQuery(jpql, VideoDTO.class);
					List<VideoDTO> list = query.getResultList();
					req.setAttribute("videos", list);
					doGetData(req, resp);
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/admin/index.jsp").forward(req, resp);
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
					.createQuery("SELECT COUNT(*) FROM User u WHERE u.email = :email AND u.admin = 1", Long.class);
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
					req.getRequestDispatcher("/admin/otp").forward(req, resp);
				}
			}
		}
		req.getRequestDispatcher("/views/jsp/admin/forgot-password.jsp").forward(req, resp);
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
		} else if (method.equalsIgnoreCase("GET")) {

		}
		req.getRequestDispatcher("/views/jsp/admin/otp.jsp").forward(req, resp);
	}

	private void doDetailVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			String movie = req.getParameter("movie-detail");
			if (movie != null && movie.equals("true")) {
				String videoId = req.getParameter("videoId");
				resp.sendRedirect("/Assignment2/admin/detail-video" + "?" + "videoId=" + videoId);
				return;
			}
			doPostData(req, resp);
		} else if (method.equalsIgnoreCase("GET")) {
			String videoId = req.getParameter("videoId");
			if (videoId != null) {
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
				EntityManager em = emf.createEntityManager();
				String jpql1 = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE v.id = :videoId GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
				TypedQuery<VideoDTO> query1 = em.createQuery(jpql1, VideoDTO.class);
				query1.setParameter("videoId", videoId);
				VideoDTO videoDTO = query1.getSingleResult();
				req.setAttribute("v", videoDTO);
				String jpql2 = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s WHERE v.id <> :videoId GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
				TypedQuery<VideoDTO> query2 = em.createQuery(jpql2, VideoDTO.class);
				query2.setParameter("videoId", videoId);
				List<VideoDTO> videos = query2.getResultList();
				req.setAttribute("videos", videos);

			}
			doGetData(req, resp);
		}
		req.getRequestDispatcher("/views/jsp/admin/video-detail.jsp").forward(req, resp);
	}

	private void doPostData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String selected = req.getParameter("selected");
		if (selected != null) {
			if (selected.equals("tab6")) {
				UserDAO dao = new UserDAO();
				System.out.println(req.getParameter("userId"));
				User user = dao.findById(req.getParameter("userId"));
				req.setAttribute("user", user);
			} else if (selected.equals("tab8")) {
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
				EntityManager em = emf.createEntityManager();
				String jpqlfu = "SELECT o FROM Favorite o WHERE o.video.id = :videoId";
				TypedQuery<Favorite> queryfu = em.createQuery(jpqlfu, Favorite.class);
				queryfu.setParameter("videoId", req.getParameter("videoIdFu"));
				List<Favorite> listfu = queryfu.getResultList();
				req.setAttribute("reportfu", listfu);
			} else if (selected.equals("tab9")) {
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
				EntityManager em = emf.createEntityManager();
				String jpqlfs = "SELECT s FROM Share s WHERE s.video.id = :videoId";
				TypedQuery<Share> queryfs = em.createQuery(jpqlfs, Share.class);
				queryfs.setParameter("videoId", req.getParameter("videoIdFs"));
				List<Share> listfs = queryfs.getResultList();
				req.setAttribute("reportfs", listfs);
			} else if (selected.equals("tab5")) {
				String update = req.getParameter("actionUser");
				if (update != null && update.equals("updateuser")) {
					String id = req.getParameter("id");
					String password = req.getParameter("password");
					String fullname = req.getParameter("fullname");
					String email = req.getParameter("email");
					UserDAO dao = new UserDAO();
					EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
					EntityManager em = emf.createEntityManager();
					String all = "SELECT u FROM User u WHERE u.admin = 0 AND u.id = :userId";
					TypedQuery<User> queryall = em.createQuery(all, User.class);
					queryall.setParameter("userId", id);
					User user = queryall.getSingleResult();
					if (user != null && !user.getAdmin()) {
						if (!isValidPassword(password)) {
							req.setAttribute("error",
							"Mật khẩu phải chứa ít nhất 8 ký tự và nhiều nhất là 20 ký tự và phải chứa ít nhất một chữ số, một chữ cái viết in hoa, một chữ cái viết thường, một ký tự đặc biệt bao gồm  !@#$%&*()-+=^  và không chứa bất kỳ khoảng trắng nào.");
						}
						else {
							user.setPassword(password);
							user.setFullname(fullname);
							user.setEmail(email);
							dao.update(user);	
							req.setAttribute("success",
							"Cập nhật thông tin người dùng thành công");
						}
						String jpqluser = "SELECT u FROM User u WHERE u.admin = 0";
						TypedQuery<User> queryuser = em.createQuery(jpqluser, User.class);
						List<User> userlist = queryuser.getResultList();
						req.setAttribute("userlist", userlist);
						User resetUser = new User();
						req.setAttribute("user", resetUser);
					} else {
						String jpqluser = "SELECT u FROM User u WHERE u.admin = 0";
						TypedQuery<User> queryuser = em.createQuery(jpqluser, User.class);
						List<User> userlist = queryuser.getResultList();
						req.setAttribute("userlist", userlist);
						User resetUser = new User();
						req.setAttribute("user", resetUser);
						req.setAttribute("error", "ID người dùng không hợp lệ");
					}
				} else if (update != null && update.equals("deleteuser")) {
					String id = req.getParameter("id");
					EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
					EntityManager em = emf.createEntityManager();
					String all = "SELECT u FROM User u WHERE u.admin = 0 AND u.id = :userId";
					TypedQuery<User> queryall = em.createQuery(all, User.class);
					queryall.setParameter("userId", id);
					User user = queryall.getSingleResult();
					if (user != null) {
						UserDAO dao = new UserDAO();
						dao.remove(id);
						String jpqluser = "SELECT u FROM User u WHERE u.admin = 0";
						TypedQuery<User> queryuser = em.createQuery(jpqluser, User.class);
						List<User> userlist = queryuser.getResultList();
						req.setAttribute("userlist", userlist);
						User resetUser = new User();
						req.setAttribute("user", resetUser);
						req.setAttribute("success",
						"Xóa thông tin người dùng thành công");
					} else {
						String jpqluser = "SELECT u FROM User u WHERE u.admin = 0";
						TypedQuery<User> queryuser = em.createQuery(jpqluser, User.class);
						List<User> userlist = queryuser.getResultList();
						req.setAttribute("userlist", userlist);
						User resetUser = new User();
						req.setAttribute("user", resetUser);
						req.setAttribute("error", "ID người dùng không hợp lệ");
					}
				}
			} else if (selected.equals("tab2")) {
				VideoDAO dao = new VideoDAO();
				Video video = dao.findById(req.getParameter("videoId"));
				req.setAttribute("video", video);
			} else if (selected.equals("tab1")) {
				String update = req.getParameter("actionVideo");
				if (update != null && update.equals("createvideo")) {
					String videoId = req.getParameter("videoId");
					String videoPoster = req.getParameter("videoImage");
					String videoTitle = req.getParameter("videoTitle");
					String videoViews = req.getParameter("videoViews");
					String active = req.getParameter("active");
					String description = req.getParameter("description");
					VideoDAO dao = new VideoDAO();
					Video video = dao.findById(videoId);
					if (video == null) {
						boolean checkId = YouTubeAPI.checkIdVideo(videoId);
						if (checkId == true) {
							Video videoadd = new Video();
							videoadd.setId(videoId);
							videoadd.setPoster(videoPoster);
							videoadd.setTitle(videoTitle);
							videoadd.setViews(Integer.parseInt(videoViews));
							videoadd.setActive(Boolean.parseBoolean(active));
							videoadd.setDescription(description);
							dao.create(videoadd);
							VideoDAO videodao = new VideoDAO();
							List<Video> videoAll = videodao.findAll();
							req.setAttribute("videoAll", videoAll);
							Video videoEmpty = new Video();
							req.setAttribute("video", videoEmpty);
							req.setAttribute("success", "Tạo video thành công");
						} else {
							VideoDAO videodao = new VideoDAO();
							List<Video> videoAll = videodao.findAll();
							req.setAttribute("videoAll", videoAll);
							Video videoEmpty = new Video();
							req.setAttribute("video", videoEmpty);
							req.setAttribute("error", "ID Video không hợp lệ");
						}
					} else {
						VideoDAO videodao = new VideoDAO();
						List<Video> videoAll = videodao.findAll();
						req.setAttribute("videoAll", videoAll);
						Video videoEmpty = new Video();
						req.setAttribute("video", videoEmpty);
						req.setAttribute("error", "ID Video không hợp lệ");
					}
				} else if (update != null && update.equals("updatevideo")) {
					String videoId = req.getParameter("videoId");
					String videoPoster = req.getParameter("videoImage");
					String videoTitle = req.getParameter("videoTitle");
					String videoViews = req.getParameter("videoViews");
					String active = req.getParameter("active");
					String description = req.getParameter("description");
					boolean checkId = YouTubeAPI.checkIdVideo(videoId);
					System.out.println(checkId);
					if (checkId == true) {
						VideoDAO dao = new VideoDAO();
						Video video = dao.findById(videoId);
						video.setId(videoId);
						video.setPoster(videoPoster);
						video.setTitle(videoTitle);
						video.setViews(Integer.parseInt(videoViews));
						video.setActive(Boolean.parseBoolean(active));
						video.setDescription(description);
						dao.update(video);
						VideoDAO videodao = new VideoDAO();
						List<Video> videoAll = videodao.findAll();
						req.setAttribute("videoAll", videoAll);
						Video videoEmpty = new Video();
						req.setAttribute("video", videoEmpty);
						req.setAttribute("success", "Cập nhật video thành công");
					} else {
						VideoDAO videodao = new VideoDAO();
						List<Video> videoAll = videodao.findAll();
						req.setAttribute("videoAll", videoAll);
						Video videoEmpty = new Video();
						req.setAttribute("video", videoEmpty);
						req.setAttribute("error", "ID Video không hợp lệ");
					}
				} else if (update != null && update.equals("deletevideo")) {
					String videoId = req.getParameter("videoId");
					VideoDAO dao = new VideoDAO();
					Video video = dao.findById(videoId);
					if (video != null) {
						dao.remove(videoId);
						VideoDAO videodao = new VideoDAO();
						List<Video> videoAll = videodao.findAll();
						req.setAttribute("videoAll", videoAll);
						Video videoEmpty = new Video();
						req.setAttribute("video", videoEmpty);
						req.setAttribute("success", "Xóa video thành công");
					} else {
						VideoDAO videodao = new VideoDAO();
						List<Video> videoAll = videodao.findAll();
						req.setAttribute("videoAll", videoAll);
						Video videoEmpty = new Video();
						req.setAttribute("video", videoEmpty);
						req.setAttribute("error", "ID Video không hợp lệ");
					}
				} else if (update != null && update.equals("resetvideo")) {
					Video videoEmpty = new Video();
					req.setAttribute("video", videoEmpty);
					VideoDAO videodao = new VideoDAO();
					List<Video> videoAll = videodao.findAll();
					req.setAttribute("videoAll", videoAll);
				}
			}
		}
	}

	private void doGetData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userId = findCookieByName(req, "adminId");
		if (userId == null) {
			resp.sendRedirect("/Assignment2/admin/sign-in");
			return;
		} else {
			UserDAO dao = new UserDAO();
			User user = dao.findById(userId);
			if (user != null) {
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("OE");
				EntityManager em = emf.createEntityManager();
				String jpql = "SELECT new com.poly.model.VideoDTO(v, COUNT(DISTINCT f.id), COUNT(DISTINCT s.id)) FROM Video v LEFT JOIN v.favorites f LEFT JOIN v.shares s GROUP BY v.id, v.title, v.views, v.active, v.poster, v.description, v.uploadDate";
				TypedQuery<VideoDTO> query = em.createQuery(jpql, VideoDTO.class);
				List<VideoDTO> list = query.getResultList();
				req.setAttribute("videos", list);
				String selected = req.getParameter("selected");
				if (selected != null) {
					if (selected.equals("tab1") || selected.equals("tab2")) {
						VideoDAO videodao = new VideoDAO();
						List<Video> videoAll = videodao.findAll();
						req.setAttribute("videoAll", videoAll);
					} else if (selected.equals("tab5") || selected.equals("tab6")) {
						String jpqluser = "SELECT u FROM User u WHERE u.admin = 0";
						TypedQuery<User> queryuser = em.createQuery(jpqluser, User.class);
						List<User> userlist = queryuser.getResultList();
						req.setAttribute("userlist", userlist);
					} else if (selected.equals("tab7") || selected.equals("tab8") || selected.equals("tab9")) {
						VideoDAO videodao = new VideoDAO();
						List<Video> videoAll = videodao.findAll();
						req.setAttribute("videoAll", videoAll);
						String jpqlfr = "SELECT new Report(o.video.title, count(o), "
								+ " max(o.likeDate), min(o.likeDate)) " + " FROM Favorite o "
								+ " GROUP BY o.video.title";
						TypedQuery<Report> queryfr = em.createQuery(jpqlfr, Report.class);
						List<Report> listfr = queryfr.getResultList();
						req.setAttribute("reportfr", listfr);
						String jpqlfu = "SELECT o FROM Favorite o";
						TypedQuery<Favorite> queryfu = em.createQuery(jpqlfu, Favorite.class);
						List<Favorite> listfu = queryfu.getResultList();
						req.setAttribute("reportfu", listfu);
						String jpqlfs = "SELECT s FROM Share s";
						TypedQuery<Share> queryfs = em.createQuery(jpqlfs, Share.class);
						List<Share> listfs = queryfs.getResultList();
						req.setAttribute("reportfs", listfs);
					}
				}
			} else {
				resp.sendRedirect("/Assignment2/admin/sign-in");
				return;
			}
		}
	}

	private void doAbout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			doPostData(req, resp);
		} else if (method.equals("GET")) {
			doGetData(req, resp);
		}
		req.getRequestDispatcher("/views/jsp/admin/about.jsp").forward(req, resp);
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

	private void doEditProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String method = req.getMethod();
		if (method.equalsIgnoreCase("POST")) {
			if (req.getParameter("selected") != null && req.getParameter("selected").equals("tab10")) {
				UserDAO dao = new UserDAO();
				User user = dao.findById(findCookieByName(req, "adminId"));
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
			} else if (req.getParameter("selected") != null && req.getParameter("selected").equals("tab11")) {
				UserDAO dao = new UserDAO();
				User user = dao.findById(findCookieByName(req, "adminId"));
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
			doPostData(req, resp);
		}
		if (method.equalsIgnoreCase("GET")) {
			String userId = findCookieByName(req, "adminId");
			if (userId == null) {
				resp.sendRedirect("/Assignment2/admin/sign-in");
				return;
			} else {
				Cookie[] cookies = req.getCookies();
				UserDAO dao = new UserDAO();
				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if (cookie.getName().equals("adminId")) {
							String adminId = cookie.getValue();
							User useredit = new User();
							useredit = dao.findById(adminId);
							req.setAttribute("useredit", useredit);
						}
					}
				}
				doGetData(req, resp);
			}
		}
		req.getRequestDispatcher("/views/jsp/admin/account.jsp").forward(req, resp);
	}

	private void doSignOut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendRedirect("/Assignment2/admin/sign-in");
	}
}
