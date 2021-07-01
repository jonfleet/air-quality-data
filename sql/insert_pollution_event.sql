-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		J. Fleet
-- Create date: 6/28/2021
-- Description:	Insert Pollution Event
-- =============================================
CREATE PROCEDURE insert_pollution_event 
	-- Add the parameters for the stored procedure here
	@country_name nvarchar(50), 
	@state_name nvarchar(50),
	@city_name nvarchar(50),
	@pollution_timestamp DateTime,
	@aqi int,
	@mainus nvarchar(5) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Insert into country (country_name) values(@country_name);
	Insert into state (state_name) values (@state_name);
	Insert into city (city_name) values (@city_name);

	
Insert into pollution_event (country_id, state_id, city_id, pollution_timestamp, aqi, mainus)
values 
(
	(select country_id from country where country_name = @country_name),
	(select state_id from state where state_name = @state_name),
	(select city_id from city where city_name = @city_name),
	@pollution_timestamp,
	@aqi,
	@mainus
);
END
GO
