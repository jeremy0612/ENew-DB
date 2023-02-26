-- Editor
INSERT INTO Editor (EditorID, Surname, Firstname, Birthday, Role, Address)
VALUES
(1, 'Smith', 'Mark', '1980-05-10', 'Senior editor', '123 Main St, Anytown, USA'),
(2, 'Johnson', 'Rachel', '1985-11-20', 'Editor', '456 Oak St, Anytown, USA'),
(3, 'Martinez', 'Juan', '1978-09-01', 'Senior editor', '789 Maple St, Anytown, USA'),
(4, 'Kim', 'Ji-Hyun', '1982-03-15', 'Editor', '246 Elm St, Anytown, USA'),
(5, 'Singh', 'Amit', '1990-12-05', 'Senior editor', '135 Pine St, Anytown, USA'),
(6, 'Rodriguez', 'Carla', '1988-06-30', 'Editor', '246 Cedar St, Anytown, USA'),
(7, 'Chen', 'Yi', '1983-02-20', 'Senior editor', '789 Maple St, Anytown, USA'),
(8, 'Nguyen', 'Lan', '1986-08-01', 'Editor', '123 Oak St, Anytown, USA'),
(9, 'Kim', 'Min-Jae', '1975-04-10', 'Senior editor', '456 Maple St, Anytown, USA'),
(10, 'Wang', 'Wei', '1981-11-15', 'Editor', '789 Oak St, Anytown, USA');
-- reporter
INSERT INTO Reporter (ReporterID, EditorID, Surname, FirstName, Birthday, Role, Address)
VALUES 
(1, 2, 'Smith', 'John', '1985-05-15', 'Senior reporter', '123 Main St, Anytown, USA'),
(2, 2, 'Johnson', 'Emily', '1990-12-02', 'Reporter', '456 Oak St, Anytown, USA'),
(3, 3, 'Martinez', 'Jose', '1988-03-10', 'Senior reporter', '789 Maple St, Anytown, USA'),
(4, 3, 'Kim', 'David', '1995-09-22', 'Reporter', '246 Elm St, Anytown, USA'),
(5, 1, 'Singh', 'Priya', '1982-11-01', 'Senior reporter', '135 Pine St, Anytown, USA'),
(6, 1, 'Rodriguez', 'Sofia', '1993-07-18', 'Reporter', '246 Cedar St, Anytown, USA'),
(7, 4, 'Chen', 'Michael', '1991-04-27', 'Senior reporter', '789 Maple St, Anytown, USA'),
(8, 4, 'Nguyen', 'Linh', '1997-02-14', 'Reporter', '123 Oak St, Anytown, USA'),
(9, 5, 'Kim', 'Sarah', '1989-09-06', 'Senior reporter', '456 Maple St, Anytown, USA'),
(10, 5, 'Wang', 'Chang', '1994-01-23', 'Reporter', '789 Oak St, Anytown, USA');
-- News
INSERT INTO News (ReporterID, EditorID, Title, Summary, PublishTime, PublishDate, Picture, Content, Sources, Views) VALUES
(1, 1, 'COVID-19 cases surge in several states', 'New cases of COVID-19 are being reported in several states.', '10:30:00', '2022-02-10', NULL, 'Health officials are urging people to take precautions such as wearing masks and getting vaccinated to help slow the spread of the virus.', 'Centers for Disease Control and Prevention (CDC)', 1200),
(2, 2, 'SpaceX launches new satellite', 'SpaceX successfully launched a new satellite into orbit.', '15:45:00', '2022-02-11', NULL, 'The satellite will be used for communication purposes and is expected to provide faster and more reliable internet service.', 'SpaceX', 950),
(1, 3, 'Apple announces new iPhone lineup', 'Apple has unveiled its latest lineup of iPhones.', '11:15:00', '2022-02-12', NULL, 'The new models feature improved cameras and longer battery life.', 'Apple', 1750),
(4, 2, 'Climate change linked to extreme weather events', 'A new study suggests that climate change is fueling more extreme weather events.', '9:00:00', '2022-02-13', NULL, 'The study found that the frequency and intensity of extreme weather events is on the rise, and that global warming is the likely cause.', 'National Oceanic and Atmospheric Administration (NOAA)', 830),
(3, 1, 'Tesla unveils new electric car', 'Tesla has revealed its latest electric car, the Model Y.', '14:00:00', '2022-02-14', NULL, 'The Model Y features a sleek design and advanced technology, and is expected to be a popular choice among eco-conscious consumers.', 'Tesla', 1430),
(2, 3, 'Amazon announces new delivery drones', 'Amazon has announced the development of new delivery drones.', '12:45:00', '2022-02-15', NULL, 'The drones will be faster and more efficient than previous models, and will help Amazon to deliver packages more quickly and reliably.', 'Amazon', 710),
(5, 2, 'Study finds link between social media use and depression', 'A new study has found a correlation between social media use and depression.', '11:30:00', '2022-02-16', NULL, 'The study suggests that excessive social media use can contribute to feelings of loneliness and sadness.', 'American Psychological Association (APA)', 1220),
(4, 1, 'Researchers develop new cancer treatment', 'Scientists have developed a new cancer treatment that shows promising results.', '16:15:00', '2022-02-17', NULL, 'The treatment targets cancer cells while leaving healthy cells unharmed, and could provide a more effective and less invasive option for patients.', 'National Cancer Institute (NCI)', 540);

-- Approve
INSERT INTO Approve (EditorID, NewsID, Approve_Date, Approve_Time)
VALUES
(1, 2, '2022-02-10', '11:15:00'),
(2, 2, '2022-02-11', '16:30:00'),
(3, 3, '2022-02-12', '10:45:00'),
(2, 4, '2022-02-13', '9:30:00'),
(1, 5, '2022-02-14', '14:45:00'),
(3, 6, '2022-02-15', '13:00:00'),
(2, 7, '2022-02-16', '12:30:00'),
(1, 8, '2022-02-17', '17:00:00');
-- Editor_Email
INSERT INTO Editor_Email (EditorID, Email, Purpose)
VALUES
    (1, 'priya.singh@example.com', 'Work'),
    (1, 'priya.singh.personal@example.com', 'Personal'),
    (2, 'emily.johnson@example.com', 'Work'),
    (2, 'emily.johnson.personal@example.com', 'Personal'),
    (3, 'jose.martinez@example.com', 'Work'),
    (3, 'jose.martinez.personal@example.com', 'Personal'),
    (4, 'michael.chen@example.com', 'Work'),
    (4, 'michael.chen.personal@example.com', 'Personal'),
    (5, 'sarah.kim@example.com', 'Work'),
    (5, 'sarah.kim.personal@example.com', 'Personal');
-- Editor_ Phone
INSERT INTO Editor_Phone (EditorID, Phone, Purpose)
VALUES 
(1, '123-456-7890', 'mobile'),
(2, '987-654-3210', 'work'),
(3, '555-123-4567', 'home'),
(4, '888-555-1212', 'mobile'),
(5, '777-777-7777', 'work'),
(1, '555-867-5309', 'home'),
(2, '123-123-1234', 'mobile'),
(3, '999-999-9999', 'work'),
(4, '555-444-3333', 'home'),
(5, '111-222-3333', 'mobile');
-- reporter_phone
INSERT INTO Reporter_Phone (ReporterID, Phone, Purpose)
VALUES 
    (1, '555-1234', 'home'),
    (1, '555-5678', 'work'),
    (2, '555-4321', 'home'),
    (2, '555-8765', 'work'),
    (3, '555-1111', 'home'),
    (4, '555-2222', 'home'),
    (5, '555-3333', 'home'),
    (6, '555-4444', 'home'),
    (7, '555-5555', 'home'),
    (8, '555-6666', 'home');
-- Reporter EMail
INSERT INTO Reporter_Email (ReporterID, Email, Purpose)
VALUES 
    (1, 'priya.smith@example.com', 'Work'),
    (2, 'emily.johnson@example.com', 'Work'),
    (3, 'jose.martinez@example.com', 'Work'),
    (4, 'david.kim@example.com', 'Work'),
    (5, 'priya.singh@example.com', 'Work'),
    (6, 'sofia.rodriguez@example.com', 'Work'),
    (7, 'michael.chen@example.com', 'Work'),
    (8, 'linh.nguyen@example.com', 'Work'),
    (9, 'sarah.kim@example.com', 'Work'),
    (10, 'chang.wang@example.com', 'Work');
-- Reader
INSERT INTO Reader (Surname, Firstname, Account, Password, Address)
VALUES 
('Johnson', 'Michael', 'mjohnson123', 'p@ssword1', '123 Main St, Anytown, USA'),
('Lee', 'Soo Jin', 'soojinlee', 'p@ssword2', '456 Oak St, Anytown, USA'),
('Chen', 'Wei', 'wchen', 'p@ssword3', '789 Maple St, Anytown, USA'),
('Garcia', 'Maria', 'mgarcia1', 'p@ssword4', '246 Elm St, Anytown, USA'),
('Kumar', 'Raj', 'raj_kumar', 'p@ssword5', '135 Pine St, Anytown, USA'),
('Nguyen', 'Thi', 'thi_nguyen', 'p@ssword6', '246 Cedar St, Anytown, USA'),
('Kim', 'Jae Min', 'jaeminkim', 'p@ssword7', '789 Maple St, Anytown, USA'),
('Gupta', 'Anjali', 'anjali_gupta', 'p@ssword8', '123 Oak St, Anytown, USA'),
('Wang', 'Wei', 'wei_wang', 'p@ssword9', '456 Maple St, Anytown, USA'),
('Gonzalez', 'Juan', 'jgonzalez', 'p@ssword10', '789 Oak St, Anytown, USA');
-- Comment
INSERT INTO Comment (ReaderID, NewsID, Content, Send_Date, Send_Time)
VALUES 
    (1, 6, 'Great article!', '2022-02-14', '13:45:00'),
    (2, 4, 'I disagree with some of the points made in this article', '2022-02-14', '14:02:30'),
    (3, 2, 'This is an important issue that needs more attention', '2022-02-14', '15:17:45'),
    (4, 3, 'I appreciate the balanced perspective presented in this article', '2022-02-14', '16:23:15'),
    (5, 3, 'This is an excellent piece of journalism', '2022-02-14', '17:35:00'),
    (6, 4, 'I have some additional information to add to this story', '2022-02-14', '18:12:20'),
    (7, 4, 'I found this article to be very informative', '2022-02-14', '19:01:10'),
    (8, 5, 'I completely agree with the author', '2022-02-14', '20:05:30'),
    (9, 6, 'I think this topic deserves more coverage', '2022-02-14', '21:18:40'),
    (7, 3, 'Thank you for shining a light on this issue', '2022-02-14', '22:00:00');
-- Category
INSERT INTO Category (CategoryId, ParentID, Name)
VALUES
    (1, NULL, 'Technology'),
    (2, NULL, 'Sports'),
    (3, NULL, 'Politics'),
    (4, NULL, 'Entertainment'),
    (5, 1, 'Hardware'),
    (6, 1, 'Software'),
    (7, 2, 'Football'),
    (8, 2, 'Basketball'),
    (9, 3, 'Elections'),
    (10, 4, 'Movies');
-- Tag
INSERT INTO Tag (NewsID, CategoryID)
VALUES 
    (7, 2),
    (3, 4),
    (2, 1),
    (3, 3),
    (9, 2),
    (4, 3),
    (5, 1),
    (6, 2),
    (7, 3),
    (8, 4);
-- Subcribe
INSERT INTO Subcribe (CategoryID, ReaderID, Send_Date)
VALUES 
(1, 1, '2023-02-15'),
(2, 1, '2023-02-15'),
(3, 1, '2023-02-15'),
(1, 2, '2023-02-15'),
(2, 2, '2023-02-15'),
(3, 2, '2023-02-15'),
(1, 3, '2023-02-15'),
(2, 3, '2023-02-15'),
(3, 3, '2023-02-15'),
(4, 3, '2023-02-15');



















