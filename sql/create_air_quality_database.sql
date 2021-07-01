USE master;
GO

-- Delete air_quality_data database if it exists

IF DB_ID('air_quality_data') IS NOT NULL
BEGIN
	ALTER DATABASE air_quality_data SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE air_quality_data;
END

-- Create New air_quality_data database

CREATE DATABASE air_quality_data;
GO

USE [air_quality_data]
GO

/****** Object:  Table [dbo].[city]    Script Date: 6/28/2021 10:47:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[city](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [varchar](50) NOT NULL UNIQUE,
 CONSTRAINT [PK_city] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [nvarchar](50) NOT NULL UNIQUE,
 CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[state](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[state_name] [nvarchar](50) NOT NULL UNIQUE,
 CONSTRAINT [PK_state] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[state]  WITH CHECK ADD  CONSTRAINT [FK_state_state] FOREIGN KEY([state_id])
REFERENCES [dbo].[state] ([state_id])
GO

ALTER TABLE [dbo].[state] CHECK CONSTRAINT [FK_state_state]
GO

CREATE TABLE [dbo].[pollution_event](
	[pollution_event_id] [int] IDENTITY(1,1) NOT NULL,
	[country_id] [int] NOT NULL,
	[state_id] [int] NOT NULL,
	[city_id] [int] NOT NULL,
	[pollution_timestamp] [datetime] NULL,
	[aqi] [int] NULL,
	[mainus] [nchar](3) NULL,
 CONSTRAINT [PK_pollution_event] PRIMARY KEY CLUSTERED 
(
	[pollution_event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pollution_event]  WITH CHECK ADD  CONSTRAINT [FK_pollution_event_city_id] FOREIGN KEY([city_id])
REFERENCES [dbo].[city] ([city_id])
GO

ALTER TABLE [dbo].[pollution_event] CHECK CONSTRAINT [FK_pollution_event_city_id]
GO

ALTER TABLE [dbo].[pollution_event]  WITH CHECK ADD  CONSTRAINT [FK_pollution_event_country_id] FOREIGN KEY([country_id])
REFERENCES [dbo].[country] ([country_id])
GO

ALTER TABLE [dbo].[pollution_event] CHECK CONSTRAINT [FK_pollution_event_country_id]
GO

ALTER TABLE [dbo].[pollution_event]  WITH CHECK ADD  CONSTRAINT [FK_pollution_event_state_id] FOREIGN KEY([state_id])
REFERENCES [dbo].[state] ([state_id])
GO

ALTER TABLE [dbo].[pollution_event] CHECK CONSTRAINT [FK_pollution_event_state_id]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Country Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pollution_event', @level2type=N'CONSTRAINT',@level2name=N'FK_pollution_event_country_id'
GO



CREATE TABLE [dbo].[weather_event](
	[weather_event_id] [int] IDENTITY(1,1) NOT NULL,
	[country_id] [int] NOT NULL,
	[state_id] [int] NOT NULL,
	[city_id] [int] NOT NULL,
	[weather_timestamp] [datetime] NOT NULL,
	[temperature] [int] NOT NULL,
	[humidity] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_weather_event] PRIMARY KEY CLUSTERED 
(
	[weather_event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO