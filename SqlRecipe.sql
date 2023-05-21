use RecipeBox;

-- =================
-- User View       |
-- =================
go
create view userInfo
as
    select id,user_name,first_name,last_name,email,date_joined,profile_image from api_customuser
go

-- =================
-- User Procedures  |
-- =================
-->  a stored procedure for retriving user's data
create proc sp_retriveUserInfo (@id varchar(50))
as
    begin
        select user_name,first_name,last_name,email,date_joined,profile_image from userInfo where id = @id;
    end
go

-- ===============================
-- Recipe Trigger for audit trial |
-- ===============================
CREATE TABLE audit_recipe(
 name_new VARCHAR(20),
 name_old VARCHAR(20),
 id varchar(100),
 instruction_new VARCHAR(8000),
 instruction_old VARCHAR(8000),
 updated_at DATETIME NULL,
 created_at DATETIME NULL,
 category_id_old varchar(100),
 category_id_new varchar(100),
 owner_id VARCHAR(100),
 photo_new Varchar(8000),
 photo_old Varchar(8000));

 DROP TABLE audit_recipe
 DROP TRIGGER updated_recipe
GO
CREATE TRIGGER updated_recipe
ON api_recipe AFTER UPDATE

AS
BEGIN 
DECLARE @name_new VARCHAR(20)= (SELECT name FROM INSERTED);
DECLARE @name_old VARCHAR(20)= (SELECT name FROM DELETED);
DECLARE @id Varchar(100)=(SELECT id FROM DELETED)
DECLARE @instruction_new VARCHAR(8000) = (SELECT instruction FROM INSERTED)
DECLARE @instruction_old VARCHAR(8000) = (SELECT instruction FROM DELETED)
DECLARE @updated_at DATETIME = (SELECT updated_at FROM DELETED);
DECLARE @created_at DATETIME=(SELECT created_at FROM DELETED)
DECLARE @category_id_new Varchar(100) = (SELECT category_id FROM INSERTED)
DECLARE @category_id_old Varchar(100) = (SELECT category_id FROM DELETED)
DECLARE @photo_new Varchar(8000)  = (SELECT photo  FROM INSERTED)
DECLARE @photo_old Varchar(8000)  = (SELECT photo  FROM DELETED)
DECLARE @owner_id  VARCHAR(100) = (SELECT owner_id FROM INSERTED)
INSERT IntO audit_recipe (name_new ,name_old,id ,instruction_new ,instruction_old ,updated_at,created_at,
        category_id_old ,category_id_new ,owner_id ,photo_new ,photo_old)

 Values(@name_new , @name_old, @id ,@instruction_new ,@instruction_old ,@updated_at,@created_at ,
   @category_id_old ,@category_id_new ,@owner_id ,@photo_new ,@photo_old);

END

-- TESTING RECIPE TRIGGER
update  api_recipe set name = 'Double Cheese Burger' WHERE name= 'Cheese Burger';
select * from dbo.audit_recipe
select * from api_recipe;




--INDEXING THE RECEPIE TABLE 
CREATE UNIQUE NONCLUSTERED INDEX  index_for_recipe_table ON api_recipe(id) 

  INCLUDE (name)

     WITH (FILLFACTOR = 70 --THIS INDICATES THAT THE INDEX PAGES WILL BE AROUND 70 PERCENT FULL.

  ,IGNORE_DUP_KEY = ON)




--BACKING UP THE DATABASE

BACKUP DATABASE RecipeBox 
 TO DISK = 'C:\RecipeBoxBackups\recipe_backup.bak' 


 WITH INIT;--this option makes it so that the backup is appended to the already existing backups
