Use Food
GO
DROP TABLE dbo.Recipes
DROP TABLE dbo.Ingredients
DROP TABLE dbo.Users
DROP TABLE dbo.Publisher
DROP TABLE dbo.Comments
DROP TABLE dbo.RecipeIngredient
DROP TABLE dbo.RecipeSubFoodCategories
DROP TABLE dbo.FoodCategories
DROP TABLE City
DROP TABLE Answers
DROP TABLE Log
DROP TABLE SpecializeIn
DROP TABLE Questions


-- Ingredients
create table Ingredients (
IngredientID smallint check(IngredientID > 0) primary key,
IngredientName varchar(20) not null UNIQUE,
Calories SMALLINT CHECK (Calories BETWEEN 1 AND 1000),
)
-- FoodCatagories
create table FoodCategories (
FoodCategoryID smallint check(FoodCategoryID > 0) primary key,
FoodCategoryName varchar(20) not null unique
)
--City
CREATE TABLE City (
CityNum SMALLINT CHECK(CityNum>0) PRIMARY KEY,
CityName VARCHAR(20)NOT NULL unique
)
-- User
create table Users(
    UserID smallint check(UserID>0),
	email VARCHAR(20) NOT NULL,
   -- RecipeID smallint references Recipes(RecipeID),
    Birthdate dateTime not null,
    CityNum SMALLINT NOT null,
    FirstName varchar(30) not null,
    LastName varchar(30) not NULL, 
	Gender char(1)check(Gender in('M','F')) NOT NULL,
	password VARCHAR(20),
	userType VARCHAR(20),
	PRIMARY KEY (UserID),
	FOREIGN KEY (CityNum) REFERENCES City(CityNum), 
	);

-- Publisher
create table Publisher(
PublisherID smallint REFERENCES Users(UserID),
FirstName varchar(30) not null,
LastName varchar(30) not NULL,
totalRecipes smallint not NULL,
Primary key(PublisherID)
)
-- Comments
create table Comments (
UserID smallint references Users(UserID),
CommentDate dateTime,
Rating tinyint check(Rating between 1 and 5),
RecipeID smallint,
PRIMARY KEY (UserID, CommentDate)
)
-- RecipeSubFoodCategories
create table RecipeSubFoodCategories (
RecipeSubFoodCategoryID SMALLINT PRIMARY KEY,
FoodCategoryID smallint references FoodCategories(FoodCategoryID)
)
-- Recipes
create table Recipes (
RecipeID smallint check(RecipeID>0),
PublisherID smallint references Publisher(PublisherID),
SubFoodCategoryID SMALLINT REFERENCES RecipeSubFoodCategories(RecipeSubFoodCategoryID),
CommentDate DATETIME ,
UserID SMALLINT,
Title varchar(20) check(len(Title) >= 0) not null,
Description varchar(500) check(len(Description) >= 0) not null,
TotalTime float check(TotalTime >0) not null,
[Type] VARCHAR(10) check(Type in('starter','dish', 'dessert')) NOT NULL,
[Level] VARCHAR(10) check(Level in('easy','medium', 'hard')) NOT NULL,
PublicationDate dateTime,
constraint [Fk_B_01] foreign key (UserID,CommentDate) references Comments(UserID,CommentDate),
Primary key(RecipeID)
)
-- RecipesIngredients
create TABLE RecipeIngredient(
RecipeID smallint references Recipes(RecipeID),
IngredientID smallint references Ingredients(IngredientID),
PublisherID smallint references Publisher(PublisherID),
SubFoodCategoryID SMALLINT REFERENCES RecipeSubFoodCategories(RecipeSubFoodCategoryID),
CommentDate DATETIME,
UserID SMALLINT,
Amount SMALLINT CHECK(Amount >0 ) ,
constraint [Fk_B_02] foreign key (UserID,CommentDate) references Comments(UserID,CommentDate),
constraint [Fk_B_03] foreign key (RecipeID) references Recipes(RecipeID),
PRIMARY KEY(RecipeID,IngredientID)
)
--specialize in
CREATE TABLE SpecializeIn(
PublisherID smallint REFERENCES Publisher(PublisherID),
CategorieID SMALLINT REFERENCES FoodCategories(FoodCategoryID),
PRIMARY KEY (PublisherID, CategorieID)
)

-- Questions
	CREATE TABLE Questions (
	questionNum INTEGER NOT NULL,
	qusetion VARCHAR(50) NOT NULL,
	PRIMARY KEY (questionNum));

	-- Answers
	CREATE TABLE Answers (
	answer VARCHAR(50) NOT NULL,
	email VARCHAR(20) NOT NULL,
	questionNum INTEGER NOT NULL,
	UserID smallint check(UserID>0),
	FOREIGN KEY (questionNum) REFERENCES Questions (questionNum),
	FOREIGN KEY (UserID) REFERENCES Users (UserID)
	);

	-- Log
	CREATE TABLE Log (
	isSuccessLogin BIT NOT NULL,
	loginTime DATETIME NOT NULL, 
	email VARCHAR(20),
	StatusLogin VARCHAR(20),
	PRIMARY KEY (email, loginTime),
	);





	
	

	
INSERT INTO Questions (questionNum, qusetion) VALUES (1, 'What is your mother name?');
INSERT INTO Questions (questionNum, qusetion) VALUES (2, 'What is your father name?');
INSERT INTO Questions (questionNum, qusetion) VALUES (3, 'What is your dog name?');
INSERT INTO Questions (questionNum, qusetion) VALUES (4, 'What is your teacher name?');
INSERT INTO Questions (questionNum, qusetion) VALUES (5, 'What is your favorit color?');
INSERT INTO Questions (questionNum, qusetion) VALUES (6, 'What is your hobit?');

INSERT INTO Answers (UserID, answer, email, questionNum) VALUES ('123', 'Ruti', 'ori@gmail.com', 1);
INSERT INTO Answers (UserID, answer, email, questionNum) VALUES ('234', 'Hezi', 'matan@gmail.com', 2);
INSERT INTO Answers (UserID, answer, email, questionNum) VALUES ('234', 'joy', 'matan@gmail.com', 3);
INSERT INTO Answers (UserID, answer, email, questionNum) VALUES ('234', 'noy', 'matan@gmail.com', 4);
INSERT INTO Answers (UserID, answer, email, questionNum) VALUES ('234', 'green', 'matan@gmail.com', 5);


	INSERT INTO Log (loginTime, email, isSuccessLogin) VALUES (CONVERT(datetime, '1995-02-07 10:33:09'), 'ori@gmail.com', 0);
	INSERT INTO Log (loginTime, email, isSuccessLogin) VALUES (CONVERT(datetime, '1995-02-07 10:34:09'), 'ori@gmail.com', 1);
	INSERT INTO Log (loginTime, email, isSuccessLogin) VALUES (CONVERT(datetime, '2022-07-29 16:01:09'), 'ori@gmail.com', 0);
	INSERT INTO Log (loginTime, email, isSuccessLogin) VALUES (CONVERT(datetime, '2022-07-29 16:00:09'), 'ori@gmail.com', 0);
	INSERT INTO Log (loginTime, email, isSuccessLogin) VALUES (CONVERT(datetime, '2022-07-29 16:02:09'), 'ori@gmail.com', 0);
	INSERT INTO Log (loginTime, email, isSuccessLogin) VALUES (CONVERT(datetime, '2022-07-29 16:01:12'), 'ori@gmail.com', 1);

	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-21 19:49:15'), 'ori@gmail.com', 0,'Fail');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-22 19:49:09'), 'nir@gmail.com', 0,'Block');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-22 19:48:09'), 'nir@gmail.com', 0,'Block');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-21 19:49:12'), 'ori@gmail.com', 1,'Success');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-22 19:48:09'), 'matan@gmail.com', 0,'Block');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-22 19:48:13'), 'nir@gmail.com', 0,'Block');

	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-07-24 16:01:12'), 'matan@gmail.com', 0,'Success');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-07-24 16:05:12'), 'nir@gmail.com', 1,'Success');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-26 12:52:00'), 'matan@gmail.com', 0,'Block');
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, '2022-08-26 12:52:00'), 'nir@gmail.com', 0,'Block');
	




 DROP PROCEDURE UpdateStatusLogin

	CREATE PROCEDURE UpdateStatusLogin
	@email VARCHAR(20), @pass VARCHAR(20)
	AS
	DECLARE @isSuccessLogin AS BIT;
	DECLARE @isBlocked AS BIT;
	DECLARE @isLoggedIn AS BIT;
	DECLARE @numOfTries AS INT;
	DECLARE @tmpTbl AS TABLE (isLogged BIT);
	
	
	SELECT TOP 1 @numOfTries =
	(
		SELECT COUNT(*)
		FROM Log
		WHERE isSuccessLogin = 0 AND email = @email AND DATEDIFF(minute, loginTime, CURRENT_TIMESTAMP) <= 3
	)
	PRINT @numOfTries
	
	
	SELECT TOP 1 @isSuccessLogin =
	(
		SELECT CASE WHEN EXISTS( 
			SELECT *
			FROM Users as U
			WHERE U.email = @email AND U.password = @pass
		)
		THEN 1 --'True'
		ELSE 0 --'False'
		END AS isSuccessLogin
	)
	PRINT @isSuccessLogin

	

	
	SELECT TOP 1 @isBlocked =
	(
		SELECT COUNT(*)
		FROM LOG
		WHERE email = @email AND StatusLogin = 'Block' AND DATEDIFF(minute, loginTime, CURRENT_TIMESTAMP) < 20
	)

	
	IF (@isSuccessLogin = 1 AND @isBlocked < 1 ) 
		INSERT INTO Log(loginTime, email, StatusLogin, isSuccessLogin)
		VALUES(CURRENT_TIMESTAMP , @email, 'Success', @isSuccessLogin);

	-- Success
	ELSE IF (@isSuccessLogin = 1 AND @numOfTries < 3) 
		INSERT INTO Log(loginTime, email, StatusLogin, isSuccessLogin)
		VALUES(CURRENT_TIMESTAMP , @email, 'Success', @isSuccessLogin);

	-- Fail
	ELSE IF (@isSuccessLogin = 0 AND @numOfTries < 3)
		INSERT INTO Log(loginTime, email, StatusLogin, isSuccessLogin)
		VALUES(CURRENT_TIMESTAMP , @email, 'Fail', @isSuccessLogin);

	-- Block
	ELSE IF (@isSuccessLogin = 0 AND @numOfTries >= 3)
		INSERT INTO Log(loginTime, email, StatusLogin, isSuccessLogin)
		VALUES(CURRENT_TIMESTAMP , @email, 'Block', @isSuccessLogin);
	GO

	EXEC UpdateStatusLogin @UserID='1111',@pass='1234';

	DROP PROCEDURE GetIsSuccessLogin

 CREATE PROCEDURE GetIsSuccessLogin @email VARCHAR(20)
 AS
 DECLARE @isSuccessLoginVar AS VARCHAR(20);
 SET @isSuccessLoginVar = 'Block'
 SELECT @isSuccessLoginVar = L.StatusLogin
 FROM Log L 
 WHERE StatusLogin = 'Success' AND DATEDIFF(SECOND, loginTime, CURRENT_TIMESTAMP) < 30 AND L.email = @email

 IF (@isSuccessLoginVar != 'Success') 
	INSERT INTO Log (loginTime, email, isSuccessLogin,StatusLogin) VALUES (CONVERT(datetime, CURRENT_TIMESTAMP), @email, 1,'Success');

PRINT @isSuccessLoginVar
 GO

 EXEC GetIsSuccessLogin @UserID='1111';


DROP PROCEDURE AllBlockedUsers

 CREATE PROCEDURE AllBlockedUsers @email VARCHAR (20)
 AS
 SELECT distinct L.email 
 FROM Log L inner join Users U ON L.email=U.email
 WHERE StatusLogin = 'Block' AND DATEDIFF(minute, loginTime, CURRENT_TIMESTAMP) < 20 AND U.email != @email
 GO



DROP PROCEDURE GetDateTimeofUsers

 CREATE PROCEDURE GetDateTimeofUsers @email VARCHAR (20)
 AS
 SELECT L.email,MAX(L.loginTime) AS max_date
 FROM Log L
 WHERE  StatusLogin = 'Success'
 GROUP BY L.email
 GO

  EXEC GetDateTimeofUsers @UserID='1111';


DROP PROCEDURE GetUserLoginHistory

 CREATE PROCEDURE GetUserLoginHistory @email VARCHAR (20)
 AS
 SELECT L.*
 FROM Log L
 WHERE  L.email=@email
 GO
 EXEC GetUserLoginHistory @UserID='1111';







 -- Insert Ingredients
 INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (1, N'
Couscous', 662)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (2, N' Tomatoes', 787)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (3, N' 
Rice
', 458)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (4, N'Limes', 682)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (5, N'
Brown sugar', 74)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (6, N' Garlic', 921)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (7, N'Red chili', 233)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (8, N'
Chicken stock', 621)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (9, N' 
Lemons
', 283)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (10, N'
Parsley', 815)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (11, N' Butter', 2)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (12, N'
Cinnamons
', 384)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (13, N'White sugar', 858)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (14, N'Eggs', 735)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (15, N'
Oregano', 696)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (16, N' 
Celery', 808)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (17, N'
Thyme', 47)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (18, N'
Shallots', 874)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (19, N'
Orange juice', 892)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (20, N' 
Bay leaves', 583)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (21, N'
Turmeric', 261)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (22, N' 
Beef stock', 14)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (23, N' 
Fennel seeds', 514)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (24, N'
Paprika ', 922)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (25, N' 
Potatoes', 970)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (26, N' 
Parmesan', 671)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (27, N' Idaho
Onions', 852)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (28, N' 
Bacon', 363)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (29, N' 
Carrots', 626)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (30, N' 
Onions ', 757)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (31, N'  
Coriander', 40)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (32, N' Pasta', 166)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (33, N'
Whole nutmeg', 427)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (34, N'

Active dry', 56)
GO
INSERT [dbo].[Ingredients] ([IngredientID], [IngredientName], [Calories]) VALUES (35, N' 
Heavy cream
', 18)
GO

--Insert City
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (24388, N'Akron')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (31475, N'Albuquerque')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (26924, N'Anaheim')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (11848, N'Anchorage')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (7077, N'Arlington')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (30677, N'Atlanta')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (458, N'Aurora')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (31524, N'Austin')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (27250, N'Bakersfield')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (9912, N'Baltimore')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (17976, N'Baton Rouge')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (24797, N'Birmingham')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (12275, N'Boston')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (19647, N'Buffalo')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (3758, N'Charlotte')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (19041, N'Chicago')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (13099, N'Cincinnati')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (28624, N'Cleveland')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (17109, N'Colorado')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (23338, N'Columbus')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (26528, N'Corpus Christi')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (18882, N'Dallas')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (19807, N'Dayton')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (9077, N'Denver')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (9807, N'Des Moines')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (28398, N'Detroit')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (10315, N'El Paso')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (29769, N'Fort Wayne')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (4860, N'Fort Worth')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (12000, N'Fremont')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (4759, N'Fresno')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (4359, N'Garland')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (30583, N'Glendale')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (24027, N'Grand Rapids')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (29238, N'Greensboro')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (32035, N'Hialeah')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (18860, N'Honolulu')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (4124, N'Houston')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (1114, N'Indianapolis')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (7339, N'Jackson')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (5763, N'Jacksonville')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (3443, N'Jersey')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (17431, N'Kansas')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (31071, N'Las Vegas')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (24129, N'Lincoln')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (9757, N'Little Rock')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (18214, N'Long Beach')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (29628, N'Los Angeles')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (24536, N'Louisville')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (9132, N'Lubbock')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (15979, N'Madison')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (14691, N'Memphis')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (8869, N'Mesa')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (28230, N'Miami')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (32404, N'Milwaukee')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (31467, N'Minneapolis')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (1914, N'Mobile')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (22226, N'Montgomery')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (23020, N'Nashville')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (221, N'New Orleans')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (8405, N'New York')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (17463, N'Newark')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (30765, N'Norfolk')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (17264, N'Oakland')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (26519, N'Oklahoma')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (22852, N'Omaha')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (31314, N'Philadelphia')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (20426, N'Phoenix')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (9644, N'Pittsburgh')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (31264, N'Portland')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (28526, N'Raleigh')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (4631, N'Richmond')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (32093, N'Riverside')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (11778, N'Rochester')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (18419, N'Sacramento')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (21665, N'San Antonio')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (23460, N'San Diego')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (15219, N'San Francisco')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (8373, N'San Jose')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (29067, N'Santa Ana')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (32213, N'Seattle')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (32383, N'Shreveport')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (27480, N'Spokane')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (3672, N'St. Louis')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (12612, N'St. Paul')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (30106, N'St. Petersburg')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (12878, N'Stockton')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (7212, N'Tacoma')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (12597, N'Tampa')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (16549, N'Toledo')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (25903, N'Tucson')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (22332, N'Tulsa')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (2499, N'Virginia Beach')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (274, N'Washington')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (7238, N'Wichita')
GO
INSERT [dbo].[City] ([CityNum], [CityName]) VALUES (13031, N'Yonkers')
GO

-- Insert Users
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('123','ori@gmail.com','12-03-1996','24388','Ori','Cohen','M','1234','admin');
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('234','matan@gmail.com','11-05-1996','458','matan','Cohen','M','4567','LoginUser');
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('345','nir@gmail.com','11-05-1996','458','nir','hen','M','1245','LoginUser');
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('387','shiran@gmail.com','11-01-1994','31071','shiran','mizrahi','F','3456','LoginUser');
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('450','shir@gmail.com','11-05-1996','458','shir','hen','F','8790','LoginUser');
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('456','tomer@gmail.com','11-05-1996','10315','Tomer','Levi','M','4567','LoginUser');
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('482','meitar@gmail.com','12-09-1994','10315','meitar','cohen','F','2234','LoginUser');
INSERT INTO Users (UserID,email,birthDate,CityNum,firstName,lastName,Gender,password,userType) VALUES ('567','barak@gmail.com','11-02-1996','31071','barak','Cohen','M','3378','LoginUser');

-- Insert Publisher
INSERT [dbo].[Publisher] ([PublisherID], [FirstName], [LastName], [totalRecipes]) VALUES (123, N'Ori', N'Cohen', 47)
GO
INSERT [dbo].[Publisher] ([PublisherID], [FirstName], [LastName], [totalRecipes]) VALUES (234, N'matan', N'Cohen', 59)
GO
INSERT [dbo].[Publisher] ([PublisherID], [FirstName], [LastName], [totalRecipes]) VALUES (345, N'nir', N'hen', 22)
GO
INSERT [dbo].[Publisher] ([PublisherID], [FirstName], [LastName], [totalRecipes]) VALUES (456, N'Tomer', N'Levi', 1)
GO
INSERT [dbo].[Publisher] ([PublisherID], [FirstName], [LastName], [totalRecipes]) VALUES (567, N'barak', N'Cohen', 1)
GO

-- Inser FoodCategories
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (9, N'Beverages')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (11, N'Cereals')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (10, N'Confections')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (1, N'Dairy')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (7, N'Grain')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (2, N'Meat')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (5, N'Poultry')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (8, N'Produce')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (6, N'Seafood')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (4, N'Shell fish')
GO
INSERT [dbo].[FoodCategories] ([FoodCategoryID], [FoodCategoryName]) VALUES (3, N'Snails')
GO

-- Insert RecipeSubFoodCategories
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (1, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (2, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (3, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (4, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (5, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (6, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (7, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (8, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (9, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (10, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (11, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (12, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (13, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (14, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (15, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (16, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (17, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (18, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (19, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (20, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (21, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (22, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (23, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (24, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (25, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (26, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (27, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (28, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (29, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (30, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (31, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (32, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (33, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (34, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (35, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (36, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (37, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (38, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (39, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (40, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (41, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (42, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (43, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (44, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (45, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (46, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (47, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (48, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (49, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (50, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (51, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (52, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (53, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (54, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (55, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (56, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (57, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (58, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (59, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (60, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (61, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (62, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (63, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (64, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (65, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (66, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (67, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (68, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (69, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (70, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (71, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (72, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (73, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (74, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (75, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (76, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (77, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (78, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (79, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (80, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (81, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (82, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (83, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (84, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (85, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (86, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (87, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (88, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (89, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (90, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (91, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (92, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (93, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (94, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (95, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (96, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (97, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (98, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (99, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (100, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (101, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (102, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (103, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (104, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (105, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (106, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (107, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (108, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (109, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (110, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (111, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (112, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (113, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (114, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (115, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (116, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (117, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (118, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (119, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (120, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (121, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (122, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (123, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (124, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (125, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (126, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (127, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (128, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (129, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (130, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (131, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (132, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (133, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (134, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (135, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (136, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (137, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (138, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (139, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (140, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (141, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (142, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (143, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (144, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (145, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (146, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (147, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (148, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (149, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (150, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (151, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (152, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (153, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (154, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (155, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (156, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (157, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (158, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (159, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (160, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (161, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (162, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (163, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (164, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (165, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (166, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (167, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (168, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (169, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (170, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (171, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (172, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (173, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (174, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (175, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (176, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (177, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (178, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (179, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (180, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (181, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (182, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (183, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (184, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (185, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (186, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (187, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (188, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (189, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (190, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (191, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (192, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (193, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (194, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (195, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (196, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (197, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (198, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (199, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (200, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (201, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (202, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (203, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (204, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (205, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (206, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (207, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (208, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (209, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (210, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (211, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (212, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (213, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (214, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (215, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (216, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (217, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (218, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (219, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (220, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (221, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (222, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (223, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (224, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (225, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (226, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (227, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (228, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (229, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (230, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (231, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (232, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (233, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (234, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (235, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (236, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (237, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (238, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (239, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (240, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (241, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (242, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (243, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (244, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (245, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (246, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (247, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (248, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (249, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (250, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (251, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (252, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (253, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (254, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (255, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (256, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (257, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (258, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (259, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (260, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (261, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (262, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (263, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (264, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (265, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (266, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (267, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (268, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (269, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (270, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (271, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (272, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (273, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (274, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (275, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (276, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (277, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (278, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (279, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (280, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (281, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (282, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (283, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (284, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (285, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (286, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (287, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (288, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (289, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (290, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (291, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (292, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (293, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (294, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (295, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (296, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (297, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (298, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (299, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (300, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (301, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (302, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (303, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (304, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (305, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (306, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (307, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (308, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (309, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (310, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (311, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (312, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (313, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (314, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (315, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (316, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (317, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (318, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (319, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (320, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (321, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (322, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (323, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (324, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (325, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (326, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (327, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (328, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (329, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (330, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (331, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (332, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (333, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (334, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (335, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (336, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (337, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (338, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (339, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (340, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (341, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (342, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (343, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (344, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (345, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (346, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (347, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (348, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (349, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (350, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (351, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (352, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (353, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (354, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (355, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (356, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (357, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (358, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (359, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (360, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (361, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (362, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (363, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (364, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (365, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (366, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (367, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (368, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (369, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (370, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (371, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (372, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (373, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (374, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (375, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (376, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (377, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (378, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (379, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (380, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (381, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (382, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (383, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (384, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (385, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (386, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (387, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (388, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (389, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (390, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (391, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (392, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (393, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (394, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (395, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (396, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (397, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (398, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (399, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (400, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (401, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (402, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (403, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (404, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (405, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (406, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (407, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (408, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (409, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (410, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (411, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (412, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (413, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (414, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (415, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (416, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (417, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (418, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (419, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (420, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (421, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (422, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (423, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (424, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (425, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (426, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (427, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (428, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (429, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (430, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (431, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (432, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (433, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (434, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (435, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (436, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (437, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (438, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (439, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (440, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (441, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (442, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (443, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (444, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (445, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (446, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (447, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (448, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (449, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (450, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (451, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (452, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (453, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (454, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (455, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (456, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (457, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (458, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (459, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (460, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (461, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (462, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (463, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (464, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (465, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (466, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (467, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (468, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (469, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (470, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (471, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (472, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (473, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (474, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (475, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (476, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (477, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (478, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (479, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (480, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (481, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (482, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (483, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (484, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (485, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (486, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (487, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (488, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (489, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (490, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (491, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (492, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (493, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (494, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (495, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (496, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (497, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (498, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (499, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (500, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (501, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (502, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (503, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (504, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (505, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (506, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (507, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (508, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (509, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (510, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (511, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (512, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (513, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (514, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (515, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (516, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (517, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (518, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (519, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (520, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (521, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (522, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (523, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (524, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (525, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (526, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (527, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (528, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (529, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (530, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (531, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (532, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (533, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (534, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (535, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (536, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (537, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (538, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (539, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (540, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (541, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (542, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (543, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (544, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (545, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (546, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (547, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (548, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (549, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (550, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (551, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (552, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (553, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (554, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (555, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (556, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (557, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (558, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (559, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (560, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (561, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (562, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (563, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (564, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (565, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (566, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (567, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (568, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (569, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (570, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (571, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (572, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (573, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (574, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (575, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (576, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (577, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (578, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (579, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (580, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (581, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (582, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (583, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (584, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (585, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (586, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (587, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (588, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (589, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (590, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (591, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (592, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (593, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (594, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (595, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (596, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (597, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (598, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (599, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (600, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (601, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (602, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (603, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (604, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (605, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (606, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (607, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (608, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (609, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (610, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (611, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (612, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (613, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (614, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (615, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (616, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (617, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (618, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (619, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (620, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (621, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (622, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (623, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (624, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (625, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (626, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (627, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (628, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (629, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (630, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (631, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (632, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (633, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (634, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (635, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (636, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (637, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (638, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (639, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (640, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (641, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (642, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (643, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (644, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (645, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (646, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (647, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (648, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (649, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (650, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (651, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (652, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (653, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (654, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (655, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (656, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (657, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (658, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (659, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (660, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (661, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (662, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (663, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (664, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (665, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (666, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (667, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (668, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (669, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (670, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (671, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (672, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (673, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (674, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (675, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (676, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (677, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (678, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (679, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (680, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (681, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (682, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (683, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (684, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (685, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (686, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (687, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (688, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (689, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (690, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (691, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (692, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (693, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (694, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (695, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (696, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (697, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (698, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (699, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (700, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (701, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (702, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (703, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (704, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (705, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (706, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (707, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (708, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (709, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (710, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (711, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (712, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (713, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (714, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (715, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (716, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (717, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (718, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (719, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (720, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (721, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (722, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (723, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (724, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (725, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (726, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (727, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (728, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (729, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (730, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (731, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (732, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (733, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (734, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (735, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (736, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (737, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (738, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (739, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (740, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (741, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (742, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (743, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (744, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (745, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (746, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (747, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (748, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (749, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (750, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (751, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (752, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (753, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (754, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (755, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (756, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (757, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (758, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (759, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (760, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (761, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (762, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (763, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (764, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (765, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (766, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (767, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (768, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (769, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (770, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (771, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (772, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (773, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (774, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (775, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (776, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (777, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (778, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (779, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (780, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (781, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (782, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (783, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (784, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (785, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (786, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (787, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (788, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (789, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (790, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (791, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (792, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (793, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (794, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (795, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (796, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (797, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (798, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (799, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (800, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (801, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (802, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (803, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (804, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (805, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (806, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (807, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (808, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (809, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (810, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (811, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (812, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (813, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (814, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (815, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (816, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (817, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (818, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (819, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (820, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (821, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (822, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (823, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (824, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (825, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (826, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (827, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (828, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (829, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (830, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (831, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (832, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (833, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (834, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (835, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (836, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (837, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (838, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (839, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (840, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (841, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (842, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (843, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (844, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (845, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (846, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (847, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (848, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (849, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (850, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (851, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (852, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (853, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (854, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (855, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (856, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (857, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (858, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (859, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (860, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (861, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (862, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (863, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (864, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (865, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (866, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (867, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (868, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (869, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (870, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (871, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (872, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (873, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (874, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (875, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (876, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (877, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (878, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (879, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (880, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (881, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (882, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (883, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (884, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (885, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (886, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (887, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (888, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (889, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (890, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (891, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (892, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (893, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (894, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (895, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (896, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (897, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (898, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (899, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (900, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (901, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (902, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (903, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (904, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (905, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (906, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (907, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (908, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (909, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (910, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (911, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (912, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (913, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (914, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (915, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (916, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (917, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (918, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (919, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (920, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (921, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (922, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (923, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (924, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (925, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (926, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (927, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (928, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (929, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (930, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (931, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (932, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (933, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (934, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (935, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (936, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (937, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (938, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (939, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (940, NULL)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (941, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (942, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (943, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (944, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (945, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (946, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (947, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (948, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (949, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (950, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (951, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (952, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (953, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (954, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (955, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (956, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (957, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (958, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (959, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (960, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (961, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (962, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (963, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (964, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (965, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (966, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (967, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (968, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (969, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (970, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (971, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (972, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (973, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (974, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (975, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (976, 3)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (977, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (978, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (979, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (980, 7)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (981, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (982, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (983, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (984, 5)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (985, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (986, 11)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (987, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (988, 9)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (989, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (990, 8)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (991, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (992, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (993, 10)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (994, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (995, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (996, 2)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (997, 6)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (998, 4)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (999, 1)
GO
INSERT [dbo].[RecipeSubFoodCategories] ([RecipeSubFoodCategoryID], [FoodCategoryID]) VALUES (1000, 7)
GO
	
	
	-- Insert Recipes
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (1, 123, 818, N'Mr', N'cold eggs green to but for ranch as consuming to they is ranch a a consuming have great I''ve serve such and deviled', 1.8217542366225992, N'starter', N'hard', CAST(N'2003-06-25T17:26:29.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (2, 234, 559, N'Mr', N'irresistible them you holiday it than bacon been to much shredded mix! green beautifully consuming family!|These to', 4.1762107802444195, N'starter', N'hard', CAST(N'1988-07-27T01:34:03.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (3, 123, 2, N'Miss.', N'this aioli a give and and bacon, told than You such such a as as green told green or dip cakes that''s', 2.2157605850211164, N'starter', N'medium', CAST(N'1976-06-20T06:22:23.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (4, 234, 443, N'Mr', N'beautifully of ranch is Cheddar good or cold but again make recipe. Better garlic friends have over them', 3.2281361125540622, N'dish', N'easy', CAST(N'1958-12-07T04:15:37.340' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (5, 123, 274, N'Mr', N'beautifully cheese, over and eggs a as Better well.|This or for for it flavor your it Cheddar You eggs.|Bacon', 2.4740922564985661, N'starter', N'hard', CAST(N'1997-10-19T09:30:29.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (6, 234, 468, N'Dr.', N'give serve such and sandwiches.|Time grease to deviled it is include is bacon onions, onions, We sandwiches.|Time', 5.5214684957272695, N'starter', N'medium', CAST(N'1989-04-17T09:38:00.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (7, 123, 470, N'Mr', N'them a as a over it on and is is great sandwiches.|Time well ranch garlic for you family!|These mix! starter', 5.513869662542767, N'dish', N'easy', CAST(N'1970-01-15T05:40:23.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (8, 123, 31, N'Dr.', N'Enjoy! dip onions, or eggs.|Bacon and than been great aioli for Hope starter crab deviled since. irresistible', 2.5146979393971609, N'starter', N'hard', CAST(N'2008-10-01T05:26:06.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (9, 123, 996, N'Mr', N'my ranch dip can include for taste.) for such family!|These much unique and consuming recipe. recipe. they', 5.7948700002370721, N'dessert', N'hard', CAST(N'1975-10-12T10:58:45.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (12, 234, 33, N'Mr', N'as since. is a well been this green as have it! You deviled We serve have much them include good recipe. sandwiches.|Time it!', 4.2093350022143383, N'dish', N'hard', CAST(N'2020-11-23T01:04:02.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (13, 234, 527, N'Mr', N'and my your taste.) family!|These deviled mix! asked grease a it! party, combine been I''ve mix! give can', 1.7206103930811447, N'starter', N'medium', CAST(N'1967-04-01T09:11:23.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (14, 123, 688, N'Dr', N'an deviled dressing friends cheddar beautifully cheddar such a worth and and is dressing made ordinary', 3.7983654629431505, N'dessert', N'medium', CAST(N'1961-04-24T04:20:14.910' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (15, 123, 82, N'Mr', N'as this green made Hope or ranch told them. I''ve told party, make a holiday bacon deviled or We Enjoy!', 3.5454865733839043, N'dessert', N'easy', CAST(N'1995-01-08T17:37:31.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (16, 234, 454, N'Mr', N'can cheddar and serve than and We for they eggs since. this is flavor and have eggs.|Bacon flavor onions,', 3.29200045917742, N'dessert', N'easy', CAST(N'1975-11-27T19:03:24.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (17, 234, 989, N'Mr', N'again again cakes a bacon and have them have deviled as as Enjoy! for over include ranch cheddar consuming well', 3.4550530139613209, N'starter', N'hard', CAST(N'2004-11-22T08:45:34.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (18, 234, 763, N'Ms.', N'and on these and serve ranch great is great cream been recipe. give an mix! a recipe. consuming great', 4.0560389594435868, N'dessert', N'easy', CAST(N'1985-07-06T20:33:37.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (19, 234, 382, N'Dr.', N'cheese, dip green is these eggs.|Bacon make Enjoy! an and cheese. on again We asked give they You and', 1.9356378744987948, N'dessert', N'hard', CAST(N'1971-07-08T09:42:23.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (20, 234, 958, N'Mr', N'much deviled eggs.|Bacon them. over made have well.|This a consuming garlic (I as ordinary but my them', 1.059117283699623, N'dish', N'easy', CAST(N'1964-12-19T19:31:40.020' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (21, 234, 716, N'Mr', N'as told irresistible as shredded grease been include cheese, them. Better it cheese, to it! starter since.', 1.517942563406165, N'dessert', N'medium', CAST(N'1987-08-26T22:41:23.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (22, 234, 5, N'Mr', N'friends my this made shredded Cheddar and as and cheddar been Enjoy! worth crab aioli for my crab (I', 5.5703920999404009, N'dessert', N'medium', CAST(N'1997-11-08T21:08:04.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (23, 234, 795, N'Mr', N'and that''s have cakes eggs.|Bacon on you and them dressing and Hope them You great give ordinary much holiday', 3.7086043673141882, N'starter', N'easy', CAST(N'1956-05-13T04:38:40.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (24, 234, 458, N'Mr', N'this cream cakes as it bacon serve grease green cakes over starter ever them spread them. and cheese, they shredded enjoy eggs.|Bacon', 5.2956446713282, N'dessert', N'medium', CAST(N'2015-08-05T12:06:53.610' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (25, 123, 222, N'Dr.', N'or use mix! these give give great flavor beautifully as starter ranch ranch it they this a made a and', 3.6654278406246696, N'dish', N'easy', CAST(N'2010-01-25T19:34:06.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (26, 123, 719, N'Dr', N'told use is We Hope it starter bacon cakes of ranch your to sandwiches.|Time good beautifully for ever dip', 4.7249075382598242, N'dish', N'hard', CAST(N'1999-07-17T20:15:31.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (27, 123, 488, N'Miss.', N'well and ranch a make cream as as a you have friends combine can (I and my We over they well I''ve for', 2.7415546191584106, N'dessert', N'hard', CAST(N'2017-01-01T14:15:34.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (28, 123, 879, N'Mr', N'been bacon a a cakes holiday is flavor is as friends for these this ever much it Enjoy! a enjoy cheddar', 5.4809018887956169, N'dish', N'hard', CAST(N'2005-02-03T20:41:40.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (29, 123, 736, N'Dr', N'since. unique a on dip deviled your them told recipe. have than spread this a is is combine cheese. but is', 3.6647691673900784, N'starter', N'hard', CAST(N'1977-12-13T12:00:59.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (30, 123, 680, N'Dr', N'to them cheese, cheese, on deviled since. bacon starter is and good ranch crab give and deviled a cheddar', 5.2397619733772061, N'dish', N'medium', CAST(N'1971-03-21T20:23:11.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (31, 234, 219, N'Mr', N'You and You bacon your cheese, they it is worth cheese, ranch starter and such We brown is dressing combine', 5.9970668903538336, N'dish', N'easy', CAST(N'1960-05-19T03:52:19.920' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (32, 234, 897, N'Mr', N'deviled aioli a a bacon, been it! The bacon and a them cream aioli is starter cold since. as ever as', 4.3434500700530823, N'starter', N'hard', CAST(N'1984-08-31T00:04:20.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (33, 234, 839, N'Mr', N'serve and You Enjoy! a a Hope great cheese, good eggs.|Bacon been them worth is been it! and as give and they unique', 4.8084472384343142, N'dessert', N'medium', CAST(N'2019-10-18T02:44:10.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (34, 234, 645, N'Mr', N'unique you Enjoy! friends as We consuming been it again spread starter asked as great cheddar sandwiches.|Time an', 1.9897448336657813, N'dessert', N'hard', CAST(N'1971-11-06T22:13:48.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (35, 234, 220, N'Mr', N'or cold is enjoy sugar but deviled taste.) Enjoy! serve ordinary crab Cheddar starter for ordinary is as', 3.2020552806565794, N'starter', N'hard', CAST(N'1986-09-01T18:00:43.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (36, 234, 482, N'Mr', N'eggs.|Bacon a flavor for have worth unique friends on bacon, a include ranch a of ranch or eggs.|Bacon', 2.6755193060615658, N'dish', N'medium', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (37, 234, 720, N'Dr', N'beautifully cheddar but bacon made We holiday holiday ranch serve you bacon, bacon they and such a than', 2.0348826674906921, N'dessert', N'easy', CAST(N'1985-02-03T10:28:31.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (38, 123, 101, N'Dr.', N'a a it for been told beautifully been friends as a eggs.|Bacon it your starter recipe. such mix! eggs.|Bacon', 2.4011686231946427, N'starter', N'medium', CAST(N'2000-09-30T16:59:49.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (39, 123, 26, N'Ms.', N'friends for sandwiches.|Time it garlic cheese, (I a been deviled sandwiches.|Time cheese, been include', 4.5681691572853218, N'starter', N'hard', CAST(N'1975-05-29T12:36:19.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (40, 123, 906, N'Mr', N'and friends include a they have cold use Better You they it them deviled an ever shredded green have', 3.5709580316073066, N'dessert', N'medium', CAST(N'1968-09-09T10:39:44.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (41, 123, 477, N'Mr', N'told good taste.) deviled You been a brown a spread eggs.|Bacon enjoy as told over cheddar serve bacon', 4.0144523587145153, N'dish', N'hard', CAST(N'1968-01-06T18:12:42.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (42, 123, 326, N'Mr', N'since. great as ordinary for that''s combine The friends garlic they ranch taste.) a to have since. and', 4.0519880531597821, N'starter', N'hard', CAST(N'2015-07-06T13:25:28.020' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (43, 123, 469, N'Mr', N'have made is this a ranch I''ve and eggs grease as make bacon, Cheddar much holiday Cheddar it! cakes consuming as unique bacon', 2.9665051121108723, N'starter', N'medium', CAST(N'1983-08-17T22:41:55.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (44, 123, 810, N'Dr.', N'as party, them such and You it to much combine green consuming well ranch dressing and made dressing (I combine told', 2.7260999147436116, N'dish', N'medium', CAST(N'1960-07-28T14:03:43.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (45, 123, 765, N'Mr', N'bacon told Better this a of and flavor Enjoy! it as on family!|These a bacon mix! and a that''s deviled to', 5.67798075158055, N'dish', N'easy', CAST(N'2000-03-30T10:14:30.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (46, 234, 295, N'Mr', N'been and well it over bacon a eggs you grease mix! recipe. ordinary Cheddar starter my your ranch can', 4.0550674526277311, N'dish', N'medium', CAST(N'1988-09-10T13:55:29.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (47, 234, 664, N'Dr', N'beautifully much again garlic onions, this Better as they as but ordinary enjoy grease and your them sandwiches.|Time give', 1.1929413900677774, N'dish', N'easy', CAST(N'1970-06-15T04:07:47.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (48, 234, 287, N'Mr', N'a The use family!|These that''s ever cream eggs.|Bacon asked a deviled grease as or they they been Better make', 5.0906399647196015, N'starter', N'easy', CAST(N'1957-02-02T05:12:06.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (49, 234, 223, N'Mr', N'a asked told eggs.|Bacon starter over asked a bacon, dip a have is Hope them. give unique flavor you', 1.3041527677812392, N'dessert', N'hard', CAST(N'2012-09-10T00:46:21.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (50, 234, 69, N'Miss', N'a have to to family!|These it bacon, to bacon spread ordinary sugar is again and spread green The made', 1.9755808538643553, N'dessert', N'medium', CAST(N'1977-06-02T22:16:43.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (51, 234, 694, N'Dr', N'an them. cream taste.) ranch as cold green combine flavor it been aioli made than cakes taste.) to over mix! them deviled family!|These they', 1.1467877231290506, N'dessert', N'hard', CAST(N'1993-10-27T12:33:57.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (52, 234, 928, N'Dr', N'your family!|These unique them. You that''s cold make that''s dressing taste.) great much recipe. give', 5.88610179623873, N'dish', N'easy', CAST(N'1979-01-28T08:21:19.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (53, 234, 929, N'Mrs.', N'good but this them spread ranch cakes ever your it give but is as than over bacon full a bacon, and ranch', 5.5269434733907428, N'dish', N'medium', CAST(N'1975-09-22T05:40:51.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (54, 234, 901, N'Mr', N'brown again brown ranch of well can cream and a asked it irresistible as sugar can give onions, have a as', 4.0610191976004373, N'starter', N'hard', CAST(N'1958-11-29T17:59:53.880' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (55, 123, 94, N'Mr', N'for told it! it crab The eggs.|Bacon as dip eggs.|Bacon sandwiches.|Time again and well you as a been', 5.0378536535603242, N'dessert', N'hard', CAST(N'1968-05-31T12:21:09.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (56, 123, 107, N'Miss', N'to and them bacon and Cheddar brown but such it! serve ordinary bacon eggs dip on eggs great a cakes friends worth', 2.2513621366821983, N'dish', N'easy', CAST(N'1981-03-03T13:16:36.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (57, 123, 954, N'Mrs', N'give crab aioli to as or these sugar ever recipe. it well.|This you cream told worth party, dip your', 1.4676064129302309, N'dessert', N'medium', CAST(N'1958-08-17T20:18:25.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (58, 123, 149, N'Dr.', N'these is or ranch holiday sugar much on as Enjoy! cakes or flavor worth include a a dip great to You good You', 2.920115913692916, N'starter', N'hard', CAST(N'1985-03-16T20:55:22.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (59, 123, 570, N'Mr', N'asked ordinary as brown it but and a for irresistible a them. holiday cheddar starter have You deviled have', 5.5627082719293925, N'dessert', N'hard', CAST(N'1982-11-15T18:15:29.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (60, 123, 619, N'Mr', N'cheddar a full a much or and of starter you since. but worth sandwiches.|Time well these cheese. been ordinary', 3.7491847182387414, N'dish', N'hard', CAST(N'1970-11-11T08:41:30.400' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (61, 123, NULL, N'Ms', N'but is garlic and Enjoy! much dressing than sugar crab We green as recipe. unique much to deviled and', 3.7799138765688585, N'dish', N'medium', CAST(N'2020-04-03T13:14:58.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (62, 123, 851, N'Mr', N'flavor cheese, to sandwiches.|Time Better I''ve cream it been unique include great cold combine cheese,', 1.0329677737471497, N'starter', N'medium', CAST(N'1994-04-15T19:22:25.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (63, 123, 282, N'Miss', N'on Enjoy! and starter this them ranch an eggs.|Bacon as again over as this I''ve as worth shredded you', 4.8499287720070816, N'starter', N'hard', CAST(N'1986-12-11T08:58:42.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (64, 123, 959, N'Mr', N'it is cream onions, this give to aioli ordinary use brown as been worth is of for cream friends over a', 1.5551080268598665, N'dish', N'easy', CAST(N'1983-10-20T17:25:06.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (65, 123, 388, N'Mr', N'make for ordinary a eggs.|Bacon and can them enjoy garlic unique Enjoy! and since. for for for worth and Better', 3.3114633850341026, N'dish', N'medium', CAST(N'1957-07-24T14:35:34.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (66, 123, 281, N'Mr', N'give crab enjoy as such and and again and worth is dip of my a as cold a serve cold them beautifully', 2.2634681939442958, N'starter', N'hard', CAST(N'1984-10-22T23:34:20.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (67, 234, 532, N'Mr', N'full and this or onions, them. and aioli great recipe. garlic dip good told than as or good onions, it irresistible that''s', 5.4008877637800232, N'dessert', N'medium', CAST(N'1999-05-31T19:47:18.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (68, 234, 65, N'Dr.', N'cakes been Hope you asked dip flavor made mix! a them them. bacon, full The my they or for consuming crab flavor', 5.7308655594153635, N'dish', N'hard', CAST(N'1954-02-06T22:19:52.690' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (69, 234, 847, N'Dr', N'consuming deviled cream make deviled for great to family!|These for I''ve a eggs.|Bacon dressing combine', 1.5963101822865708, N'dessert', N'medium', CAST(N'2017-05-25T10:57:34.230' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (70, 234, 105, N'Mr', N'ranch You ordinary over Better you recipe. well.|This green as aioli bacon a serve made ranch for make', 1.8699672673223389, N'starter', N'medium', CAST(N'1996-08-22T10:19:31.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (71, 234, 402, N'Mr', N'family!|These a and enjoy use mix! (I a as this that''s as have sandwiches.|Time and cheddar I''ve have', 2.2571177916867278, N'dessert', N'easy', CAST(N'1962-12-06T07:08:59.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (72, 234, 131, N'Dr.', N'dip ranch this brown onions, garlic family!|These dip cream Enjoy! a Enjoy! crab eggs eggs You or cheese,', 2.0538843907666786, N'starter', N'easy', CAST(N'1997-02-26T02:03:35.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (73, 234, 616, N'Dr.', N'aioli cheese, Better party, and bacon a sugar starter make as to but enjoy grease deviled a mix! crab', 5.487869802158265, N'dish', N'easy', CAST(N'1982-06-27T20:09:14.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (74, 234, 686, N'Mr', N'ranch cheese. consuming Cheddar irresistible great these use Better it unique ranch but on starter onions,', 4.3646798428914879, N'dessert', N'medium', CAST(N'1969-10-28T09:53:53.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (75, 234, 173, N'Mrs.', N'bacon, crab such of cakes consuming is enjoy is sugar eggs.|Bacon consuming (I a (I made told dip as beautifully give my cold Enjoy!', 3.0446649249851077, N'dessert', N'medium', CAST(N'1956-07-02T15:29:40.880' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (76, 234, 610, N'Ms.', N'these for cheddar a ever sandwiches.|Time as but as cream told told these asked and it! Better told good a', 3.4659545102463825, N'dish', N'hard', CAST(N'1971-06-16T06:06:12.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (77, 234, 998, N'Miss.', N'a is than give spread been good as have cakes onions, asked it! great ranch these bacon, told unique', 3.6038869878295285, N'dessert', N'easy', CAST(N'1957-01-09T23:59:27.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (78, 234, 64, N'Dr', N'give as of crab green worth and ordinary them dip is ever We and cheese, of and told made use cold of', 1.9825044525705764, N'dessert', N'hard', CAST(N'1990-04-14T07:04:20.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (79, 234, 843, N'Dr.', N'cheese. serve grease a brown ordinary shredded as for include deviled make ranch deviled it your grease or', 5.6176639197476508, N'starter', N'medium', CAST(N'1978-02-12T18:24:10.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (80, 234, 646, N'Mr', N'this over than and bacon over combine eggs.|Bacon eggs I''ve irresistible aioli Cheddar shredded and ever a', 5.6103603879969386, N'dessert', N'medium', CAST(N'1979-11-25T22:11:24.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (81, 234, 971, N'Miss', N'taste.) use spread it or shredded it them told combine for asked a it eggs it them unique cheese, them irresistible my is well.|This', 4.5319661481920477, N'dessert', N'hard', CAST(N'1992-08-13T15:26:19.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (82, 234, 513, N'Miss.', N'unique irresistible a you and or Cheddar and an can great have made dip that''s ranch asked full but make but holiday', 3.6509146544388096, N'dish', N'hard', CAST(N'1995-06-15T15:03:25.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (83, 234, 814, N'Dr', N'as that''s or full for grease this a a give ranch and on well.|This and The Enjoy! or mix! and good crab deviled cakes', 5.1767491210143772, N'dish', N'easy', CAST(N'1957-04-24T13:29:12.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (84, 234, 576, N'Mr', N'as onions, and and cream for is great much is than We garlic you well such or party, serve enjoy is or', 2.6891883135257233, N'dish', N'medium', CAST(N'1980-09-03T22:24:57.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (85, 234, 673, N'Miss', N'holiday party, family!|These dip they well for include or great dressing combine as Enjoy! mix! The have such to', 5.0929742502481563, N'dish', N'hard', CAST(N'2006-02-15T23:27:02.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (86, 123, 302, N'Miss', N'been and and deviled as beautifully cheddar make full an (I eggs as friends flavor as great spread bacon,', 1.1109650941151033, N'starter', N'easy', CAST(N'2014-02-21T12:01:51.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (87, 123, 466, N'Mr', N'can use make friends flavor enjoy they since. deviled friends The for a this a your ever but been spread aioli', 4.81650659666234, N'dessert', N'easy', CAST(N'2006-08-27T22:11:28.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (88, 123, 217, N'Miss', N'them grease my ordinary as a The them I''ve to bacon garlic include on (I over bacon, dip to is have dressing and deviled since. this deviled them. cheddar but irresistible a or', 1.7474280408338774, N'dish', N'medium', CAST(N'1978-10-03T06:04:26.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (89, 123, 231, N'Mr', N'party, serve mix! again this green and as for much full beautifully grease worth beautifully it as Cheddar', 2.9518911801054566, N'dessert', N'hard', CAST(N'2004-05-19T14:23:01.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (90, 123, 447, N'Mr', N'bacon, dressing dip them sandwiches.|Time serve have garlic it a and since. well they friends starter unique', 1.9506931439743811, N'dessert', N'medium', CAST(N'2012-09-04T08:57:12.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (91, 123, 20, N'Dr.', N'make have well.|This dressing The and an deviled great give and it as dressing as enjoy dip as of for cheese, a sugar', 2.2079128931313345, N'dessert', N'hard', CAST(N'1981-01-15T21:42:18.290' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (92, 123, 817, N'Mr', N'as dip serve cheddar them. cold We include to well taste.) is since. eggs they good We brown over family!|These cheese, but', 5.1147667537977766, N'dessert', N'easy', CAST(N'2021-11-19T13:33:08.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (93, 123, 914, N'Mrs', N'have Cheddar that''s cream deviled Cheddar You great sandwiches.|Time consuming a bacon ranch We taste.)', 2.83846035126525, N'starter', N'medium', CAST(N'1970-11-16T22:44:20.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (94, 123, 510, N'Mrs.', N'them. have Better dip deviled and ordinary family!|These family!|These again my worth ranch cheese, been crab', 1.8189844390465806, N'dish', N'easy', CAST(N'1957-07-19T03:54:49.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (95, 123, 994, N'Mrs.', N'holiday they unique or brown your cheese. worth and full of it again they and Hope and that''s bacon,', 5.7910441550384482, N'dish', N'hard', CAST(N'1970-06-07T21:24:46.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (96, 123, 654, N'Mrs', N'crab sandwiches.|Time for told to a ever use than enjoy dip consuming ranch Better a a is Cheddar been been holiday spread', 3.9814845849673661, N'dish', N'medium', CAST(N'1995-09-22T22:50:16.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (97, 234, 968, N'Mr', N'taste.) and dip family!|These them. and friends cheese. your unique I''ve a cream aioli enjoy is is and great', 5.2020592811527, N'starter', N'easy', CAST(N'1981-07-27T04:26:45.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (98, 234, 773, N'Mr', N'as full friends cheddar worth family!|These green my unique cakes over and dip a for such been for they they Cheddar on is than', 2.4113970852510058, N'dish', N'easy', CAST(N'2021-10-28T05:16:49.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (99, 234, 421, N'Mrs', N'great I''ve over good you You Cheddar combine bacon them. for to have deviled party, a as starter them. Better', 5.4146365297095089, N'starter', N'hard', CAST(N'1956-01-05T23:28:08.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (100, 456, 886, N'Mr', N'cheese, since. been a have is cheese, a is sandwiches.|Time The again as beautifully them. onions, combine', 4.4145125576362538, N'starter', N'easy', CAST(N'1968-06-08T10:40:09.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (101, 234, 256, N'Mr', N'bacon, over is combine dip make or made mix! ever make a dip We great beautifully mix! such over that''s cakes', 4.6541796888477069, N'dessert', N'easy', CAST(N'2011-04-12T18:08:10.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (102, 234, 898, N'Ms.', N'shredded cheddar grease have and cold make deviled them. onions, sandwiches.|Time I''ve enjoy and serve', 1.4620758306524138, N'starter', N'medium', CAST(N'1969-05-09T05:47:54.610' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (103, 234, 883, N'Ms', N'such give and have your it! worth and told ranch it include enjoy ordinary eggs.|Bacon worth a dip as on this', 4.49432978243303, N'dish', N'medium', CAST(N'1961-09-09T18:14:32.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (104, 234, 786, N'Mr', N'that''s We it deviled cold onions, your and such cheese, since. green an We and starter full cheese, made or I''ve over your to', 5.4341855004589, N'dessert', N'easy', CAST(N'1969-01-19T14:26:50.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (105, 234, 353, N'Ms', N'and have flavor great cheese, recipe. a Cheddar use serve holiday them cheddar recipe. enjoy The Better', 5.7184630621776282, N'dessert', N'medium', CAST(N'1967-06-29T15:07:43.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (106, 234, 34, N'Dr', N'as or holiday you The over dressing dip cream for friends aioli again brown irresistible brown great', 5.092903332362372, N'dessert', N'medium', CAST(N'2018-08-31T10:30:22.340' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (107, 234, 122, N'Mr', N'friends as since. you ranch and but cheddar cream full include ranch cream unique green cheddar We my', 1.3982319940804653, N'dessert', N'hard', CAST(N'2018-08-02T12:12:04.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (108, 345, 497, N'Dr', N'and been to to a again (I over for irresistible ever cakes irresistible Enjoy! been ranch mix! worth family!|These than and', 2.1622636304992549, N'dish', N'easy', CAST(N'1958-11-25T19:46:57.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (109, 345, 262, N'Ms.', N'Better make is make since. a told they well a bacon unique Enjoy! eggs over ranch bacon spread brown', 2.0163542726153292, N'starter', N'medium', CAST(N'1955-05-31T02:30:12.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (110, 345, 243, N'Mr', N'this well a cheddar cold beautifully that''s told such holiday sugar is of these Better holiday cheese,', 2.5718991433139422, N'dish', N'hard', CAST(N'2018-12-16T06:14:57.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (111, 345, 134, N'Ms.', N'worth as give mix! can holiday Hope bacon it! cheese, your worth and mix! You I''ve eggs cheese, eggs', 4.6474751488526707, N'dish', N'easy', CAST(N'1977-02-22T13:17:08.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (112, 345, 560, N'Mr', N'dip a them. (I good sandwiches.|Time dip enjoy recipe. aioli beautifully been and The combine I''ve Cheddar', 5.4851019603596542, N'starter', N'hard', CAST(N'1990-05-05T13:14:04.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (113, 345, 342, N'Dr', N'Hope Enjoy! over them and such for make a friends party, include a is aioli Cheddar and a starter give', 3.3024519939452652, N'starter', N'medium', CAST(N'1960-02-03T02:31:11.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (114, 345, 98, N'Mr', N'or as great well.|This have ranch eggs and been is Cheddar We good much cold and they ever them to over Cheddar', 5.9523478839324548, N'starter', N'easy', CAST(N'1955-12-22T20:04:04.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (115, 345, 711, N'Dr.', N'include these asked shredded is and enjoy is irresistible a dip ordinary ever serve is cheddar your again well.|This it', 5.2172185700466942, N'dish', N'easy', CAST(N'2000-03-29T17:15:10.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (116, 345, 652, N'Mr', N'and and irresistible cheddar bacon, flavor use enjoy grease consuming cakes my told that''s give an it', 1.1289992221300487, N'dessert', N'medium', CAST(N'1977-10-20T22:11:32.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (117, 345, 265, N'Dr.', N'cakes flavor dip on unique spread cheese, as it! spread a holiday or You We cream that''s and great grease eggs.|Bacon an ranch', 1.856218652732772, N'dish', N'easy', CAST(N'1989-12-23T05:53:13.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (118, 345, 196, N'Dr.', N'friends garlic it! ranch is and you on than (I a consuming great on Hope deviled sugar much The holiday', 3.1607404584813588, N'dish', N'medium', CAST(N'1959-04-09T10:33:45.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (119, 345, 492, N'Mrs', N'ranch serve taste.) as starter and well.|This eggs dip a as it Cheddar Hope dressing taste.) bacon and', 2.4621337766117106, N'starter', N'medium', CAST(N'1999-09-03T17:58:03.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (120, 345, 320, N'Mr', N'bacon, or friends onions, a an my them irresistible make it have it cheese, have use have The spread', 3.2004982909189996, N'dish', N'medium', CAST(N'1965-06-02T02:33:42.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (121, 345, 245, N'Dr.', N'holiday You an combine these ranch good to and well.|This eggs green give spread of cheddar them have', 3.4469615972819558, N'dish', N'medium', CAST(N'2000-02-26T01:22:52.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (122, 345, 611, N'Mr', N'I''ve have a been them. You cakes is to you of bacon, make onions, since. a bacon my and cheese, as them', 4.6534597229461463, N'starter', N'hard', CAST(N'1973-08-29T13:42:52.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (123, 345, NULL, N'Miss.', N'cheese, consuming a friends to on these a ranch (I well.|This as such to deviled to deviled them. or', 3.7789743793099069, N'dish', N'hard', CAST(N'1971-09-20T07:56:51.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (124, 345, 962, N'Dr.', N'a party, and Hope taste.) a crab dressing been brown cheese, combine The over them family!|These irresistible', 5.6456170383121895, N'dessert', N'hard', CAST(N'1957-09-21T02:00:21.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (125, 345, 97, N'Mr', N'onions, but been Cheddar have bacon, Cheddar brown they a irresistible have a much that''s since. make', 5.6620543741910039, N'starter', N'medium', CAST(N'1968-08-07T12:37:13.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (126, 345, 191, N'Mr', N'Enjoy! that''s friends ordinary holiday deviled this onions, dip Enjoy! dip it give them a a garlic beautifully', 3.1423510378889512, N'starter', N'hard', CAST(N'1963-01-16T17:35:50.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (127, 345, 111, N'Ms', N'cheese, a mix! as to serve give make (I well them. eggs.|Bacon as these cakes can a a over as cold Enjoy! and ever', 5.2154240395014284, N'dessert', N'hard', CAST(N'1979-04-13T03:19:14.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (128, 345, 102, N'Ms.', N'but cheddar and (I mix! cream them cream that''s over Enjoy! flavor as asked deviled use garlic flavor', 4.6688853631116842, N'starter', N'easy', CAST(N'1977-12-10T16:14:25.320' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (129, 345, 643, N'Mrs', N'these sandwiches.|Time told irresistible for party, cream ever than on dip cheese, and beautifully much', 4.57363568785304, N'dish', N'medium', CAST(N'2021-05-22T12:29:07.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (130, NULL, 242, N'Mr', N'Enjoy! garlic well cold worth it ranch them starter them dip family!|These We my great sandwiches.|Time dip', 5.063180340017742, N'dish', N'hard', CAST(N'1982-10-10T16:39:24.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (131, NULL, 860, N'Mr', N'that''s a The onions, beautifully holiday your recipe. as a and as them full and serve holiday on ranch', 4.2638952290936816, N'dish', N'hard', CAST(N'2011-11-20T01:39:26.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (132, NULL, 908, N'Mr', N'cheddar and brown great starter as to ordinary make sandwiches.|Time cold recipe. mix! on cakes Cheddar again mix!', 2.1924899025785223, N'dish', N'hard', CAST(N'1957-03-14T18:42:38.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (133, NULL, 461, N'Dr.', N'grease We to and it an spread dip garlic beautifully made Hope have this again for sugar party, as a mix! Better holiday', 2.5678679228610677, N'dessert', N'hard', CAST(N'1987-04-10T07:36:11.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (134, NULL, 779, N'Mr', N'this full a brown brown great grease ranch well.|This is have is on your is your it! it Cheddar bacon,', 2.2031513621113969, N'dessert', N'easy', CAST(N'1962-09-07T07:44:01.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (135, NULL, 648, N'Mrs', N'as garlic and asked them or is family!|These a consuming holiday ranch for been Hope it! holiday them', 1.9561806991492308, N'starter', N'medium', CAST(N'1990-08-15T04:03:14.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (136, NULL, 609, N'Mr', N'again them an them consuming they sandwiches.|Time cheese. and they for crab ordinary of bacon to on on have', 4.0698903175396337, N'dessert', N'easy', CAST(N'1976-04-07T09:38:25.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (137, NULL, 624, N'Mr', N'over it sandwiches.|Time for them or eggs your cheese, consuming of they cheese. spread I''ve and been eggs.|Bacon', 5.15658487200578, N'starter', N'easy', CAST(N'1986-10-06T20:48:53.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (138, NULL, 874, N'Mr', N'ever again crab and can have is great ordinary taste.) unique an been great ever it as spread and holiday', 5.7425636205554769, N'dessert', N'hard', CAST(N'2010-04-04T23:02:22.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (139, NULL, 138, N'Mrs', N'sugar well.|This have Hope them. over onions, bacon Hope spread grease they or my taste.) asked for than', 2.9707252513480955, N'dessert', N'hard', CAST(N'1966-03-09T07:17:13.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (140, NULL, NULL, N'Mr', N'and include great cheese, serve holiday over Enjoy! is cheese, as enjoy a Better include them. an and shredded over', 1.0000709178857836, N'dessert', N'medium', CAST(N'2009-06-17T12:56:40.290' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (141, NULL, 84, N'Dr.', N'told they much much as and since. green full Better recipe. and aioli bacon over and good over your it!', 5.7127331000346375, N'starter', N'easy', CAST(N'2017-07-21T23:49:47.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (142, NULL, 867, N'Mr', N'beautifully green and or eggs.|Bacon have full that''s and for enjoy made as a include deviled dip sandwiches.|Time', 3.6542429661630851, N'starter', N'hard', CAST(N'2000-10-03T02:24:30.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (143, NULL, 787, N'Dr.', N'full great cakes well them an is and and (I mix! Hope bacon, flavor a flavor cold family!|These starter my holiday shredded', 5.7310737682185477, N'dish', N'hard', CAST(N'1976-05-06T03:34:13.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (144, NULL, 830, N'Mr', N'sugar cheese. over for them. ranch as been shredded than been great garlic friends crab a again starter', 1.3799920367915146, N'dish', N'hard', CAST(N'2007-06-04T08:08:03.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (145, NULL, 523, N'Dr', N'crab as cakes it ranch Enjoy! (I you great a well combine unique irresistible sandwiches.|Time cheese,', 3.3032179951217109, N'starter', N'medium', CAST(N'1988-07-13T19:40:04.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (146, NULL, 635, N'Mr', N'a You for ever and Cheddar but you and give as they have cream that''s green a mix! recipe. over for cheese,', 2.7228109327716803, N'dessert', N'hard', CAST(N'2012-09-12T08:28:13.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (147, NULL, 10, N'Mr', N'to a my holiday full dip beautifully they it as that''s green cheese, this good on much grease and bacon, include', 2.8123147598525113, N'dessert', N'hard', CAST(N'2014-10-18T11:01:57.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (148, NULL, 801, N'Mr', N'and is and Better these The over eggs.|Bacon that''s a onions, bacon, combine as Better deviled as them as', 2.8861124673327954, N'dessert', N'easy', CAST(N'1967-11-27T02:40:15.330' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (149, NULL, 922, N'Dr.', N'cheese, made give spread great cakes than have cheese. made as worth over cheddar cheese, again have as my well a', 2.6017658689998862, N'dessert', N'hard', CAST(N'1979-04-21T10:39:38.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (150, NULL, 193, N'Mr', N'been The dressing cheese, your such cream serve include ranch Better ranch for over use them. them is', 5.6620449329083993, N'dessert', N'easy', CAST(N'2014-08-17T23:13:13.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (151, NULL, 662, N'Dr', N'well.|This spread enjoy sandwiches.|Time a this told irresistible been again cheese, ever a can We You mix! dressing', 3.1252659322345937, N'dessert', N'easy', CAST(N'1958-10-01T16:57:03.320' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (152, NULL, 535, N'Ms.', N'friends full for them as an sugar told taste.) and The good this onions, dip sugar and cheese. consuming', 3.0413188226713421, N'dish', N'medium', CAST(N'1975-04-20T17:53:00.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (153, NULL, 774, N'Miss', N'irresistible irresistible irresistible or friends ordinary give my that''s a as as have bacon deviled', 5.9492633086392948, N'dish', N'hard', CAST(N'1975-02-25T11:18:45.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (154, NULL, 126, N'Dr.', N'to We ranch Hope enjoy my asked been a combine Hope have you recipe. ranch a great include but sandwiches.|Time', 3.2141382387905093, N'dish', N'medium', CAST(N'2012-08-04T20:54:26.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (155, NULL, 120, N'Mr', N'them. as friends of mix! great or your can again spread good I''ve a deviled grease dressing such told', 1.9675509603542978, N'dessert', N'medium', CAST(N'1990-04-13T09:17:16.400' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (156, NULL, 563, N'Mr', N'than over shredded told brown holiday as a eggs.|Bacon much We been that''s as taste.) bacon again this serve', 1.0007199659015611, N'dessert', N'medium', CAST(N'1990-08-15T04:25:18.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (157, NULL, 641, N'Mr', N'is and as eggs.|Bacon it make for and enjoy Better shredded is ordinary can and your again can cream holiday and', 3.6831014513425071, N'dish', N'hard', CAST(N'2019-08-19T21:51:02.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (158, NULL, 59, N'Mr', N'this Enjoy! worth great than as it my cream over a and and as party, combine crab serve been The eggs', 4.84871274412084, N'dish', N'hard', CAST(N'1956-12-20T16:14:10.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (159, NULL, 94, N'Mr', N'been is worth full (I over them a them. aioli as cheddar recipe. ever unique include Enjoy! is green', 5.7721311262678965, N'dish', N'medium', CAST(N'1953-06-15T01:49:37.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (160, NULL, 121, N'Mr', N'them my well have consuming Better cheese, can them your as deviled been and it good a brown or this', 3.5761120242886766, N'dish', N'medium', CAST(N'1957-06-13T21:31:52.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (161, NULL, 631, N'Dr.', N'a worth and friends have a sugar use your and recipe. eggs them my crab as a a You onions, irresistible on friends', 5.8774792928609436, N'dessert', N'medium', CAST(N'1992-05-21T07:11:07.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (162, NULL, 100, N'Dr', N'shredded full (I onions, a garlic a well as deviled spread a as bacon is The garlic that''s make to as', 2.7293466309687804, N'dessert', N'hard', CAST(N'1993-08-23T19:57:39.240' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (163, NULL, 13, N'Mr', N'is your taste.) to they they Enjoy! I''ve party, I''ve (I worth well.|This cheese. We well them these cheese,', 3.5886279426462151, N'starter', N'hard', CAST(N'1959-07-06T07:17:50.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (164, NULL, 46, N'Mr', N'(I deviled great and these them. it! mix! and friends or flavor full bacon well.|This dressing onions, starter since.', 2.9531739325975876, N'dessert', N'hard', CAST(N'1994-08-20T09:50:48.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (165, NULL, 824, N'Mr', N'shredded as as for recipe. enjoy told on Better asked onions, cheese. made of ordinary grease unique as', 4.3080039142202606, N'dessert', N'easy', CAST(N'1960-01-28T04:35:30.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (166, NULL, 952, N'Mr', N'good this shredded cakes and as as and friends bacon, of sugar Hope well give eggs friends Hope cheese, your', 3.4549852462741479, N'starter', N'easy', CAST(N'1972-12-11T18:34:29.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (167, NULL, 946, N'Dr.', N'and recipe. a and include over been can bacon onions, and a bacon as them give Better than bacon, party, well cold', 3.9172340374985866, N'starter', N'easy', CAST(N'1956-01-27T05:37:52.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (168, NULL, 32, N'Mr', N'again cream asked serve give than great aioli been on a over them. combine You and recipe. been such good and', 2.0993006318338683, N'starter', N'easy', CAST(N'2019-05-28T18:47:10.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (169, NULL, 845, N'Mr', N'include but over to and it party, again for a good and to taste.) cheese. again cold deviled it on mix! since.', 4.9961671847832232, N'starter', N'hard', CAST(N'1987-05-09T16:00:50.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (170, NULL, 552, N'Dr.', N'bacon make a aioli dressing party, bacon a them. made them over them dressing family!|These Cheddar crab asked', 2.1473282525070609, N'dessert', N'easy', CAST(N'1976-12-23T07:36:45.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (171, NULL, 419, N'Mr', N'this for well recipe. crab sandwiches.|Time beautifully well to starter is that''s garlic is been them include such', 1.9724143501242688, N'dish', N'medium', CAST(N'2013-01-14T01:22:39.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (172, NULL, 422, N'Mr', N'made deviled asked use them is holiday made than party, been for The this The flavor make and for make', 2.1136550321772951, N'dish', N'easy', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (173, NULL, 601, N'Dr.', N'them as cheese, crab ordinary can ordinary and serve ordinary a over good use aioli or a starter give is eggs.|Bacon', 1.190015207133263, N'dessert', N'medium', CAST(N'2001-09-19T06:50:51.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (174, NULL, 913, N'Dr', N'this as grease as holiday use deviled or worth taste.) brown dressing green and it Hope serve beautifully it', 2.4620628587259272, N'dish', N'easy', CAST(N'2015-01-31T03:16:31.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (175, NULL, 681, N'Mr', N'well.|This garlic (I have eggs.|Bacon and ordinary as have have your my ever a it great ever these brown have', 3.4877651908843617, N'dish', N'easy', CAST(N'2012-03-18T05:01:23.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (176, NULL, 467, N'Ms.', N'good on them Hope for as Enjoy! as and brown spread as asked over bacon asked You mix! made great great an', 5.7927186311188708, N'dish', N'hard', CAST(N'1969-11-11T02:43:55.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (177, NULL, 87, N'Mr', N'cheese. bacon unique cheese, an bacon it! cold sugar than is they to they to crab asked and them full', 4.9223859547275985, N'dish', N'easy', CAST(N'2021-05-24T22:58:22.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (178, NULL, 520, N'Mr', N'it beautifully full dip and your as a a cream Better deviled on it them deviled ever as great these told', 3.398982342518392, N'starter', N'hard', CAST(N'2019-04-25T10:08:38.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (179, NULL, 950, N'Mr', N'a cold this taste.) your full to sugar dip cheese, give as green such recipe. spread your full ranch recipe. have enjoy', 3.3423990431904786, N'dessert', N'easy', CAST(N'1986-04-17T23:48:47.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (180, NULL, 107, N'Mr', N'great eggs combine over as starter friends dip them well these and (I or as as a well and these my over family!|These', 3.9392434414193236, N'dish', N'medium', CAST(N'1991-03-10T06:20:17.680' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (181, NULL, 189, N'Dr', N'is deviled of great sandwiches.|Time cheese, The use been of The give cold Hope is irresistible asked sandwiches.|Time include as than', 1.3300362780364399, N'dish', N'easy', CAST(N'1977-11-25T04:08:59.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (182, NULL, 72, N'Mr', N'a is Hope a it can You this spread and or cakes Cheddar as over deviled bacon enjoy it family!|These', 3.329311572168633, N'starter', N'medium', CAST(N'1970-03-31T06:33:53.600' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (183, NULL, 909, N'Mrs.', N'can brown bacon, unique deviled The green for give it You them cakes and your is holiday is as bacon eggs.|Bacon', 3.0671194941117985, N'dish', N'easy', CAST(N'1964-05-18T00:38:59.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (184, NULL, 757, N'Mr', N'aioli my you bacon, is these dressing cheese, and asked it! dressing and We spread ordinary use have but', 4.9115907549446405, N'dessert', N'easy', CAST(N'2020-08-21T05:34:46.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (185, NULL, 152, N'Miss.', N'they that''s a grease We is worth mix! cheese, such you told irresistible consuming and been bacon worth', 2.9379144077831478, N'dish', N'medium', CAST(N'1959-10-06T13:15:54.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (186, NULL, 614, N'Miss.', N'and make onions, have The cakes consuming a to them. onions, as have dressing a full as dressing mix! I''ve grease', 2.2225764064223394, N'dessert', N'easy', CAST(N'1977-01-09T23:42:21.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (187, NULL, 571, N'Dr.', N'them it than asked it! brown Hope bacon they Enjoy! an family!|These cold friends crab since. worth them bacon', 2.2432265939392275, N'dessert', N'easy', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (188, NULL, 865, N'Mr', N'a and dressing full and over ranch for grease consuming is I''ve and asked enjoy and dip well deviled they', 5.3537296840705579, N'starter', N'easy', CAST(N'1989-08-02T07:46:26.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (189, NULL, 378, N'Dr.', N'an over well.|This worth an spread eggs.|Bacon been and and and is eggs.|Bacon cheese, on and cream cakes mix!', 1.235600401757099, N'starter', N'medium', CAST(N'2004-01-18T07:23:53.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (190, NULL, 47, N'Dr.', N'well spread been and to that''s or and to friends and sandwiches.|Time cream and is is Cheddar cold for', 1.9554607332476697, N'dish', N'easy', CAST(N'1996-09-04T10:41:45.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (191, NULL, 534, N'Mr', N'is cakes mix! ranch ranch as recipe. onions, told my onions, and dressing it can as an as Hope friends and as', 1.3867888661971264, N'starter', N'medium', CAST(N'1994-05-26T22:26:45.330' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (192, NULL, 160, N'Mr', N'as worth great eggs We over ever The them cheese. to good ranch taste.) dressing a to combine grease party,', 1.3078721278849395, N'dessert', N'medium', CAST(N'2021-12-30T23:37:55.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (193, NULL, 77, N'Mr', N'recipe. give told shredded since. cheese. ranch a sugar and is shredded combine for Enjoy! a dip have', 5.97043249428758, N'dish', N'easy', CAST(N'1978-08-19T11:47:22.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (194, NULL, 986, N'Mr', N'ordinary and dip of to brown my well.|This full your made The great I''ve than been for been eggs give eggs.|Bacon irresistible', 5.3946132270594189, N'starter', N'medium', CAST(N'1982-10-18T04:34:42.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (195, NULL, 333, N'Mr', N'include a party, on to a an as eggs serve and them. Cheddar asked is but this combine you The have well', 1.12259162502484, N'dessert', N'hard', CAST(N'2009-10-21T21:12:44.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (196, NULL, 518, N'Mr', N'cheese, mix! garlic a over flavor is great We such cheddar this aioli Hope sandwiches.|Time your cheddar ever cheese,', 3.9833864690658576, N'dish', N'medium', CAST(N'1961-09-26T09:45:20.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (197, NULL, 129, N'Mr', N'bacon and asked well over these starter eggs mix! have an great of flavor Better taste.) bacon full garlic a', 1.0656150235168707, N'starter', N'easy', CAST(N'1970-01-28T05:45:32.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (198, NULL, 117, N'Dr', N'have include cakes dressing sugar bacon, worth bacon and to great holiday a them and Hope over cold irresistible', 3.77789983562096, N'dessert', N'easy', CAST(N'1976-11-29T03:52:08.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (199, NULL, 776, N'Dr.', N'shredded friends you Enjoy! this mix! these cheddar I''ve it beautifully brown much well.|This full use', 3.0719881225712542, N'dish', N'hard', CAST(N'1994-03-31T19:06:40.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (200, NULL, 755, N'Mrs', N'of them such is to ever Hope my is cream much holiday over Better holiday ever on brown a make been is', 5.8482327488475629, N'dessert', N'medium', CAST(N'2003-09-16T17:43:25.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (201, NULL, 176, N'Mr', N'that''s irresistible have as much cakes a these mix! flavor since. dressing cheese, full sugar ever I''ve', 4.8055768952730933, N'dish', N'hard', CAST(N'2000-05-08T03:32:33.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (202, NULL, 180, N'Mr', N'Better you holiday use deviled party, to brown a dip dip dip it these is a dip a a is and bacon, We cheese, on a it dip to mix!', 1.7130141280186428, N'dish', N'medium', CAST(N'1968-08-03T01:05:34.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (203, NULL, 730, N'Ms.', N'cakes ever ever party, cheddar for much enjoy but dressing again bacon use party, bacon them as holiday cheese, a to', 3.8899452825495722, N'dessert', N'medium', CAST(N'2009-08-18T02:50:21.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (204, NULL, 229, N'Dr.', N'cheddar and green taste.) I''ve green eggs and green garlic sandwiches.|Time it! spread and that''s deviled', 1.4544376164928254, N'dessert', N'hard', CAST(N'2017-05-22T16:14:47.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (205, NULL, 45, N'Mrs', N'it to on it! or ranch great as much holiday as have dip a it and serve (I sugar as enjoy great party, is', 4.6896305827841305, N'starter', N'hard', CAST(N'2002-07-20T10:39:24.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (206, NULL, 485, N'Dr.', N'and make flavor irresistible is shredded make to told as them green mix! cheese, cream include well starter taste.) grease', 2.0116109000572986, N'dish', N'hard', CAST(N'1955-04-30T03:02:52.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (207, NULL, 608, N'Dr.', N'sandwiches.|Time they and dressing aioli made been they for these You unique The your a cheese, ordinary of eggs asked', 2.8513036155380789, N'dessert', N'easy', CAST(N'1954-08-04T21:50:33.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (208, NULL, 23, N'Mr', N'and they sugar a onions, them. well cheese. deviled brown cheese. as brown cakes than unique made make', 4.4872004499133684, N'dessert', N'hard', CAST(N'1979-01-12T10:06:12.150' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (209, NULL, 103, N'Mrs.', N'bacon, taste.) and is grease and grease and a enjoy bacon it holiday them been flavor full make and it ever', 5.7263730479061481, N'starter', N'easy', CAST(N'1982-03-20T14:36:28.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (210, NULL, 526, N'Ms.', N'cakes taste.) for full a as onions, as cream them. green cream than holiday bacon, a as serve and consuming', 2.1748323292354272, N'starter', N'hard', CAST(N'1984-12-09T06:17:22.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (211, NULL, 375, N'Mr', N'been holiday include have use onions, brown and as is dip shredded cakes green is sugar onions, you an', 2.078334011173963, N'starter', N'easy', CAST(N'1995-09-25T18:10:30.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (212, NULL, 457, N'Miss.', N'give a You that''s green dip told a and serve made is friends asked Enjoy! beautifully a and combine to told crab', 1.2841191088241148, N'dish', N'hard', CAST(N'1990-11-19T10:18:53.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (213, NULL, 586, N'Dr.', N'told it that''s is have they bacon cold include I''ve enjoy eggs.|Bacon it as give and and (I these ranch and consuming to', 2.5063137009303613, N'dish', N'medium', CAST(N'1993-04-21T18:16:39.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (214, NULL, 778, N'Miss', N'friends cheddar sandwiches.|Time or The sandwiches.|Time ordinary and over great over party, deviled these bacon', 2.8328876848485729, N'dessert', N'easy', CAST(N'1986-05-04T22:02:15.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (215, NULL, 700, N'Mr', N'full on a a We this told The and as and combine a since. sandwiches.|Time and party, Hope bacon, and', 3.2460757462522367, N'dessert', N'easy', CAST(N'1987-10-13T09:53:52.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (216, NULL, 465, N'Mr', N'You deviled as consuming aioli as beautifully ranch a crab make for cheese. a your cream deviled a to taste.) again', 3.5481677206923106, N'dessert', N'easy', CAST(N'1997-07-20T21:40:38.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (217, NULL, 838, N'Ms.', N'have made give flavor an mix! crab eggs.|Bacon cream and brown cheese. cheese. again for grease flavor', 5.6622271368569823, N'dish', N'hard', CAST(N'2009-03-15T14:57:59.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (218, NULL, 40, N'Mr', N'full that''s for been them and than Better We ranch deviled dip cheddar make much a as great consuming them', 4.6770371877015737, N'dish', N'medium', CAST(N'1981-01-04T06:32:08.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (219, NULL, 816, N'Mr', N'(I well.|This good deviled as for I''ve have cold I''ve cheddar garlic (I cold unique these as made spread', 1.0152595248144398, N'starter', N'easy', CAST(N'1995-01-02T14:22:52.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (220, NULL, 752, N'Mr', N'it! they (I as great as make include starter include make that''s a as starter and give grease well.|This', 3.0854275077979207, N'dessert', N'easy', CAST(N'2021-09-29T18:01:55.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (221, NULL, 924, N'Mr', N'to of combine them and recipe. make as on serve combine sandwiches.|Time and for family!|These spread than that''s spread much', 2.2117586523349204, N'dish', N'hard', CAST(N'1970-08-11T10:08:27.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (222, NULL, 992, N'Mr', N'it! an recipe. again but and a include deviled it bacon them. this deviled a recipe. ranch cheese, well', 4.5635043534280282, N'starter', N'hard', CAST(N'1992-06-26T20:49:04.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (223, NULL, 550, N'Mrs', N'enjoy ranch told such great We onions, them since. ranch ordinary spread well.|This good an unique Better such over', 1.8637002300767693, N'dessert', N'medium', CAST(N'1990-11-24T11:10:36.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (224, NULL, 966, N'Mr', N'an told give cheese, bacon a garlic as is them sandwiches.|Time worth or as my this dip over full bacon,', 4.040706451535554, N'dish', N'hard', CAST(N'1981-05-23T18:56:06.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (225, NULL, 431, N'Mr', N'a ordinary onions, dressing of beautifully dip my beautifully cream friends them as them taste.) (I over and include ever crab', 1.7605393863099346, N'dessert', N'medium', CAST(N'1978-01-02T20:20:24.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (226, NULL, 56, N'Mrs', N'they sugar is holiday consuming party, You enjoy that''s a your a Better for bacon starter bacon, Enjoy! mix! have', 1.6645422222393296, N'dessert', N'easy', CAST(N'1987-05-09T16:22:55.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (227, NULL, 308, N'Dr', N'use eggs deviled grease grease but (I as cheese, spread them for it cold brown use you a bacon, mix!', 2.1432225378897147, N'dessert', N'easy', CAST(N'2020-05-05T19:49:23.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (228, NULL, 866, N'Dr', N'dressing over cheese. green a is Cheddar eggs.|Bacon ranch been ordinary great mix! combine aioli that''s', 1.7954019800738441, N'dish', N'hard', CAST(N'1983-03-30T20:47:56.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (229, NULL, 667, N'Dr.', N'a your that''s dip but I''ve as enjoy been is serve great enjoy grease dip mix! and again unique combine', 2.3394712337010874, N'dish', N'easy', CAST(N'2013-11-28T09:38:06.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (230, NULL, 993, N'Dr.', N'enjoy great onions, but over cold great crab Hope recipe. a flavor ever (I them to cakes a such make', 5.5043787218185045, N'dessert', N'hard', CAST(N'2006-05-07T17:31:10.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (231, NULL, 52, N'Mr', N'mix! (I on Cheddar have them. and cheese. green a an cream use than deviled beautifully serve this of starter I''ve', 5.727103607602, N'starter', N'medium', CAST(N'1995-02-19T23:15:50.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (232, NULL, 701, N'Mr', N'for and grease bacon that''s as cheddar Hope but over a great this cheese. and Better use cheddar Enjoy! use your great', 2.144486119106638, N'dessert', N'easy', CAST(N'2014-12-12T22:51:47.410' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (233, NULL, 216, N'Mr', N'since. these Cheddar irresistible cakes crab consuming Better garlic been friends mix! it! you your to can eggs.|Bacon', 1.3269942199471378, N'dish', N'easy', CAST(N'1980-02-25T03:51:42.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (234, NULL, 519, N'Mr', N'flavor spread and it! over them enjoy aioli make recipe. deviled great bacon and and as include family!|These ever', 3.4941662943429157, N'starter', N'hard', CAST(N'1968-08-09T16:25:13.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (235, NULL, 511, N'Miss.', N'recipe. but to over starter Cheddar an irresistible beautifully as is them. bacon bacon a family!|These a and dressing', 5.13366654614623, N'starter', N'hard', CAST(N'2007-12-10T20:16:14.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (236, NULL, 186, N'Ms.', N'such bacon bacon, again holiday deviled bacon much but much it! of such a dip serve is cakes a ever brown', 5.6170221500177968, N'dessert', N'hard', CAST(N'1975-08-08T05:14:43.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (237, NULL, 384, N'Mr', N'deviled eggs.|Bacon have I''ve is a is flavor and it over is over good such my deviled and dressing full', 5.4393662896190609, N'starter', N'easy', CAST(N'1990-04-09T01:18:38.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (238, NULL, 833, N'Mr', N'beautifully a Better to as but holiday (I or starter eggs.|Bacon dip starter irresistible to beautifully give serve We', 2.6126818776189733, N'dish', N'easy', CAST(N'1974-11-08T14:19:06.500' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (239, NULL, 729, N'Mr', N'than that''s and onions, well.|This include include ever cream cheese. dip irresistible Better or grease', 1.22196017216051, N'dish', N'medium', CAST(N'1983-10-29T13:59:34.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (240, NULL, 536, N'Mr', N'brown can unique cakes over great (I can use it! include onions, to a The cheddar to cakes taste.) this', 1.9263035077258497, N'starter', N'medium', CAST(N'2018-04-25T02:31:53.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (241, NULL, 75, N'Ms', N'as cheese. as eggs.|Bacon include worth been a (I garlic I''ve beautifully cakes Enjoy! made Better grease', 5.3712727908842606, N'dessert', N'hard', CAST(N'1958-03-04T15:25:20.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (242, NULL, 917, N'Mr', N'use starter my sandwiches.|Time for taste.) as party, ranch that''s been Hope serve or have a You unique eggs as ranch have', 3.7560261440258591, N'dessert', N'medium', CAST(N'2019-12-29T13:36:08.910' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (243, NULL, 653, N'Mr', N'mix! friends enjoy worth great my as enjoy to been is serve well.|This cold as as and and a have shredded a', 5.6273566361644107, N'starter', N'hard', CAST(N'1960-05-15T17:09:57.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (244, NULL, 237, N'Mr', N'or sandwiches.|Time dressing include grease cheese, We them and a a as friends serve to beautifully such and again and an', 5.0607680725216717, N'dessert', N'hard', CAST(N'1972-02-10T01:06:30.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (245, NULL, 558, N'Ms.', N'include it such and spread but family!|These been to since. Enjoy! as deviled a include and party, but', 5.8771267220737071, N'dish', N'hard', CAST(N'1953-12-11T16:31:15.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (246, NULL, 743, N'Miss', N'onions, a beautifully is a to it as you give a and it! worth deviled good to over Cheddar great include', 1.1026697573730115, N'dessert', N'medium', CAST(N'1956-07-08T12:07:51.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (247, NULL, 589, N'Dr', N'ever cheese, combine to great they much and for green have enjoy bacon full Better for I''ve a give party,', 4.8015584269545775, N'starter', N'hard', CAST(N'1981-09-11T05:21:16.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (248, NULL, 183, N'Mr', N'a The them. sandwiches.|Time your brown ranch enjoy to mix! is asked again consuming your bacon and your full have but beautifully spread', 4.1375448094390075, N'dessert', N'easy', CAST(N'2014-04-16T13:45:06.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (249, NULL, 884, N'Mr', N'give your for my eggs beautifully as aioli Better you as sandwiches.|Time them cheese, combine good they great consuming can', 3.1485374808071822, N'dish', N'easy', CAST(N'2017-01-04T18:40:50.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (250, NULL, 241, N'Mr', N'green they (I to cheese. good is a as combine enjoy they sandwiches.|Time crab as it! crab to been since.', 3.5744239043325297, N'starter', N'hard', CAST(N'1965-04-03T23:32:06.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (251, NULL, 642, N'Mrs', N'great cakes is We it deviled since. them. sandwiches.|Time starter shredded as this for since. beautifully', 4.3211593322088753, N'starter', N'hard', CAST(N'1974-07-13T18:47:21.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (252, NULL, 934, N'Dr.', N'my they cakes my they I''ve enjoy dip shredded than taste.) or good You ordinary ranch sugar is than deviled for friends on', 2.3885778358152967, N'dish', N'medium', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (253, NULL, 547, N'Mrs.', N'The cheddar make made cold combine bacon bacon a shredded asked starter can cheese. and Hope these I''ve', 3.7626403108065207, N'dish', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (254, NULL, 258, N'Mr', N'can The and deviled sandwiches.|Time brown a You brown cheese, than dip cream bacon We shredded shredded', 5.9865606147733335, N'dessert', N'medium', CAST(N'2011-01-23T23:13:24.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (255, NULL, 167, N'Dr.', N'Better include but but great Cheddar asked sandwiches.|Time and or combine onions, full for since. as', 4.636474096512643, N'dish', N'medium', CAST(N'2003-11-27T13:29:15.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (256, NULL, 727, N'Dr.', N'cream combine holiday them them The deviled dip cheese. and sugar of over The these ranch such can spread for', 1.2420725418450649, N'dish', N'hard', CAST(N'1994-07-02T01:04:44.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (257, NULL, 3, N'Dr', N'that''s Hope taste.) cheese, and is eggs these cold friends enjoy since. I''ve eggs.|Bacon family!|These', 5.8493138979418733, N'dessert', N'hard', CAST(N'1986-02-06T07:34:57.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (258, NULL, 615, N'Mr', N'as ranch full cheddar as well told my them. The bacon such green since. deviled aioli deviled eggs deviled them grease over', 5.8492388310140182, N'dish', N'medium', CAST(N'1960-11-12T06:43:29.290' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (259, NULL, 967, N'Mr', N'grease dressing Hope such this and Hope give friends bacon to cheddar grease cold been aioli as have shredded', 5.69389823018289, N'starter', N'easy', CAST(N'1999-09-09T13:54:58.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (260, NULL, 73, N'Mr', N'irresistible a and use on made green this use of consuming enjoy and grease dressing and enjoy I''ve include ranch a party,', 4.0250883605448013, N'starter', N'hard', CAST(N'1981-03-28T07:54:14.320' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (261, NULL, 704, N'Ms.', N'or We ranch them well combine this it! Cheddar can great Hope sugar cream Enjoy! flavor dressing consuming', 5.8683883621675843, N'dish', N'hard', CAST(N'1992-05-20T19:54:22.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (262, NULL, 627, N'Dr', N'over made recipe. an it for sugar cheddar is brown as taste.) such a than unique sandwiches.|Time since.', 2.055901635464235, N'dish', N'medium', CAST(N'1968-03-13T18:16:29.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (263, NULL, 248, N'Mr', N'well.|This The cheese, for an a cheddar these Hope or made include Hope ever eggs grease Better to to them. cream', 3.147729216212281, N'dish', N'medium', CAST(N'1956-12-24T07:13:29.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (264, NULL, 933, N'Mr', N'great as can recipe. and that''s eggs worth have over told bacon ranch a unique that''s Hope made well.|This as Better it (I', 1.2219943260876436, N'starter', N'medium', CAST(N'1993-05-07T01:02:36.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (265, NULL, 109, N'Dr', N'dressing good good recipe. deviled ranch holiday great bacon great eggs.|Bacon a Cheddar over as over great', 2.4477287216334274, N'starter', N'easy', CAST(N'1987-02-14T00:28:05.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (266, NULL, 907, N'Dr.', N'your well this aioli to as give deviled Cheddar Better for been consuming starter unique much is and', 5.933847892067325, N'starter', N'easy', CAST(N'1997-11-12T21:05:18.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (267, NULL, 169, N'Mr', N'these over combine cheese, again cheese, cheese, sugar ever full you much it! cold cheddar ranch you full Better', 5.9571248888769768, N'dessert', N'hard', CAST(N'2011-10-20T07:01:31.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (268, NULL, 784, N'Dr', N'these dressing as mix! You mix! Hope flavor but ordinary have irresistible give flavor an family!|These over cheese. and', 5.0121474065874461, N'dish', N'medium', CAST(N'2002-10-13T19:18:43.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (269, NULL, 70, N'Miss.', N'them it! deviled ranch and and ordinary include combine asked cold them eggs Hope green give such is a make', 3.699221138702343, N'dessert', N'easy', CAST(N'1963-09-26T06:27:11.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (270, NULL, 88, N'Mrs', N'great I''ve them bacon enjoy cheddar and (I cheese, them than told We been ever deviled them your have', 3.6290535962344395, N'dessert', N'medium', CAST(N'1977-09-13T01:51:26.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (271, NULL, 567, N'Mr', N'than and over over been party, I''ve aioli use The Hope include made irresistible dip as a for since. can', 4.10880143107325, N'dessert', N'easy', CAST(N'2000-05-25T01:46:00.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (272, NULL, 138, N'Mr', N'been taste.) combine been on or on family!|These as Hope for consuming a include holiday a it unique', 4.049545259238009, N'dessert', N'medium', CAST(N'1965-03-08T04:39:09.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (273, NULL, 726, N'Mr', N'it as a is party, been flavor your it bacon, Hope enjoy make cold deviled Hope over they (I flavor shredded Better', 4.4550770155410646, N'dessert', N'easy', CAST(N'1960-04-13T20:21:59.910' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (274, NULL, 163, N'Dr', N'taste.) ranch been full than Hope sandwiches.|Time told combine a great as Better again it! sugar mix!', 5.0889560170885906, N'dessert', N'hard', CAST(N'1987-05-09T00:38:52.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (275, NULL, 448, N'Mr', N'such as Better great is a as make bacon or but taste.) consuming dip worth ordinary is is taste.) We', 3.7141547169136606, N'dessert', N'easy', CAST(N'2019-03-08T16:32:33.340' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (276, NULL, 238, N'Mr', N'mix! aioli have and include well.|This green it a as make it made brown You it made and give well friends', 4.4557325083090618, N'dish', N'medium', CAST(N'1998-09-09T11:50:58.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (277, NULL, 969, N'Dr.', N'holiday family!|These combine sugar flavor and such as your sugar worth bacon shredded make family!|These friends make', 4.9361477172636183, N'starter', N'hard', CAST(N'2016-07-29T02:36:34.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (278, NULL, 263, N'Mr', N'beautifully irresistible a and sandwiches.|Time is them and but onions, a it aioli them well.|This as', 2.8029321575550976, N'dessert', N'hard', CAST(N'1972-08-12T20:32:18.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (279, NULL, 156, N'Mr', N'eggs.|Bacon ordinary serve worth aioli worth have a as bacon, that''s of include You your for and shredded ranch asked', 4.1635797294618468, N'starter', N'easy', CAST(N'1985-02-12T03:39:06.500' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (280, NULL, 404, N'Mr', N'as cheese. deviled well well for is make Cheddar dressing as well over an and Hope can cream serve told', 1.6578696289369228, N'starter', N'easy', CAST(N'1971-10-16T10:04:05.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (281, NULL, 602, N'Dr.', N'crab party, starter combine can asked cold The them since. a include and a an you made and We a ordinary', 2.8629837952847517, N'dessert', N'easy', CAST(N'1980-06-13T02:24:51.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (282, NULL, 910, N'Mr', N'grease have this much much garlic and combine for and brown for worth eggs combine bacon you combine', 4.0056777284507064, N'starter', N'hard', CAST(N'1974-06-28T08:12:33.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (283, NULL, 264, N'Mr', N'good eggs deviled an full have starter The taste.) mix! to brown a and We and ordinary good family!|These beautifully I''ve', 4.6468644992666626, N'dessert', N'medium', CAST(N'1958-08-29T11:01:39.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (284, NULL, 55, N'Mr', N'but ranch a make again friends to have crab beautifully good Enjoy! that''s dressing flavor unique or over', 4.7650473293685582, N'dish', N'medium', CAST(N'1959-01-21T06:04:16.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (285, NULL, 785, N'Mr', N'or party, recipe. them since. flavor of We bacon ever asked Cheddar told as it and a cheese. a great been', 2.1832193896096292, N'dessert', N'easy', CAST(N'1988-03-25T02:07:06.600' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (286, NULL, 144, N'Mr', N'you recipe. made can sandwiches.|Time a them (I ever it sandwiches.|Time deviled or dip bacon beautifully as', 4.3385257717867036, N'dish', N'hard', CAST(N'2001-08-27T10:06:00.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (287, NULL, 51, N'Mr', N'again serve is for bacon, a and I''ve they cheese. holiday ranch sandwiches.|Time can bacon eggs.|Bacon', 4.3818458083001177, N'starter', N'easy', CAST(N'1984-10-25T22:43:48.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (288, NULL, 427, N'Dr.', N'ever You garlic this on again combine spread include give consuming my them Cheddar consuming worth again', 1.3404336051738046, N'dessert', N'medium', CAST(N'2006-01-27T00:02:26.240' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (289, NULL, 9, N'Dr', N'that''s cheese. combine an than worth on and can make told taste.) We well friends of a my over cold friends', 4.8576921978302732, N'dessert', N'easy', CAST(N'1964-01-17T09:22:31.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (290, NULL, 335, N'Mr', N'bacon and told them. over is asked beautifully good and garlic ranch your party, dip is have a sugar bacon, it', 4.8915940043011652, N'dish', N'hard', CAST(N'2007-08-26T02:46:57.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (291, NULL, 494, N'Mr', N'them. such great ranch as bacon, for that''s We these dip great my been dip and consuming a The You friends', 5.7677082520759235, N'dessert', N'hard', CAST(N'2004-07-03T08:50:15.960' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (292, NULL, 873, N'Mr', N'Cheddar you and again over my use your and to and sandwiches.|Time (I ever well starter as great spread', 5.5901274586050436, N'dessert', N'medium', CAST(N'2000-01-29T13:32:45.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (293, NULL, 21, N'Miss.', N'is Better ranch an bacon for party, and and is combine for a make of this bacon, that''s your ranch crab', 2.918783647436082, N'starter', N'hard', CAST(N'1997-11-28T15:19:45.150' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (294, NULL, 106, N'Dr.', N'have shredded is is been can to eggs and unique or over them party, a ranch cakes to Hope crab include', 3.1968718116157091, N'dish', N'medium', CAST(N'1962-01-12T17:24:23.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (295, NULL, 21, N'Miss', N'ever as or brown serve again give as you include than cream family!|These good spread it! it eggs.|Bacon We', 2.0579151455582654, N'dessert', N'medium', CAST(N'2004-06-19T18:24:44.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (296, NULL, 137, N'Mr', N'We to sugar sandwiches.|Time dip and beautifully use family!|These a (I beautifully a flavor bacon garlic', 4.315371155420026, N'dish', N'medium', CAST(N'1968-08-17T19:43:05.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (297, NULL, 6, N'Dr', N'great beautifully shredded and and eggs.|Bacon We Enjoy! use dip for The to spread sugar it dressing', 1.6082969278135788, N'dish', N'easy', CAST(N'2014-05-02T19:18:24.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (298, NULL, 517, N'Mr', N'have worth have since. asked these have grease ever Better You include a Cheddar have ranch ranch and', 5.4053623100767672, N'dessert', N'medium', CAST(N'1986-10-28T14:22:44.250' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (299, NULL, 311, N'Mr', N'and for or they over as dressing told sandwiches.|Time to cheese. make and cheddar as as spread a sandwiches.|Time include these', 3.6130393508882444, N'dessert', N'medium', CAST(N'1985-11-15T13:08:03.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (300, NULL, 283, N'Dr', N'and make shredded irresistible friends recipe. well.|This bacon taste.) much a is them garlic beautifully', 5.943278830006383, N'starter', N'medium', CAST(N'1984-07-02T20:04:39.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (301, NULL, 64, N'Mr', N'starter but them. but dip my much give told since. cheddar shredded it party, taste.) your as that''s these', 1.1455448684960348, N'dessert', N'medium', CAST(N'1982-04-22T18:04:59.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (302, NULL, 247, N'Mrs', N'make is over eggs.|Bacon a make for Enjoy! again for over you than and that''s enjoy told cheese, made than', 5.7894110203671323, N'dessert', N'easy', CAST(N'1973-02-27T21:12:32.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (303, NULL, 152, N'Miss.', N'I''ve friends them this combine as you bacon for spread grease holiday cheese. great them than use a you', 1.4383236707366647, N'starter', N'easy', CAST(N'2014-10-13T05:40:39.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (304, NULL, 266, N'Mr', N'holiday and you and unique great irresistible ever cheese, such it good and or aioli spread I''ve as since. ranch', 5.5194838845727423, N'dish', N'hard', CAST(N'1956-12-30T03:29:49.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (305, NULL, 1, N'Mr', N'you friends and and a of since. crab a spread onions, since. enjoy a and since. of enjoy a them bacon and to much', 5.46562247325928, N'dish', N'medium', CAST(N'1966-11-23T11:59:05.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (306, NULL, 57, N'Dr', N'them. ordinary holiday bacon, as sandwiches.|Time well combine as it recipe. give taste.) as I''ve holiday as well.|This made The eggs ranch', 1.2716140729708663, N'starter', N'easy', CAST(N'2004-10-30T14:01:40.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (307, NULL, 540, N'Mr', N'dressing them shredded to it bacon, cheddar for for bacon eggs.|Bacon been over include a cream but them cold have', 3.9335008202742325, N'dessert', N'medium', CAST(N'1957-12-22T03:10:06.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (308, NULL, 397, N'Mr', N'been it green to as since. mix! ranch a than dressing good and family!|These this again enjoy cakes as eggs.|Bacon', 4.6736842937179306, N'dish', N'hard', CAST(N'2009-03-06T18:08:29.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (309, NULL, 190, N'Dr.', N'irresistible cold is over family!|These asked to much on eggs.|Bacon bacon, great as mix! friends as can', 3.2724058978596728, N'dessert', N'easy', CAST(N'2013-11-17T06:40:51.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (310, NULL, 660, N'Mr', N'brown ranch for of ever to to them such as it cold eggs.|Bacon but taste.) again brown cheese, bacon, full', 1.1807415882035819, N'dessert', N'hard', CAST(N'1958-03-21T01:38:17.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (311, NULL, 250, N'Ms', N'aioli ranch since. garlic ranch for over on give holiday is a cheese, it use over of these to such enjoy give asked', 2.3059248245814463, N'dish', N'easy', CAST(N'1999-12-03T22:28:09.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (312, NULL, 613, N'Dr', N'my ranch your use good or and garlic for told and dip full a such ever deviled spread such to my bacon', 4.0463817403867752, N'starter', N'easy', CAST(N'1966-06-27T11:02:38.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (313, NULL, 185, N'Dr.', N'cakes party, full use cheese, and recipe. serve include mix! eggs.|Bacon use a than them. consuming worth', 2.6856591015521714, N'starter', N'medium', CAST(N'1997-09-30T03:04:22.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (314, NULL, 628, N'Mrs', N'it is onions, a and full The (I over well.|This since. sandwiches.|Time but consuming combine holiday great and', 5.0360286012459676, N'starter', N'easy', CAST(N'1980-11-25T03:50:52.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (315, NULL, 228, N'Mr', N'this and cream these is been an my this to such to beautifully ranch that''s well a taste.) taste.) consuming consuming', 2.1621045652600492, N'starter', N'hard', CAST(N'1953-10-16T05:29:22.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (316, NULL, 74, N'Mr', N'dip of a mix! or it cakes cream again spread sugar and as taste.) use have eggs.|Bacon your aioli cheddar told brown', 2.8627106337168771, N'dish', N'easy', CAST(N'1970-11-24T11:41:48.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (317, NULL, 829, N'Miss.', N'deviled told dressing great recipe. flavor but The made to starter over is garlic a and bacon, consuming', 3.4090371361975733, N'dish', N'hard', CAST(N'1962-07-17T07:14:50.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (318, NULL, 150, N'Miss.', N'holiday family!|These recipe. worth my a cream ordinary consuming ranch irresistible as cakes it good', 4.3826818868437236, N'starter', N'hard', CAST(N'2019-12-04T01:09:12.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (319, NULL, 675, N'Mr', N'ranch they it! deviled dressing and flavor or brown to been give use for deviled for eggs dip it party, as', 5.0387749364780143, N'dish', N'medium', CAST(N'1958-02-12T22:55:30.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (320, NULL, 491, N'Dr', N'worth again as (I eggs.|Bacon of a We enjoy enjoy deviled unique for as Better garlic a them and such', 4.1092029498467237, N'dish', N'medium', CAST(N'2007-06-19T14:22:05.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (321, NULL, 682, N'Miss', N'use mix! recipe. spread these dip combine and taste.) since. serve since. brown (I as or and cakes enjoy', 2.5520020837672064, N'dessert', N'hard', CAST(N'1966-01-18T22:21:29.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (322, NULL, 108, N'Dr', N'full spread recipe. cheddar a is shredded combine crab well beautifully spread and unique since. green', 5.6166912837031724, N'starter', N'medium', CAST(N'1958-09-24T06:59:05.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (323, NULL, 870, N'Dr', N'have your and well Better them them We and well as them The bacon and well.|This it! cream and The friends', 1.1544552087571729, N'dish', N'medium', CAST(N'1991-09-28T09:56:11.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (324, NULL, 17, N'Dr', N'bacon asked (I green and a spread sandwiches.|Time garlic it a aioli well bacon good flavor over green a as sandwiches.|Time combine since.', 4.8076271344011774, N'starter', N'easy', CAST(N'1978-01-31T03:40:13.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (325, NULL, 944, N'Mr', N'well.|This them. as cakes they and such is it ever brown sugar to they or include a and and Cheddar is', 3.8613453441585159, N'starter', N'medium', CAST(N'1995-03-12T17:01:10.400' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (326, NULL, 268, N'Miss.', N'and as as you cream eggs been is told and well.|This cheese. for can make sugar great my them. bacon', 4.5186739724682061, N'dessert', N'medium', CAST(N'1953-04-27T12:13:15.880' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (327, NULL, 637, N'Ms.', N'cheese. aioli for full can beautifully is great it! great Enjoy! cakes unique well eggs again bacon that''s garlic', 2.130761611801927, N'dessert', N'medium', CAST(N'1989-04-09T13:19:24.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (328, NULL, 528, N'Dr.', N'give family!|These Hope consuming since. told you much shredded well.|This good as told such You worth combine', 2.2582052039253551, N'starter', N'hard', CAST(N'2020-04-01T02:57:36.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (329, NULL, 919, N'Miss', N'aioli a as brown combine can spread as a for dip as can a been deviled and full great dip for unique', 4.0310408715303243, N'starter', N'easy', CAST(N'2004-11-18T06:14:08.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (330, NULL, 942, N'Dr', N'that''s these that''s an holiday The as you told cream unique taste.) good is ordinary friends flavor eggs', 5.3987835614936346, N'dish', N'hard', CAST(N'2003-07-22T20:49:27.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (331, NULL, 352, N'Mr', N'that''s bacon, serve it dressing serve make green them. and have an cold is dressing as worth eggs.|Bacon', 3.8474355804954818, N'dessert', N'medium', CAST(N'2006-05-09T16:32:33.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (332, NULL, 351, N'Miss', N'crab it made that''s ranch them. Better great well crab combine a ranch over family!|These We is worth', 5.5307854071868512, N'starter', N'medium', CAST(N'1982-10-02T12:13:50.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (333, NULL, 251, N'Dr.', N'and it combine eggs that''s The them been ranch of can is onions, worth to cheese, ranch irresistible', 5.1898928066668537, N'dessert', N'medium', CAST(N'2008-09-27T07:24:15.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (334, NULL, 245, N'Miss.', N'a can have beautifully flavor crab as I''ve can bacon my dip this bacon recipe. of them sandwiches.|Time full an', 4.2203008994554638, N'dessert', N'medium', CAST(N'1953-08-13T07:34:27.150' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (335, NULL, 43, N'Mrs', N'on I''ve you sugar cheddar family!|These and green as flavor but consuming cream We sugar Enjoy! and a irresistible them worth but', 1.5123247604408883, N'dish', N'hard', CAST(N'2011-06-25T15:59:06.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (336, NULL, 17, N'Miss.', N'spread as asked a than cream Cheddar and cakes such is and consuming Hope spread cream bacon, it! asked', 3.07357277491762, N'starter', N'hard', CAST(N'1960-04-16T05:12:19.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (337, NULL, 777, N'Mr', N'a and over bacon friends it! taste.) Cheddar green Better shredded such cheese, a onions, a is Hope eggs.|Bacon', 3.5673540577140423, N'starter', N'hard', CAST(N'1981-09-15T02:31:53.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (338, NULL, 304, N'Miss', N'them eggs over as Enjoy! as The to The Enjoy! to taste.) it recipe. green Cheddar serve since. a of cheese, sandwiches.|Time', 5.1273806146939194, N'dish', N'hard', CAST(N'1954-08-31T07:31:49.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (339, NULL, 62, N'Dr', N'dressing The shredded is aioli made brown as Cheddar a a ranch them. shredded good for taste.) dip cream been', 5.2994248561092769, N'starter', N'hard', CAST(N'2014-02-27T18:05:10.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (340, NULL, 93, N'Mr', N'over consuming deviled them they that''s and and Enjoy! them of as ever on brown a green it! spread beautifully party, to', 1.9116053166387628, N'dessert', N'hard', CAST(N'2005-05-25T12:05:25.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (341, NULL, 800, N'Mr', N'Hope combine as bacon, spread eggs.|Bacon great unique good cakes green ordinary ranch sandwiches.|Time', 1.4050249515124713, N'dessert', N'medium', CAST(N'1996-09-06T06:55:53.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (342, NULL, 410, N'Dr', N'recipe. bacon, to grease grease starter to cheese. and give unique a for unique consuming and been deviled combine grease', 5.7081615145821871, N'dessert', N'easy', CAST(N'1997-08-21T04:35:19.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (343, NULL, 230, N'Mr', N'brown a cheese, bacon, grease holiday bacon You and and ordinary Hope these give this I''ve Enjoy! these of dressing give', 4.0680277073141315, N'dessert', N'easy', CAST(N'2014-03-11T17:21:35.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (344, NULL, 76, N'Ms', N'shredded We and to garlic The sandwiches.|Time crab ever they you cheese. such as include dip include', 4.6769506096266911, N'dessert', N'medium', CAST(N'1958-10-30T07:44:14.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (345, NULL, 734, N'Mr', N'can You such on make eggs.|Bacon been have bacon made than on friends sugar and bacon, onions, and great enjoy', 3.5856691797197189, N'starter', N'hard', CAST(N'1960-09-23T04:18:48.330' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (346, NULL, 46, N'Mrs.', N'dressing is well crab is for as We a for good family!|These ever bacon for cream serve grease and starter spread', 2.7213265116891483, N'dessert', N'hard', CAST(N'1991-01-07T21:47:37.150' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (347, NULL, 806, N'Mr', N'and worth include on Cheddar as a crab but taste.) Cheddar made starter beautifully and give Better Cheddar', 3.9044683570528722, N'dish', N'hard', CAST(N'1955-05-02T10:28:22.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (348, NULL, 385, N'Dr.', N'spread as You a dip good starter taste.) aioli and mix! crab have cakes them onions, brown and beautifully', 3.8827550461901144, N'starter', N'hard', CAST(N'1970-01-04T11:28:52.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (349, NULL, 354, N'Dr', N'a been taste.) and deviled aioli include cheese, can my give full holiday for (I We We The mix! can and deviled them.', 2.03476724635566, N'starter', N'hard', CAST(N'1961-03-30T11:55:00.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (350, NULL, 347, N'Mr', N'Hope to cheddar Better ordinary but ranch since. flavor cold well.|This them. as and is and shredded', 5.1952045118413892, N'dish', N'medium', CAST(N'1986-07-28T06:42:55.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (351, NULL, 943, N'Miss.', N'make asked this deviled crab cheese. sandwiches.|Time (I bacon, deviled eggs flavor sandwiches.|Time', 1.9063340192224523, N'dessert', N'hard', CAST(N'1959-02-02T12:28:15.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (352, NULL, 756, N'Dr', N'and over Cheddar over ever unique it! over party, The green bacon have an Hope cheese, a taste.) and can', 3.2256150409698554, N'dish', N'medium', CAST(N'2016-05-29T18:09:12.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (353, NULL, 44, N'Miss.', N'an on ranch taste.) cheese, your and and spread taste.) spread and over bacon, can as a since. full a', 1.3665873735987524, N'dish', N'hard', CAST(N'1981-09-15T15:27:14.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (354, NULL, 268, N'Dr', N'but it! than and include a great ranch eggs it it! a such cold serve is since. well.|This dip or bacon', 5.5038364010415215, N'dish', N'easy', CAST(N'2000-05-28T22:45:57.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (355, NULL, 554, N'Miss', N'green onions, aioli bacon use and (I they good deviled it and cold grease party, a good a family!|These dip', 4.3912767462391766, N'dish', N'medium', CAST(N'1971-06-15T21:43:09.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (356, NULL, 158, N'Mr', N'bacon recipe. ever The taste.) asked well.|This that''s holiday they them for deviled it it taste.) for', 1.5288535847928624, N'dish', N'easy', CAST(N'1976-07-30T11:05:53.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (357, NULL, 331, N'Ms', N'ranch I''ve as Cheddar a but taste.) garlic You an Cheddar as dip cheddar can than it taste.) unique consuming and Enjoy!', 5.6349558116099594, N'starter', N'hard', CAST(N'2003-06-02T11:16:21.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (358, NULL, 565, N'Mrs', N'eggs.|Bacon these well mix! have holiday unique cold you and as starter an is as The my is told and Hope We', 2.6306965363354875, N'dessert', N'hard', CAST(N'1989-09-13T02:00:26.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (359, NULL, 503, N'Ms', N'grease flavor it crab have ever is it grease and mix! on and to your deviled flavor since. a deviled', 2.6581385404142264, N'dish', N'easy', CAST(N'1983-10-20T10:28:39.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (360, NULL, 792, N'Mr', N'and ever family!|These and combine can eggs.|Bacon include as again We as use is such your eggs.|Bacon', 1.946948500791075, N'dish', N'easy', CAST(N'1966-07-29T23:45:50.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (361, NULL, 166, N'Mrs.', N'over much a cream your have an for unique and as sandwiches.|Time make bacon, much sandwiches.|Time these', 5.1408524611689392, N'dish', N'medium', CAST(N'1968-07-24T00:42:16.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (362, NULL, 546, N'Mr', N'my is Hope bacon, flavor them much bacon worth of Better ordinary Cheddar these or Enjoy! to again as', 2.6752956163488775, N'dish', N'medium', CAST(N'1959-09-22T00:12:30.550' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (363, NULL, 298, N'Mrs.', N'this you eggs.|Bacon told Better cheddar can on a they made The as The them ranch have ranch have cheese.', 1.6426434221876056, N'dish', N'hard', CAST(N'1957-04-19T11:54:20.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (364, NULL, 232, N'Miss.', N'starter they and bacon or can We holiday cheddar eggs.|Bacon ever they is eggs holiday your been over is', 3.8736223363660378, N'dish', N'medium', CAST(N'1963-04-29T09:51:23.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (365, NULL, 335, N'Mr', N'it! garlic full full cakes onions, sugar good of that''s have Hope asked to have irresistible spread can The well.|This is a have', 3.3333060077081, N'starter', N'medium', CAST(N'1973-11-11T09:05:43.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (366, NULL, 489, N'Dr.', N'over ranch flavor this a can starter eggs.|Bacon but (I have a sandwiches.|Time well grease asked grease over grease', 2.7751394173945951, N'starter', N'medium', CAST(N'1970-03-04T10:14:19.150' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (367, NULL, 669, N'Mr', N'full been for aioli to combine as a a (I but party, Better holiday consuming of as serve cheese, holiday You asked cakes cakes cheese.', 4.8564889337199215, N'dish', N'hard', CAST(N'1979-09-30T03:38:23.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (368, NULL, 195, N'Miss', N'to flavor it beautifully since. such over cheddar cream as holiday have and and cakes is The them. your', 4.4653582020967075, N'starter', N'easy', CAST(N'1997-02-17T19:29:55.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (369, NULL, 133, N'Dr', N'starter Better The as brown and great as Cheddar and is a than and dip sandwiches.|Time onions, make green', 4.52370384080508, N'dessert', N'easy', CAST(N'1991-06-02T11:51:45.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (370, NULL, 417, N'Miss.', N'to made them. bacon your as over I''ve friends bacon green bacon to combine garlic family!|These onions,', 5.0885317903424294, N'starter', N'hard', CAST(N'2015-07-02T00:17:03.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (371, NULL, 862, N'Dr.', N'cakes much and grease eggs.|Bacon grease made or irresistible a and and or onions, well over you cheese. shredded', 5.2953565760028347, N'starter', N'medium', CAST(N'2011-03-11T09:09:55.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (372, NULL, 182, N'Dr.', N'use onions, and again have and great friends it have starter (I and brown you as my cheese, friends sugar I''ve good', 4.2816565215036535, N'starter', N'hard', CAST(N'1960-11-16T23:43:00.930' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (373, NULL, 305, N'Dr.', N'again great irresistible give great as garlic been onions, party, as or as Hope can deviled is it over', 5.0832570307344458, N'dessert', N'hard', CAST(N'1958-10-07T07:04:01.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (374, NULL, 174, N'Dr', N'and this as can family!|These and sandwiches.|Time deviled is is cheese, serve and as party, family!|These', 4.1271696198392522, N'dish', N'medium', CAST(N'1974-09-20T10:50:04.320' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (375, NULL, 562, N'Dr.', N'include beautifully crab spread sandwiches.|Time that''s it full made full friends recipe. and since.', 3.7041779983342522, N'dish', N'hard', CAST(N'1963-10-14T07:26:12.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (376, NULL, 351, N'Miss', N'as a an than deviled well it use dip include recipe. garlic irresistible over ordinary party, have as', 2.8438405691850188, N'starter', N'medium', CAST(N'1990-05-30T17:46:09.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (377, NULL, 294, N'Mr', N'over brown include well.|This asked flavor as make and Cheddar full it The recipe. enjoy sandwiches.|Time enjoy great', 2.5486635763890404, N'dish', N'easy', CAST(N'1966-07-15T13:37:30.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (378, NULL, 463, N'Dr', N'use flavor my ranch over on and Better ranch ranch over your ordinary holiday Better eggs.|Bacon make', 2.4775045991304818, N'dessert', N'hard', CAST(N'1985-11-30T02:11:56.680' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (379, NULL, 164, N'Mr', N'told green for friends as and We a a flavor much spread cakes green much sandwiches.|Time cheese. great', 2.221957954681459, N'starter', N'medium', CAST(N'1970-05-10T23:21:25.320' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (380, NULL, 123, N'Dr.', N'have beautifully than deviled recipe. this great cheese. unique dip is is cheddar of well is Cheddar your include and ever', 2.1400188324693676, N'starter', N'hard', CAST(N'1957-03-05T19:13:33.250' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (381, NULL, 740, N'Mr', N'crab great cheese, over mix! well.|This use cheese. sugar Cheddar crab over have and much cream that''s', 1.6142056154153335, N'starter', N'hard', CAST(N'2019-12-27T01:44:53.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (382, NULL, 174, N'Mr', N'and bacon brown as and been consuming as such this garlic Cheddar it cheese, as dressing and friends asked made', 4.2480065656118118, N'dish', N'hard', CAST(N'1972-04-06T01:50:31.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (383, NULL, 197, N'Mr', N'taste.) You ordinary aioli deviled an consuming well.|This as them. a full cakes unique an for irresistible', 1.2234379575696952, N'dessert', N'hard', CAST(N'2012-01-03T15:02:35.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (384, NULL, 235, N'Dr', N'friends great taste.) recipe. dip spread a sandwiches.|Time is can a this your is friends to brown garlic', 4.835836359688936, N'dessert', N'medium', CAST(N'1971-04-24T23:31:13.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (385, NULL, 766, N'Mrs.', N'cheddar that''s as over been The a well.|This party, that''s shredded an onions, deviled or onions, family!|These', 4.4924495422711832, N'dessert', N'easy', CAST(N'1997-06-20T08:21:12.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (386, NULL, 85, N'Ms.', N'much ever You irresistible full made flavor great have sandwiches.|Time that''s a green friends as them', 1.6218205395256264, N'dish', N'easy', CAST(N'2011-12-10T22:23:21.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (387, NULL, 709, N'Dr', N'or full green and spread you I''ve ever and make again deviled Better serve and a make can green worth great sugar', 5.1641980335880993, N'dessert', N'medium', CAST(N'1954-01-17T20:46:36.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (388, NULL, 260, N'Mr', N'sandwiches.|Time shredded ever it and have great them flavor (I a cakes unique an it! Cheddar eggs have asked', 5.6860564056253322, N'starter', N'easy', CAST(N'1961-05-02T08:38:17.610' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (389, NULL, 267, N'Mr', N'is a ranch flavor Cheddar aioli Hope cheese. good a use cold of great it! made as bacon a ranch since.', 5.8290241532162872, N'dish', N'hard', CAST(N'2004-02-28T09:51:17.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (390, NULL, 231, N'Ms.', N'serve worth a worth again is deviled onions, as worth sandwiches.|Time ever I''ve been cheese, it that''s', 5.9834711756480257, N'dessert', N'medium', CAST(N'1987-11-27T04:53:12.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (391, NULL, 401, N'Mrs.', N'ordinary worth made have friends ever aioli starter taste.) eggs.|Bacon holiday sandwiches.|Time worth to', 3.4386169633076604, N'starter', N'hard', CAST(N'1978-11-14T17:55:58.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (392, NULL, 88, N'Mr', N'and recipe. these and cream dressing give is (I but a and on Enjoy! eggs.|Bacon a is is for them since.', 1.9366575213785551, N'dish', N'hard', CAST(N'2014-01-02T00:31:27.600' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (393, NULL, 356, N'Mr', N'cheese, party, told as is great that''s such (I a and is mix! is You grease a consuming and include have', 3.469242074279693, N'starter', N'hard', CAST(N'1992-11-10T21:03:10.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (394, NULL, 318, N'Ms.', N'deviled and a as taste.) shredded such good dressing spread deviled ever again such cheese. and bacon since.', 4.3524763553182018, N'dish', N'hard', CAST(N'2000-08-01T18:19:20.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (395, NULL, 2, N'Mr', N'but You friends since. over ranch have bacon is have bacon a to make Enjoy! it a cheddar taste.) over', 2.7707528554698233, N'dish', N'easy', CAST(N'1989-11-02T11:23:09.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (396, NULL, 927, N'Mr', N'or You them. family!|These Cheddar use it cheese, it! sugar combine have I''ve it this made full I''ve', 4.7297293351635936, N'starter', N'hard', CAST(N'1989-12-17T06:43:22.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (397, NULL, 334, N'Mr', N'friends holiday include Better Cheddar cheese, and holiday enjoy cheese, combine green a for a party, been a deviled', 5.0655180923945817, N'starter', N'medium', CAST(N'1993-05-04T16:40:59.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (398, NULL, 241, N'Ms.', N'such much ordinary You been dip a but dip unique ranch on and eggs.|Bacon good or as bacon, garlic and', 1.1944053709480937, N'dish', N'hard', CAST(N'2003-11-14T07:30:11.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (399, NULL, 190, N'Mrs', N'beautifully bacon and been over and this grease great starter cream worth well.|This shredded them for but as is', 2.3436446019185917, N'dessert', N'hard', CAST(N'2006-12-18T22:38:31.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (400, NULL, 853, N'Mr', N'Better a been You cakes as a again been have cheddar for bacon dip deviled beautifully it! them. sugar We', 1.8105297623251238, N'starter', N'easy', CAST(N'2012-07-21T18:04:29.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (401, NULL, 130, N'Mr', N'combine as and them dip worth garlic them asked friends is for cream give party, such beautifully well.|This bacon', 3.8648375779692259, N'starter', N'easy', CAST(N'1964-04-10T18:09:13.680' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (402, NULL, 159, N'Ms', N'spread them include told cream irresistible brown garlic holiday cakes garlic can shredded enjoy crab great I''ve', 5.4391101549561647, N'dish', N'hard', CAST(N'1980-03-13T14:58:26.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (403, NULL, 110, N'Mr', N'and a been onions, The brown is The and much you again bacon serve over for recipe. bacon have cheddar ordinary', 5.3590512053850343, N'dish', N'medium', CAST(N'2000-08-03T23:37:06.880' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (404, NULL, 522, N'Mrs', N'bacon, or your they recipe. them ordinary enjoy over irresistible brown deviled consuming have a much these', 2.9462354560132304, N'starter', N'hard', CAST(N'1967-09-29T11:37:57.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (405, NULL, 256, N'Mr', N'for a of green Hope a again a but dip and crab a it combine green dip an We for serve starter for over ranch', 5.8998479358385536, N'starter', N'easy', CAST(N'1997-05-18T21:32:59.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (406, NULL, 201, N'Mr', N'much sandwiches.|Time brown cold cheese, and cakes well.|This much made them. been deviled cheese, of that''s We', 3.6246774977187988, N'dish', N'hard', CAST(N'2020-03-17T12:45:14.330' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (407, NULL, 324, N'Miss', N'recipe. brown as holiday spread combine Hope cheddar them use cheddar The or dip but and combine and Better a cheese, my', 4.1423580102354087, N'dish', N'medium', CAST(N'2010-08-24T11:05:10.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (408, NULL, 357, N'Mr', N'a make and of family!|These combine flavor ranch cheese. they it sandwiches.|Time mix! over cheese. cheddar serve', 3.2394177537595006, N'dessert', N'easy', CAST(N'1959-12-28T04:37:09.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (409, NULL, 531, N'Mr', N'shredded such We You cold cheddar these friends eggs use you them bacon, that''s well.|This party, much', 2.7996584027072688, N'dessert', N'easy', CAST(N'1989-08-16T15:19:45.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (410, NULL, 62, N'Mr', N'good and beautifully cheese, worth Cheddar this to as they much starter dressing been and I''ve grease', 2.5474361770541574, N'dish', N'easy', CAST(N'2003-01-16T03:56:59.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (411, NULL, 501, N'Dr.', N'an irresistible as again friends it it! is again been family!|These and beautifully have them for bacon than to', 4.980190008403822, N'starter', N'easy', CAST(N'1963-01-16T21:28:23.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (412, NULL, 718, N'Dr.', N'worth green asked sandwiches.|Time these but over told have and and family!|These and as have been as', 4.1574512124794776, N'starter', N'hard', CAST(N'1970-07-04T09:04:24.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (413, NULL, 549, N'Mr', N'garlic these friends well.|This dip such them. flavor cheese. cream We include dip over flavor good can party,', 1.4087385816540283, N'dessert', N'medium', CAST(N'1972-05-06T02:39:00.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (414, NULL, 828, N'Mr', N'You a use give it! give a can irresistible my and much on asked over been and unique or them dressing ranch ranch You', 1.5181197079448587, N'starter', N'easy', CAST(N'1979-08-17T15:15:06.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (415, NULL, 572, N'Mr', N'them and told deviled these you Enjoy! as much include crab as flavor serve this asked You deviled cheese, great', 1.3327428853757413, N'starter', N'medium', CAST(N'1968-08-02T22:00:56.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (416, NULL, 309, N'Mr', N'Hope Better beautifully beautifully The spread and since. that''s holiday include as full and and serve', 1.892845895557127, N'dessert', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (417, NULL, 34, N'Dr.', N'cream shredded an or mix! eggs.|Bacon great it! give have shredded give for my combine dip and over cakes', 2.4518576587791823, N'dessert', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (418, NULL, 339, N'Mr', N'been bacon brown been over it this eggs.|Bacon bacon over can and a I''ve such as full bacon as and and', 2.8068070624986694, N'dish', N'easy', CAST(N'2018-04-18T22:51:45.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (419, NULL, 428, N'Mr', N'grease as have have is as than consuming onions, (I eggs them. have have is Better well.|This a Enjoy! and Cheddar', 5.381172794094855, N'dessert', N'medium', CAST(N'1969-09-18T09:09:55.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (420, NULL, NULL, N'Ms.', N'great well family!|These as beautifully dressing dip sandwiches.|Time deviled made deviled since. worth shredded a', 2.7114854681824729, N'dish', N'medium', CAST(N'2007-12-26T12:23:07.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (421, NULL, 214, N'Dr.', N'cream You can as give cakes on over Enjoy! brown them. than them been much crab a You than for it! and full they friends Enjoy!', 3.6109413838064954, N'starter', N'easy', CAST(N'1987-11-09T01:30:10.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (422, NULL, 200, N'Mrs', N'We full is much but a them. brown onions, on sandwiches.|Time it! cheese, ranch these brown include is', 5.17043252809459, N'starter', N'medium', CAST(N'1983-12-02T10:42:21.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (423, NULL, 341, N'Mr', N'this for ranch enjoy a mix! and make grease cakes made full mix! taste.) of of The them. cakes Cheddar give it and', 4.6363340488804194, N'dessert', N'easy', CAST(N'1969-02-15T13:27:42.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (424, NULL, 385, N'Mr', N'such bacon or much than Cheddar your a You again Hope is garlic or recipe. friends and cheese, friends', 4.5402326651570535, N'dessert', N'medium', CAST(N'1971-05-31T19:00:05.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (425, NULL, 899, N'Miss.', N'it! holiday have and well.|This cheese, your again crab and use and ever bacon, asked told again irresistible and', 2.649914827034769, N'dessert', N'easy', CAST(N'2014-12-21T09:38:38.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (426, NULL, 389, N'Ms.', N'these and cheddar as ranch make well.|This enjoy as ranch and cold on they grease is is it consuming', 4.35869905462428, N'dessert', N'medium', CAST(N'1956-07-07T06:58:32.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (427, NULL, 182, N'Mr', N'as a green than grease full I''ve recipe. bacon, been it bacon Hope and well over great an have is dip and', 1.8124144472239607, N'starter', N'easy', CAST(N'1989-08-18T06:21:05.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (428, NULL, 916, N'Mr', N'than garlic family!|These eggs since. friends an is crab for brown on and a Enjoy! been grease and this', 1.7307806754162445, N'dish', N'hard', CAST(N'2019-03-09T08:38:27.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (429, NULL, 115, N'Mr', N'and cheese. cheddar dip and as told they cream bacon them than been been taste.) them. they spread green', 2.3564167643694285, N'starter', N'easy', CAST(N'1990-01-06T02:39:50.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (430, NULL, 16, N'Ms', N'aioli crab since. flavor since. party, dip recipe. for taste.) cheese, a again as of these as cheese,', 4.9744486631706586, N'dish', N'hard', CAST(N'1980-03-06T12:44:40.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (431, NULL, 638, N'Mr', N'include again as as your dip starter as as great is The and than of or told to I''ve You enjoy a an your on', 3.7783224767904366, N'dessert', N'easy', CAST(N'2006-11-17T23:26:55.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (432, NULL, 38, N'Mrs', N'enjoy deviled onions, such beautifully can or have been Better an this dip is my dip Enjoy! as them your', 2.3542582054409467, N'dessert', N'easy', CAST(N'1995-10-28T00:42:49.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (433, NULL, 176, N'Mr', N'can is eggs cakes again give dip friends well.|This worth this dressing much flavor my a made bacon,', 1.1338599972118904, N'starter', N'easy', CAST(N'2019-01-26T01:05:10.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (434, NULL, 361, N'Mr', N'family!|These unique eggs.|Bacon cheddar recipe. that''s aioli combine and and for over ranch Better have and', 1.4114281923563352, N'starter', N'easy', CAST(N'1984-08-31T06:07:18.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (435, NULL, 90, N'Mr', N'they a well.|This a worth ordinary of as again been deviled (I We recipe. crab consuming to told told', 4.2751812545001417, N'starter', N'hard', CAST(N'2000-12-12T03:33:25.410' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (436, NULL, 889, N'Ms.', N'cold as Cheddar these as as The for as have flavor and this cheese, sandwiches.|Time We serve as eggs', 2.1750954604591688, N'dessert', N'hard', CAST(N'1979-10-20T05:16:56.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (437, NULL, 406, N'Mr', N'well and bacon of full and it have eggs can friends it! is make cheese, brown bacon cold to over bacon, dip beautifully enjoy', 4.8889553602267775, N'starter', N'easy', CAST(N'2014-11-25T01:04:19.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (438, NULL, 444, N'Mr', N'worth party, unique as consuming since. mix! great bacon bacon full consuming it! sandwiches.|Time your worth', 4.2772025015564648, N'dessert', N'easy', CAST(N'1992-10-15T10:46:27.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (439, NULL, 301, N'Dr', N'them it such bacon bacon great and good irresistible over starter than and as garlic great have much', 4.9359884238503815, N'dessert', N'medium', CAST(N'1993-09-02T02:13:24.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (440, NULL, 377, N'Mr', N'of party, friends that''s it! a deviled and Better them. recipe. deviled as have You dip it good beautifully flavor serve an', 1.867772044552384, N'starter', N'medium', CAST(N'1997-04-07T03:24:37.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (441, NULL, 290, N'Mr', N'full include is ever good cold over enjoy bacon much or over asked combine grease is is such or cakes deviled The', 3.4794625292902173, N'dessert', N'medium', CAST(N'1995-12-07T01:58:13.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (442, NULL, 53, N'Miss.', N'dip them. mix! been cakes ordinary as these Enjoy! dip been enjoy Hope for have a cheese, Enjoy! friends that''s', 2.9247802798285987, N'dessert', N'easy', CAST(N'1999-04-04T19:35:58.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (443, NULL, 203, N'Miss', N'(I dip and been as worth recipe. an been cheddar give to as cheese. bacon, to ranch well ever over shredded', 3.8863980029180638, N'starter', N'easy', CAST(N'1954-04-19T11:18:10.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (444, NULL, 493, N'Miss', N'it mix! than combine We and been it is grease onions, eggs to consuming a recipe. crab for and to much as', 4.2815879761621307, N'starter', N'hard', CAST(N'2016-01-21T16:09:26.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (445, NULL, 200, N'Mr', N'much a a eggs.|Bacon and Cheddar on cheddar a bacon, sugar crab a Enjoy! I''ve and my cheese, We a green', 2.0032811672442037, N'dessert', N'medium', CAST(N'1993-09-15T17:18:32.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (446, NULL, 225, N'Mr', N'I''ve aioli much worth to shredded as ever have since. as you well.|This holiday sugar use full unique', 5.2811657508281833, N'dessert', N'hard', CAST(N'1954-02-13T05:54:17.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (447, NULL, 413, N'Ms.', N'I''ve dressing Enjoy! grease for a have You have bacon a such enjoy can it! full a since. Hope include', 1.5279189397245268, N'dessert', N'medium', CAST(N'1977-11-11T07:24:49.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (448, NULL, 332, N'Miss.', N'dressing You deviled a is your and over unique ranch for that''s bacon shredded spread ranch dip you but', 2.9511223663348343, N'dessert', N'medium', CAST(N'1961-05-14T08:51:33.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (449, NULL, NULL, N'Dr.', N'for mix! unique eggs.|Bacon they a cold for cheese, bacon and you is a and a and told onions, serve made', 4.0197334699424605, N'dish', N'medium', CAST(N'1994-08-29T21:52:26.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (450, NULL, 291, N'Mr', N'a eggs We dip deviled them. been and unique The than deviled a taste.) cheese. The cheese, eggs.|Bacon much much', 1.8779069599126963, N'dessert', N'medium', CAST(N'1966-03-28T05:48:04.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (451, NULL, 293, N'Dr.', N'crab as you as sandwiches.|Time asked and Enjoy! unique (I them can worth We We aioli Better aioli is great of ranch an over use aioli', 3.2778716763844118, N'dish', N'easy', CAST(N'1984-12-30T20:18:24.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (452, NULL, 299, N'Mr', N'beautifully on asked eggs.|Bacon them. a as they they family!|These Better shredded full been it as shredded them family!|These and', 3.2587110298959123, N'dessert', N'easy', CAST(N'1993-07-16T12:31:24.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (453, NULL, 430, N'Mr', N'unique them. You give mix! and as bacon bacon green crab The can and Cheddar starter and irresistible they good', 1.8132325768532382, N'dessert', N'medium', CAST(N'1973-03-31T21:33:27.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (454, NULL, 362, N'Mr', N'my dip and is over spread them (I a aioli on flavor (I shredded great dressing spread party, a Cheddar Better over', 5.6321591337361188, N'starter', N'easy', CAST(N'2007-05-10T04:17:51.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (455, NULL, 431, N'Mr', N'ever You bacon, but Hope combine is (I I''ve as a flavor brown since. onions, on green this a or use eggs.|Bacon', 4.1995883785186283, N'dessert', N'hard', CAST(N'1969-01-06T06:00:01.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (456, NULL, 290, N'Mr', N'shredded brown it again cream dip them brown a to party, a a and I''ve or dip I''ve unique but been is', 4.6944050498746357, N'starter', N'hard', CAST(N'1976-01-18T11:56:09.330' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (457, NULL, 798, N'Mr', N'and brown irresistible it ordinary is dip eggs aioli recipe. irresistible ever beautifully cheese. as', 1.8027761060757452, N'dessert', N'medium', CAST(N'1996-06-06T04:36:46.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (458, NULL, 264, N'Mr', N'Hope party, Better Better taste.) it been include them. cheddar beautifully eggs.|Bacon serve that''s holiday cheese, them.', 1.8188185402279806, N'dish', N'easy', CAST(N'2014-11-10T23:09:07.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (459, NULL, 135, N'Mrs', N'and garlic to holiday The include as Enjoy! ordinary good cheese. give and such as a been and have this', 1.2963206289784615, N'starter', N'hard', CAST(N'1987-03-24T05:19:48.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (460, NULL, 985, N'Mr', N'cheddar holiday Enjoy! friends We have them eggs.|Bacon them. than ranch cream for and bacon I''ve include', 2.5411488812142746, N'starter', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (461, NULL, 647, N'Mr', N'starter it! cold spread been cream an cream bacon, as shredded sandwiches.|Time been well full combine cold use', 2.8122630504948383, N'dish', N'medium', CAST(N'1997-01-28T16:38:34.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (462, NULL, 204, N'Miss.', N'since. been them told a combine than a but deviled full We enjoy cheese, but starter cheese, worth since. since. friends', 3.4115773348191647, N'starter', N'hard', CAST(N'2000-02-11T05:16:51.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (463, NULL, 429, N'Miss', N'your them. ranch holiday asked cheese. use cold serve grease eggs Enjoy! and cold bacon serve been bacon, bacon them my Cheddar', 1.8830009893900721, N'dessert', N'easy', CAST(N'2000-03-11T12:54:32.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (464, NULL, 382, N'Mr', N'for and The made irresistible is a for cream include bacon and ranch Enjoy! well to family!|These flavor', 3.8252097395366107, N'dish', N'medium', CAST(N'1983-03-13T10:05:23.500' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (465, NULL, 50, N'Ms', N'over grease full bacon, dip it a beautifully a my deviled them shredded cold flavor and enjoy this bacon but', 4.7691137002637207, N'dish', N'hard', CAST(N'1983-06-20T22:20:29.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (466, NULL, 434, N'Mr', N'well a enjoy We cheese, to as great made and asked cheese, friends to you consuming again cheddar full taste.)', 3.6259318029628749, N'starter', N'hard', CAST(N'1975-02-09T05:10:14.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (467, NULL, 11, N'Mr', N'unique been a and to a mix! bacon than and as give have recipe. enjoy holiday and as as good as for have and recipe.', 4.0235912152675866, N'starter', N'hard', CAST(N'2015-10-20T14:36:56.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (468, NULL, 84, N'Dr', N'dressing green deviled grease I''ve your ranch they this Hope (I The cheese. as I''ve Enjoy! Hope include', 5.9973103892976933, N'dish', N'easy', CAST(N'2005-12-21T02:51:48.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (469, NULL, 54, N'Ms.', N'onions, and make and for can or I''ve ranch it! again taste.) them. party, been crab well a eggs a as', 3.2429384534447165, N'starter', N'medium', CAST(N'2000-05-17T15:21:04.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (470, NULL, 568, N'Dr', N'been my spread as Better on as mix! irresistible dressing such on since. it starter unique cheese, and', 5.157647424916572, N'starter', N'medium', CAST(N'1991-07-23T05:30:58.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (471, NULL, 377, N'Miss', N'Hope over my dressing Hope for but unique worth as great sugar onions, of ordinary that''s or that''s for', 3.0038905353303487, N'dish', N'medium', CAST(N'2014-07-17T21:22:04.610' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (472, NULL, 473, N'Mr', N'give of it Better onions, for your brown and them as dip for ordinary Better great for We cream a cream for', 4.174655157222718, N'starter', N'hard', CAST(N'1986-09-22T14:10:46.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (473, NULL, 14, N'Mrs.', N'a great ordinary my use include Enjoy! Enjoy! green them your this them sugar a flavor include beautifully You unique and', 3.8708186386482875, N'dish', N'hard', CAST(N'1997-10-18T11:14:29.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (474, NULL, 285, N'Miss.', N'eggs.|Bacon this have beautifully party, well.|This include a onions, dressing well You them been such grease bacon', 4.5134007495424715, N'dish', N'hard', CAST(N'1977-08-17T20:38:20.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (475, NULL, 58, N'Mrs.', N'a We is great deviled serve You Enjoy! I''ve well.|This dressing a as they much can cold for irresistible', 5.2320229388922561, N'dish', N'easy', CAST(N'1994-06-13T05:45:17.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (476, NULL, 708, N'Mr', N'and a use friends been can them. crab bacon a We as beautifully over Cheddar use worth cheese. can ordinary', 1.6861611039778968, N'dish', N'easy', CAST(N'1965-01-20T10:24:53.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (477, NULL, 717, N'Miss', N'cold dressing brown taste.) have friends and it! bacon bacon been deviled an beautifully garlic great full cheddar or', 2.2840345251765264, N'starter', N'medium', CAST(N'2010-08-06T05:54:12.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (478, NULL, 880, N'Ms', N'grease as is told as cheese, this Hope ever have Better ordinary cheese. on friends them my and The cheese,', 1.3547460727182896, N'dish', N'medium', CAST(N'1982-08-15T23:24:11.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (479, NULL, 425, N'Mr', N'green well is been for this deviled it! The holiday good but is give recipe. good over told and serve these', 3.53695149791285, N'starter', N'easy', CAST(N'1975-01-25T21:18:16.230' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (480, NULL, 35, N'Ms.', N'asked of as I''ve flavor than your and beautifully flavor made cheddar deviled cheddar made such sandwiches.|Time', 3.3687490762065857, N'dessert', N'easy', CAST(N'1999-09-15T01:41:33.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (481, NULL, 211, N'Miss', N'and Hope these they and bacon is can The told ever cheese, combine deviled bacon, starter cheese. as', 3.8307801148997527, N'starter', N'easy', CAST(N'2013-11-08T03:44:20.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (482, NULL, 114, N'Mr', N'cheese, them is an great enjoy serve ranch and them on over a irresistible unique friends for eggs The shredded', 4.8612920808891271, N'starter', N'hard', CAST(N'2000-08-25T23:33:43.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (483, NULL, 403, N'Mr', N'You full to sugar shredded as and is grease taste.) bacon that''s enjoy much The crab a and and dip as', 3.711047205473784, N'dessert', N'easy', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (484, NULL, 266, N'Dr', N'been and combine asked use and dip since. starter recipe. to you that''s give Hope been The deviled it! deviled dip flavor ordinary my taste.) these', 1.4785098044567322, N'dish', N'hard', CAST(N'1981-04-06T21:29:31.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (485, NULL, NULL, N'Dr.', N'deviled told such as cream ranch them crab starter well.|This your (I or bacon bacon, give these can cheese,', 2.6965769867862468, N'starter', N'medium', CAST(N'1977-07-11T10:46:00.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (486, NULL, 545, N'Miss.', N'Hope as them. is as recipe. for but of Enjoy! told them. to bacon, have them mix! cakes ordinary can and', 1.5196114468945243, N'dessert', N'hard', CAST(N'1976-10-11T20:51:46.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (487, NULL, 73, N'Mr', N'as unique again starter is eggs and shredded deviled ranch enjoy told worth use eggs.|Bacon dip dip deviled a them. cream', 1.5410256285877086, N'starter', N'medium', CAST(N'2017-03-06T16:26:16.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (488, NULL, 475, N'Mr', N'ranch is ordinary sandwiches.|Time since. and eggs.|Bacon bacon have and cold is good much that''s cream', 1.501700863475772, N'dessert', N'hard', CAST(N'1966-05-05T10:55:30.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (489, NULL, 525, N'Mr', N'but cakes such eggs they shredded I''ve these a them cold eggs I''ve holiday ranch ranch to made irresistible onions,', 3.2118398138377069, N'dish', N'easy', CAST(N'1975-07-30T03:09:21.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (490, NULL, 325, N'Mr', N'starter sandwiches.|Time you garlic for as make onions, holiday ordinary your can cheese. a dressing', 5.5807762046255061, N'dessert', N'hard', CAST(N'1964-09-18T20:47:18.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (491, NULL, 250, N'Mr', N'them an you a an garlic as ranch a and they asked over as these for cakes is as ever to that''s You bacon and', 1.3723193543834236, N'starter', N'easy', CAST(N'1968-08-26T00:07:17.340' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (492, NULL, 48, N'Dr.', N'unique bacon onions, as is taste.) holiday as (I them as recipe. spread for a as it can these eggs.|Bacon than', 4.0701368199987975, N'dessert', N'easy', CAST(N'1977-11-25T15:37:16.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (493, NULL, 856, N'Mr', N'sandwiches.|Time this aioli eggs.|Bacon and for worth The it! include dip ranch well.|This irresistible', 3.9808818725780033, N'dish', N'medium', CAST(N'2005-05-15T00:40:09.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (494, NULL, 104, N'Mr', N'Enjoy! to have cheese, made a holiday give is over ordinary it dip a brown garlic ranch spread cheese, and onions,', 3.3948395426361073, N'dish', N'hard', CAST(N'1953-01-15T01:55:11.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (495, NULL, 146, N'Mr', N'such over shredded is eggs include eggs.|Bacon these I''ve ranch brown grease and flavor cheese. cold crab', 5.0555089940575462, N'dish', N'hard', CAST(N'1958-07-26T05:26:38.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (496, NULL, 349, N'Mr', N'and cheese, and and ever a a (I crab and for include grease cheese, a cream it! shredded they can over than been such', 1.0678851944710526, N'dessert', N'medium', CAST(N'2018-08-04T09:34:50.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (497, NULL, 112, N'Mr', N'flavor your brown grease ever onions, flavor onions, and (I to worth great include a The cheese. to give', 2.0417792904385266, N'dessert', N'easy', CAST(N'2019-02-24T22:07:46.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (498, NULL, 401, N'Mr', N'cheese. is that''s enjoy You since. them as over flavor beautifully as made include crab include flavor a', 1.0611882633814533, N'dessert', N'medium', CAST(N'2017-09-26T13:03:41.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (499, NULL, 74, N'Mr', N'friends ordinary that''s worth again my combine for (I full much grease it! ranch bacon cream and it and eggs.|Bacon ordinary and well', 5.5124742758984091, N'dish', N'hard', CAST(N'1969-01-23T09:30:34.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (500, NULL, NULL, N'Mr', N'and and a cream for and been such I''ve serve and as unique deviled cold serve grease made your ordinary', 4.3773493642813293, N'dish', N'medium', CAST(N'1992-10-29T12:57:41.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (501, NULL, 852, N'Mr', N'good eggs.|Bacon dressing of unique beautifully as taste.) a on good deviled can have garlic consuming sugar', 2.2575745355605958, N'dessert', N'easy', CAST(N'1993-12-13T10:59:11.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (502, NULL, 476, N'Mr', N'that''s and Better much full these for them grease a brown holiday of eggs.|Bacon brown and worth asked', 1.5306085504268336, N'starter', N'easy', CAST(N'1999-11-27T02:41:35.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (503, NULL, 399, N'Mr', N'a it deviled such starter a sugar is You ever beautifully or a them over bacon is spread ever been starter', 5.7081839128901173, N'dessert', N'hard', CAST(N'1970-02-23T03:02:28.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (504, NULL, 19, N'Dr', N'but a have crab cakes garlic taste.) Enjoy! sandwiches.|Time a a aioli make a I''ve a sugar irresistible since.', 4.8620860450258885, N'starter', N'easy', CAST(N'1999-06-26T16:03:44.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (505, NULL, 750, N'Mr', N'and a these aioli combine than full deviled onions, this made green include or cheese, cakes We these', 4.8740164245823472, N'starter', N'hard', CAST(N'1991-10-23T03:20:34.960' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (506, NULL, 153, N'Mr', N'well The friends ever a that''s (I eggs.|Bacon for irresistible brown well.|This is deviled much it! on', 5.1032165191616938, N'dish', N'medium', CAST(N'2002-02-12T00:30:22.230' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (507, NULL, 115, N'Mr', N'been but as an as them been as ever as worth serve a they dip shredded much enjoy as consuming a have give combine been good', 5.3878923912476244, N'starter', N'easy', CAST(N'2001-07-05T15:37:17.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (508, NULL, 663, N'Mr', N'sugar We You as told combine cheddar can holiday have as include enjoy cream again much We have to party,', 3.2998318273107672, N'starter', N'medium', CAST(N'2009-03-14T09:03:54.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (509, NULL, 353, N'Ms.', N'them. a they it! sugar and this deviled serve taste.) a combine great such sugar dressing green much', 1.4001361948438622, N'dish', N'easy', CAST(N'1968-11-29T15:53:03.910' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (510, NULL, 99, N'Miss', N'brown as mix! for garlic consuming is Better You well.|This grease it! eggs.|Bacon I''ve a a this your enjoy well.|This', 3.5134272745407316, N'starter', N'hard', CAST(N'2000-10-18T15:48:09.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (511, NULL, 396, N'Mr', N'your been make your ranch dressing flavor aioli told brown well.|This ever cheddar cold good that''s holiday', 3.4103705246981098, N'dessert', N'medium', CAST(N'1995-04-20T17:52:58.340' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (512, NULL, 432, N'Mr', N'and and garlic garlic over dip cakes as my told been crab these spread Hope shredded told aioli dressing', 1.4480300333574554, N'starter', N'easy', CAST(N'1980-06-02T00:05:48.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (513, NULL, 97, N'Mr', N'asked spread cheddar give dip a or made well.|This for of and We these recipe. cheese, ranch this and', 4.281867042315131, N'starter', N'easy', CAST(N'2015-06-04T12:31:58.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (514, NULL, 330, N'Mr', N'it combine much party, of Better it! consuming brown (I ranch full and serve I''ve them as use grease', 3.9275715527718753, N'dish', N'medium', CAST(N'1974-05-13T07:18:30.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (515, NULL, 557, N'Mr', N'such for great them well.|This you and (I over We or Cheddar as Hope or again bacon, family!|These eggs.|Bacon', 4.7103687663145219, N'dessert', N'hard', CAST(N'1968-02-27T21:27:34.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (516, NULL, 243, N'Dr.', N'make beautifully over as cheese, made taste.) to it mix! or is as sandwiches.|Time and well beautifully', 3.950970969605712, N'dish', N'medium', CAST(N'1995-05-16T01:35:27.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (517, NULL, 295, N'Mr', N'Better enjoy deviled worth use they unique made crab a consuming for ranch than as and a for well.|This', 5.70053012934538, N'starter', N'medium', CAST(N'2018-06-04T17:04:50.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (518, NULL, 676, N'Dr', N'recipe. as you such ever full bacon bacon well.|This sugar worth bacon they full grease told made unique', 1.40449118493334, N'dish', N'easy', CAST(N'1971-11-07T07:47:20.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (519, NULL, 472, N'Mr', N'grease deviled cream to family!|These you sandwiches.|Time these cheddar ranch unique as eggs good You', 2.1286327527503635, N'dish', N'hard', CAST(N'1975-09-02T02:08:31.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (520, NULL, 649, N'Mr', N'dip (I and this unique you much bacon is or and but have an them cream spread a use and ever than bacon and', 4.2495022533691964, N'dessert', N'easy', CAST(N'1959-06-02T13:13:36.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (521, NULL, 837, N'Mr', N'cheese, eggs deviled over cheese, Enjoy! ranch good told been as an (I a again a and green deviled great sugar', 3.084906174375166, N'dessert', N'easy', CAST(N'1988-04-15T05:54:12.920' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (522, NULL, 603, N'Ms', N'well.|This a cheese, irresistible aioli I''ve eggs been well.|This your We use combine bacon a Hope a', 3.5218903517918152, N'starter', N'hard', CAST(N'1961-10-07T18:14:43.960' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (523, NULL, 584, N'Mr', N'is as grease and family!|These as party, crab combine holiday cheddar and deviled green it well crab', 3.7854705754599864, N'starter', N'hard', CAST(N'1993-03-24T11:27:34.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (524, NULL, 697, N'Mr', N'taste.) flavor it! holiday sandwiches.|Time to great have much beautifully have them serve much again to green well.|This deviled unique', 3.6621622488192109, N'starter', N'hard', CAST(N'1994-04-04T06:04:30.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (525, NULL, 450, N'Mr', N'aioli much asked been to been since. can you a shredded spread is consuming grease enjoy full them and ordinary', 4.7853280705331489, N'starter', N'easy', CAST(N'1984-09-22T15:13:47.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (526, NULL, 365, N'Mr', N'to You Cheddar these family!|These a an you or such sandwiches.|Time bacon, Better recipe. great over and', 4.9337537153315516, N'dessert', N'medium', CAST(N'1966-08-28T13:53:42.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (527, NULL, NULL, N'Ms.', N'(I a since. include as again recipe. a cheese. unique and eggs cream worth You party, is We been as over', 1.1937732846447142, N'dish', N'easy', CAST(N'1962-03-05T20:41:54.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (528, NULL, 498, N'Mr', N'taste.) they than great combine eggs.|Bacon to them Better Hope Cheddar cheese, your party, been you', 1.4759790960121801, N'starter', N'easy', CAST(N'1986-09-08T12:15:34.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (529, NULL, 976, N'Ms.', N'it! it to to a dip serve enjoy as or as full cheese. cakes cheddar made well holiday such beautifully', 5.4578917554849253, N'starter', N'easy', CAST(N'1992-03-26T05:47:50.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (530, NULL, 142, N'Dr.', N'have you cheese, over on been The these dip onions, such good onions, they them it! holiday and We cakes as ranch made', 5.164137744421204, N'dessert', N'medium', CAST(N'1981-01-13T11:03:29.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (531, NULL, 469, N'Mr', N'have bacon, onions, made them friends well garlic shredded is a unique cheese. this Hope they them. a', 5.64438181353937, N'dish', N'hard', CAST(N'1997-04-18T07:37:31.600' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (532, NULL, 935, N'Mr', N'consuming dressing as over sandwiches.|Time asked Hope been ranch brown You a include a mix! on irresistible cheese, brown that''s unique', 2.2228462617950728, N'starter', N'hard', CAST(N'1969-04-25T21:21:12.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (533, NULL, 931, N'Mr', N'as and holiday dip them than and dip been worth or Better use grease it ever much or for great it than sugar them a', 1.8422717968198805, N'starter', N'medium', CAST(N'1994-07-14T20:23:37.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (534, NULL, 334, N'Mrs', N'since. to green sugar dip deviled grease and over or a have it! it use a to have You made dip cheese. such eggs.|Bacon', 5.1596021336315205, N'dessert', N'medium', CAST(N'2011-10-17T10:26:30.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (535, NULL, 791, N'Mr', N'bacon, over recipe. consuming recipe. them have these cakes them. irresistible give dressing bacon these', 2.11117454064599, N'dessert', N'easy', CAST(N'2003-02-12T10:19:04.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (536, NULL, 181, N'Mr', N'taste.) cream You as cakes have worth a asked to or cold dip shredded and and and made Better great your starter on combine You', 3.3001715644729193, N'starter', N'hard', CAST(N'2021-10-18T22:59:57.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (537, NULL, 689, N'Mr', N'these to this flavor We than grease aioli onions, ranch you a dip You and ordinary you Better a over and a holiday', 5.1531081679990089, N'starter', N'easy', CAST(N'1996-09-16T00:41:52.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (538, NULL, 42, N'Dr.', N'as and I''ve and asked and it been recipe. sugar cheese, is I''ve eggs.|Bacon serve dip combine use shredded', 4.8489611604478959, N'dessert', N'easy', CAST(N'1954-03-03T07:29:58.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (539, NULL, 764, N'Mrs', N'it! cold Better bacon green and irresistible dressing eggs.|Bacon cheese, aioli dip great eggs as cakes', 2.6044933798743846, N'starter', N'hard', CAST(N'2011-06-15T18:08:56.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (540, NULL, 890, N'Dr.', N'family!|These told such sugar cheese, serve full We as full great made over and my shredded it told made a give you over', 3.5933604676245525, N'dessert', N'hard', CAST(N'1997-05-29T10:15:38.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (541, NULL, 542, N'Dr.', N'have great spread since. but been can onions, than much include these it! cold a can spread ranch and cheese.', 2.1317190556469, N'dessert', N'medium', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (542, NULL, 397, N'Mr', N'sandwiches.|Time been them enjoy ranch a unique Better as The irresistible as as a aioli of I''ve holiday dip cream great I''ve include great', 4.2411938012769417, N'starter', N'easy', CAST(N'1997-04-08T05:14:29.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (543, NULL, 826, N'Dr.', N'again on a I''ve as it! ranch irresistible is family!|These made cold dip bacon, dressing taste.) party, much', 1.1015646686319098, N'dish', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (544, NULL, 741, N'Mrs', N'them for it and enjoy eggs as it ordinary such well it such cheese, include an a dressing holiday cold cream', 5.6984125392969753, N'starter', N'easy', CAST(N'1960-12-24T07:22:21.920' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (545, NULL, 768, N'Dr.', N'deviled and bacon bacon dip holiday been use deviled is enjoy holiday over have it brown my mix! and', 3.1704056799273963, N'dessert', N'medium', CAST(N'2019-06-05T19:02:26.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (546, NULL, 212, N'Mr', N'The dip shredded a The been them and ranch well well.|This sandwiches.|Time We and a been deviled great dressing', 5.9242893210259684, N'dessert', N'hard', CAST(N'1996-10-10T11:21:12.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (547, NULL, 429, N'Dr.', N'them. deviled I''ve recipe. of them. as on aioli as a it starter unique give and you dip much grease but', 5.7882697776836665, N'dish', N'easy', CAST(N'1991-06-01T02:54:20.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (548, NULL, 49, N'Mr', N'cream on deviled family!|These have taste.) great cream and cakes bacon a as for unique give and grease that''s and a', 1.053310319806128, N'dessert', N'hard', CAST(N'2010-03-26T00:01:28.930' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (549, NULL, 902, N'Mr', N'recipe. to dressing asked of bacon, well.|This than such well eggs them they party, much again again', 4.6844707763215858, N'dish', N'hard', CAST(N'1984-06-23T03:05:17.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (550, NULL, 269, N'Dr.', N'Hope enjoy aioli cheese, combine bacon much to bacon them eggs that''s deviled a to over irresistible asked', 2.1045380244518341, N'starter', N'medium', CAST(N'1984-01-03T17:21:39.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (551, NULL, 507, N'Ms', N'as you Enjoy! Better a since. well garlic told it! cheese, bacon serve recipe. bacon grease bacon, over', 1.3673550651256718, N'dish', N'easy', CAST(N'2006-11-18T04:27:37.680' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (552, NULL, 275, N'Mr', N'to or ordinary been green and is deviled again holiday been cream cheese, party, a it taste.) cream much cakes', 1.6372881055051871, N'dish', N'hard', CAST(N'1985-03-12T03:51:11.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (553, NULL, 269, N'Ms', N'You sugar an and a worth this consuming as dressing include dip it great and to I''ve deviled a We this them', 4.93255551063109, N'dish', N'medium', CAST(N'1953-03-02T16:29:59.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (554, NULL, 677, N'Dr.', N'(I friends and have and shredded to to full a they full aioli such asked dressing recipe. as as irresistible', 2.2629720225292127, N'dessert', N'hard', CAST(N'2000-04-20T14:20:25.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (555, NULL, 863, N'Mr', N'have a great you sugar cheese. and aioli have dip and a since. cheese, a bacon is is and bacon and and', 2.2924431899061628, N'dish', N'medium', CAST(N'1995-01-26T10:55:10.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (556, NULL, 545, N'Ms.', N'irresistible is cheese. they you can these deviled brown serve over grease over such spread ranch great', 4.7356841837687806, N'dessert', N'medium', CAST(N'1962-08-24T20:16:57.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (557, NULL, 478, N'Dr.', N'cheese, Cheddar great to Enjoy! cheese, Better than is a sandwiches.|Time sandwiches.|Time and asked', 3.7451379749668474, N'dessert', N'easy', CAST(N'1957-07-17T07:03:28.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (558, NULL, 781, N'Mr', N'to that''s Better full a aioli asked holiday and party, told holiday cold cream and it made grease asked that''s', 3.0460216640709068, N'dessert', N'hard', CAST(N'1985-03-08T16:44:27.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (559, NULL, 502, N'Dr.', N'you ever is cakes but beautifully great mix! been starter a spread these dip your combine cakes ranch', 1.0767579744927389, N'dessert', N'hard', CAST(N'1959-09-05T15:14:01.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (560, NULL, 254, N'Mr', N'Better a told bacon, starter for it Enjoy! told spread brown holiday starter You a Hope Hope well.|This', 5.9402627092507965, N'starter', N'easy', CAST(N'1997-11-20T20:57:58.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (561, NULL, 758, N'Mr', N'it over and We a garlic (I on cheese, irresistible deviled been ever that''s again them Cheddar been can', 4.90944323451698, N'dessert', N'easy', CAST(N'1967-10-05T00:49:57.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (562, NULL, 71, N'Mr', N'these great them. a or told ranch cheese, good holiday unique I''ve much bacon this friends eggs beautifully', 4.9119132952354452, N'starter', N'easy', CAST(N'1978-02-25T13:26:52.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (563, NULL, 522, N'Mr', N'but irresistible combine and flavor a as a green bacon that''s cheese, been cold as Better is The Hope a', 3.8419400718258414, N'dessert', N'medium', CAST(N'1992-12-10T03:48:27.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (564, NULL, 364, N'Ms', N'is can starter enjoy enjoy or or for on dip starter worth for well been a made party, party, ordinary told that''s', 2.2359984504226587, N'dessert', N'medium', CAST(N'1967-10-29T03:21:42.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (565, NULL, 194, N'Mr', N'bacon, great give worth ordinary to these cheese. can these family!|These on and an and give crab cheese, a', 3.8690454610013614, N'dessert', N'easy', CAST(N'1969-12-20T03:16:04.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (566, NULL, 521, N'Ms', N'worth ordinary and they worth have worth shredded and much sugar great unique as as on The Better is', 2.1875242629030369, N'dessert', N'medium', CAST(N'2009-11-16T04:49:34.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (567, NULL, 170, N'Mr', N'an ever it a it and and make dip again cold and is a well.|This cheese, cold garlic green brown again', 5.6057582365375751, N'dessert', N'hard', CAST(N'1956-07-03T08:10:38.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (568, NULL, 169, N'Mr', N'as use your sandwiches.|Time this as since. again worth again been onions, on use and cheese, family!|These serve sugar', 5.12226490868361, N'dish', N'medium', CAST(N'1978-12-26T20:31:46.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (569, NULL, 370, N'Mr', N'well.|This and of is to flavor told a it for eggs ranch it and deviled these family!|These sandwiches.|Time family!|These', 2.8163970121258854, N'dish', N'easy', CAST(N'2007-11-19T03:42:10.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (570, NULL, 366, N'Mr', N'starter worth and bacon bacon taste.) been bacon use them include them over been dip friends enjoy well.|This and as', 2.4101972018416027, N'dessert', N'hard', CAST(N'1956-08-19T02:05:27.920' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (571, NULL, 780, N'Mr', N'good bacon worth Cheddar to my starter as but ranch bacon since. been mix! green I''ve to them but over', 4.7978628016067031, N'starter', N'easy', CAST(N'1993-03-30T20:59:25.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (572, NULL, 179, N'Mr', N'great include this holiday worth Enjoy! have told made and dressing good cheese, Enjoy! cheese, party, but', 1.8515689688974848, N'dish', N'medium', CAST(N'1968-05-10T22:27:36.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (573, NULL, 561, N'Mr', N'to is full of they bacon cheddar We We starter recipe. it sandwiches.|Time since. spread unique made', 4.7999978050589549, N'starter', N'easy', CAST(N'2020-08-29T00:53:35.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (574, NULL, 427, N'Mrs', N'than include mix! ordinary serve consuming unique deviled combine that''s it! a them garlic enjoy or brown', 4.53527228512581, N'dish', N'hard', CAST(N'2017-04-04T09:34:52.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (575, NULL, 368, N'Miss', N'an sandwiches.|Time green and irresistible taste.) eggs great my of dip and dip irresistible onions, again', 3.117783197722297, N'starter', N'medium', CAST(N'1982-05-24T13:38:23.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (576, NULL, 705, N'Dr', N'ranch a it a my it a it! sandwiches.|Time as cheddar made ranch a Hope or as they mix! much well You', 4.8437123730982243, N'dessert', N'easy', CAST(N'2000-04-04T15:52:52.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (577, NULL, 95, N'Dr.', N'combine bacon, aioli and it! a Better ordinary a onions, crab deviled make been a of aioli again mix!', 3.4203256831599056, N'dessert', N'hard', CAST(N'1984-02-24T07:59:07.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (578, NULL, 48, N'Mrs', N'You as as grease use spread give a and friends but can it We and ever can them make again ordinary friends', 4.0870580361630111, N'starter', N'hard', CAST(N'1980-04-22T22:31:50.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (579, NULL, 366, N'Mrs', N'ranch spread recipe. ever serve grease is brown ever enjoy eggs.|Bacon is cold flavor dip it have cakes party, Enjoy!', 1.4917565688918142, N'starter', N'easy', CAST(N'1964-05-03T23:12:17.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (580, NULL, 95, N'Mr', N'irresistible shredded Hope is sugar your holiday dip this as over but and for is eggs spread Enjoy! than include', 4.8610387495071805, N'starter', N'easy', CAST(N'2018-06-14T00:06:21.930' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (581, NULL, 55, N'Mr', N'Hope them and it ordinary for bacon crab you much a well.|This unique for shredded enjoy a irresistible', 5.1454839376478851, N'dish', N'medium', CAST(N'1955-11-05T03:10:09.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (582, NULL, 60, N'Mr', N'as recipe. told of cheddar cold on than eggs.|Bacon consuming eggs an made a been over such a and great', 1.1404629648385862, N'dessert', N'medium', CAST(N'1996-06-29T15:12:18.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (583, NULL, 808, N'Mr', N'them give a on to is spread The such onions, and and dressing onions, Enjoy! been dip bacon, good You and and as again Better aioli to as', 2.7915083196905943, N'dish', N'easy', CAST(N'2004-03-06T10:48:24.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (584, NULL, 206, N'Mr', N'aioli as been made full is much cheddar cream your you bacon and unique unique but cheddar cheese. they', 4.3533537310330912, N'dessert', N'medium', CAST(N'2000-03-02T03:20:15.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (585, NULL, 430, N'Mr', N'over made include serve a you cheese, for enjoy your starter it such grease and to holiday dressing over', 4.7967826792955321, N'starter', N'medium', CAST(N'2001-10-21T07:47:57.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (586, NULL, 782, N'Dr', N'well.|This cheese, you and dressing cakes ranch told as but over recipe. that''s We for garlic combine deviled', 5.0070937080341826, N'starter', N'easy', CAST(N'1960-01-16T01:56:39.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (587, NULL, 936, N'Dr', N'brown you and again bacon Better cheddar and I''ve great a or as as and ranch dip for a The a cheddar ordinary', 3.2902907511639832, N'dessert', N'easy', CAST(N'1980-11-13T18:33:29.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (588, NULL, 696, N'Dr.', N'or include you brown and much that''s you is onions, Better your over Better they cheese. ranch these', 5.5792997742906678, N'dish', N'hard', CAST(N'2018-12-28T17:17:05.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (589, NULL, 477, N'Miss', N'a family!|These ordinary for eggs eggs.|Bacon grease and that''s Cheddar ranch full of aioli consuming', 3.8671589437253582, N'starter', N'easy', CAST(N'1996-03-30T10:26:02.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (590, NULL, 388, N'Mr', N'holiday over flavor or aioli my cheese, your have such been cold it but starter good and your cheddar and sugar', 3.3754903568772088, N'starter', N'hard', CAST(N'1984-11-21T00:06:40.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (591, NULL, 458, N'Mr', N'eggs.|Bacon shredded taste.) a them a worth We them enjoy again enjoy to to serve this as (I and shredded', 5.5550335895060714, N'starter', N'medium', CAST(N'2007-04-03T03:23:02.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (592, NULL, 313, N'Mr', N'much much well.|This and and ever make friends is for ranch unique for eggs and friends use ever since.', 3.1070865039281022, N'dish', N'easy', CAST(N'1970-12-07T17:34:36.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (593, NULL, 416, N'Mrs', N'ranch bacon bacon recipe. to a over as well.|This told bacon made cheese, they ever asked deviled it The Better', 4.7722031859551564, N'dessert', N'easy', CAST(N'2015-02-14T07:45:56.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (594, NULL, 322, N'Dr.', N'that''s garlic holiday is The as ordinary have is your as spread grease grease beautifully We cheddar', 2.6642306706235885, N'starter', N'medium', CAST(N'2020-10-26T03:43:53.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (595, NULL, 111, N'Mr', N'my is garlic Better eggs.|Bacon great and a to such worth to you friends party, beautifully it these', 4.6839172331075734, N'dessert', N'hard', CAST(N'2008-05-29T06:40:00.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (596, NULL, 177, N'Mr', N'full them. starter flavor over that''s dressing Hope shredded unique since. cheddar over of worth is as them', 3.2198057604114552, N'dish', N'medium', CAST(N'1986-04-21T04:42:04.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (597, NULL, 24, N'Mr', N'bacon brown aioli have Cheddar they serve I''ve such for a been grease bacon, worth crab a deviled and but', 1.3992537294511003, N'starter', N'medium', CAST(N'1957-06-20T06:27:11.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (598, NULL, 328, N'Mr', N'a a been dressing as We shredded but friends flavor as cakes sandwiches.|Time can onions, deviled cakes worth', 4.8655662182092509, N'dessert', N'easy', CAST(N'1982-06-12T01:52:46.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (599, NULL, 762, N'Ms.', N'as You to asked ranch You cold them a my since. good cheese. grease aioli Enjoy! taste.) is eggs.|Bacon cakes', 2.829367078295614, N'dish', N'easy', CAST(N'2013-01-04T04:06:17.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (600, NULL, 633, N'Miss', N'Cheddar dip family!|These since. aioli enjoy unique shredded as as these than ever dressing as taste.)', 1.9828814170243598, N'starter', N'hard', CAST(N'1962-07-21T14:12:52.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (601, NULL, 894, N'Dr.', N'again been them been (I have bacon, cheddar brown and but deviled bacon an give well.|This since. since.', 1.3185310844883933, N'starter', N'easy', CAST(N'1993-04-10T03:10:34.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (602, NULL, NULL, N'Mr', N'a my sugar and The much well.|This that''s have a cakes them give (I use my consuming full and Cheddar a as', 1.6660048690000573, N'starter', N'medium', CAST(N'1965-06-06T06:22:34.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (603, NULL, 411, N'Dr', N'shredded combine use been party, dip great deviled enjoy them. sandwiches.|Time to recipe. cheddar it!', 4.2369133076802425, N'dish', N'hard', CAST(N'1955-05-08T20:19:18.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (604, NULL, 473, N'Mrs.', N'cheese, deviled Better over a worth deviled a told over ever a Enjoy! as beautifully cheese, them these include deviled', 3.2742735744799831, N'dessert', N'easy', CAST(N'1980-11-05T00:59:50.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (605, NULL, 248, N'Mr', N'flavor or a aioli dip The have over over been make over dip and garlic green starter full bacon, great You use', 3.306675222845131, N'dessert', N'easy', CAST(N'2012-10-04T20:22:13.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (606, NULL, 350, N'Dr', N'as as over garlic well bacon, your to have been and again they a my over (I these over You great an I''ve', 5.5157860962281866, N'dessert', N'medium', CAST(N'1991-07-11T06:00:01.500' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (607, NULL, 18, N'Mrs.', N'is these consuming than eggs flavor can (I beautifully flavor dip dressing combine eggs.|Bacon you green it!', 2.8372903004462322, N'starter', N'medium', CAST(N'1986-07-14T02:57:35.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (608, NULL, 128, N'Mr', N'have bacon than friends but unique worth and dressing well.|This over as on over Enjoy! unique but aioli', 1.3972832255052792, N'dessert', N'medium', CAST(N'1957-11-28T06:55:07.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (609, NULL, 527, N'Dr.', N'The give cream friends they and good We told cream dip dressing and as good such and and recipe. taste.)', 5.1451888248069153, N'dessert', N'easy', CAST(N'1970-11-29T00:42:02.550' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (610, NULL, 272, N'Mr', N'dip my these include sandwiches.|Time deviled as dip to unique than but great taste.) my cold holiday', 3.4487308168079385, N'dessert', N'easy', CAST(N'2016-10-22T19:02:17.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (611, NULL, 432, N'Dr', N'include it starter recipe. include sandwiches.|Time and a taste.) can I''ve as I''ve again recipe. spread', 2.3153585006088755, N'starter', N'medium', CAST(N'2000-06-30T12:17:50.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (612, NULL, 229, N'Mr', N'well.|This cheese, give bacon bacon, cheese, Hope combine deviled eggs a to as brown deviled made consuming', 5.6580799388038372, N'dessert', N'medium', CAST(N'1999-03-26T08:31:37.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (613, NULL, 402, N'Mr', N'bacon aioli dip and they much it deviled a as ranch and them ever well cheese, as make asked is sandwiches.|Time', 2.5542650951790926, N'dessert', N'hard', CAST(N'1973-11-05T17:32:10.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (614, NULL, 357, N'Mr', N'Hope dip made irresistible friends give a Enjoy! sandwiches.|Time it and or deviled over is recipe. eggs use', 2.2157192249855582, N'dessert', N'hard', CAST(N'1963-03-24T15:07:39.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (615, NULL, 315, N'Mrs.', N'cheese, beautifully bacon as been mix! and to Hope to grease such of much Cheddar (I combine recipe. is', 1.7947787716029113, N'dessert', N'hard', CAST(N'1995-01-17T17:47:48.880' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (616, NULL, 312, N'Mr', N'and is and this an a a brown beautifully a than over this cheese, as Better this than Enjoy! mix! give', 4.7689802696783934, N'starter', N'hard', CAST(N'1993-04-06T09:37:38.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (617, NULL, 679, N'Mr', N'dressing aioli include them holiday a is dip as aioli have is good an Better green mix! as can family!|These', 3.12040497554485, N'dessert', N'hard', CAST(N'1995-12-22T02:38:27.290' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (618, NULL, 284, N'Mrs', N'irresistible of consuming cakes dip ever mix! good much enjoy have enjoy is it! you cheddar good dip', 5.48858634079275, N'starter', N'hard', CAST(N'2014-10-10T00:28:12.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (619, NULL, 423, N'Mr', N'them. they them We have worth and on taste.) they spread and a cold since. make told of irresistible', 3.439215771127127, N'dish', N'easy', CAST(N'1988-01-07T19:33:45.910' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (620, NULL, 591, N'Mr', N'of and onions, include deviled taste.) dressing include dressing ever I''ve cheddar holiday cheese, asked', 4.8619517529671787, N'dish', N'hard', CAST(N'1962-12-06T01:19:24.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (621, NULL, 537, N'Mrs', N'cheddar a for brown eggs.|Bacon family!|These mix! these an include to it recipe. cakes asked is We dip told a', 4.8972335117390529, N'dessert', N'medium', CAST(N'1982-01-03T10:16:04.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (622, NULL, 493, N'Mr', N'been as such flavor it for deviled worth Cheddar onions, a We and a ranch it they ranch bacon, worth', 1.0264584622469071, N'dish', N'hard', CAST(N'1959-07-06T14:53:32.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (623, NULL, 210, N'Mr', N'sugar give as spread and as is and a sugar an it of aioli serve is them a taste.) party, is as been a', 2.2551059649582514, N'starter', N'medium', CAST(N'2004-09-27T10:05:43.880' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (624, NULL, 399, N'Mr', N'Enjoy! over again can and We over worth good been and and than or use for as dip as cream to it and give', 5.4409066552486767, N'starter', N'medium', CAST(N'1975-12-30T03:35:30.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (625, NULL, 165, N'Mr', N'asked Enjoy! bacon, sandwiches.|Time You you The a a eggs they bacon, and can they bacon a friends of', 2.8551636123355308, N'dish', N'easy', CAST(N'1971-05-18T22:42:25.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (626, NULL, 565, N'Mr', N'ever aioli and enjoy as been told ordinary them give is party, been to much made ranch party, mix! sugar', 2.6907762976786014, N'dessert', N'easy', CAST(N'1975-04-25T03:24:49.170' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (627, NULL, 317, N'Mr', N'eggs is Cheddar green to eggs it dip have eggs green cheese, is to cheddar a enjoy green deviled asked', 3.0793657829423275, N'dessert', N'easy', CAST(N'1975-03-27T14:41:40.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (628, NULL, 745, N'Mrs.', N'well cakes irresistible over include use family!|These told cakes recipe. Enjoy! can well a a full use', 3.1357671344353664, N'starter', N'medium', CAST(N'2021-11-02T21:09:41.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (629, NULL, 194, N'Dr', N'sandwiches.|Time family!|These give sugar serve friends full that''s taste.) brown you and that''s been and', 5.8513550520182385, N'dish', N'easy', CAST(N'1961-11-07T02:54:51.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (630, NULL, 258, N'Mr', N'worth and your worth serve bacon, as your as consuming bacon as deviled eggs them. green irresistible dip and', 5.8979774373108418, N'dish', N'hard', CAST(N'2018-02-02T08:56:18.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (631, NULL, 249, N'Mr', N'been can but use ordinary bacon ranch have cheese, or sugar family!|These I''ve onions, friends told good great', 4.4444586436471241, N'dish', N'medium', CAST(N'1995-10-17T09:25:41.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (632, NULL, 893, N'Mr', N'a an dressing Enjoy! cream cream made cakes these cheese, have ranch of Enjoy! cakes as for The make', 4.5547594649506546, N'dessert', N'medium', CAST(N'1954-09-15T06:06:21.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (633, NULL, 452, N'Dr.', N'and Cheddar as again it! them they garlic to friends cheese. beautifully on dip they aioli for over been sugar told We', 2.2576909578673963, N'dish', N'medium', CAST(N'1989-04-18T18:25:33.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (634, NULL, 358, N'Dr', N'a Cheddar crab full ever friends recipe. and cheese, bacon, they ranch sandwiches.|Time Cheddar shredded', 5.5088751518674544, N'dessert', N'medium', CAST(N'1954-10-15T08:59:24.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (635, NULL, 494, N'Mr', N'onions, recipe. told over it party, bacon, to crab The use to ranch as them family!|These your ordinary', 4.5425076650187872, N'starter', N'easy', CAST(N'1978-03-06T20:55:47.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (636, NULL, 488, N'Dr.', N'this and We been been Hope that''s grease is full and my We irresistible ranch over is or mix! on dip great Hope dip Hope', 4.4794790686478283, N'starter', N'easy', CAST(N'2012-05-30T20:47:35.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (637, NULL, 203, N'Mr', N'it a Better since. cold than sandwiches.|Time cheese, make well over and well ranch a dressing made as ever green You spread', 2.9035496571583437, N'starter', N'hard', CAST(N'1994-02-22T18:53:00.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (638, NULL, 405, N'Miss', N'such and irresistible cakes cold great than well.|This cheese, brown cheese, it been as combine garlic garlic party,', 5.5172347452106116, N'dish', N'easy', CAST(N'1976-05-02T09:48:34.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (639, NULL, 24, N'Mr', N'green is ranch use great them Cheddar friends unique as You on been it can can asked irresistible eggs.|Bacon', 2.04667850818796, N'starter', N'medium', CAST(N'2009-05-28T06:58:01.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (640, NULL, 368, N'Mr', N'bacon is aioli eggs.|Bacon The recipe. it is it asked and brown for again deviled you brown and well.|This and', 5.2809965830673447, N'dish', N'hard', CAST(N'1963-04-14T01:47:55.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (641, NULL, 622, N'Dr.', N'and them and for taste.) eggs.|Bacon and been as a have dressing been worth such again sandwiches.|Time', 3.1698034075879509, N'dessert', N'medium', CAST(N'1995-07-04T22:59:03.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (642, NULL, 215, N'Mr', N'Hope dressing ranch over worth recipe. and a ordinary bacon We for consuming well that''s ranch eggs ranch', 2.893007525658704, N'starter', N'medium', CAST(N'1975-12-18T11:38:22.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (643, NULL, 622, N'Miss', N'is Enjoy! than cheese, cakes eggs.|Bacon We Enjoy! told such cream as dip flavor and and and it! have', 1.4341109494837516, N'dessert', N'medium', CAST(N'2001-01-30T16:35:03.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (644, NULL, 257, N'Dr.', N'Hope give give these and bacon serve bacon family!|These asked dressing cheese, cheddar well.|This such but', 1.4184281269174202, N'dish', N'hard', CAST(N'2001-06-07T15:23:44.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (645, NULL, 253, N'Dr.', N'great aioli since. taste.) it! and is been and as is green over aioli ever include them. The as cheese. your bacon', 2.0601318562683333, N'starter', N'easy', CAST(N'2006-05-23T11:48:50.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (646, NULL, 440, N'Dr', N'to cheddar these brown them you or an friends a that''s been Hope asked brown since. worth than on it! and cheddar', 5.8969536507022351, N'dish', N'easy', CAST(N'1961-01-08T18:51:24.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (647, NULL, 891, N'Mr', N'than been consuming Cheddar an you worth or serve or great consuming been but green garlic and on starter as spread to made is again', 1.5528214087490091, N'dessert', N'medium', CAST(N'2019-02-01T00:02:25.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (648, NULL, 566, N'Dr.', N'cold worth aioli they beautifully for consuming combine serve as it as unique and recipe. cream as a over', 3.5564839609695991, N'dessert', N'medium', CAST(N'2004-11-23T16:38:16.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (649, NULL, 449, N'Ms', N'this a ordinary you taste.) unique cakes Hope it! and for well.|This have a as ever include this for onions,', 1.8694518990206772, N'dish', N'hard', CAST(N'1978-10-10T09:56:04.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (650, NULL, 272, N'Mr', N'taste.) include full serve and great ranch recipe. enjoy is (I to brown over them bacon and a party, as mix! for', 5.9149369634291791, N'dessert', N'hard', CAST(N'1968-02-23T21:02:22.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (651, NULL, 453, N'Mr', N'than your grease dip recipe. ever but We dip been a shredded my or or told party, been as make my I''ve deviled unique is', 1.0994007848666054, N'dessert', N'hard', CAST(N'2012-04-30T02:03:37.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (652, NULL, 30, N'Mr', N'for a well dressing as ranch a crab as I''ve is Hope they shredded have told and that''s you brown cream deviled grease them. starter an', 1.91066738865835, N'starter', N'medium', CAST(N'1964-09-10T05:58:59.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (653, NULL, 475, N'Ms.', N'great deviled use and worth cakes full good dip than Hope made or but over or great Hope a We great and and', 2.426350447082124, N'dish', N'easy', CAST(N'2016-06-04T06:19:00.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (654, NULL, 41, N'Mr', N'worth well.|This great deviled irresistible them over great as enjoy a well.|This worth as or taste.)', 3.9674153253284352, N'dessert', N'easy', CAST(N'2003-01-31T02:46:52.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (655, NULL, 316, N'Ms', N'ever since. well.|This your good to aioli ranch well Hope an for cheese, for recipe. You (I (I over of enjoy', 3.0856479052853065, N'dish', N'medium', CAST(N'2002-07-18T03:56:48.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (656, NULL, 37, N'Mr', N'again deviled again and bacon again a and than use it spread and dip brown is cheese, much it! serve', 1.292072622241486, N'dish', N'easy', CAST(N'1986-10-06T12:17:01.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (657, NULL, 481, N'Dr', N'it and over to holiday party, well as is is I''ve worth these of asked have full family!|These friends', 5.4108989040418054, N'dessert', N'hard', CAST(N'1982-09-08T20:16:50.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (658, NULL, 286, N'Mr', N'much have a brown unique over again them deviled cream to taste.) as make that''s your for deviled friends', 4.796006652431565, N'starter', N'easy', CAST(N'2001-05-09T16:43:48.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (659, NULL, 172, N'Mr', N'grease well.|This as you dip combine onions, combine spread mix! party, give cheese, onions, this cream good', 1.4191099621444521, N'dish', N'hard', CAST(N'1962-06-21T02:17:24.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (660, NULL, 820, N'Mrs.', N'and sugar for and them them. been flavor bacon these a a been made flavor over cold and cakes deviled', 1.61589892516653, N'dessert', N'hard', CAST(N'1990-06-13T16:57:24.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (661, NULL, 490, N'Mrs.', N'ranch have much this that''s enjoy ordinary make bacon combine cheese, spread and Better told been aioli made', 3.4364203132858595, N'dessert', N'easy', CAST(N'1969-04-16T15:18:21.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (662, NULL, 537, N'Mr', N'Enjoy! it bacon ever cheese, worth beautifully eggs your make to make cakes this deviled Enjoy! an flavor such and been', 5.7015231660108654, N'starter', N'hard', CAST(N'1986-09-10T05:47:54.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (663, NULL, 223, N'Mr', N'unique it You holiday give combine garlic for over cheese, and them again been serve and asked great', 1.5459281734870412, N'starter', N'medium', CAST(N'2018-01-21T04:00:15.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (664, NULL, 307, N'Ms.', N'recipe. eggs.|Bacon a ranch have is aioli is a holiday cream ranch have but these eggs for deviled my', 5.2472113874960744, N'starter', N'medium', CAST(N'1974-10-26T15:45:43.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (665, NULL, 207, N'Miss.', N'I''ve onions, family!|These as been shredded eggs.|Bacon deviled party, a well.|This well.|This Cheddar', 5.004272173160814, N'dish', N'hard', CAST(N'1974-01-07T09:36:36.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (666, NULL, 22, N'Mr', N'shredded aioli told enjoy green cheese, enjoy dip as use and a The ordinary and on mix! a cakes flavor', 3.7605990356582213, N'starter', N'hard', CAST(N'1998-10-17T06:11:28.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (667, NULL, 355, N'Dr.', N'ever over cheese. your garlic a include ordinary and cheese. brown again dip dip family!|These I''ve dip this', 4.40038898093644, N'starter', N'easy', CAST(N'1962-12-08T14:06:03.750' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (668, NULL, 895, N'Mr', N'recipe. brown mix! have they irresistible made unique flavor shredded great worth unique good flavor or it and', 3.0453899433116383, N'dessert', N'easy', CAST(N'1972-01-23T08:32:46.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (669, NULL, 641, N'Mrs.', N'dressing deviled great consuming over give as is consuming told party, holiday Better Hope full and flavor', 3.6732115599667705, N'dish', N'hard', CAST(N'2007-01-17T18:11:51.990' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (670, NULL, 329, N'Miss.', N'for again have great Enjoy! for bacon onions, them. a shredded brown combine a them well.|This friends', 3.3152997029550839, N'dish', N'medium', CAST(N'2004-08-18T21:00:13.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (671, NULL, 616, N'Ms.', N'cheese. eggs bacon holiday ordinary cheese, green starter on told spread a have is it well.|This that''s but serve and We', 2.8654306125200497, N'dessert', N'easy', CAST(N'2021-02-11T14:44:38.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (672, NULL, 257, N'Mr', N'much grease to it crab as grease Hope bacon worth consuming a Enjoy! it again unique a as as you great them', 3.6031702303342379, N'starter', N'hard', CAST(N'1972-08-21T16:49:52.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (673, NULL, 452, N'Mrs.', N'aioli irresistible spread Better cold as deviled or family!|These shredded as You you such than have', 4.44190783260479, N'dessert', N'medium', CAST(N'1958-05-15T17:30:10.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (674, NULL, 585, N'Dr', N'on green a on bacon, have unique crab than Cheddar been sandwiches.|Time ranch and cheddar is beautifully', 4.1582191880597819, N'dessert', N'medium', CAST(N'1977-09-26T17:45:50.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (675, NULL, 466, N'Mr', N'as grease cheese, You they Cheddar holiday well.|This deviled include bacon, and flavor deviled great', 2.6921483453792279, N'dish', N'medium', CAST(N'1989-06-03T02:20:21.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (676, NULL, 570, N'Mr', N'is bacon of ranch I''ve ordinary dressing it to as you give well (I The beautifully friends spread over', 3.0042259860803493, N'dessert', N'hard', CAST(N'1959-01-17T22:37:41.680' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (677, NULL, 408, N'Mr', N'full good bacon my cakes worth this well Hope Cheddar unique consuming since. them. that''s these again', 5.5923475127631548, N'dessert', N'medium', CAST(N'1980-06-04T22:18:29.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (678, NULL, 308, N'Mr', N'taste.) it deviled brown and it! they asked cakes family!|These ranch and as your good cheese, recipe. (I', 1.8366778380408313, N'dessert', N'hard', CAST(N'1956-04-22T18:41:59.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (679, NULL, 372, N'Mr', N'great much aioli use shredded cakes asked ordinary spread serve that''s worth a on spread them a You consuming', 4.3807747989803438, N'starter', N'easy', CAST(N'1991-08-08T15:46:40.320' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (680, NULL, 346, N'Mr', N'and recipe. to Better your a a as serve can cheese, is made grease spread Enjoy! I''ve can bacon, dressing dip', 2.9582099616332957, N'dessert', N'easy', CAST(N'1963-05-11T03:51:00.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (681, NULL, 58, N'Miss', N'I''ve sandwiches.|Time and for on mix! combine this make spread bacon, to a have much friends recipe. as have', 2.1379548889295918, N'starter', N'medium', CAST(N'1978-03-24T03:22:23.340' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (682, NULL, 512, N'Mr', N'as well worth made them over they asked Hope great bacon deviled bacon and consuming sugar a a garlic eggs.|Bacon', 5.522881821972728, N'dessert', N'hard', CAST(N'1992-05-02T22:03:23.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (683, NULL, 514, N'Mr', N'an consuming consuming full well my on can full and been been they Enjoy! it! spread irresistible on these it green', 2.2663152354146892, N'dessert', N'hard', CAST(N'1996-01-25T11:13:36.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (684, NULL, 428, N'Miss', N'Enjoy! is as great asked over my as mix! cheddar holiday been mix! them. it! you it I''ve Better include cheese.', 5.9364180885890585, N'dessert', N'medium', CAST(N'2015-09-14T05:52:29.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (685, NULL, 462, N'Mrs', N'these been Enjoy! is eggs your irresistible serve them much them. since. sandwiches.|Time these serve', 5.7985766524442361, N'dish', N'easy', CAST(N'1958-10-06T06:52:41.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (686, NULL, 10, N'Dr', N'but crab deviled ranch and but cold The ranch well.|This dip bacon aioli family!|These have your and', 3.533791254988774, N'starter', N'hard', CAST(N'1984-02-07T03:26:42.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (687, NULL, 276, N'Mr', N'cakes on shredded you give flavor them for grease it! include asked party, them. made this cream ranch', 3.1284090178685307, N'dish', N'medium', CAST(N'1960-04-11T23:47:21.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (688, NULL, 354, N'Mr', N'a spread been bacon, spread as garlic is cream grease cakes to on consuming starter them. as party, dressing a', 4.290275632538961, N'dessert', N'easy', CAST(N'2008-03-18T15:38:40.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (689, NULL, 338, N'Miss.', N'cream and dip cheese, that''s mix! of and and for can taste.) full bacon, You as cream a them cream onions, ever cheese,', 3.4232272465821483, N'starter', N'easy', CAST(N'1974-03-30T05:02:36.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (690, NULL, 538, N'Ms', N'cream taste.) good garlic such for unique family!|These Hope you for them cakes to ever cold such made', 4.2504350427773012, N'dish', N'hard', CAST(N'2013-05-31T08:38:46.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (691, NULL, NULL, N'Mr', N'on and give cold that''s irresistible can cheese, cold bacon use crab give (I Hope a of Enjoy! them as cakes', 5.068580164606022, N'starter', N'easy', CAST(N'1982-09-23T00:30:44.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (692, NULL, 606, N'Mr', N'them eggs cheese, much a told your and is over my Enjoy! bacon mix! bacon Enjoy! have bacon flavor and', 4.1075430047267787, N'dessert', N'medium', CAST(N'2014-10-16T02:09:11.930' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (693, NULL, 113, N'Mr', N'of irresistible as them bacon, party, it bacon aioli unique cold holiday again garlic much such a your', 5.09812478306616, N'starter', N'easy', CAST(N'1966-11-13T07:31:10.600' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (694, NULL, 168, N'Dr', N'flavor (I well cold well.|This as family!|These deviled since. (I asked eggs.|Bacon can a crab a is this', 1.43077958302143, N'starter', N'medium', CAST(N'1971-12-16T14:00:36.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (695, NULL, 191, N'Mrs', N'a and cakes great I''ve and a is or and been as great beautifully well include Better well.|This but ever a is can these bacon ordinary', 2.8445762697814851, N'dish', N'medium', CAST(N'2015-12-28T10:29:34.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (696, NULL, 36, N'Mr', N'they as to eggs.|Bacon made Enjoy! use great it cheese, of asked enjoy to starter as it shredded make', 3.468280241577085, N'dessert', N'medium', CAST(N'1961-10-25T17:11:09.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (697, NULL, 753, N'Miss.', N'ranch a is that''s friends have green again well.|This on ordinary a as that''s a a cold and cheddar combine', 2.3470793521716629, N'dessert', N'easy', CAST(N'1979-11-27T07:38:06.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (698, NULL, 528, N'Mr', N'I''ve eggs is make cheese. well.|This of as them taste.) great sandwiches.|Time than well.|This since.', 2.1868995619876772, N'dish', N'easy', CAST(N'1979-04-08T00:49:19.360' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (699, NULL, 118, N'Mr', N'use over combine I''ve dressing family!|These a over cheese, deviled for much much them combine great', 2.4141559537566062, N'dessert', N'easy', CAST(N'1980-06-01T05:47:08.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (700, NULL, 275, N'Dr', N'The ordinary garlic spread than and your these it shredded sandwiches.|Time eggs.|Bacon since. them. as sugar eggs.|Bacon cheese, green cream it!', 4.2995328206101124, N'dessert', N'medium', CAST(N'1960-08-07T05:37:21.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (701, NULL, 215, N'Mrs', N'great been and (I a full flavor dip Cheddar friends good bacon, ever this and a great cheddar have and include', 2.4965646697657951, N'dish', N'hard', CAST(N'2020-02-01T04:45:21.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (702, NULL, 170, N'Mr', N'since. green cheddar bacon mix! ever enjoy it give bacon, or is good crab deviled an use serve they irresistible and it well well', 4.5074314654373708, N'dessert', N'medium', CAST(N'2000-01-10T15:29:39.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (703, NULL, 598, N'Mr', N'dip such dressing cold such brown dip much ever serve friends they dip them. taste.) include well a a', 5.8832724010028281, N'dish', N'hard', CAST(N'2019-11-06T22:26:24.400' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (704, NULL, 620, N'Mr', N'sugar dip much ranch is mix! and serve a cream use dressing cheese. great a cream have flavor to well have (I my', 4.5541521960655942, N'dessert', N'easy', CAST(N'1996-02-21T12:55:51.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (705, NULL, 543, N'Mrs', N'family!|These bacon them grease and include it you much great again crab shredded family!|These consuming ranch use cakes', 4.04950635090913, N'starter', N'hard', CAST(N'1969-01-11T06:17:43.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (706, NULL, 25, N'Mr', N'deviled I''ve as full deviled enjoy We it! much dressing cream dip Hope recipe. is it You to for your it!', 3.4962305545323673, N'dessert', N'hard', CAST(N'1992-09-09T09:13:44.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (707, NULL, 747, N'Mr', N'Cheddar is green again well.|This taste.) them again full include much irresistible over much You these', 3.46875955605356, N'starter', N'easy', CAST(N'1959-04-29T12:28:48.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (708, NULL, 337, N'Mrs.', N'green Better cheese. onions, unique sugar asked over and and much starter for bacon over onions, make', 4.2681312590223417, N'dish', N'medium', CAST(N'1991-09-09T12:33:09.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (709, NULL, 284, N'Mr', N'well.|This as over and The told Cheddar holiday over and unique include deviled taste.) good Better worth starter to dip', 2.2752669799492073, N'starter', N'hard', CAST(N'1966-08-31T00:26:31.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (710, NULL, 414, N'Dr', N'mix! a on as irresistible great since. grease these make and flavor flavor irresistible full good make', 1.0814219192049568, N'dessert', N'medium', CAST(N'1996-07-01T05:19:06.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (711, NULL, 684, N'Mrs', N'or and and recipe. serve as as serve irresistible serve and dressing and recipe. deviled over dip is', 1.6997251094783308, N'dessert', N'hard', CAST(N'1959-05-04T13:58:32.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (712, NULL, 607, N'Mr', N'a cream over as as deviled them. a great been cheddar taste.) as than have since. deviled to The your bacon starter worth', 4.5742210660009741, N'starter', N'easy', CAST(N'1979-05-20T01:34:51.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (713, NULL, 523, N'Dr', N'again Hope The make for as but much You is and it bacon shredded you much ranch make serve crab told onions, a Cheddar eggs.|Bacon it', 1.415231853451222, N'dessert', N'easy', CAST(N'1962-10-03T00:57:07.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (714, NULL, 663, N'Mr', N'Better and them or make have bacon include eggs.|Bacon and ranch starter made ranch bacon, a enjoy have', 4.4609000005111561, N'dish', N'medium', CAST(N'2021-02-09T22:26:23.340' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (715, NULL, 521, N'Miss.', N'Better sugar them Hope them. recipe. The have Cheddar a made but sugar for and to Cheddar them dip they', 5.4779440362369378, N'dessert', N'easy', CAST(N'1965-03-23T13:35:01.330' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (716, NULL, 692, N'Ms', N'this them deviled and deviled party, a ranch holiday than and shredded much to include much is is to', 3.9135384913131306, N'dessert', N'medium', CAST(N'1998-12-14T17:14:57.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (717, NULL, 306, N'Mr', N'(I sugar ever ordinary them onions, dip and flavor been for as it! for is cold crab they spread as sugar', 4.4352079305961762, N'starter', N'easy', CAST(N'2012-08-15T18:34:17.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (718, NULL, 323, N'Ms.', N'than as deviled is serve as recipe. combine cakes your shredded a shredded sandwiches.|Time and sugar it! for', 1.6095100848979831, N'dish', N'hard', CAST(N'1955-05-10T22:07:46.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (719, NULL, 280, N'Mr', N'give cold crab irresistible you and We of is holiday eggs.|Bacon as of that''s include taste.) as bacon Hope', 5.4486347350518383, N'dish', N'easy', CAST(N'1969-01-21T08:53:02.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (720, NULL, 590, N'Mr', N'as include ordinary brown as sandwiches.|Time full well Better grease and worth over eggs.|Bacon since. a', 2.4704809181720395, N'starter', N'hard', CAST(N'2011-12-01T06:09:53.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (721, NULL, 703, N'Miss.', N'unique great your my and combine great is and crab and great and and cakes have a much include dressing as', 1.6321900177896909, N'dish', N'easy', CAST(N'1991-07-08T06:24:07.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (722, NULL, 387, N'Mr', N'well.|This been over shredded ordinary cheese. have have family!|These spread cream Cheddar enjoy well great', 1.110113348397479, N'dish', N'hard', CAST(N'1976-09-20T22:27:23.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (723, NULL, 159, N'Miss.', N'flavor or full as and than such ever make and for well friends cheese. a an crab for to Hope cream Hope', 5.6221626967294895, N'dish', N'easy', CAST(N'2019-10-26T03:30:10.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (724, NULL, 519, N'Mr', N'you and ranch told cheese. is full a garlic my is bacon on to dip aioli is ever to family!|These family!|These', 5.42277651718947, N'starter', N'hard', CAST(N'2015-08-19T09:33:05.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (725, NULL, 823, N'Mr', N'family!|These these your spread give irresistible make dip as bacon such and Hope I''ve and to and great is', 4.2467195383490619, N'dish', N'easy', CAST(N'1974-11-27T20:29:29.240' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (726, NULL, 478, N'Dr', N'cheese, Cheddar a grease Hope friends have and make family!|These bacon again give them. cheese, for that''s', 4.7578876077932719, N'dessert', N'hard', CAST(N'1959-04-30T12:35:26.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (727, NULL, 43, N'Ms', N'make grease cream grease cheese. starter a my family!|These ordinary and onions, a dip good for cheese,', 4.5050454472680785, N'dessert', N'medium', CAST(N'1958-10-10T09:18:41.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (728, NULL, 888, N'Mr', N'worth We told a told cold mix! holiday told much bacon a is great told onions, for since. (I full cold', 4.01112824958336, N'dessert', N'easy', CAST(N'2008-05-30T03:29:33.910' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (729, NULL, 63, N'Mr', N'them made as ever bacon, crab told great a an taste.) shredded recipe. cakes but and a and deviled eggs', 2.3136429182782967, N'starter', N'hard', CAST(N'1983-09-30T07:16:16.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (730, NULL, 79, N'Mr', N'aioli shredded of and ranch shredded have aioli and dip and as eggs.|Bacon Cheddar been much a over sandwiches.|Time that''s eggs.|Bacon to', 5.2238681038021424, N'dish', N'easy', CAST(N'1980-08-09T09:09:11.680' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (731, NULL, 844, N'Ms.', N'cheese. recipe. recipe. than asked told as and and it unique they combine cheese. great a aioli We combine you', 1.6571466339086864, N'dessert', N'medium', CAST(N'2001-02-20T14:59:34.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (732, NULL, 724, N'Mr', N'great for Enjoy! a full an spread since. combine Enjoy! well as great irresistible great as great it!', 4.4054479507754785, N'dish', N'medium', CAST(N'1954-02-28T21:29:10.020' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (733, NULL, 495, N'Dr.', N'and well green been but been deviled worth of consuming use well ranch these and for grease aioli as spread', 5.4225218842842251, N'dessert', N'medium', CAST(N'1997-11-21T12:54:50.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (734, NULL, 459, N'Mr', N'ordinary garlic full and as than starter taste.) holiday holiday and they combine dip again aioli well been much', 1.0812419783702316, N'dish', N'hard', CAST(N'1984-01-02T10:09:18.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (735, NULL, 836, N'Dr.', N'unique consuming than them grease dip party, and Better unique cold these Cheddar it cheese, bacon, of', 1.4616452918675007, N'dish', N'easy', CAST(N'1965-04-08T23:05:39.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (736, NULL, 442, N'Dr.', N'cheddar bacon, or great spread enjoy asked dressing it! them. on as dressing good made them is a sugar', 3.630523423492221, N'dish', N'easy', CAST(N'2000-03-13T11:52:43.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (737, NULL, 69, N'Mr', N'is a combine to as but onions, bacon these as over eggs them holiday unique for bacon, cheese, these', 5.6396094209699, N'dish', N'easy', CAST(N'1994-06-26T23:36:59.230' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (738, NULL, 509, N'Dr.', N'they deviled and spread over a serve ordinary (I eggs cheddar The can ever onions, eggs dressing recipe.', 3.7121630393490954, N'dessert', N'medium', CAST(N'2021-12-03T22:17:45.850' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (739, NULL, 617, N'Dr.', N'such We I''ve cheese, You them an cheese, green taste.) Hope and grease as for they over ranch and and unique', 2.8869117376799283, N'dish', N'hard', CAST(N'1999-09-03T23:34:45.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (740, NULL, 114, N'Mr', N'and great brown them. use give irresistible well told on starter party, ordinary these crab such recipe. unique', 3.3023460979118693, N'dessert', N'medium', CAST(N'1988-01-26T21:38:56.740' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (741, NULL, 49, N'Dr.', N'ordinary dip for Cheddar them. it and your The dip as ever dip dressing Hope The recipe. well a and party,', 1.0650316989352142, N'dessert', N'hard', CAST(N'1977-10-11T14:57:53.720' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (742, NULL, 685, N'Dr', N'have dip eggs.|Bacon mix! eggs I''ve bacon irresistible your my great again recipe. I''ve and Cheddar taste.) (I', 4.8602777588461894, N'starter', N'hard', CAST(N'1990-08-03T11:14:11.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (743, NULL, 361, N'Mr', N'a Enjoy! asked include as sandwiches.|Time crab worth enjoy consuming brown cold these my garlic made', 3.0150086525897537, N'dish', N'medium', CAST(N'1994-07-20T15:12:09.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (744, NULL, 23, N'Ms.', N'cold full as and Better holiday deviled dip can The asked such you well well and great again include asked', 3.3418053273771915, N'dish', N'medium', CAST(N'1999-09-28T23:43:29.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (745, NULL, 222, N'Dr', N'full cheese. an unique ranch Better a over Better an sugar eggs.|Bacon include and good made and a as garlic aioli made a', 3.5507099332989709, N'dessert', N'easy', CAST(N'2007-01-28T18:40:13.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (746, NULL, 40, N'Dr', N'a I''ve family!|These deviled bacon deviled taste.) than and they dip a deviled starter starter You have full', 1.4943590986050475, N'starter', N'easy', CAST(N'1956-05-06T22:55:53.050' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (747, NULL, 654, N'Mr', N'bacon such cream garlic these a serve cheese, aioli and good can and such asked to ever cheese, full', 3.6923111512755558, N'dessert', N'medium', CAST(N'2005-01-14T01:12:04.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (748, NULL, 154, N'Dr.', N'shredded a deviled cheese. a can ranch they Cheddar asked consuming have Cheddar cheese, recipe. have as', 1.6372247825550033, N'dessert', N'hard', CAST(N'1967-10-03T09:04:47.260' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (749, NULL, 9, N'Ms.', N'use We ordinary Enjoy! (I a but a dip your you dip that''s my starter and cream cheese, been an than a', 1.952835546784492, N'dish', N'easy', CAST(N'1959-09-26T00:25:35.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (750, NULL, 305, N'Miss.', N'and can as made I''ve sandwiches.|Time enjoy made cold that''s Hope cakes as beautifully to deviled your', 4.9310377784683546, N'dish', N'easy', CAST(N'1970-01-14T17:14:36.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (751, NULL, 57, N'Miss', N'beautifully taste.) crab have serve family!|These it! and your again bacon, deviled I''ve sugar a much', 5.0330723109809083, N'dessert', N'easy', CAST(N'1971-03-11T22:36:52.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (752, NULL, 760, N'Miss.', N'make you give garlic consuming have Better serve give Hope bacon, a told dip them a over ranch a is grease than', 1.73756926727368, N'dish', N'easy', CAST(N'1977-07-20T09:30:20.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (753, NULL, 497, N'Mr', N'good your and irresistible a deviled deviled a made cold taste.) told Cheddar a them as and cheese, is', 2.7382648269358389, N'dessert', N'easy', CAST(N'1963-03-18T15:56:17.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (754, NULL, 525, N'Mr', N'bacon a to great ordinary great a ranch flavor it shredded them it but is ordinary been and your serve use', 5.9436750355845662, N'dessert', N'medium', CAST(N'1990-07-01T23:37:14.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (755, NULL, 831, N'Mr', N'cheese, dip grease as ranch include and much bacon family!|These family!|These dip dip told Cheddar and my and', 3.6673428028204209, N'starter', N'easy', CAST(N'1991-01-30T23:13:14.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (756, NULL, 471, N'Mr', N'you The and You have garlic use ranch ever a I''ve cold onions, aioli good starter cheddar and them them', 2.3864513213683161, N'dessert', N'easy', CAST(N'1996-05-13T06:17:58.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (757, NULL, 440, N'Miss', N'these cakes of asked made Hope serve it brown and a ever spread them and You aioli enjoy a to consuming', 4.8852687687078813, N'starter', N'easy', CAST(N'2002-03-17T11:59:29.320' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (758, NULL, 137, N'Mrs', N'much I''ve over sugar an them. cheese, again use cakes my holiday them. over as of told deviled make mix!', 1.4604958838133588, N'dish', N'hard', CAST(N'1957-03-21T12:53:18.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (759, NULL, 416, N'Mr', N'We over starter as ordinary it The garlic friends eggs.|Bacon a that''s a irresistible bacon give them cheddar', 1.3074326577165316, N'dish', N'hard', CAST(N'1974-03-27T16:26:21.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (760, NULL, 392, N'Mrs', N'dip mix! Hope but crab a dip a been asked to over to and and a serve I''ve and You great Cheddar than', 5.2916187431158583, N'starter', N'easy', CAST(N'1962-09-14T17:42:16.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (761, NULL, 938, N'Mr', N'enjoy cheese, deviled it eggs.|Bacon cream have a We friends starter and worth well.|This such cheddar', 4.9911851072642879, N'dessert', N'medium', CAST(N'1986-12-01T23:55:02.920' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (762, NULL, 76, N'Miss.', N'asked of to a sugar them it sugar family!|These eggs beautifully Enjoy! crab can my they sugar and to consuming', 5.4576313064702, N'dish', N'easy', CAST(N'1972-11-29T08:59:14.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (763, NULL, 300, N'Mr', N'can made cheese, than and dip ranch since. such have a eggs.|Bacon dressing grease told again include', 2.954488340744045, N'starter', N'hard', CAST(N'1960-12-11T05:16:53.500' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (764, NULL, 13, N'Mr', N'ranch We over unique and and beautifully recipe. they grease such been as or deviled We sugar unique that''s', 3.051398876147065, N'dish', N'medium', CAST(N'2008-01-21T15:17:19.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (765, NULL, 453, N'Dr.', N'cheese. ranch told and dip a family!|These these and (I crab flavor give made over Hope cheese. it! You', 5.42427528529627, N'starter', N'easy', CAST(N'2017-05-10T14:19:31.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (766, NULL, 621, N'Mr', N'unique them of they brown Cheddar worth them well for give starter it sugar have enjoy combine but and can on have crab unique', 3.2942771587028528, N'dish', N'medium', CAST(N'1958-03-06T16:29:22.240' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (767, NULL, 948, N'Mrs', N'full family!|These a a again over grease great is my since. flavor since. eggs holiday them and party, it', 5.151699181716749, N'dish', N'medium', CAST(N'2003-06-28T12:40:01.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (768, NULL, 855, N'Dr', N'onions, of garlic but green ranch mix! great party, a them it! Better of it dip spread crab been deviled shredded', 1.3339898750809907, N'dish', N'easy', CAST(N'2000-09-30T14:47:49.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (769, NULL, 541, N'Mr', N'dip cheddar of is it! and an We and and since. give spread eggs they mix! is deviled (I ordinary it party,', 3.9992547086436554, N'dessert', N'easy', CAST(N'2008-11-03T23:20:43.690' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (770, NULL, 177, N'Mr', N'dip sandwiches.|Time your spread cream as as of and been ranch grease dip these a We have cheese, and', 2.8474206127447168, N'starter', N'hard', CAST(N'1987-01-10T01:42:17.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (771, NULL, 270, N'Mr', N'of them. onions, on over serve told your (I combine and deviled recipe. holiday for as dip them and eggs.|Bacon', 4.2739290703432307, N'starter', N'easy', CAST(N'1957-06-20T17:37:58.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (772, NULL, 593, N'Ms.', N'it or or include your use and great can grease it great sugar on full them mix! recipe. combine them', 1.7230448912470811, N'dish', N'hard', CAST(N'2012-09-11T20:16:31.290' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (773, NULL, 348, N'Ms', N'full ordinary unique these flavor your Hope family!|These Hope give as of bacon a Cheddar for dip aioli mix! cheddar', 4.7225983472180548, N'dessert', N'easy', CAST(N'1977-09-05T22:33:00.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (774, NULL, 516, N'Mr', N'make dip as unique Hope shredded well Better a deviled The deviled and cheese, family!|These have my', 3.146288637139969, N'dessert', N'hard', CAST(N'2002-12-26T11:14:05.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (775, NULL, 8, N'Mr', N'include and such a I''ve a since. have that''s over (I holiday that''s ranch over your and enjoy ordinary', 2.4054492192368251, N'dish', N'easy', CAST(N'1987-02-20T15:12:00.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (776, NULL, 718, N'Mrs', N'(I and shredded cream a they for deviled asked have over that''s dressing them cheddar made a The mix! have', 2.7719122589435017, N'dish', N'easy', CAST(N'1953-12-05T19:09:55.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (777, NULL, 289, N'Mr', N'well as Better combine sandwiches.|Time my a and Cheddar have for them and cheese. great than cheese, beautifully great', 4.0951046958077253, N'dessert', N'medium', CAST(N'2004-03-03T07:15:13.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (778, NULL, 358, N'Mr', N'taste.) starter Cheddar flavor a over shredded flavor a can over spread to cold I''ve use include use', 3.2803573693522985, N'starter', N'medium', CAST(N'1973-01-28T03:46:40.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (779, NULL, 940, N'Mrs', N'and a have as an and taste.) these serve bacon serve well Hope a cream as brown starter mix! them asked flavor', 2.8720665838904988, N'starter', N'hard', CAST(N'1961-07-22T14:52:51.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (780, NULL, 310, N'Mr', N'since. such that''s my include Hope spread serve flavor garlic is cheese, grease dip give them good to is', 3.7523604397440145, N'starter', N'easy', CAST(N'1971-07-24T21:33:36.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (781, NULL, 423, N'Mrs', N'as it! can cheese, brown you to dip can party, green of a ranch full Cheddar garlic a shredded onions, cold eggs a', 2.0655764565177153, N'starter', N'easy', CAST(N'1976-04-15T11:23:22.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (782, NULL, 363, N'Mr', N'bacon, and brown great sandwiches.|Time bacon eggs than to The crab ranch great and well can cold friends', 3.8678206647130757, N'starter', N'hard', CAST(N'2013-01-07T00:13:54.610' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (783, NULL, 487, N'Mr', N'you been ranch sandwiches.|Time of ordinary shredded friends party, make and them green to over recipe.', 3.0582927027988678, N'starter', N'hard', CAST(N'2001-09-05T03:03:58.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (784, NULL, 759, N'Mr', N'We and We I''ve family!|These told your cream and unique cheddar such over for bacon for beautifully onions, have', 3.3826051398099422, N'dessert', N'hard', CAST(N'1966-09-16T14:01:40.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (785, NULL, 595, N'Mr', N'shredded cheese, ranch party, as my crab can to and well well deviled The and mix! it! grease taste.)', 1.190795792821234, N'dessert', N'hard', CAST(N'1962-06-01T10:32:19.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (786, NULL, 67, N'Mr', N'them You good great deviled and been cheese. Hope mix! cheese, ever cold combine eggs starter enjoy them', 5.9195773666350071, N'starter', N'medium', CAST(N'1976-08-04T05:29:14.240' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (787, NULL, 713, N'Ms.', N'well as combine great but of make recipe. over include deviled and serve a a unique for include dip Enjoy!', 2.6671831238396386, N'dish', N'medium', CAST(N'2012-12-13T05:32:52.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (788, NULL, 581, N'Mrs.', N'to cheddar and cold sandwiches.|Time use to irresistible onions, asked deviled crab brown and cheese.', 5.4788468486996589, N'starter', N'easy', CAST(N'1960-05-23T13:17:35.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (789, NULL, 841, N'Dr', N'bacon bacon is them. good combine holiday spread cheese, and I''ve mix! We and again as Better well.|This enjoy holiday', 3.4138991755498105, N'starter', N'hard', CAST(N'2014-12-02T10:56:04.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (790, NULL, 433, N'Mr', N'or is good ranch them make much use is as The consuming taste.) taste.) dip I''ve as deviled onions, make cream for combine and', 5.0751939704991846, N'dessert', N'easy', CAST(N'1990-11-26T16:47:41.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (791, NULL, 783, N'Miss', N'irresistible and a it! eggs great shredded (I include crab We Hope have my and sandwiches.|Time this', 4.74525465478434, N'starter', N'easy', CAST(N'2019-12-27T23:53:14.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (792, NULL, 398, N'Mr', N'as grease irresistible eggs bacon for beautifully them flavor flavor eggs.|Bacon You family!|These cream an', 5.1791135371565415, N'starter', N'medium', CAST(N'1990-04-08T10:43:40.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (793, NULL, 224, N'Mr', N'of again and well.|This and to I''ve combine cheese, sandwiches.|Time it We you great combine them. as deviled ever', 3.4047303816325636, N'dish', N'medium', CAST(N'2000-09-09T05:51:24.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (794, NULL, 82, N'Mr', N'use grease to Cheddar ever cream a eggs.|Bacon I''ve family!|These We grease eggs.|Bacon aioli cakes irresistible', 3.59529299456407, N'dish', N'hard', CAST(N'1989-12-21T05:52:29.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (795, NULL, 59, N'Mr', N'but family!|These Better include have make cheddar such onions, that''s and bacon, on an use flavor and', 4.311160990647581, N'starter', N'hard', CAST(N'1954-02-25T21:43:53.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (796, NULL, 584, N'Mr', N'these your well combine mix! they over a of (I and them. Hope ranch my you ranch deviled as but cheese, but', 1.6074003924650142, N'starter', N'medium', CAST(N'1957-11-13T05:58:39.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (797, NULL, 333, N'Mr', N'mix! and cheddar sugar eggs but taste.) recipe. over as dip been can sugar use unique flavor bacon, and', 2.905789418102144, N'dessert', N'easy', CAST(N'1982-08-24T05:57:18.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (798, NULL, 619, N'Mr', N'well.|This friends you sugar flavor cream brown much irresistible an worth they cheese, cheese. eggs a', 5.9636097764426887, N'dessert', N'hard', CAST(N'2008-06-28T23:54:49.380' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (799, NULL, 105, N'Mr', N'and great made can and give recipe. to as great recipe. bacon, serve (I enjoy dip on as as an garlic beautifully unique Better that''s', 3.9175300420809211, N'dish', N'medium', CAST(N'2004-05-20T09:23:57.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (800, NULL, 349, N'Mr', N'cheese, told your (I a brown and a have much good taste.) sugar unique dressing give it well and them and family!|These cheese, friends', 1.2564327745961177, N'dish', N'hard', CAST(N'2001-11-25T02:10:51.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (801, NULL, 83, N'Ms.', N'irresistible cheese, and use deviled over bacon, over can a bacon to cakes to that''s enjoy garlic worth over', 2.3426599168882984, N'dessert', N'medium', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (802, NULL, 4, N'Mr', N'cakes bacon, well.|This Better as that''s deviled to is is been and cold recipe. use asked enjoy an them', 3.3583212761945656, N'dish', N'easy', CAST(N'1974-11-09T10:15:51.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (803, NULL, NULL, N'Mr', N'it them. have onions, made cakes such them. and but is taste.) a again recipe. a is family!|These cakes to', 3.6379700739113474, N'dessert', N'medium', CAST(N'1957-04-16T10:24:15.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (804, NULL, 661, N'Mr', N'ever ever have a ever cheddar cakes they your Better serve holiday than green dip make cheddar well cheese,', 5.105414934039775, N'starter', N'easy', CAST(N'1980-11-28T09:44:03.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (805, NULL, 735, N'Dr.', N'for serve taste.) told is starter (I garlic You combine recipe. that''s such sandwiches.|Time to bacon', 1.6571087081251241, N'dish', N'hard', CAST(N'1994-09-15T22:43:17.920' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (806, NULL, 230, N'Ms.', N'a cold ranch ranch well ordinary enjoy and since. this I''ve and shredded combine sugar have The taste.) ever', 4.310027419733828, N'dish', N'medium', CAST(N'1965-07-27T23:36:37.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (807, NULL, 770, N'Mrs', N'been as cheddar to and an recipe. and been and Cheddar cheese, this than flavor and this I''ve have this recipe. consuming', 3.0149709200556254, N'dessert', N'hard', CAST(N'1980-06-29T02:20:21.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (808, NULL, 35, N'Mr', N'to taste.) or deviled been sandwiches.|Time cheese, crab include a taste.) a and as beautifully cream', 5.59197618979587, N'starter', N'easy', CAST(N'2021-11-13T10:57:20.020' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (809, NULL, 915, N'Mr', N'asked since. We a cold cheese, garlic over I''ve consuming deviled than a dip worth green a deviled an aioli a for', 4.538225816347742, N'starter', N'medium', CAST(N'1982-03-23T04:42:11.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (810, NULL, 70, N'Mr', N'mix! to a and is them. told onions, serve You and been dressing dip make friends and taste.) to and ever', 1.8954305438769192, N'dessert', N'hard', CAST(N'1956-05-12T08:25:14.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (811, NULL, 155, N'Mr', N'over well.|This cheddar and is as cream asked than consuming them you grease ranch bacon as such to to but', 4.2913466255605908, N'starter', N'hard', CAST(N'1990-02-26T04:03:19.160' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (812, NULL, 276, N'Miss.', N'ordinary sugar as made spread shredded been a as cheese. to enjoy over make a sugar crab bacon, taste.) have', 2.6049113993555828, N'starter', N'hard', CAST(N'2014-03-11T23:02:44.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (813, NULL, 763, N'Ms', N'as deviled cheese, as beautifully and for again again starter starter but flavor an good ranch sandwiches.|Time', 4.5884292999228595, N'starter', N'hard', CAST(N'1982-02-18T08:12:48.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (814, NULL, 359, N'Mr', N'(I is they worth for a deviled enjoy spread and and recipe. well.|This as been again them than an I''ve', 3.5550722179725174, N'starter', N'hard', CAST(N'2017-08-29T22:00:26.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (815, NULL, 869, N'Dr.', N'and We full you this for them well starter recipe. friends aioli spread cheese, cheese, make and friends friends my on', 4.2260422865981431, N'starter', N'hard', CAST(N'1955-09-04T18:52:45.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (816, NULL, 381, N'Mr', N'but have for to shredded as such a a party, combine great serve much brown and cheese. friends bacon', 2.1233644425512126, N'dessert', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (817, NULL, 582, N'Mr', N'(I consuming for green a they make serve it a as a garlic sandwiches.|Time The and that''s cakes and brown', 3.3993386036713322, N'dish', N'easy', CAST(N'2008-05-31T06:18:54.130' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (818, NULL, 56, N'Mr', N'for have an dressing ordinary as for give Hope as taste.) You spread deviled (I ordinary flavor party,', 5.5718832009341028, N'dish', N'hard', CAST(N'1995-11-24T23:41:08.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (819, NULL, 277, N'Mr', N'recipe. include spread taste.) than they great as cheese. family!|These cream can have ranch a such crab', 2.8606030833258309, N'dish', N'medium', CAST(N'1993-03-26T05:55:16.100' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (820, NULL, 759, N'Mr', N'beautifully can The been well.|This mix! dip well.|This ever worth cheese. The ever as use combine a good', 5.5046979186612637, N'dessert', N'medium', CAST(N'2016-03-26T15:15:13.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (821, NULL, 456, N'Mrs', N'been Better eggs.|Bacon that''s it cold aioli a as since. again ranch to again them eggs.|Bacon as it good dip', 1.6270940348632139, N'dessert', N'hard', CAST(N'1998-08-23T04:45:00.570' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (822, NULL, 79, N'Mr', N'them Better starter told them The Hope you aioli dip recipe. unique green told cheddar eggs.|Bacon these as taste.) combine made', 5.672852333017091, N'starter', N'easy', CAST(N'1993-10-07T08:50:17.640' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (823, NULL, 244, N'Miss.', N'as as and as taste.) cheese, friends bacon family!|These them over ranch your crab onions, The Cheddar bacon, this', 3.9200906995311806, N'dish', N'medium', CAST(N'1967-03-24T10:56:29.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (824, NULL, 988, N'Mr', N'sugar they great my this brown party, bacon dip consuming been them can You great than for been brown', 4.9240607381444708, N'starter', N'easy', CAST(N'1996-02-05T23:22:25.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (825, NULL, 797, N'Mr', N'but them my cream irresistible for my make as them. again to them made this cheddar mix! aioli as your', 4.1021659579603771, N'starter', N'hard', CAST(N'2007-10-30T03:51:44.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (826, NULL, 745, N'Dr', N'give as as much ever since. combine good a grease include these green ordinary it it! and spread Enjoy! and', 5.0948155331866882, N'dessert', N'hard', CAST(N'1970-12-10T06:33:02.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (827, NULL, 965, N'Mr', N'unique recipe. asked taste.) mix! well as spread have and irresistible it! worth it made enjoy eggs well', 4.3183145096145168, N'dessert', N'medium', CAST(N'1989-01-13T01:49:03.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (828, NULL, 186, N'Ms.', N'it! you my cakes have use dressing make that''s an it! to spread eggs brown ordinary dressing good ever been flavor a is (I it', 2.1273053526539849, N'starter', N'medium', CAST(N'1989-03-14T06:54:17.960' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (829, NULL, 753, N'Miss.', N'consuming them. have spread sugar bacon made them made for or family!|These they as a cheese, a a your', 4.8351276464923876, N'dish', N'hard', CAST(N'1965-01-03T14:25:07.240' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (830, NULL, 569, N'Mr', N'have friends much such a eggs.|Bacon as bacon, and a make it it than Hope and as asked of a have worth my', 1.7980488267718111, N'starter', N'medium', CAST(N'2009-09-15T16:40:31.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (831, NULL, 331, N'Dr', N'The great recipe. is over and as ranch or them of and make cakes is over irresistible unique such a since. crab', 5.8661228408413582, N'dish', N'easy', CAST(N'2001-10-31T13:30:11.630' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (832, NULL, 206, N'Dr.', N'make you The garlic as is and cakes a but again dip make a bacon dip as told consuming over use serve', 4.1314949193650365, N'dessert', N'medium', CAST(N'1982-04-10T09:13:20.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (833, NULL, 972, N'Dr', N'my party, green Enjoy! well.|This cream it such have sugar a for worth great over Enjoy! bacon and as you Enjoy!', 5.3628273272713773, N'dish', N'easy', CAST(N'1993-04-13T13:12:37.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (834, NULL, 54, N'Mr', N'on much full and a is cold my an been ranch cold a since. is unique eggs well combine it deviled brown', 2.6156338092943812, N'dessert', N'easy', CAST(N'2017-09-04T07:20:24.610' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (835, NULL, 441, N'Ms.', N'cakes they dip and told great as and is deviled full The and party, enjoy taste.) deviled enjoy bacon', 2.409700522855716, N'dish', N'medium', CAST(N'1990-09-09T18:22:43.250' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (836, NULL, 595, N'Mr', N'as make an full crab as bacon, serve cheese. recipe. it You and them. use they full beautifully dip and I''ve as enjoy', 4.70725518032315, N'dish', N'easy', CAST(N'1981-08-27T12:42:00.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (837, NULL, 184, N'Mr', N'I''ve asked worth You dressing have can you garlic Enjoy! and ever worth ranch these bacon, give irresistible such', 1.2298505908017283, N'starter', N'easy', CAST(N'2018-09-14T11:17:44.210' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (838, NULL, 172, N'Mr', N'family!|These been an cheese. as holiday ranch it told they spread full (I and green full to you cheese,', 3.9528777687590928, N'starter', N'medium', CAST(N'1972-01-01T00:59:07.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (839, NULL, 129, N'Dr', N'great a an onions, a ranch is a it and a cakes much been sandwiches.|Time (I cheese. unique or these', 2.7254964316848183, N'starter', N'hard', CAST(N'1985-02-09T14:29:51.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (840, NULL, 775, N'Miss', N'serve that''s bacon, again cold worth to an made well flavor and a again much mix! grease dressing good', 2.8807683730874065, N'dish', N'medium', CAST(N'1959-12-22T04:20:40.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (841, NULL, 185, N'Ms.', N'well.|This taste.) flavor shredded for unique consuming cheese, cheese, and worth is full ever and cheese, your', 3.9046064465793808, N'dish', N'medium', CAST(N'1954-02-20T14:25:02.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (842, NULL, 700, N'Dr.', N'Enjoy! crab and serve asked ranch your can for green than dip serve and but that''s serve as ever them', 3.0752069340437682, N'dish', N'easy', CAST(N'2003-12-03T08:11:58.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (843, NULL, 499, N'Mr', N'holiday cream beautifully it! great dip it bacon, crab dip as of ordinary that''s than family!|These shredded', 1.9406210323519171, N'dessert', N'hard', CAST(N'1976-09-20T18:31:54.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (844, NULL, 480, N'Ms', N'as can You a great over is you The a as a you a my a a unique shredded this to on cream to Hope cakes combine', 2.5184686316728913, N'starter', N'hard', CAST(N'1983-09-24T00:50:41.140' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (845, NULL, 784, N'Mr', N'been deviled been them. over include starter a to cheese, on unique this is they worth for that''s consuming', 1.7838473449385945, N'dish', N'medium', CAST(N'1957-01-12T04:52:20.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (846, NULL, 91, N'Dr', N'a consuming have and cold party, such and full cream good and We party, spread them. is that''s and Cheddar beautifully', 3.1403432554287569, N'dessert', N'medium', CAST(N'1977-10-07T06:52:45.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (847, NULL, 668, N'Dr', N'well.|This cream of bacon give shredded good unique as bacon use cheese, them. them. unique You asked', 1.5906842372336816, N'starter', N'medium', CAST(N'1998-09-16T17:44:57.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (848, NULL, 657, N'Ms', N'eggs.|Bacon much great bacon ranch starter garlic party, combine than bacon, cheddar cheddar Better use', 5.8496581636600471, N'starter', N'medium', CAST(N'1990-11-09T15:40:25.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (849, NULL, 636, N'Ms', N'green cheese. and aioli (I great my deviled bacon eggs.|Bacon taste.) of and (I Hope brown a have shredded a', 5.3692507079659268, N'dish', N'hard', CAST(N'1994-08-09T12:43:14.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (850, NULL, 615, N'Dr', N'them these a sugar deviled a aioli brown cheese, family!|These spread consuming recipe. on an cheddar', 3.1877965480963684, N'starter', N'easy', CAST(N'1998-01-06T10:58:38.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (851, NULL, 470, N'Mr', N'dip great eggs deviled made that''s been an combine since. it eggs and for have as them. much them these', 4.2080617887936818, N'dessert', N'medium', CAST(N'2003-07-22T23:33:34.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (852, NULL, 579, N'Ms.', N'Hope starter cold for brown a Enjoy! this my ordinary your as garlic can is than is to full that''s deviled', 3.3339062171680416, N'dish', N'medium', CAST(N'1980-04-02T22:02:45.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (853, NULL, 233, N'Mrs', N'as have onions, unique as as they ranch cheese, shredded and as full irresistible recipe. Better them dip cold good it', 4.1030066931168587, N'dish', N'medium', CAST(N'1986-08-20T00:03:23.030' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (854, NULL, 86, N'Mr', N'Better them. cheddar have mix! of is a but and an garlic and give green it The holiday as Better them', 4.4128321234196575, N'dish', N'hard', CAST(N'1988-05-29T14:42:04.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (855, NULL, 485, N'Mrs', N'Enjoy! dip great a holiday aioli it bacon it it ranch it! deviled beautifully have deviled cakes but dip and your', 5.629338739732904, N'dish', N'hard', CAST(N'1962-11-07T19:09:48.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (856, NULL, 219, N'Dr.', N'starter a or consuming been your flavor my flavor bacon, and good bacon an such brown bacon use serve', 2.6698075838712079, N'dish', N'easy', CAST(N'1963-08-15T00:33:39.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (857, NULL, 777, N'Mr', N'irresistible it dressing cakes cream you deviled cakes include cheese, ranch cheese, cheese, a green', 5.4382305766633854, N'dessert', N'hard', CAST(N'1987-09-04T15:14:22.250' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (858, NULL, 445, N'Dr', N'have to great eggs.|Bacon include and them ordinary ever and it and well.|This is Enjoy! Better my friends is made', 4.7139093357668767, N'dessert', N'medium', CAST(N'2000-10-03T10:53:26.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (859, NULL, 37, N'Miss', N'sugar a Cheddar and aioli beautifully cheddar cold use grease is sandwiches.|Time consuming holiday told sugar been deviled', 2.0032489760793974, N'starter', N'easy', CAST(N'1971-06-18T06:32:30.220' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (860, NULL, 563, N'Ms', N'have over starter on told to you unique garlic it! and spread for dip sugar serve your is for an and', 2.5622931749384352, N'dish', N'easy', CAST(N'1962-12-21T03:11:01.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (861, NULL, 18, N'Ms', N'told for well bacon and cream been deviled deviled cheddar consuming that''s and friends dip well for', 5.99171291011931, N'dish', N'easy', CAST(N'1958-09-03T20:54:14.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (862, NULL, 670, N'Mr', N'cheddar that''s Hope ranch crab for them We but as them aioli is and as serve and is beautifully on over ever', 1.8876655674016409, N'dish', N'medium', CAST(N'1998-05-15T16:42:19.600' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (863, NULL, 739, N'Mrs.', N'ranch great such enjoy green dressing I''ve onions, Enjoy! can to serve they dressing Hope but asked Better or', 1.7568485433034824, N'dish', N'medium', CAST(N'1968-06-26T11:55:13.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (864, NULL, 484, N'Mr', N'as of it! unique much bacon taste.) and combine a aioli include brown over make party, made told you', 3.7401769895759305, N'starter', N'hard', CAST(N'1965-02-28T18:16:48.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (865, NULL, 147, N'Mr', N'cream great them. is is deviled bacon unique them as Enjoy! a bacon over We since. to party, you flavor', 2.0293077030355615, N'starter', N'hard', CAST(N'2002-05-22T15:12:00.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (866, NULL, 281, N'Mr', N'it for ranch Better enjoy much ranch ever or have flavor ranch a a a them for cream it taste.) crab spread', 1.1598517061955536, N'starter', N'easy', CAST(N'1996-02-01T23:11:53.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (867, NULL, 987, N'Dr', N'and Enjoy! taste.) or your beautifully give give bacon for beautifully bacon unique is ranch cheese.', 3.2420840720842055, N'dish', N'medium', CAST(N'2018-11-14T14:50:41.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (868, NULL, 840, N'Dr', N'sugar been friends a irresistible of garlic Cheddar give it! have irresistible Better to Better on cheese,', 2.9727954906284788, N'starter', N'hard', CAST(N'2018-07-07T15:42:19.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (869, NULL, 486, N'Mr', N'aioli them starter a a sandwiches.|Time them my deviled use as bacon, You cheese, I''ve Enjoy! to aioli', 2.1453716951168014, N'dish', N'easy', CAST(N'2013-06-10T13:50:05.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (870, NULL, 175, N'Mr', N'bacon, consuming they my deviled ranch and brown is bacon, or green them well.|This than for and as well an they', 5.5187871062749938, N'dish', N'hard', CAST(N'1989-01-03T09:18:26.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (871, NULL, 373, N'Dr.', N'give Enjoy! deviled them starter family!|These garlic again recipe. and holiday ordinary that''s give', 1.8935138517494843, N'dessert', N'medium', CAST(N'1958-12-21T07:35:01.410' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (872, NULL, 582, N'Dr', N'and again grease cold cakes cold told it worth have as holiday and unique on these give as make eggs these Better', 5.446460834912239, N'dish', N'medium', CAST(N'1989-06-01T05:19:46.470' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (873, NULL, 995, N'Dr', N'consuming well.|This but cakes can great you since. irresistible much as onions, bacon than Cheddar or', 3.8463867692492837, N'starter', N'hard', CAST(N'1963-10-16T09:11:17.280' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (874, NULL, 77, N'Mr', N'cream asked aioli much it and it! my been crab than serve cheese, cream include bacon, starter combine deviled enjoy', 5.9798347102384248, N'starter', N'easy', CAST(N'1986-04-06T01:34:35.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (875, NULL, 209, N'Mr', N'green it! cheese, bacon asked dip holiday them. as onions, onions, ranch Enjoy! recipe. it a this and', 2.6000914720818828, N'dish', N'easy', CAST(N'2015-02-05T00:50:10.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (876, NULL, 189, N'Mr', N'cheese, good but cheese, and this cheese. these deviled dip dip Cheddar unique as well since. Better', 4.5518871008194459, N'dish', N'hard', CAST(N'2016-09-19T20:33:02.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (877, NULL, 957, N'Ms.', N'taste.) a but a cheese, for have a make cold sandwiches.|Time cold as Hope shredded cheddar use taste.) eggs have eggs.|Bacon crab', 4.7322313006651733, N'dish', N'medium', CAST(N'1970-01-17T14:18:23.410' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (878, NULL, 175, N'Mr', N'them family!|These I''ve consuming green Cheddar again as ever it that''s great asked dip such it a have use', 2.4016220678582894, N'starter', N'medium', CAST(N'2005-06-30T10:05:48.250' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (879, NULL, 505, N'Dr', N'have consuming and worth dip party, Cheddar as over Better ordinary dip ranch give well.|This combine as', 4.140213393205876, N'dish', N'medium', CAST(N'1992-01-25T18:30:04.880' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (880, NULL, 716, N'Mr', N'mix! full to dip flavor friends You it! cold cream combine Hope on party, such a irresistible ranch and', 1.9618227025316202, N'starter', N'medium', CAST(N'1983-01-23T20:58:59.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (881, NULL, 195, N'Mrs', N'cheese. aioli combine a flavor been bacon starter that''s and aioli combine and mix! over recipe. consuming', 4.5041312959530071, N'dessert', N'easy', CAST(N'1994-03-25T12:48:04.670' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (882, NULL, 655, N'Mrs', N'include cream it been a to been since. mix! Enjoy! can bacon I''ve include but have or sugar cheese, have ever', 4.4686563459544706, N'dish', N'hard', CAST(N'2020-03-05T10:08:37.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (883, NULL, 714, N'Dr', N'over shredded and well (I family!|These unique bacon enjoy a than to Better flavor flavor it! Enjoy! been', 2.7580546446880581, N'dish', N'medium', CAST(N'2016-08-04T18:11:03.910' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (884, NULL, 168, N'Mr', N'good it! and since. deviled to We a unique over cold cream a been as or irresistible and been on cheddar eggs dip', 2.6473310983960197, N'starter', N'hard', CAST(N'1988-12-28T03:26:28.820' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (885, NULL, 513, N'Mrs', N'Cheddar give cheese, these is deviled ranch a told to as I''ve bacon, sugar You your recipe. over cream for', 3.5899870379781293, N'starter', N'easy', CAST(N'1959-02-25T17:06:56.610' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (886, NULL, 435, N'Mr', N'irresistible deviled cheese. deviled garlic Hope to ordinary cheese, it Better flavor as a them. a them', 3.5322166236733161, N'starter', N'hard', CAST(N'1974-07-31T15:27:26.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (887, NULL, 790, N'Mrs', N'them cheese, great that''s taste.) family!|These but enjoy unique give asked good been sugar asked unique', 1.0284882262481787, N'dish', N'easy', CAST(N'2017-08-21T09:09:57.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (888, NULL, 822, N'Mr', N'again it of as good and a aioli beautifully dip my you it told that''s is Hope as starter them. a deviled', 1.9499952038517199, N'starter', N'medium', CAST(N'1957-11-15T22:30:32.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (889, NULL, 850, N'Dr', N'starter ordinary a and eggs and great irresistible again deviled them make and a well.|This brown and', 2.9862950695614772, N'dish', N'medium', CAST(N'2007-10-29T12:10:35.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (890, NULL, 131, N'Ms.', N'spread holiday cheese, cheese, (I bacon or ranch include and I''ve ranch a starter recipe. cheese, for', 5.7398929389845081, N'starter', N'easy', CAST(N'1980-01-27T17:49:03.350' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (891, NULL, 731, N'Dr', N'been ranch than shredded enjoy them been sandwiches.|Time ranch been grease them dressing but green (I', 5.2690246036597639, N'dessert', N'easy', CAST(N'2015-12-23T21:27:38.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (892, NULL, 980, N'Mr', N'cheese. starter and your a family!|These dip give for and onions, ranch cakes cheese. made use deviled starter deviled as', 2.5159412550348517, N'starter', N'hard', CAST(N'1970-12-13T00:24:17.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (893, NULL, 325, N'Mrs.', N'told cakes We well.|This Hope and and holiday such and friends have have spread that''s and well.|This', 2.9496287926796958, N'starter', N'medium', CAST(N'1953-07-16T18:26:37.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (894, NULL, 435, N'Miss.', N'that''s beautifully serve shredded as great bacon shredded I''ve and holiday they this You a ranch them. can', 1.163203256746383, N'dessert', N'hard', CAST(N'1975-02-21T11:18:49.580' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (895, NULL, 187, N'Miss', N'Enjoy! eggs.|Bacon (I full an dip asked combine well.|This serve unique shredded been for as eggs a as a worth', 2.8890554629680958, N'starter', N'medium', CAST(N'1954-04-20T07:26:25.660' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (896, NULL, 630, N'Mr', N'have taste.) cakes ranch Enjoy! well irresistible cheese, You that''s green aioli and beautifully them family!|These a green a', 3.0169408791777403, N'dessert', N'easy', CAST(N'1977-10-07T21:42:42.960' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (897, NULL, 31, N'Miss.', N'Enjoy! family!|These it consuming eggs.|Bacon sugar ranch shredded consuming as a of aioli worth shredded', 2.3183583907402858, N'dessert', N'hard', CAST(N'1988-06-08T20:16:44.090' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (898, NULL, 529, N'Mr', N'been party, can worth it family!|These unique Better cold sugar as deviled a ever can as and crab well', 4.2004440427759864, N'dish', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (899, NULL, 378, N'Mr', N'these as over aioli and been it cakes again dressing have ranch flavor sugar onions, starter as or cheddar', 1.48916092863733, N'starter', N'easy', CAST(N'1964-07-24T00:15:05.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (900, NULL, 227, N'Mr', N'them Cheddar have cheese, enjoy ever serve aioli is that''s have bacon (I taste.) and of and bacon and', 1.623995638743041, N'dish', N'easy', CAST(N'2003-05-04T09:38:41.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (901, NULL, 770, N'Dr.', N'is eggs.|Bacon enjoy holiday Enjoy! have good but mix! and made cheese, cheese. irresistible them cheese,', 5.8982591833445523, N'dish', N'hard', CAST(N'1982-12-11T05:40:26.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (902, NULL, 25, N'Mr', N'mix! deviled crab onions, I''ve and it Better them Cheddar flavor it for and bacon consuming grease sugar they', 4.6178887466052032, N'starter', N'hard', CAST(N'1980-11-22T16:02:03.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (903, NULL, 625, N'Mr', N'on have grease crab make green starter is cheese, full We irresistible have and irresistible they sugar', 4.7042864685432457, N'dessert', N'medium', CAST(N'2002-03-12T02:02:37.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (904, NULL, 681, N'Mr', N'and it as eggs.|Bacon a a taste.) cheese, green as aioli ranch ranch You cheddar as crab and consuming have again this full', 5.850463601690933, N'starter', N'easy', CAST(N'1999-06-01T01:50:20.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (905, NULL, 757, N'Mrs.', N'give you worth well.|This for mix! eggs onions, that''s cheddar friends beautifully cakes bacon, taste.) give', 2.2942826963468841, N'dish', N'medium', CAST(N'1958-08-07T03:24:47.760' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (906, NULL, 731, N'Ms', N'grease over make for green and eggs over them. as starter brown recipe. on is it mix! much crab holiday', 4.7616009538814428, N'dish', N'hard', CAST(N'1992-01-18T03:23:37.010' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (907, NULL, 292, N'Dr.', N'a you sandwiches.|Time as cheese. party, it! great cheese, ranch much cakes is taste.) Better enjoy have dip', 5.487519447918757, N'starter', N'medium', CAST(N'1967-02-21T18:13:48.430' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (908, NULL, 779, N'Mrs', N'The bacon You and You great irresistible is since. grease Enjoy! been and cold beautifully it enjoy such', 4.1231719828784339, N'dish', N'medium', CAST(N'1969-06-19T12:51:28.230' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (909, NULL, 51, N'Dr.', N'have ranch again recipe. since. good over holiday on been bacon than and made this green serve as crab', 2.8127406513377746, N'starter', N'medium', CAST(N'1953-05-16T22:28:47.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (910, NULL, 726, N'Miss', N'Enjoy! cheese, than consuming You worth good is these holiday green taste.) unique cream garlic but a Cheddar irresistible is', 2.0774516389134581, N'dessert', N'hard', CAST(N'1995-04-24T13:51:53.930' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (911, NULL, 625, N'Mr', N'or of over have told make family!|These a irresistible or eggs.|Bacon that''s holiday my to as (I you', 3.9375762832060346, N'starter', N'hard', CAST(N'1968-02-17T22:36:46.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (912, NULL, 212, N'Mr', N'crab cheese, and have made family!|These it! or give have bacon aioli have brown made holiday to as ever bacon deviled ordinary', 4.0366085088050969, N'dessert', N'easy', CAST(N'2015-07-28T10:15:16.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (913, NULL, 600, N'Dr', N'they a eggs.|Bacon cheese, been but to can it! is ordinary family!|These and as much my and (I cheese,', 1.5736959425610007, N'starter', N'hard', CAST(N'2004-03-06T05:08:34.000' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (914, NULL, 373, N'Dr.', N'shredded You for enjoy (I green is and to and have is for brown again asked eggs cheese. for asked dip', 1.0414262735477771, N'dessert', N'medium', CAST(N'1961-09-09T16:23:21.510' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (915, NULL, 208, N'Mr', N'made since. serve for serve than cheese. serve include family!|These combine deviled as ranch crab told serve well.|This sandwiches.|Time cream unique good such an bacon worth to ranch', 4.0581618789854286, N'dish', N'hard', CAST(N'2010-05-25T09:33:30.550' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (916, NULL, 978, N'Miss', N'is recipe. is bacon deviled since. onions, friends been sandwiches.|Time Better to a bacon told an and', 2.5230565641648397, N'dessert', N'easy', CAST(N'1990-09-27T14:22:56.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (917, NULL, 589, N'Miss.', N'Better a they a cheddar include ranch recipe. on great The cheese, family!|These recipe. cheese, is and', 5.1296109227135833, N'dessert', N'hard', CAST(N'1960-06-30T10:45:37.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (918, NULL, 12, N'Mr', N'a cold over have holiday The cakes again and cheddar sandwiches.|Time taste.) than cheese. ranch a bacon, (I and dip deviled ordinary that''s cream', 5.1095174449074632, N'starter', N'medium', CAST(N'2003-10-10T22:31:15.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (919, NULL, 392, N'Dr.', N'well party, great ordinary been family!|These dip much it! them. cakes have worth sandwiches.|Time and', 1.1501899515978014, N'dessert', N'hard', CAST(N'2001-06-29T08:28:45.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (920, NULL, 127, N'Mr', N'and as told it! is you a much told Better this an is since. cold well sandwiches.|Time starter and bacon I''ve have Enjoy! asked cheese. full bacon good great You', 4.4970910793622449, N'starter', N'easy', CAST(N'1959-01-05T01:09:51.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (921, NULL, 340, N'Mr', N'cheddar Hope a mix! them spread this mix! sugar them. shredded recipe. unique cakes as deviled a taste.) eggs cheese, onions,', 1.1313634799473749, N'dish', N'easy', CAST(N'1980-10-22T23:44:33.970' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (922, NULL, 771, N'Mr', N'starter green an deviled eggs ever cold of them family!|These sugar as mix! can brown told an on ever', 2.2920888682324851, N'dish', N'easy', CAST(N'2000-06-12T14:01:55.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (923, NULL, 202, N'Dr.', N'a for ever worth well green great make enjoy bacon, on dip and shredded cakes them you been cheese, to they', 5.9865004210670012, N'dessert', N'medium', CAST(N'2013-12-30T16:20:09.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (924, NULL, 359, N'Ms', N'Cheddar it! party, cheddar cheddar is been them. a it asked your this cheese. mix! cream as is cheese,', 2.4054787561322928, N'dish', N'easy', CAST(N'1963-09-10T03:31:43.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (925, NULL, 319, N'Dr', N'and that''s Cheddar I''ve flavor sandwiches.|Time serve bacon my Hope and use serve as aioli taste.) spread', 1.2497625026152295, N'dessert', N'medium', CAST(N'1986-05-15T20:01:01.920' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (926, NULL, 188, N'Dr', N'as them. to as been consuming holiday and holiday worth well.|This can for serve a bacon cheese, beautifully', 5.3775725967146331, N'dish', N'hard', CAST(N'1995-01-11T11:50:48.240' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (927, NULL, 620, N'Mr', N'The since. onions, to them. combine starter and include or to recipe. mix! as it been as I''ve as deviled over', 3.4968320422325432, N'dish', N'easy', CAST(N'2010-01-08T07:10:43.600' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (928, NULL, 228, N'Ms', N'or a enjoy aioli irresistible deviled bacon, aioli them a onions, bacon made a (I it eggs ranch you aioli', 3.6831835125029007, N'starter', N'easy', CAST(N'1988-11-16T10:53:09.020' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (929, NULL, 991, N'Ms.', N'and told party, well over ranch sugar for them. of sandwiches.|Time crab The for irresistible such Hope', 4.090779247270329, N'dessert', N'medium', CAST(N'2010-08-24T21:52:27.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (930, NULL, 629, N'Miss.', N'ever sandwiches.|Time to a beautifully holiday on serve ordinary as my beautifully it include ordinary', 5.5831505929041425, N'dish', N'easy', CAST(N'1984-12-17T18:08:09.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (931, NULL, 198, N'Miss', N'sandwiches.|Time and good on include a can bacon well to use ever over great of worth to and over is', 3.2335287100791597, N'dessert', N'easy', CAST(N'1990-05-01T03:07:27.860' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (932, NULL, 854, N'Ms.', N'a flavor (I party, full for You dip much is is include as grease sugar for deviled as I''ve good I''ve', 1.5317872578891867, N'dessert', N'medium', CAST(N'1981-04-14T00:16:18.440' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (933, NULL, 36, N'Mr', N'We and a that''s eggs.|Bacon cakes deviled it them them. cream these it include a for but beautifully', 1.9124611392209592, N'starter', N'medium', CAST(N'1958-06-27T14:03:17.700' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (934, NULL, 393, N'Mrs', N'dip and cheese, Hope or and party, You over is bacon beautifully well.|This and well that''s garlic shredded', 3.516217754462835, N'dessert', N'medium', CAST(N'1955-02-28T00:27:07.190' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (935, NULL, 394, N'Mr', N'dressing sandwiches.|Time a eggs.|Bacon cheddar to or cakes been cream cream is a unique a aioli cheese,', 2.0635635191870683, N'dessert', N'hard', CAST(N'1962-02-15T12:49:37.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (936, NULL, 504, N'Ms', N'have worth they cheddar told friends they include much brown make great but of cheddar but include told', 5.8862425493478039, N'dessert', N'medium', CAST(N'1955-03-04T04:56:56.480' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (937, NULL, 398, N'Ms.', N'over told made (I green a holiday cream (I and this ranch unique family!|These include can starter spread', 5.7643698774112249, N'dessert', N'medium', CAST(N'2014-01-13T10:45:26.730' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (938, NULL, 369, N'Dr', N'well.|This We Hope a beautifully The great to We a them and is these enjoy than such and worth as Better', 2.907591042997125, N'dish', N'medium', CAST(N'1973-10-06T08:18:16.330' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (939, NULL, 981, N'Mr', N'dip they to cream Cheddar it! is irresistible brown The for again of Enjoy! it! ever have over is it!', 1.3530484020491356, N'dessert', N'medium', CAST(N'2010-12-30T14:46:16.150' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (940, NULL, NULL, N'Mr', N'of this I''ve well deviled and bacon cheddar cream serve been a bacon, give and a cheddar eggs.|Bacon deviled', 4.8283860840966861, N'dessert', N'medium', CAST(N'2018-12-11T00:02:51.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (941, NULL, 386, N'Mr', N'over cheddar bacon use that''s onions, of on great for cakes of a to ranch have aioli these grease this', 4.0446971757545587, N'dessert', N'easy', CAST(N'2014-01-03T22:53:08.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (942, NULL, 581, N'Dr.', N'eggs enjoy is family!|These taste.) as on eggs great a been ranch make cheddar eggs to again grease Better', 2.9053162433697453, N'starter', N'hard', CAST(N'1958-02-12T02:35:57.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (943, NULL, 38, N'Ms', N'cheese, cheese, it cheddar much We this You this aioli ordinary is aioli and or over have cheese. that''s aioli', 5.1372545525139452, N'dessert', N'hard', NULL)
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (944, NULL, 278, N'Ms', N'friends make Enjoy! and recipe. but them sandwiches.|Time onions, asked bacon, family!|These cheese, your', 1.9088434306480193, N'dessert', N'medium', CAST(N'2017-04-07T10:41:10.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (945, NULL, 919, N'Mrs.', N'holiday them made good can a them. good dip a mix! to been a ordinary dressing Enjoy! to you dip great', 2.8023166557784736, N'starter', N'medium', CAST(N'1984-07-24T08:38:38.530' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (946, NULL, 556, N'Ms', N'these The that''s brown ever deviled family!|These bacon ranch made recipe. dressing include to as an family!|These starter', 2.2324160948546679, N'starter', N'easy', CAST(N'1992-09-11T13:33:49.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (947, NULL, 569, N'Miss.', N'We Hope well is as is combine serve Cheddar full is or spread Hope and recipe. Enjoy! consuming sugar cheese.', 1.942245312473851, N'dessert', N'easy', CAST(N'1986-07-02T07:33:46.870' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (948, NULL, 751, N'Dr.', N'ranch cheese, and Better they as flavor flavor grease sugar told bacon as as cold to include a cheese. again holiday cheese, a since.', 2.908202519131919, N'starter', N'hard', CAST(N'1964-10-19T16:19:04.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (949, NULL, 533, N'Dr', N'combine serve sugar and is deviled to Better an again Better unique ranch dip can The beautifully an', 3.1050413777609549, N'starter', N'hard', CAST(N'1962-04-05T08:00:56.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (950, NULL, 633, N'Mr', N'is an to irresistible well.|This you asked irresistible crab is a and Cheddar been eggs.|Bacon give cream', 1.3659988988032559, N'starter', N'easy', CAST(N'1965-02-21T08:53:06.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (951, NULL, 367, N'Mr', N'a a as ever beautifully have you deviled and and much they as for have recipe. great made Enjoy! again', 3.8873299564641575, N'dessert', N'medium', CAST(N'2006-05-26T20:55:52.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (952, NULL, 591, N'Dr', N'have ranch but and cheese, them made beautifully ever ever or party, worth such that''s for family!|These holiday', 3.2088409458328231, N'dish', N'easy', CAST(N'2015-10-20T20:40:47.800' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (953, NULL, 796, N'Miss.', N'and eggs I''ve a ranch good told grease as cheese. ordinary you ordinary for sugar Better ranch sandwiches.|Time', 4.0502540911781857, N'dish', N'hard', CAST(N'1995-12-28T23:11:27.270' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (954, NULL, 532, N'Miss.', N'bacon them. cheese. for crab starter again crab and aioli grease include an is sugar grease use your this', 2.9920698492750852, N'dessert', N'easy', CAST(N'2008-12-10T11:47:58.980' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (955, NULL, 508, N'Mr', N'make been a dip We cheese, it them have make friends starter over over a grease and cheese. Enjoy! Cheddar', 1.4926321587956659, N'dessert', N'hard', CAST(N'1958-07-20T23:05:13.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (956, NULL, 436, N'Ms.', N'over them. a a beautifully dressing full consuming they a spread to asked sandwiches.|Time been they', 4.6061703151120668, N'dessert', N'medium', CAST(N'1975-07-13T09:54:07.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (957, NULL, 984, N'Mr', N'and and that''s a taste.) dressing serve it bacon green bacon taste.) ever for grease much The a consuming', 4.6313883255382011, N'starter', N'easy', CAST(N'2004-06-29T15:38:31.040' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (958, NULL, 109, N'Mr', N'We crab beautifully over them worth over starter Better for much spread as cheese, deviled a combine and they', 3.2988077124109525, N'dish', N'easy', CAST(N'1988-11-22T23:41:53.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (959, NULL, 618, N'Ms', N'ranch holiday dressing consuming a and it! a have but deviled or much as (I cheese. cheese. over is and', 5.6007010990757031, N'dish', N'hard', CAST(N'1991-07-03T22:30:54.230' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (960, NULL, 687, N'Dr.', N'deviled you them you ranch aioli told eggs and it told good cheese, have sugar bacon, deviled but I''ve mix! Cheddar', 2.916710099632251, N'starter', N'hard', CAST(N'1966-01-17T05:49:18.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (961, NULL, 205, N'Mr', N'and them party, a onions, shredded made told have use Hope or an ranch Cheddar enjoy Enjoy! ranch been since. a', 2.2647689116488996, N'starter', N'medium', CAST(N'1985-07-26T15:33:59.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (962, NULL, 531, N'Mrs.', N'make well and enjoy friends that''s it that''s spread it as my as deviled as as but taste.) ever a combine', 2.8043359354158564, N'dessert', N'easy', CAST(N'2004-01-09T20:12:53.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (963, NULL, 643, N'Mr', N'holiday it cheese. brown sugar again dip Cheddar family!|These shredded of and as great your as well worth a as', 1.0323927356081049, N'dish', N'hard', CAST(N'2000-04-06T07:20:39.410' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (964, NULL, 621, N'Mr', N'serve them well.|This family!|These ever since. deviled beautifully ever such on them worth than mix! as', 3.2295900584336321, N'dish', N'medium', CAST(N'1980-10-25T14:59:00.520' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (965, NULL, 810, N'Mrs', N'as bacon cakes garlic cakes over family!|These make over dressing grease have ever have cheese, Hope', 4.8439229288342975, N'dessert', N'hard', CAST(N'1990-05-30T04:20:37.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (966, NULL, 725, N'Mr', N'it an deviled my been beautifully and a great is friends well ranch and since. (I can onions, bacon bacon starter taste.)', 3.4057890253168477, N'dish', N'easy', CAST(N'1957-12-25T10:44:26.070' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (967, NULL, 341, N'Dr.', N'for consuming made and sandwiches.|Time it cheese, it over give to friends party, and such a it! them', 3.1241473695841373, N'dish', N'medium', CAST(N'2008-11-04T22:20:27.840' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (968, NULL, 815, N'Miss.', N'these to a it crab have bacon, cold good it! eggs again combine deviled you ever them cream it it flavor to', 4.0574781880981661, N'dish', N'medium', CAST(N'2010-01-31T20:11:58.790' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (969, NULL, 693, N'Mr', N'taste.) bacon aioli cream ordinary cheddar since. holiday cheddar as a spread include good to for as and or much as well a', 4.977862754360709, N'starter', N'hard', CAST(N'2002-01-08T04:41:26.810' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (970, NULL, 751, N'Mr', N'for Hope taste.) eggs cold it that''s give good on use as a is Cheddar eggs.|Bacon as brown family!|These', 4.1719193296376247, N'dessert', N'medium', CAST(N'2021-07-25T03:33:43.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (971, NULL, 657, N'Mr', N'onions, to Cheddar irresistible cheese, been cold a for Cheddar of full made over Hope this spread made cheddar', 2.7586866867536153, N'starter', N'hard', CAST(N'2008-03-24T04:36:34.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (972, NULL, 514, N'Dr', N'family!|These cakes that''s these irresistible been it deviled include told give friends beautifully recipe. as a', 3.2220198797164579, N'dish', N'easy', CAST(N'1998-09-14T03:37:30.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (973, NULL, 403, N'Mr', N'unique aioli a dip as good as serve than We it or family!|These combine sandwiches.|Time unique Cheddar is', 4.7564690428583276, N'dish', N'easy', CAST(N'2008-09-24T02:27:21.540' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (974, NULL, 556, N'Dr', N'make made shredded than enjoy onions, have have ordinary ranch grease my a make been cheese, over for', 2.3218038675011154, N'starter', N'medium', CAST(N'2014-10-11T07:44:59.560' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (975, NULL, 882, N'Dr.', N'a a ranch unique Enjoy! use cheese. cold shredded over irresistible eggs it a dip and good and as irresistible made', 1.4523939036076861, N'dish', N'hard', CAST(N'2004-07-19T08:25:53.310' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (976, NULL, 769, N'Dr.', N'have beautifully cakes family!|These ranch flavor crab you to ordinary as is it cold or is great well on combine', 4.22604723657763, N'dish', N'medium', CAST(N'1967-01-01T02:16:43.710' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (977, NULL, 653, N'Ms', N'asked enjoy Cheddar this give Hope deviled cheese, ranch as great you them grease cheese. spread than is', 3.1548343157185403, N'dish', N'medium', CAST(N'1975-09-11T21:08:36.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (978, NULL, 387, N'Mr', N'bacon them and brown this your well.|This over can sandwiches.|Time have enjoy you consuming aioli and', 5.0776569904189826, N'starter', N'hard', CAST(N'2005-03-07T03:20:45.420' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (979, NULL, 672, N'Mr', N'starter spread made dip it! much well well cheddar of this much and that''s unique to green they a brown taste.) dressing', 5.6031621003538188, N'dish', N'medium', CAST(N'1982-06-09T07:41:30.940' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (980, NULL, 561, N'Mr', N'and serve mix! We (I deviled to deviled great and or it as holiday spread starter a eggs brown bacon cream', 5.0173464077605612, N'dessert', N'easy', CAST(N'1992-12-28T13:57:54.200' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (981, NULL, 297, N'Dr', N'such told We as We I''ve dressing starter enjoy your cheese, give is them ever shredded asked that''s beautifully', 4.4353272842407812, N'dish', N'medium', CAST(N'2021-11-13T12:27:15.060' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (982, NULL, 959, N'Dr.', N'dressing ordinary them. The ever been Better that''s well.|This as a cheddar bacon as it green much cakes been', 1.5886295231006247, N'starter', N'medium', CAST(N'1983-03-25T19:31:44.180' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (983, NULL, 192, N'Mr', N'ordinary of deviled them been ever flavor The give spread your worth been this onions, grease on that''s dip', 1.5781421347419462, N'starter', N'easy', CAST(N'2000-10-05T23:09:47.300' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (984, NULL, 183, N'Dr.', N'but serve as ever mix! bacon cold You to as great cakes my I''ve brown a cakes have these told can garlic you have asked dip', 3.7247803484670725, N'dessert', N'easy', CAST(N'1976-09-26T02:00:02.120' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (985, NULL, 941, N'Mr', N'such your taste.) and brown aioli give an cakes ranch as worth full deviled make well cheese, as and', 2.695820636439985, N'dish', N'medium', CAST(N'1957-04-01T00:56:34.900' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (986, NULL, 291, N'Dr.', N'deviled bacon, and dip I''ve as irresistible cold Better as cream taste.) serve these these bacon my dressing', 1.024687764246337, N'dish', N'hard', CAST(N'1991-02-27T21:27:22.080' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (987, NULL, 26, N'Mrs.', N'over on dressing to dressing deviled a and on your family!|These taste.) deviled an deviled it eggs.|Bacon bacon,', 3.4815331667110012, N'starter', N'hard', CAST(N'2016-05-03T03:56:00.590' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (988, NULL, 462, N'Mr', N'make a and been great for much Hope starter your this cream a cold made good but much great over include', 4.9203912899458739, N'starter', N'medium', CAST(N'1994-05-04T12:28:19.460' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (989, NULL, 875, N'Mr', N'is flavor been a and full have I''ve and bacon, crab been brown sugar starter full Hope cheese, holiday on', 3.0235855956671691, N'starter', N'medium', CAST(N'2021-12-07T14:58:03.890' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (990, NULL, 714, N'Mr', N'great for made as is unique (I since. it Better have serve cheese, make (I told brown crab and family!|These a spread make family!|These', 3.4573932040750019, N'dessert', N'easy', CAST(N'2001-08-17T14:33:00.110' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (991, NULL, 886, N'Ms', N'your asked as well.|This you green friends as family!|These holiday such I''ve your great shredded make', 2.2548542238096028, N'dish', N'easy', CAST(N'1979-08-18T21:11:06.950' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (992, NULL, 374, N'Miss', N'and Better full been a them starter starter cheese, is a have and and full a and deviled friends them as garlic', 3.4655621650002719, N'starter', N'easy', CAST(N'1988-04-10T05:15:02.780' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (993, NULL, 124, N'Mr', N'cheese, this asked been ordinary bacon, your Enjoy! ranch use friends on and a spread as I''ve garlic', 3.3068899439214214, N'starter', N'hard', CAST(N'1975-07-14T12:14:32.490' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (994, NULL, 504, N'Dr', N'family!|These mix! them a dip irresistible much Hope and sandwiches.|Time my asked but on garlic make than', 4.4363383024168836, N'dish', N'hard', CAST(N'1960-09-20T02:28:57.550' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (995, NULL, 459, N'Mr', N'ever beautifully cream irresistible mix! as have it I''ve great that''s such spread mix! irresistible include as', 3.5636171724477865, N'dessert', N'hard', CAST(N'1978-06-06T23:12:16.620' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (996, NULL, 507, N'Dr.', N'serve garlic over as include it! since. cold is taste.) them as them The consuming green and crab over for', 2.2403612403387023, N'dessert', N'hard', CAST(N'1967-12-03T03:49:58.390' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (997, NULL, 813, N'Miss.', N'it over cheese, cream is starter irresistible bacon dip brown a is or cold made a good You eggs.|Bacon', 2.87292350776164, N'dessert', N'hard', CAST(N'1966-09-30T15:32:28.770' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (998, NULL, 503, N'Dr', N'use it The a to been such and bacon ranch great serve a include party, taste.) We as these is since.', 2.9076644940803127, N'dish', N'easy', CAST(N'1999-04-19T11:36:57.370' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (999, NULL, 318, N'Dr.', N'cheese, and but as them a bacon, ranch cheese, full to for green crab them. cheese, and cakes of deviled worth', 3.0649205018137211, N'dessert', N'hard', CAST(N'1979-11-10T06:20:32.830' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (1000, NULL, 594, N'Mr', N'told deviled deviled dressing made and than ranch cakes it can and of they deviled such crab bacon, sugar', 5.3965276304616259, N'dessert', N'easy', CAST(N'1979-07-31T21:54:12.450' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (1002, 123, 818, N'Mr', N'Blabla', 2.5, N'dessert', N'easy', CAST(N'2019-06-25T17:26:29.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (1003, 567, 818, N'Mr', N'Blabla', 2.5, N'dessert', N'easy', CAST(N'2019-06-25T17:26:29.650' AS DateTime))
GO
INSERT [dbo].[Recipes] ([RecipeID], [PublisherID], [SubFoodCategoryID], [Title], [Description], [TotalTime], [Type], [Level], [PublicationDate]) VALUES (1510, 123, 662, N'Mr', N'Blablabla', 2.7, N'dish', N'medium', CAST(N'2018-06-25T17:26:29.650' AS DateTime))
GO


-- Insert RecipeIngredient
INSERT [dbo].[RecipeIngredient] ([RecipeID], [IngredientID], [Amount]) VALUES (1, 1, 100)
GO
INSERT [dbo].[RecipeIngredient] ([RecipeID], [IngredientID], [Amount]) VALUES (1, 14, 2)
GO
INSERT [dbo].[RecipeIngredient] ([RecipeID], [IngredientID], [Amount]) VALUES (1, 22, 250)
GO
INSERT [dbo].[RecipeIngredient] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 2, 50)
GO
INSERT [dbo].[RecipeIngredient] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 25, 100)
GO
INSERT [dbo].[RecipeIngredient] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 29, 100)
GO
INSERT [dbo].[RecipeIngredient] ([RecipeID], [IngredientID], [Amount]) VALUES (3, 16, 30)
GO

-- Insert Comments
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (345, CAST(N'2020-12-03T00:00:00.000' AS DateTime), 3, 1)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (387, CAST(N'2000-01-01T00:00:00.000' AS DateTime), 5, 34)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (450, CAST(N'2019-06-03T00:00:00.000' AS DateTime), 5, 12)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (450, CAST(N'2021-02-05T00:00:00.000' AS DateTime), 3, 100)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (456, CAST(N'2021-09-27T00:00:00.000' AS DateTime), 4, 23)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (482, CAST(N'2021-04-03T00:00:00.000' AS DateTime), 5, 5)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (567, CAST(N'2018-09-08T00:00:00.000' AS DateTime), 4, 2)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (482, CAST(N'2021-03-03T00:00:00.000' AS DateTime), 2, 5)
GO
INSERT [dbo].[Comments] ([UserID], [CommentDate], [Rating], [RecipeID]) VALUES (567, CAST(N'2018-05-08T00:00:00.000' AS DateTime), 1, 2)
GO



-- USERS
CREATE LOGIN MyUser WITH PASSWORD = '1234';
USE food
GO
CREATE USER MyUser FOR LOGIN MyUser
GO

CREATE LOGIN AdminUser WITH PASSWORD = '1234';
USE food
GO

CREATE USER AdminUser FOR LOGIN AdminUser
GO

CREATE LOGIN RegisterUser WITH PASSWORD = '1234';
USE food
GO
CREATE USER RegisterUser FOR LOGIN RegisterUser
GO

CREATE LOGIN GuestUser WITH PASSWORD = '1234';
USE food
GO
CREATE USER GuestUser FOR LOGIN GuestUser
GO
