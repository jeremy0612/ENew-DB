USE [master]
GO
/****** Object:  Database [ENews]    Script Date: 2/26/2023 3:08:07 PM ******/
CREATE DATABASE [ENews]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ENews', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ENews.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ENews_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ENews_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ENews] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ENews].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ENews] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ENews] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ENews] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ENews] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ENews] SET ARITHABORT OFF 
GO
ALTER DATABASE [ENews] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ENews] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ENews] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ENews] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ENews] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ENews] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ENews] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ENews] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ENews] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ENews] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ENews] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ENews] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ENews] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ENews] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ENews] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ENews] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ENews] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ENews] SET RECOVERY FULL 
GO
ALTER DATABASE [ENews] SET  MULTI_USER 
GO
ALTER DATABASE [ENews] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ENews] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ENews] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ENews] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ENews] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ENews] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ENews', N'ON'
GO
ALTER DATABASE [ENews] SET QUERY_STORE = OFF
GO
USE [ENews]
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumberOfNewsArticles]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetNumberOfNewsArticles](@reporterID INT)
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*)
    FROM News
    WHERE ReporterID = @reporterID;
    RETURN @count;
END
GO
/****** Object:  Table [dbo].[News]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[ReporterID] [int] NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Summary] [nvarchar](500) NOT NULL,
	[PublishTime] [time](7) NOT NULL,
	[PublishDate] [date] NOT NULL,
	[Picture] [varbinary](max) NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Sources] [nvarchar](200) NULL,
	[Views] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reporter]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporter](
	[ReporterID] [int] NOT NULL,
	[EditorID] [int] NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Birthday] [date] NULL,
	[Role] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReporterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Title_Reporter]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Title_Reporter]()
RETURNS TABLE
AS
RETURN
(
    SELECT News.Title, Reporter.ReporterID
    FROM News
    JOIN Reporter ON News.ReporterID = Reporter.ReporterID
)
GO
/****** Object:  Table [dbo].[Approve]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Approve](
	[EditorID] [int] NULL,
	[NewsID] [int] NULL,
	[Approve_Date] [date] NULL,
	[Approve_Time] [time](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] NOT NULL,
	[ParentID] [int] NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[ReaderID] [int] NULL,
	[NewsID] [int] NULL,
	[Content] [nvarchar](500) NOT NULL,
	[Send_Date] [date] NOT NULL,
	[Send_Time] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Editor]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Editor](
	[EditorID] [int] NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EditorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Editor_Email]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Editor_Email](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[EditorID] [int] NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Purpose] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Editor_Phone]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Editor_Phone](
	[PhoneID] [int] IDENTITY(1,1) NOT NULL,
	[EditorID] [int] NULL,
	[Phone] [varchar](12) NOT NULL,
	[Purpose] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PhoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reader]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reader](
	[ReaderID] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Account] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReaderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reporter_Email]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporter_Email](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[ReporterID] [int] NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Purpose] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reporter_Phone]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporter_Phone](
	[PhoneID] [int] IDENTITY(1,1) NOT NULL,
	[ReporterID] [int] NULL,
	[Phone] [varchar](12) NOT NULL,
	[Purpose] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PhoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subcribe]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subcribe](
	[SubcribeID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ReaderID] [int] NOT NULL,
	[Send_Date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubcribeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 2/26/2023 3:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[NewsId] [int] NULL,
	[CategoryID] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (1, 2, CAST(N'2022-02-10' AS Date), CAST(N'11:15:00' AS Time))
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (2, 2, CAST(N'2022-02-11' AS Date), CAST(N'16:30:00' AS Time))
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (3, 3, CAST(N'2022-02-12' AS Date), CAST(N'10:45:00' AS Time))
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (2, 4, CAST(N'2022-02-13' AS Date), CAST(N'09:30:00' AS Time))
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (1, 5, CAST(N'2022-02-14' AS Date), CAST(N'14:45:00' AS Time))
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (3, 6, CAST(N'2022-02-15' AS Date), CAST(N'13:00:00' AS Time))
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (2, 7, CAST(N'2022-02-16' AS Date), CAST(N'12:30:00' AS Time))
INSERT [dbo].[Approve] ([EditorID], [NewsID], [Approve_Date], [Approve_Time]) VALUES (1, 8, CAST(N'2022-02-17' AS Date), CAST(N'17:00:00' AS Time))
GO
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (1, NULL, N'Technology')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (2, NULL, N'Sports')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (3, NULL, N'Politics')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (4, NULL, N'Entertainment')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (5, 1, N'Hardware')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (6, 1, N'Software')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (7, 2, N'Football')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (8, 2, N'Basketball')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (9, 3, N'Elections')
INSERT [dbo].[Category] ([CategoryId], [ParentID], [Name]) VALUES (10, 4, N'Movies')
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (7, 1, 6, N'Great article!', CAST(N'2022-02-14' AS Date), CAST(N'13:45:00' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (8, 2, 4, N'I disagree with some of the points made in this article', CAST(N'2022-02-14' AS Date), CAST(N'14:02:30' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (9, 3, 2, N'This is an important issue that needs more attention', CAST(N'2022-02-14' AS Date), CAST(N'15:17:45' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (10, 4, 3, N'I appreciate the balanced perspective presented in this article', CAST(N'2022-02-14' AS Date), CAST(N'16:23:15' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (11, 5, 3, N'This is an excellent piece of journalism', CAST(N'2022-02-14' AS Date), CAST(N'17:35:00' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (12, 6, 4, N'I have some additional information to add to this story', CAST(N'2022-02-14' AS Date), CAST(N'18:12:20' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (13, 7, 4, N'I found this article to be very informative', CAST(N'2022-02-14' AS Date), CAST(N'19:01:10' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (14, 8, 5, N'I completely agree with the author', CAST(N'2022-02-14' AS Date), CAST(N'20:05:30' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (15, 9, 6, N'I think this topic deserves more coverage', CAST(N'2022-02-14' AS Date), CAST(N'21:18:40' AS Time))
INSERT [dbo].[Comment] ([CommentID], [ReaderID], [NewsID], [Content], [Send_Date], [Send_Time]) VALUES (16, 7, 3, N'Thank you for shining a light on this issue', CAST(N'2022-02-14' AS Date), CAST(N'22:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (1, N'Smith', N'Mark', CAST(N'1980-05-10' AS Date), N'Senior editor', N'123 Main St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (2, N'Johnson', N'Rachel', CAST(N'1985-11-20' AS Date), N'Editor', N'456 Oak St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (3, N'Martinez', N'Juan', CAST(N'1978-09-01' AS Date), N'Senior editor', N'789 Maple St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (4, N'Kim', N'Ji-Hyun', CAST(N'1982-03-15' AS Date), N'Editor', N'246 Elm St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (5, N'Singh', N'Amit', CAST(N'1990-12-05' AS Date), N'Senior editor', N'135 Pine St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (6, N'Rodriguez', N'Carla', CAST(N'1988-06-30' AS Date), N'Editor', N'246 Cedar St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (7, N'Chen', N'Yi', CAST(N'1983-02-20' AS Date), N'Senior editor', N'789 Maple St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (8, N'Nguyen', N'Lan', CAST(N'1986-08-01' AS Date), N'Editor', N'123 Oak St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (9, N'Kim', N'Min-Jae', CAST(N'1975-04-10' AS Date), N'Senior editor', N'456 Maple St, Anytown, USA')
INSERT [dbo].[Editor] ([EditorID], [Surname], [Firstname], [Birthday], [Role], [Address]) VALUES (10, N'Wang', N'Wei', CAST(N'1981-11-15' AS Date), N'Editor', N'789 Oak St, Anytown, USA')
GO
SET IDENTITY_INSERT [dbo].[Editor_Email] ON 

INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (1, 1, N'priya.singh@example.com', N'Work')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (2, 1, N'priya.singh.personal@example.com', N'Personal')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (3, 2, N'emily.johnson@example.com', N'Work')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (4, 2, N'emily.johnson.personal@example.com', N'Personal')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (5, 3, N'jose.martinez@example.com', N'Work')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (6, 3, N'jose.martinez.personal@example.com', N'Personal')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (7, 4, N'michael.chen@example.com', N'Work')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (8, 4, N'michael.chen.personal@example.com', N'Personal')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (9, 5, N'sarah.kim@example.com', N'Work')
INSERT [dbo].[Editor_Email] ([EmailID], [EditorID], [Email], [Purpose]) VALUES (10, 5, N'sarah.kim.personal@example.com', N'Personal')
SET IDENTITY_INSERT [dbo].[Editor_Email] OFF
GO
SET IDENTITY_INSERT [dbo].[Editor_Phone] ON 

INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (1, 1, N'123-456-7890', N'mobile')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (2, 2, N'987-654-3210', N'work')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (3, 3, N'555-123-4567', N'home')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (4, 4, N'888-555-1212', N'mobile')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (5, 5, N'777-777-7777', N'work')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (6, 1, N'555-867-5309', N'home')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (7, 2, N'123-123-1234', N'mobile')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (8, 3, N'999-999-9999', N'work')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (9, 4, N'555-444-3333', N'home')
INSERT [dbo].[Editor_Phone] ([PhoneID], [EditorID], [Phone], [Purpose]) VALUES (10, 5, N'111-222-3333', N'mobile')
SET IDENTITY_INSERT [dbo].[Editor_Phone] OFF
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (2, 1, N'COVID-19 cases surge in several states', N'New cases of COVID-19 are being reported in several states.', CAST(N'10:30:00' AS Time), CAST(N'2022-02-10' AS Date), NULL, N'Health officials are urging people to take precautions such as wearing masks and getting vaccinated to help slow the spread of the virus.', N'Centers for Disease Control and Prevention (CDC)', 1200)
INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (3, 2, N'SpaceX launches new satellite', N'SpaceX successfully launched a new satellite into orbit.', CAST(N'15:45:00' AS Time), CAST(N'2022-02-11' AS Date), NULL, N'The satellite will be used for communication purposes and is expected to provide faster and more reliable internet service.', N'SpaceX', 950)
INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (4, 1, N'Apple announces new iPhone lineup', N'Apple has unveiled its latest lineup of iPhones.', CAST(N'11:15:00' AS Time), CAST(N'2022-02-12' AS Date), NULL, N'The new models feature improved cameras and longer battery life.', N'Apple', 1750)
INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (5, 4, N'Climate change linked to extreme weather events', N'A new study suggests that climate change is fueling more extreme weather events.', CAST(N'09:00:00' AS Time), CAST(N'2022-02-13' AS Date), NULL, N'The study found that the frequency and intensity of extreme weather events is on the rise, and that global warming is the likely cause.', N'National Oceanic and Atmospheric Administration (NOAA)', 830)
INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (6, 3, N'Tesla unveils new electric car', N'Tesla has revealed its latest electric car, the Model Y.', CAST(N'14:00:00' AS Time), CAST(N'2022-02-14' AS Date), NULL, N'The Model Y features a sleek design and advanced technology, and is expected to be a popular choice among eco-conscious consumers.', N'Tesla', 1430)
INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (7, 2, N'Amazon announces new delivery drones', N'Amazon has announced the development of new delivery drones.', CAST(N'12:45:00' AS Time), CAST(N'2022-02-15' AS Date), NULL, N'The drones will be faster and more efficient than previous models, and will help Amazon to deliver packages more quickly and reliably.', N'Amazon', 710)
INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (8, 5, N'Study finds link between social media use and depression', N'A new study has found a correlation between social media use and depression.', CAST(N'11:30:00' AS Time), CAST(N'2022-02-16' AS Date), NULL, N'The study suggests that excessive social media use can contribute to feelings of loneliness and sadness.', N'American Psychological Association (APA)', 1220)
INSERT [dbo].[News] ([NewsID], [ReporterID], [Title], [Summary], [PublishTime], [PublishDate], [Picture], [Content], [Sources], [Views]) VALUES (9, 4, N'Researchers develop new cancer treatment', N'Scientists have developed a new cancer treatment that shows promising results.', CAST(N'16:15:00' AS Time), CAST(N'2022-02-17' AS Date), NULL, N'The treatment targets cancer cells while leaving healthy cells unharmed, and could provide a more effective and less invasive option for patients.', N'National Cancer Institute (NCI)', 540)
SET IDENTITY_INSERT [dbo].[News] OFF
GO
SET IDENTITY_INSERT [dbo].[Reader] ON 

INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (1, N'Johnson', N'Michael', N'mjohnson123', N'p@ssword1', N'123 Main St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (2, N'Lee', N'Soo Jin', N'soojinlee', N'p@ssword2', N'456 Oak St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (3, N'Chen', N'Wei', N'wchen', N'p@ssword3', N'789 Maple St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (4, N'Garcia', N'Maria', N'mgarcia1', N'p@ssword4', N'246 Elm St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (5, N'Kumar', N'Raj', N'raj_kumar', N'p@ssword5', N'135 Pine St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (6, N'Nguyen', N'Thi', N'thi_nguyen', N'p@ssword6', N'246 Cedar St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (7, N'Kim', N'Jae Min', N'jaeminkim', N'p@ssword7', N'789 Maple St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (8, N'Gupta', N'Anjali', N'anjali_gupta', N'p@ssword8', N'123 Oak St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (9, N'Wang', N'Wei', N'wei_wang', N'p@ssword9', N'456 Maple St, Anytown, USA')
INSERT [dbo].[Reader] ([ReaderID], [Surname], [Firstname], [Account], [Password], [Address]) VALUES (10, N'Gonzalez', N'Juan', N'jgonzalez', N'p@ssword10', N'789 Oak St, Anytown, USA')
SET IDENTITY_INSERT [dbo].[Reader] OFF
GO
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (1, 2, N'Smith', N'John', CAST(N'1985-05-15' AS Date), N'Senior reporter', N'123 Main St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (2, 2, N'Johnson', N'Emily', CAST(N'1990-12-02' AS Date), N'Reporter', N'456 Oak St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (3, 3, N'Martinez', N'Jose', CAST(N'1988-03-10' AS Date), N'Senior reporter', N'789 Maple St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (4, 3, N'Kim', N'David', CAST(N'1995-09-22' AS Date), N'Reporter', N'246 Elm St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (5, 1, N'Singh', N'Priya', CAST(N'1982-11-01' AS Date), N'Senior reporter', N'135 Pine St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (6, 1, N'Rodriguez', N'Sofia', CAST(N'1993-07-18' AS Date), N'Reporter', N'246 Cedar St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (7, 4, N'Chen', N'Michael', CAST(N'1991-04-27' AS Date), N'Senior reporter', N'789 Maple St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (8, 4, N'Nguyen', N'Linh', CAST(N'1997-02-14' AS Date), N'Reporter', N'123 Oak St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (9, 5, N'Kim', N'Sarah', CAST(N'1989-09-06' AS Date), N'Senior reporter', N'456 Maple St, Anytown, USA')
INSERT [dbo].[Reporter] ([ReporterID], [EditorID], [Surname], [FirstName], [Birthday], [Role], [Address]) VALUES (10, 5, N'Wang', N'Chang', CAST(N'1994-01-23' AS Date), N'Reporter', N'789 Oak St, Anytown, USA')
GO
SET IDENTITY_INSERT [dbo].[Reporter_Email] ON 

INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (1, 1, N'priya.smith@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (2, 2, N'emily.johnson@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (3, 3, N'jose.martinez@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (4, 4, N'david.kim@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (5, 5, N'priya.singh@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (6, 6, N'sofia.rodriguez@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (7, 7, N'michael.chen@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (8, 8, N'linh.nguyen@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (9, 9, N'sarah.kim@example.com', N'Work')
INSERT [dbo].[Reporter_Email] ([EmailID], [ReporterID], [Email], [Purpose]) VALUES (10, 10, N'chang.wang@example.com', N'Work')
SET IDENTITY_INSERT [dbo].[Reporter_Email] OFF
GO
SET IDENTITY_INSERT [dbo].[Reporter_Phone] ON 

INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (1, 1, N'555-1234', N'home')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (2, 1, N'555-5678', N'work')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (3, 2, N'555-4321', N'home')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (4, 2, N'555-8765', N'work')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (5, 3, N'555-1111', N'home')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (6, 4, N'555-2222', N'home')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (7, 5, N'555-3333', N'home')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (8, 6, N'555-4444', N'home')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (9, 7, N'555-5555', N'home')
INSERT [dbo].[Reporter_Phone] ([PhoneID], [ReporterID], [Phone], [Purpose]) VALUES (10, 8, N'555-6666', N'home')
SET IDENTITY_INSERT [dbo].[Reporter_Phone] OFF
GO
SET IDENTITY_INSERT [dbo].[Subcribe] ON 

INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (1, 1, 1, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (2, 2, 1, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (3, 3, 1, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (4, 1, 2, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (5, 2, 2, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (6, 3, 2, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (7, 1, 3, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (8, 2, 3, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (9, 3, 3, CAST(N'2023-02-15' AS Date))
INSERT [dbo].[Subcribe] ([SubcribeID], [CategoryID], [ReaderID], [Send_Date]) VALUES (10, 4, 3, CAST(N'2023-02-15' AS Date))
SET IDENTITY_INSERT [dbo].[Subcribe] OFF
GO
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (7, 2)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (3, 4)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (2, 1)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (3, 3)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (9, 2)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (4, 3)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (5, 1)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (6, 2)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (7, 3)
INSERT [dbo].[Tag] ([NewsId], [CategoryID]) VALUES (8, 4)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Reader__B0C3AC462BF926F2]    Script Date: 2/26/2023 3:08:09 PM ******/
ALTER TABLE [dbo].[Reader] ADD UNIQUE NONCLUSTERED 
(
	[Account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Reporter_Editor]    Script Date: 2/26/2023 3:08:09 PM ******/
CREATE NONCLUSTERED INDEX [idx_Reporter_Editor] ON [dbo].[Reporter]
(
	[EditorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Approve]  WITH CHECK ADD  CONSTRAINT [FK_Approve_News] FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
GO
ALTER TABLE [dbo].[Approve] CHECK CONSTRAINT [FK_Approve_News]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_CategoryID_ParentID] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_CategoryID_ParentID]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_News] FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_News]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Reader] FOREIGN KEY([ReaderID])
REFERENCES [dbo].[Reader] ([ReaderID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Reader]
GO
ALTER TABLE [dbo].[Editor_Email]  WITH CHECK ADD  CONSTRAINT [FK_Editor_Email] FOREIGN KEY([EditorID])
REFERENCES [dbo].[Editor] ([EditorID])
GO
ALTER TABLE [dbo].[Editor_Email] CHECK CONSTRAINT [FK_Editor_Email]
GO
ALTER TABLE [dbo].[Editor_Phone]  WITH CHECK ADD  CONSTRAINT [FK_Editor_Phone] FOREIGN KEY([EditorID])
REFERENCES [dbo].[Editor] ([EditorID])
GO
ALTER TABLE [dbo].[Editor_Phone] CHECK CONSTRAINT [FK_Editor_Phone]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Editor] FOREIGN KEY([ReporterID])
REFERENCES [dbo].[Reporter] ([ReporterID])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Editor]
GO
ALTER TABLE [dbo].[Reporter]  WITH CHECK ADD  CONSTRAINT [FK_Editor_Reporter] FOREIGN KEY([EditorID])
REFERENCES [dbo].[Editor] ([EditorID])
GO
ALTER TABLE [dbo].[Reporter] CHECK CONSTRAINT [FK_Editor_Reporter]
GO
ALTER TABLE [dbo].[Reporter_Email]  WITH CHECK ADD  CONSTRAINT [FK_Reporter_Email] FOREIGN KEY([ReporterID])
REFERENCES [dbo].[Reporter] ([ReporterID])
GO
ALTER TABLE [dbo].[Reporter_Email] CHECK CONSTRAINT [FK_Reporter_Email]
GO
ALTER TABLE [dbo].[Reporter_Phone]  WITH CHECK ADD FOREIGN KEY([ReporterID])
REFERENCES [dbo].[Reporter] ([ReporterID])
GO
ALTER TABLE [dbo].[Reporter_Phone]  WITH CHECK ADD  CONSTRAINT [FK_Reporter_Phone] FOREIGN KEY([ReporterID])
REFERENCES [dbo].[Reporter] ([ReporterID])
GO
ALTER TABLE [dbo].[Reporter_Phone] CHECK CONSTRAINT [FK_Reporter_Phone]
GO
ALTER TABLE [dbo].[Subcribe]  WITH CHECK ADD  CONSTRAINT [FK_Subcribe_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Subcribe] CHECK CONSTRAINT [FK_Subcribe_Category]
GO
ALTER TABLE [dbo].[Subcribe]  WITH CHECK ADD  CONSTRAINT [FK_Subcribe_Reader] FOREIGN KEY([ReaderID])
REFERENCES [dbo].[Reader] ([ReaderID])
GO
ALTER TABLE [dbo].[Subcribe] CHECK CONSTRAINT [FK_Subcribe_Reader]
GO
ALTER TABLE [dbo].[Tag]  WITH CHECK ADD  CONSTRAINT [FK_Category_Tag] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Tag] CHECK CONSTRAINT [FK_Category_Tag]
GO
ALTER TABLE [dbo].[Tag]  WITH CHECK ADD  CONSTRAINT [FK_News_Tag] FOREIGN KEY([NewsId])
REFERENCES [dbo].[News] ([NewsID])
GO
ALTER TABLE [dbo].[Tag] CHECK CONSTRAINT [FK_News_Tag]
GO
/****** Object:  StoredProcedure [dbo].[MostActiveReporter]    Script Date: 2/26/2023 3:08:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MostActiveReporter]
AS
BEGIN
    DECLARE @mostActive INT
    SELECT TOP 1 @mostActive = ReporterID
    FROM
    (
        SELECT ReporterID, COUNT(ReporterID) AS NumberOfNews
        FROM 
        (
            SELECT News.Title, Reporter.ReporterID
            FROM News 
            JOIN Reporter ON News.ReporterID = Reporter.ReporterID
        ) AS TEMP
        GROUP BY ReporterID
    ) AS TEMP2
    ORDER BY NumberOfNews DESC
    RETURN (@mostActive)
END
GO
/****** Object:  StoredProcedure [dbo].[MostWritingReporter]    Script Date: 2/26/2023 3:08:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MostWritingReporter]
AS
BEGIN
    DECLARE @mostActive INT
    SELECT TOP 1 @mostActive = ReporterID
    FROM
    (
        SELECT ReporterID, COUNT(ReporterID) AS NumberOfNews
        FROM 
        (
            SELECT News.Title, Reporter.ReporterID
            FROM News 
            JOIN Reporter ON News.ReporterID = Reporter.ReporterID
        ) AS TEMP
        GROUP BY ReporterID
    ) AS TEMP2
    ORDER BY NumberOfNews DESC
    SELECT @mostActive
    RETURN (@mostActive)
END
GO
/****** Object:  StoredProcedure [dbo].[Subcription_Of_Reader]    Script Date: 2/26/2023 3:08:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Subcription_Of_Reader] 
    @FIRSTDATE DATE, 
    @ENDDATE DATE ,
    @READER INT
AS 
BEGIN
    SELECT * 
    FROM Subcribe
    WHERE (Send_Date BETWEEN @FIRSTDATE AND @ENDDATE)
    AND ReaderID = @READER
END;
GO
USE [master]
GO
ALTER DATABASE [ENews] SET  READ_WRITE 
GO
