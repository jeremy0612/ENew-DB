-- ===== Create new database named ENEW =======
CREATE DATABASE ENews;
-- ============================================
-- ===== Create News table ===================
BEGIN TRANSACTION
    CREATE TABLE News 
    (
        NewsID INT PRIMARY KEY IDENTITY(1,1),
        ReporterID INT ,
        EditorID INT  ,
        Title NVARCHAR(100) NOT NULL,
        Summary NVARCHAR(500) NOT NULL,
        PublishTime TIME NOT NULL,
        PublishDate DATE NOT NULL,
        Picture VARBINARY(MAX),
        Content NVARCHAR(MAX) NOT NULL,
        Sources NVARCHAR(200),
        Views INT NOT NULL
    );
IF(@@ERROR <> 0)
    ROLLBACK TRANSACTION
COMMIT TRANSACTION
-- ========================================
-- ========== Create table Reporter========
BEGIN TRANSACTION
    CREATE TABLE Reporter 
    (
        ReporterID INT PRIMARY KEY,
        EditorID INT ,
        Surname NVARCHAR(50) NOT NULL,
        FirstName NVARCHAR(50) NOT NULL,
        Birthday DATE,
        Role NVARCHAR(50),
        Address NVARCHAR(100)
    );
IF(@@ERROR <> 0)
    ROLLBACK TRANSACTION
COMMIT TRAN
-- ====================================
-- =========== Create Approve table====
CREATE TABLE Approve
(
    EditorID INT ,
    NewsID INT ,
    Approve_Date DATE,
    Approve_Time TIME
);
-- ======== Create Editor table =======
CREATE TABLE Editor
(
    EditorID INT PRIMARY KEY,
    Surname NVARCHAR(50) NOT NULL,
    Firstname NVARCHAR(50) NOT NULL,
    Birthday DATE NOT NULL,
    Role NVARCHAR(50) NOT NULL,
    Address NVARCHAR(100) NOT NULL
);
-- ===================================
-- ==== Create Editor's email table ==
CREATE TABLE Editor_Email
(
    EmailID INT PRIMARY KEY IDENTITY(1,1),
    EditorID INT ,
    Email NVARCHAR(100) NOT NULL,
    Purpose NVARCHAR(10)
);
-- ==== Create Editor's phone table ==
CREATE TABLE Editor_Phone 
(
    PhoneID INT PRIMARY KEY IDENTITY(1,1),
    EditorID INT,
    Phone VARCHAR(12) NOT NULL,
    Purpose VARCHAR(10) NOT NULL,
);
-- ==== Create Reporter's phone table ==
CREATE TABLE Reporter_Phone
(
    PhoneID INT PRIMARY KEY IDENTITY(1,1),
    ReporterID INT FOREIGN KEY REFERENCES Reporter(ReporterID),
    Phone VARCHAR(12) NOT NULL,
    Purpose VARCHAR(10) NOT NULL
)
-- ==== Create Reporter's email table ==
CREATE TABLE Reporter_Email
(
    EmailID INT PRIMARY KEY IDENTITY(1,1),
    ReporterID INT,
    Email NVARCHAR(100) NOT NULL,
    Purpose NVARCHAR(10) NOT NULL
);
-- ======================================
-- ========== Create Reader Table =======
CREATE TABLE Reader
(
    ReaderID INT PRIMARY KEY IDENTITY(1,1),
    Surname NVARCHAR(50) NOT NULL,
    Firstname NVARCHAR(50) NOT NULL,
    Account NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Address NVARCHAR(100) NOT NULL
);
-- ======================================
-- ======= Create Comment table =========
CREATE TABLE Comment 
(
    CommentID INT PRIMARY KEY IDENTITY(1,1),
    ReaderID INT ,
    NewsID INT ,
    Content NVARCHAR(500) NOT NULL,
    Send_Date DATE NOT NULL,
    Send_Time TIME NOT NULL
);
-- ====== Create Subcribe table =========
CREATE TABLE Subcribe
(
  SubcribeID INT PRIMARY KEY IDENTITY(1,1),
  CategoryID INT NOT NULL,
  ReaderID INT NOT NULL,
  Send_Date DATE NOT NULL
);
-- ======== Create tag table ============
CREATE TABLE Tag 
(
    NewsID INT,
    CategoryID INT
);
-- ========= Create Category table =====
CREATE TABLE Category 
(
    CategoryId INT PRIMARY KEY,
    ParentID INT,
    Name NVARCHAR(100) NOT NULL
);

-- ===============  REFERENCING ==========

-- === Self Referencing category Table ===
ALTER TABLE Category
ADD CONSTRAINT FK_CategoryID_ParentID FOREIGN KEY (ParentID)  REFERENCES Category(CategoryID);

-- === FK Referencing tag Table ===
ALTER TABLE Tag
ADD CONSTRAINT FK_Category_Tag FOREIGN KEY (CategoryID)  REFERENCES Category(CategoryID);
ALTER TABLE Tag
ADD CONSTRAINT FK_News_Tag FOREIGN KEY (NewsID)  REFERENCES News(NewsID);

-- === FK Referencing Subcribe Table ===
ALTER TABLE Subcribe
ADD CONSTRAINT FK_Subcribe_Category FOREIGN KEY (CategoryID)  REFERENCES Category(CategoryID);
ALTER TABLE Subcribe
ADD CONSTRAINT FK_Subcribe_Reader FOREIGN KEY (ReaderID)  REFERENCES Reader(ReaderID);

-- === FK Referencing Comment Table ===
ALTER TABLE Comment
ADD CONSTRAINT FK_Comment_Reader FOREIGN KEY (ReaderID)  REFERENCES Reader(ReaderID);
ALTER TABLE Comment
ADD CONSTRAINT FK_Comment_News FOREIGN KEY (NewsID)  REFERENCES News(NewsID);

-- === FK Referencing Comment Table ===
ALTER TABLE Comment
ADD CONSTRAINT FK_Comment_Reader FOREIGN KEY (ReaderID)  REFERENCES Reader(ReaderID);
ALTER TABLE Comment
ADD CONSTRAINT FK_Comment_News FOREIGN KEY (NewsID)  REFERENCES News(NewsID);

-- === Relation  Approve between Editor and News ===
ALTER TABLE Approve
ADD CONSTRAINT FK_Approve_News FOREIGN KEY (NewsID)  REFERENCES News(NewsID);
ALTER TABLE Approve
ADD CONSTRAINT FK_Approve_Editor FOREIGN KEY (EditorID)  REFERENCES Editor(EditorID);

-- === Relation between Reporter and News ===
ALTER TABLE News
ADD CONSTRAINT FK_News_Editor FOREIGN KEY (ReporterID)  REFERENCES Reporter(ReporterID);

-- === FK Referencing Reporter Table ===
ALTER TABLE Reporter_Email
ADD CONSTRAINT FK_Reporter_Email FOREIGN KEY (ReporterID)  REFERENCES Reporter(ReporterID);
ALTER TABLE Reporter_Phone
ADD CONSTRAINT FK_Reporter_Phone FOREIGN KEY (ReporterID)  REFERENCES Reporter(ReporterID);

-- === FK Referencing Editor Table ===
ALTER TABLE Editor_Email
ADD CONSTRAINT FK_Editor_Email FOREIGN KEY (EditorID)  REFERENCES Editor(EditorID);
ALTER TABLE Editor_Phone
ADD CONSTRAINT FK_Editor_Phone FOREIGN KEY (EditorID)  REFERENCES Editor(EditorID);

-- === Manage relation between editor and reporter ===
ALTER TABLE Reporter
ADD CONSTRAINT FK_Editor_Reporter FOREIGN KEY (EditorID)  REFERENCES Editor(EditorID);





