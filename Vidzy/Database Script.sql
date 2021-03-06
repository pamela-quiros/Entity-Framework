USE [Vidzy]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 10/11/2015 1:14:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Genres](
	[Id] [tinyint] NOT NULL,
	[Name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Genres] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Videos]    Script Date: 10/11/2015 1:14:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Videos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[ReleaseDate] [datetime] NOT NULL,
	[GenreId] [tinyint] NULL,
	[Classification] [tinyint] NOT NULL CONSTRAINT [DF_Videos_Classification]  DEFAULT ((1)),
 CONSTRAINT [PK_Videos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Videos]  WITH CHECK ADD  CONSTRAINT [FK_Videos_Genres] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
GO
ALTER TABLE [dbo].[Videos] CHECK CONSTRAINT [FK_Videos_Genres]
GO
/****** Object:  StoredProcedure [dbo].[spAddVideo]    Script Date: 10/11/2015 1:14:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddVideo]
(
	@Name varchar(255),
	@ReleaseDate datetime,
	@Genre varchar(255),
	@Classification tinyint
)
AS

	DECLARE @GenreId tinyint
	SET @GenreId = (SELECT Id FROM Genres WHERE Name = @Genre)

	INSERT INTO Videos (Name, ReleaseDate, GenreId, Classification)
	VALUES (@Name, @ReleaseDate, @GenreId, @Classification)

GO
INSERT INTO Genres (Id, Name)
VALUES 
	(1, 'Comedy'), 
	(2, 'Action'), 
	(3, 'Horror'), 
	(4, 'Thriller'), 
	(5, 'Family'), 
	(6, 'Romance')