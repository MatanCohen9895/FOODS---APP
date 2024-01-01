use Food
go


--drop procedure GetStoredProc


create or alter procedure GetStoredProc

@TypeOfRecipe VARCHAR(10),
@LevelOfRecipe VARCHAR(10)
as 
BEGIN
SET NOCOUNT ON
SET ANSI_WARNINGS OFF

IF((@TypeOfRecipe IS NULL OR @TypeOfRecipe = '') AND (@LevelOfRecipe IS NULL OR @LevelOfRecipe = ''))
	BEGIN
		select R.RecipeID,R.PublisherID,R.SubFoodCategoryID,R.Title,R.Description,R.TotalTime,R.Type,R.Level,R.PublicationDate
		from Recipes as R
		where R.PublisherID IS NOT NULL
	END

ELSE IF(@TypeOfRecipe IS NULL OR @TypeOfRecipe = '')
	BEGIN
		select R.RecipeID,R.PublisherID,R.SubFoodCategoryID,R.Title,R.Description,R.TotalTime,R.Type,R.Level,R.PublicationDate
		from Recipes as R
		where R.Level = @LevelOfRecipe AND R.PublisherID IS NOT NULL
	END
ELSE IF(@LevelOfRecipe IS NULL OR @LevelOfRecipe = '')
	BEGIN
		select R.RecipeID,R.PublisherID,R.SubFoodCategoryID,R.Title,R.Description,R.TotalTime,R.Type,R.Level,R.PublicationDate
		from Recipes as R
		where R.Type = @TypeOfRecipe AND R.PublisherID IS NOT NULL
	END
ELSE
	BEGIN
		select R.RecipeID,R.PublisherID,R.SubFoodCategoryID,R.Title,R.Description,R.TotalTime,R.Type,R.Level,R.PublicationDate
		from Recipes as R
		where R.Type = @TypeOfRecipe AND R.Level = @LevelOfRecipe AND R.PublisherID IS NOT NULL
	END
END
go

select distinct Type from Recipes


exec GetStoredProc '', ''

create or alter procedure BringDataOnUser
@ID smallint
as 
BEGIN
	SELECT * 
	FROM Publisher 
	WHERE Publisher.PublisherID = @ID
END

exec BringDataOnUser 123

-- no active puplisher
create or alter view noactivepuplisher as
select U.UserID,U.FirstName,U.LastName, U.Gender, (select cityName from city where U.CityNum = city.CityNum) as city
from Users as U
where UserID not in (
select PublisherID
from Publisher)

--s


-- Bring all recipes with their type and their level
create or alter view RecipeStatistics as
select count(R.recipeID) as NumberOfRecipes, R.Level, R.Type
from Recipes as R
group by R.Level, R.Type

select* from RecipeStatistics

-- Bring all recipes with their grade
create or alter view RecipeGrades as
select count(R.recipeID) as NumberOfRecipes, C.Rating, R.Type
from Recipes as R inner join Comments as C
on R.RecipeID = C.RecipeID
group by C.Rating, R.Type

select* from RecipeGrades
--
--Function that count for each publisher how many Recipes he published
create or alter function BestPublisher (@P_ID int)
returns real
as begin
declare @amount real
select @amount = COUNT(@P_ID)
from Publisher as P inner join Recipes as R
on P.PublisherID = R.PublisherID
where P.PublisherID = @P_ID
return @amount
end
go
--Calling the function from the select part
select P.PublisherID, P.FirstName, P.LastName,
Amount =dbo.BestPublisher(P.PublisherID)
from Publisher as P




create or alter view Bpublisher as
select P.PublisherID, P.FirstName, P.LastName,
Amount =dbo.BestPublisher(P.PublisherID)
from Publisher as P

--
select* from Bpublisher




-- Function that receive ID of one of the Publishers that exist in the system and return statistics for recipes according to the combination of the elements(Type and Level) ➔ for example, num of Recipes that are DESSERT and HARD.
create or alter function StatsUsers (@ID int)
returns table
as return
select P.FirstName , P.LastName, count(R.recipeID) as NumberOfRecipes, R.Level, R.Type
from Recipes as R inner join Publisher as P
on R.PublisherID = P.PublisherID
where R.PublisherID = @ID
group by R.Level, R.Type , P.FirstName, P.LastName
go
--Calling the function with specific ID
select *
from dbo.StatsUsers(123)
go

--

create or alter function stuser (@ID int)
returns real
as begin
select P.FirstName , P.LastName, count(R.recipeID) as NumberOfRecipes, R.Level, R.Type
from Recipes as R inner join Publisher as P
on R.PublisherID = P.PublisherID
where R.PublisherID = @ID
group by R.Level, R.Type , P.FirstName, P.LastName
end
go

---- (PROCEDURE) Function that receive ID of one of the Publishers that exist in the system and return statistics for recipes according to the combination of the elements(Type and Level) ➔ for example, num of Recipes that are DESSERT and HARD.

drop procedure GetStuser

create or alter procedure GetStuser

@ID int
as 
BEGIN
select P.FirstName , P.LastName, count(R.recipeID) as NumberOfRecipes, R.Level, R.Type
from Recipes as R inner join Publisher as P
on R.PublisherID = P.PublisherID
where R.PublisherID = @ID
group by R.Level, R.Type , P.FirstName, P.LastName
END
go

exec GetStuser 123



--Trigger
-- Using trigger for updating column totalRecipes after inserting, deleting or updating recipes
--delete column
Alter table Publisher drop column totalRecipes
-- add column
Alter table Publisher add totalRecipes int
go
--check add column
select *
from Publisher
-- update the new column
update Publisher
set Publisher.totalRecipes = (
select COUNT(R.RecipeID)
from Recipes as R
where R.PublisherID= Publisher.PublisherID
)
go
select *
from Publisher
create or alter trigger updatePublisher
on Recipes
after insert, update, delete as
begin
declare @action as char(1);
declare @OldEmpId as int;
declare @NewEmpId as int;
set @action = (case when exists(select * from inserted) and exists(select* from deleted)
then 'U'
when exists(select * from inserted) then 'I'
when exists(select * from deleted) then 'D'
else null
end)
if @action = 'U'
begin
print ('Update Action')
select @OldEmpId = deleted.PublisherID
from deleted
select @NewEmpId = inserted.PublisherID
from inserted
if @NewEmpId = @OldEmpId return ;
update Publisher
set totalRecipes = totalRecipes + 1
where PublisherID = @NewEmpId
update Publisher
set totalRecipes = totalRecipes - 1
where PublisherID = @OldEmpId
end
else if @action = 'I'
begin
print('Inserted Action')
select @NewEmpId = inserted.PublisherID
from inserted
update Publisher
set totalRecipes = totalRecipes + 1
where PublisherID = @NewEmpId
end
else if @action = 'D'
begin
print('Deleted Action')
select @OldEmpId = deleted.PublisherID
from deleted
update Publisher
set totalRecipes = totalRecipes - 1
where PublisherID = @OldEmpId
end
else return
end
go

--delete order
select * from Recipes
delete from Recipes
WHERE RecipeID =11

-- grade
select * from FoodCategories
select * from Comments

-- add new recipe by checking if already exist in the system
create or alter procedure CreateNewRecipe @RID int, @PID int, @SubID int, @Title nvarchar(5), @Description nvarchar(30), @TotalTime float, @Type nvarchar(10), @Level nvarchar(10)
as
if not exists
(select *
from Recipes as R
where R.RecipeID = @RID and R.PublisherID is not null)
begin
insert into Recipes(RecipeID, PublisherID, SubFoodCategoryID, Title, [Description], TotalTime,[Type],[Level], PublicationDate)
values (@RID, @PID, @SubID, @Title, @Description, @TotalTime, @Type, @Level, '2018-06-25 17:26:29.650')
print 'Succesfully inserted'
end
else print 'Already used'
go

exec CreateNewRecipe 1510, 123, 662, 'Mr', 'Blablabla', 2.7, 'dish', 'medium'
select *
from Recipes


-- delete bad comment
delete from Comments
where Comments.Rating < 3