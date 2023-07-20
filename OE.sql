CREATE DATABASE OE
GO
USE [OE]
GO
/****** Object:  Table [dbo].[Favorites]    Script Date: 4/10/2023 1:00:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorites](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](20) NOT NULL,
	[VideoId] [varchar](20) NOT NULL,
	[LikeDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shares]    Script Date: 4/10/2023 1:00:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shares](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](20) NOT NULL,
	[VideoId] [varchar](20) NOT NULL,
	[Emails] [nvarchar](255) NOT NULL,
	[ShareDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/10/2023 1:00:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [varchar](20) NOT NULL,
	[Fullname] [nvarchar](50) NULL,
	[Password] [varchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Gender] [bit] NULL,
	[Admin] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Video]    Script Date: 4/10/2023 1:00:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[Id] [varchar](20) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Views] [int] NOT NULL,
	[Poster] [text] NULL,
	[Description] [ntext] NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Favorites] ON 

INSERT [dbo].[Favorites] ([Id], [UserId], [VideoId], [LikeDate]) VALUES (1, N'annv', N'AEjv3tFncGQ', CAST(N'2023-04-09' AS Date))
INSERT [dbo].[Favorites] ([Id], [UserId], [VideoId], [LikeDate]) VALUES (2, N'annv', N'Xi9yUx8Gm94', CAST(N'2023-04-09' AS Date))
INSERT [dbo].[Favorites] ([Id], [UserId], [VideoId], [LikeDate]) VALUES (3, N'nghianh', N'TnMrrg9ssXA', CAST(N'2023-04-09' AS Date))
SET IDENTITY_INSERT [dbo].[Favorites] OFF
GO
SET IDENTITY_INSERT [dbo].[Shares] ON 

INSERT [dbo].[Shares] ([Id], [UserId], [VideoId], [Emails], [ShareDate]) VALUES (1, N'annv', N'AEjv3tFncGQ', N'kien21265@gmail.com', CAST(N'2023-04-09' AS Date))
SET IDENTITY_INSERT [dbo].[Shares] OFF
GO
INSERT [dbo].[Users] ([Id], [Fullname], [Password], [Email], [Gender], [Admin]) VALUES (N'annv', N'Nguyễn Văn An', N'An1234@78910', N'annv@gmail.com', NULL, 0)
INSERT [dbo].[Users] ([Id], [Fullname], [Password], [Email], [Gender], [Admin]) VALUES (N'nghianh', N'Nguyễn Hữu Nghĩa', N'Nghia785417@456', N'nghianh@gmail.com', NULL, 0)
INSERT [dbo].[Users] ([Id], [Fullname], [Password], [Email], [Gender], [Admin]) VALUES (N'trungnc', N'Nguyễn Chí Trung', N'Trung7894521@123', N'trungnc@gmail.com', NULL, 0)
GO
INSERT [dbo].[Video] ([Id], [Title], [Views], [Poster], [Description], [Active]) VALUES (N'AEjv3tFncGQ', N'HÀI KỊCH || GIẢI HẠN || TRẤN THÀNH - ANH ĐỨC
', 0, N'https://i.ytimg.com/vi/AEjv3tFncGQ/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFTyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCCnQ_HjsxSwm4g_BBYU_0eBIVbGA', N'Tiểu Phẩm : Hài Kịch Giải Hạn
Trình Diễn : Trấn Thành, Anh Đức

 Kênh Youtube Tổng hợp và Karaoke chính thức của HT Production 
Nhấn đăng kí để thưởng thức những sản phẩm mới nhất từ HT Production nhé !
 ♫  Youtube HT Production:   

 / htproduction   
 ♫  Youtube Đan Trường :    

 / dantruongsingerof...  
 ♫  Fanpage Đan Trường : https://www.facebook.com/dantruongoff...
 ♫  Youtube Trung Quang :   

 / trungquangofficial  
 ♫  Fanpage Trung Quang : https://www.facebook.com/TrungQuangSi...
Bản quyền sản phẩm thuộc về HT Production. 
Vui lòng KHÔNG reupload!', 1)
INSERT [dbo].[Video] ([Id], [Title], [Views], [Poster], [Description], [Active]) VALUES (N'cQm5Mbu9yj0', N'RỒI TỚI LUÔN cùng Hoài Linh, Trấn Thành, Trường Giang, Tiến Luật | Hài Việt Tuyển Chọn Hay Nhất
', 0, N'https://i.ytimg.com/vi/cQm5Mbu9yj0/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFTyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAk26E4sQwF1pw9I37DbO_g2lh-TQ', N'▲ RỒI TỚI LUÔN cùng Hoài Linh, Trấn Thành, Trường Giang, Tiến Luật | Hài Việt Tuyển Chọn Hay Nhất
▲ Xem Hài Hay Tại Đây : https://goo.gl/Ahe1RH

▲ Khoái Coi Hài - Kênh hài tổng hợp những video clip hài hước hay nhất của Hoài Linh, Trường Giang, Trấn Thành, Chí Tài ....

▲ Khoái Coi Hài mang đến cho bạn những phút giây thư giãn, thoải mái, những tiếng cười vui vẻ sau một ngày làm việc.', 1)
INSERT [dbo].[Video] ([Id], [Title], [Views], [Poster], [Description], [Active]) VALUES (N'L2-hHGwVZb0', N'HÀI KỊCH || ĐÔI BẠN GIÀ || TRẤN THÀNH - CÁT PHƯỢNG - ANH ĐỨC
', 0, N'https://i.ytimg.com/vi/L2-hHGwVZb0/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFTyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDjHW8PyOauztNd1M43z5povktE4w', N'Hài Kịch Đôi Bạn Già
Trình diễn: Trấn Thành, Cát Phượng, Anh Đức

Kênh Youtube Tổng hợp và Karaoke chính thức của HT Production 
Nhấn đăng kí để thưởng thức những sản phẩm mới nhất từ HT Production nhé !
 ♫  Youtube HT Production:   

 / htproduction   
 ♫  Youtube Đan Trường :    

 / dantruongsingerof...  
 ♫  Fanpage Đan Trường : https://www.facebook.com/dantruongoff...
 ♫  Youtube Trung Quang :   

 / trungquangofficial  
 ♫  Fanpage Trung Quang : https://www.facebook.com/TrungQuangSi...
Bản quyền sản phẩm thuộc về HT Production. 
Vui lòng KHÔNG reupload!', 1)
INSERT [dbo].[Video] ([Id], [Title], [Views], [Poster], [Description], [Active]) VALUES (N'TnMrrg9ssXA', N'HẺM CỤT FULL- TRẤN THÀNH | NS NGỌC GIÀU, NS VIỆT ANH, LÊ GIANG, DƯƠNG LÂM, QUỐC KHÁNH, LỘ LỘ, A QUAY
', 0, N'https://i.ytimg.com/vi/TnMrrg9ssXA/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDyQ-ESkAQTeHJB-oAu1qCVQwwWUA', N'HẺM CỤT FULL | NS Ngọc Giàu, NS Việt Anh, Trấn Thành, Lê Giang, Dương Lâm, Quốc Khánh, Hoàng Mèo, Kim Nhã, Lộ Lộ, A Quay, Trúc Trân, Kim Đào, Trọng Hiếu, Bé Bảo Nhi
#TranThanh #HemCut #Lazada #Phimhaitet #Phimhaitet2022 #LeGiang #BaoLam #QuocKhanh #Phimhai
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Chào Mừng Bạn Đến Với Youtube Chính Thức Được Trực Tiếp Quản Lý Bởi MC Trấn Thành, Những Thành Viên Của Gia Đình TRAN THANH Official Và METUB Network.
Các Bạn Nhớ Subscribe, Like Và Share Để Ủng Hộ Tinh Thần Cho Trấn Thành Và Nhận Được Những Thông Tin, Video Mới Nhất Về Các Hoạt Động Nghệ Thuật Của MC Trấn Thành Nhé.
Fanpage Chính Thức:
Https://Www.Facebook.Com/Tran.Thanh.Ne
Kênh Youtube Chính Thức: Http://Metub.Net/Tranthanh
Rất Cảm Ơn Các Anh Chị, Các Bạn Đã Ủng Hộ Chúng Tôi Trong Suốt Thời Gian Qua!', 1)
INSERT [dbo].[Video] ([Id], [Title], [Views], [Poster], [Description], [Active]) VALUES (N'UVlTG9wYjR0', N'KHÓ Ở - TRẤN THÀNH [Cười Đủ Kiểu] HD
', 0, N'https://i.ytimg.com/vi/UVlTG9wYjR0/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFTyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCXNITQnwW-_uIH_33kX_QqsCbfnw', N'KHÓ Ở - TRẤN THÀNH [Cười Đủ Kiểu] HD

Bản quyền thuộc về Hiệp Hội Công Nghiệp Ghi Âm Việt Nam - © 2015 By RIAV - PLEASE DO NOT RE-UPLOAD!

Official Facebook Page: https://www.facebook.com/RIAVonline', 1)
INSERT [dbo].[Video] ([Id], [Title], [Views], [Poster], [Description], [Active]) VALUES (N'Xi9yUx8Gm94', N'TUI LÀ TƯ HẬU Full Series | Hài Trấn Thành | Anh Đức, Diệu Nhi, Hải Triều, BB Trần, Vỹ Dạ, Vinh Râu
', 0, N'https://i.ytimg.com/vi/Xi9yUx8Gm94/hqdefault.jpg?sqp=-oaymwEcCOADEI4CSFTyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAnxVnsACin7F61jegTfAlv961pJQ', N'Với sự tham gia của các diễn viên : Đàm Vĩnh Hưng, Hari Won, Hoàng Sơn, Lê Giang, Tiến Luật, Anh Đức, Diệu Nhi, Khả Như, Lâm Vỹ Dạ, BB Trần, Hải Triều, Vinh Râu, Hữu Tín, Tuấn Kiệt, Dương Thanh Vàng, Minh Dự, Tuấn Dũng, Lê Minh Ngọc, Minh Kha. Cùng các sao nhí: bé Tin Tin, bé Nắng (Kim Thư), An Khang, Ngân Chi...
Tui Là Tư Hậu - Teaser Tập 8 | Trấn Thành, Hari Won, Tin Tin, Hữu Tín, Bé Nắng, An Khang, Ngân Chi
Chào mừng bạn đến với Youtube chính thức được trực tiếp quản lý bởi MC Trấn Thành, những thành viên của gia đình TRAN THANH Official và METUB Network.
Các bạn nhớ Subscribe, Like và Share để ủng hộ tinh thần cho Trấn Thành và nhận được những thông tin, video mới nhất về các hoạt động nghệ thuật của MC Trấn Thành  nhé.  
Fanpage chính thức:  
https://www.facebook.com/tran.thanh.ne 
Kênh youtube chính thức: metub.net/tranthanh 
Rất cảm ơn các anh chị, các bạn đã ủng hộ chúng tôi trong suốt thời gian qua!', 1)
GO
ALTER TABLE [dbo].[Favorites] ADD  DEFAULT (getdate()) FOR [LikeDate]
GO
ALTER TABLE [dbo].[Shares] ADD  DEFAULT (getdate()) FOR [ShareDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [Admin]
GO
ALTER TABLE [dbo].[Video] ADD  DEFAULT ((0)) FOR [Views]
GO
ALTER TABLE [dbo].[Video] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Favorites]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Favorites]  WITH CHECK ADD FOREIGN KEY([VideoId])
REFERENCES [dbo].[Video] ([Id])
GO
ALTER TABLE [dbo].[Shares]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Shares]  WITH CHECK ADD FOREIGN KEY([VideoId])
REFERENCES [dbo].[Video] ([Id])
GO
