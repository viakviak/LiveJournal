﻿-- ViakViak Schema
-- C:\Users\vroyt\Documents\SQL Server Management Studio\ViakViakSchema.sql

-- Drop foreign keys..
IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleLabel_Label]'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleLabel DROP CONSTRAINT [FK_ArticleLabel_Label]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleLabel_Article]'), 'IsConstraint') = 1
	ALTER TABLE dbo.ArticleLabel DROP CONSTRAINT [FK_ArticleLabel_Article]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleWord_Word]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[ArticleWord] DROP CONSTRAINT [FK_ArticleWord_Word]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_ArticleWord_Article]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[ArticleWord] DROP CONSTRAINT [FK_ArticleWord_Article]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_Root_Language]'), 'IsConstraint') = 1
	ALTER TABLE dbo.[Root] DROP CONSTRAINT [FK_Root_Language]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_Word_Root]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[Word] DROP CONSTRAINT [FK_Word_Root]
GO

IF OBJECTPROPERTY(OBJECT_ID('[FK_Word_Language]'), 'IsConstraint') = 1
	ALTER TABLE [dbo].[Word] DROP CONSTRAINT [FK_Word_Language]
GO

-- Drop tables..
/****** Object:  Table dbo.Article    Script Date: 9/5/2016 6:20:20 PM ******/
IF OBJECT_ID(N'dbo.Article', N'U') IS NOT NULL
	DROP TABLE dbo.Article
GO

/****** Object:  Table dbo.ArticleLabel    Script Date: 9/5/2016 7:03:55 PM ******/
IF OBJECT_ID(N'dbo.ArticleLabel', N'U') IS NOT NULL
	DROP TABLE dbo.ArticleLabel
GO

/****** Object:  Table dbo.[Root]    Script Date: 9/5/2016 6:53:21 PM ******/
IF OBJECT_ID(N'dbo.Article', N'U') IS NOT NULL
	DROP TABLE dbo.[Root]
GO

/****** Object:  Table [dbo].[ArticleWord]    Script Date: 9/5/2016 7:09:18 PM ******/
IF OBJECT_ID(N'dbo.ArticleWord', N'U') IS NOT NULL
	DROP TABLE [dbo].[ArticleWord]
GO

/****** Object:  Table [dbo].[Label]    Script Date: 9/5/2016 7:12:58 PM ******/
IF OBJECT_ID(N'dbo.Label', N'U') IS NOT NULL
	DROP TABLE [dbo].[Label]
GO

/****** Object:  Table dbo.[Language]    Script Date: 9/5/2016 6:51:52 PM ******/
IF OBJECT_ID(N'dbo.Language', N'U') IS NOT NULL
	DROP TABLE dbo.[Language]
GO

/****** Object:  Table dbo.[Root]    Script Date: 9/5/2016 6:53:21 PM ******/
IF OBJECT_ID(N'dbo.Root', N'U') IS NOT NULL
	DROP TABLE [dbo].[Root]
GO
/****** Object:  Table [dbo].[Word]    Script Date: 9/5/2016 7:14:14 PM ******/
IF OBJECT_ID(N'dbo.Word', N'U') IS NOT NULL
	DROP TABLE [dbo].[Word]
GO

-- Drop stored procedures..
IF OBJECT_ID('spAddArticle', 'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spAddArticle]	
GO

-- Create tables..
/****** Object:  Table dbo.Article    Script Date: 9/5/2016 6:20:20 PM ******/
CREATE TABLE dbo.Article(
	[ArticleID] [int] IDENTITY(1,1) NOT NULL,
	LiveJournalID [int] NULL,
	Title [nvarchar](256) NULL,
	Content [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table dbo.ArticleLabel    Script Date: 9/5/2016 7:03:55 PM ******/
CREATE TABLE dbo.ArticleLabel(
	[ArticleLabelID] [int] IDENTITY(1,1) NOT NULL,
	[ArticleID] [int] NOT NULL,
	[LabelID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_ArticleLabel] PRIMARY KEY CLUSTERED 
(
	[ArticleLabelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ArticleWord]    Script Date: 9/5/2016 7:09:18 PM ******/
CREATE TABLE [dbo].[ArticleWord](
	[ArticleWordID] [int] IDENTITY(1,1) NOT NULL,
	[ArticleID] [int] NOT NULL,
	[WordID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_ArticleWord] PRIMARY KEY CLUSTERED 
(
	[ArticleWordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Label]    Script Date: 9/5/2016 7:12:58 PM ******/
CREATE TABLE [dbo].[Label](
	[LabelID] [int] IDENTITY(1,1) NOT NULL,
	LabelName [nvarchar](50) NOT NULL,
	LanguageID [int] NULL DEFAULT 1,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Label] PRIMARY KEY CLUSTERED 
(
	[LabelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table dbo.[Language]    Script Date: 9/5/2016 6:51:52 PM ******/
CREATE TABLE dbo.[Language](
	LanguageID [int] IDENTITY(1,1) NOT NULL,
	[LanguageName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	LanguageID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table dbo.[Root]    Script Date: 9/5/2016 6:53:21 PM ******/
CREATE TABLE dbo.[Root](
	[RootID] [int] IDENTITY(1,1) NOT NULL,
	[RootName] [nvarchar](12) NULL,
	LanguageID [int] NULL DEFAULT 1,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Root] PRIMARY KEY CLUSTERED 
(
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Word]    Script Date: 9/5/2016 7:14:14 PM ******/
CREATE TABLE [dbo].[Word](
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[WordName] [nvarchar](128) NOT NULL,
	LanguageID [int] NULL DEFAULT 1,
	[RootID] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT getdate()
 CONSTRAINT [PK_Word] PRIMARY KEY CLUSTERED 
(
	[WordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Create foreign keys..
ALTER TABLE dbo.ArticleLabel  WITH CHECK ADD  CONSTRAINT [FK_ArticleLabel_Article] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Article] ([ArticleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleLabel CHECK CONSTRAINT [FK_ArticleLabel_Article]
GO

ALTER TABLE dbo.ArticleLabel  WITH CHECK ADD  CONSTRAINT [FK_ArticleLabel_Label] FOREIGN KEY([LabelID])
REFERENCES [dbo].[Label] ([LabelID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE dbo.ArticleLabel CHECK CONSTRAINT [FK_ArticleLabel_Label]
GO

ALTER TABLE [dbo].[ArticleWord]  WITH CHECK ADD  CONSTRAINT [FK_ArticleWord_Article] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Article] ([ArticleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArticleWord] CHECK CONSTRAINT [FK_ArticleWord_Article]
GO

ALTER TABLE [dbo].[ArticleWord]  WITH CHECK ADD  CONSTRAINT [FK_ArticleWord_Word] FOREIGN KEY([WordID])
REFERENCES [dbo].[Word] ([WordID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArticleWord] CHECK CONSTRAINT [FK_ArticleWord_Word]
GO

ALTER TABLE dbo.[Root]  WITH CHECK ADD  CONSTRAINT [FK_Root_Language] FOREIGN KEY(LanguageID)
REFERENCES [dbo].[Language] (LanguageID)
GO
ALTER TABLE dbo.[Root] CHECK CONSTRAINT [FK_Root_Language]
GO

ALTER TABLE [dbo].[Word]  WITH CHECK ADD  CONSTRAINT [FK_Word_Language] FOREIGN KEY(LanguageID)
REFERENCES [dbo].[Language] (LanguageID)
GO
ALTER TABLE [dbo].[Word] CHECK CONSTRAINT [FK_Word_Language]
GO

ALTER TABLE [dbo].[Word]  WITH CHECK ADD  CONSTRAINT [FK_Word_Root] FOREIGN KEY([RootID])
REFERENCES [dbo].[Root] ([RootID])
GO
ALTER TABLE [dbo].[Word] CHECK CONSTRAINT [FK_Word_Root]
GO

-- stored procedures
-- =============================================
-- Author:		ViakViak
-- Create date: 11/12/2016
-- Description:	Adds Article data
-- =============================================
CREATE PROCEDURE spAddArticle 
	@liveJournalID int, 
	@title nvarchar(1024) = NULL,
	@labels nvarchar(2048) = NULL, -- comma separated labels
	@content nvarchar(max) = NULL
AS
begin
DECLARE @articleID int;
DECLARE @posStart int = 1;
DECLARE @posStop int = 0;
DECLARE @length int;
DECLARE @lbl nvarchar(128);
DECLARE @labelID int;

SET NOCOUNT ON;

SELECT @articleID = ArticleID FROM dbo.Article WHERE LiveJournalID = @liveJournalID;
if @articleID IS NULL
	begin
	INSERT INTO dbo.Article(LiveJournalID, Title, Content) VALUES (@liveJournalID, @title, @content);
	SET @articleID = @@IDENTITY;
	end
else if @content IS NOT NULL
	UPDATE dbo.Article SET Content = @content WHERE ArticleID = @articleID;

if @labels IS NOT NULL
	begin -- labels..
	DELETE FROM dbo.ArticleLabel WHERE ArticleID = @articleID;

	SET @labels = LTRIM(RTRIM(@labels));
	SET @length = LEN(@labels);
	while @posStop < @length
		begin
		SET @posStop = CHARINDEX(N',', @labels, @posStart);
		if @posStop = 0 -- not found
			SET @posStop = @length + 1;-- end of line
		SET @lbl = LTRIM(RTRIM(SUBSTRING(@labels, @posStart, @posStop - @posStart)));
		if LEN(@lbl) > 0
			begin
			SELECT @labelID = LabelID FROM dbo.Label WHERE LabelName = @lbl;
			if @labelID IS NOT NULL
				INSERT INTO dbo.ArticleLabel(ArticleID, LabelID) VALUES (@articleID, @labelID);
			end
		SET @posStart = @posStop + 1;
		end
	end
end
GO

-- data..
INSERT INTO dbo.[Language](LanguageName, [Description]) VALUES (N'Russian', NULL); -- 1
INSERT INTO dbo.[Language](LanguageName, [Description]) VALUES (N'English', NULL); -- 2

INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'english', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'livejournal', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'usa', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'welcome', 2, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Англия', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Вашкевич', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Венеция', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'Изобретение', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'бог', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'вяк', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'геральдика', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'государство', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'деньги', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'долг', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'закон', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'имя', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'история', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'книга', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'компания', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'материя', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'смерть', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'мнение', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'общество', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'оружие', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'перевод', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'переход', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'программа', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'свобода', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'символ', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'слова', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'спорт', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'тело', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'технология', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'титул', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'торговля', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'шутка', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'эзотерика', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'экономика', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'еда', 1, NULL);
INSERT INTO dbo.[Label](LabelName, LanguageID, [Description]) VALUES (N'музыка', 1, NULL);

-- <lj-cut>
-- INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (, N'');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (41271, N'Что в имени твоем: Трамп');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40970, N'Что в имени твоем: Волга');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40952, N'Self-Interest and Ignorance');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40640, N'Что в имени твоем: Цуцик');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (40280, N'Что в имени твоем: Двигать');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39939, N'Что в имени твоем: Плюс');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39863, N'Прямой перевод: Advise - Direct translation');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39647, N'Переход Р - Л');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39200, N'Что в имени твоем: Свет');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (39064, N'Что в имени твоем: Пешка');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (38894, N'Что в имени твоем: Пехота');
--INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (38489, N'Что в имени твоем: Путин');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (38363, N'Что в имени твоем: Челси');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37986, N'Переход Г - Ж');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37656, N'Прямой перевод: Grill - direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37588, N'Вымышленный "Братан" Алексея Николаевича Толстого');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (37275, N'Переход Д - Ж');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36922, N'Что в имени твоем: Дорога');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36629, N'Переход Г - Р (грассирование)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36515, N'Прямой перевод: Water - direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (36138, N'Что в имени твоем: Суворов');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (35913, N'Что в имени твоем: Шалава');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (35667, N'Что в имени твоем: Шмокодявка');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (35512, N'Прямой перевод: Severe Weather - direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34907, N'Что в имени твоем: Бетон');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34907, N'Что в имени твоем: Пирог');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34642, N'Переход: С - Ш (шепелявость)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34476, N'Переход: Т - Ф');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (34092, N'Что в имени твоем: Раз, два, три, четыре, пять, шесть, семь, восемь, девять, десять');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33794, N'Что в имени твоем: Буратино');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33634, N'Переход "звонкий-глухой"');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33360, N'Переход Г - Х');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (33253, N'Что в имени твоем: Курок');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32945, N'Что в имени твоем: Колобок');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32662, N'Что в имени твоем: Сковорода');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32311, N'Что в имени твоем: Музыка');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (32225, N'What is in the name: Commerce - что в имени твоем');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31981, N'What is in the name: Vagina - что в имени твоем');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31712, N'Что в имени твоем: Свастика');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31341, N'What is in the name: Evening - что в имени твоем');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (31060, N'What is in the name: Chocolate. Шоколад - что в имени твоем?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30779, N'Прямой перевод: ...bourg - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30472, N'Прямой перевод: Teacher - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30351, N'Прямой перевод: Domestic - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (30099, N'Что в имени твоем: Час');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29842, N'Что в имени твоем: Рана');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29617, N'Прямой перевод: Preach - Direct Translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29208, N'Переход: Ч - К');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (29146, N'Прямой перевод: Path - Direct Translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28792, N'Прямой перевод: Pain - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28551, N'Прямой перeвод: Fellow - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28236, N'Прямой перевод: Bagel - direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (28015, N'Прямой перевод: Given - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (27831, N'Прямой перевод: Hotel - direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (27526, N'Что в имени твоем: Времена года');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (27188, N'Что в имени твоем: Зима');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26993, N'Что в имени твоем: Совет');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26844, N'Прямой перевод: Tired - direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26397, N'Что в имени твоем: София');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (26247, N'Что в имени твоем: Омар Хайам');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25986, N'Что в имени твоем: Бог');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25640, N'Что бы это значило: игра Футбол');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25435, N'Что в имени твоем: Пчела');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25093, N'Что в имени твоем: Червонный');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (25067, N'Прямой перевод: Tennis - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24622, N'Прямой перевод: Volume - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24427, N'Brexit');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24284, N'Что в имени твоем: Неделя');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (24060, N'Прямой перевод: Шабат (суббота)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (23609, N'Палиндром: Йохан...');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (23421, N'Прямой перевод: Cross - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (23071, N'Прямой перевод Spark - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (22974, N'Прямой перевод: Love - Direct Translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (22632, N'Прямой перевод: Knowledge - Direct Translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (22501, N'О незаметной пропаганде бестианства. About quiet bestuality propaganda.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (21973, N'Испанский скульптор, который владеет искусством мять камни');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (21395, N'Прямой перевод: Cattle');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (21101, N'Чтобы это значило: Учеба');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (20807, N'What is in the name: Don''t tread on me!');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (20627, N'Прямой перевод: Cost (затраты, расходы)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (20390, N'Прямой перевод: Smart (Умный)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19999, N'Прямой перевод: Patent (Патент)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19758, N'Что в имени твоем: цвета (colors)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19706, N'Прямой перевод: Profit (выгода)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (19264, N'Прямой перевод: Revenue');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18993, N'Что в имени твоем: Глаз');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18821, N'Прямой перевод: Court	');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18520, N'Прямой перевод: Quarters (Квартира)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (18274, N'Что в имени твоем: Knight');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17957, N'Что в имени твоем: Birth (рождение)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17884, N'Что в имени твоем: Рыцарь');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17527, N'Прямой перевод: Sovereign');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17282, N'Модель данных для chispa1707');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (17149, N'Модель данных для chispa1707');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (16646, N'Прямой перевод: Book');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (16618, N'Свобода человека. Источник и предназначение.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (16161, N'Что в имени твоем: Персона');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15943, N'Что в имени твоем: Иберия, Европа');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15747, N'Мои словокопания: Цель, Метод и Ограничения.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15463, N'Прямой перевод: Alert');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (15207, N'Прямой перевод: Rent');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (14782, N'Что в имени твоем: Держава');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (14410, N'Прямой перевод: Exit');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (14254, N'Что в имени твоем: Столица');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13982, N'Что в имени твоем: Карл Маркс, Фридрих Энгельс, Владимир Ленин');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13811, N'Что в имени твоем: Бердыш');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13513, N'Что в имени твоем: Книга');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (13147, N'Что в имени твоем: Князь');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (12976, N'Что в имени твоем: Яхве, Иегова');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (12662, N'Прямой перевод: Silver - Direct translation');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (12290, N'System Admin');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11820, N'Что в имени твоем: Великий');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11544, N'Что в имени твоем: Единорог');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11518, N'Символ Единорога в истории');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (11024, N'Что в имени твоем: Аллах');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10847, N'Что в имени твоем: Закон');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10602, N'Что в имени твоем: Грифон');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10325, N'Что в имени твоем: Ходжа Нассреддин');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (10052, N'Что в имени твоем: Царь');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9953, N'Сарацины. Этимология');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9497, N'Что в имени твоем: Государство');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9423, N'Что в имени твоем: Зомби');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (9103, N'Что в имени твоем? Cotton (хлопок)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (8744, N'Что в имени твоем: Золотой Телец.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (8418, N'Что в имени твоем: Масса');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (8020, N'Что в имени твоем: Барак Обама');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7709, N'Проект Самуила Кругляка «Получение электроэнергии из атмосферы»');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7468, N'Hardware. Что в имени?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7192, N'Software. Что в имени?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (7077, N'Этому ученому удалось разгадать тайну, которую скрывают картины эпохи Возрождения');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6866, N'Слово: Этруски');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6579, N'Этруски — изгнанники');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6257, N'Переговоры о разделе б/Украины: накал противостояния');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (6059, N'Понтовое ружье (The punt gun)');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (5751, N'Об этимологии слова Болван');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (5574, N'Книга: Грэм Лоури. Как Венецианский вирус инфицировал и победил Англию');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (5147, N'Кому принадлежит земля в Англии?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4890, N'Книга: Дэвид Гребер. Долг: первые 5000 лет истории');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4769, N'Немножко про ОЛЬДЕНБУРГОВ, для справки...');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4423, N'Греческий язык - это Русский!');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4131, N'Человеческий мир');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (4070, N'Книга: С. Г. КОРДОНСКИЙ. Сословная структура постсоветской России.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (3799, N'Мир до волны. Ч. 1. Родные Пенаты.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (3490, N'Биобетон');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (3208, N'Как погибла Тартария? Часть 1.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2940, N'Развалины античной Америки');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2740, N'post');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2508, N'Повинность');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2143, N'Йер');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (2029, N'Люцифер. Что в имени?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (1718, N'Программирование как контракт с дьяволом');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (1499, N'Звездный след катастрофы.');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (1249, N'Стамбик ПОДСЫПАЛИ. А что заставило его ПОДСЫПАТЬ ?');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (800, N'Николай Николаевич Вашкевич');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (765, N'Вяк, вяк');
INSERT INTO dbo.Article(LiveJournalID, Title) VALUES (369, N'Добро пожаловать в LiveJournal');
GO

/*
exec spAddArticle , N'', N'', N'
<span viak="word">
</span>
';
GO

*/
exec spAddArticle 18993, N'Что в имени твоем: Глаз', N'вяк, геральдика, символ, слова, тело, экономика', N'
<span viak="word">Глаз
ГЛЗ - глаз
ЗЛГ - залог
ГЛс - голос глист галс галс(тук) Гулистан
сЛГ - слог салага слуга услуга Селигер
кЛЗ - клизма clause(англ:оговорка) Клязма
ЗЛк - злюка злак
кЛс - колесо колос колосс кулиса класс cluster(англ:скопление)
сЛк - слякоть салака silk(англ:шелк) силикон
жЛЗ - железо жалюзи
ЗЛж - залежи заложить
жЛс - жалость
сЛж - сложный слежение служба слаженность
шЛк - шелк шлак Шилка
кЛш - клюшка клише клешня калоша клуша калашный Калашников
ГЛш - голыш глушить глашатай оглашенный
шЛх - шлюха шлях шляхта Шолохов
хЛс - хлыст холостой хлястик холст
сЛх - слух ослух 
</span><span viak="description">
галс - длинное движение судна относительно ветра
глаз голос слух - основные способы общения на расстоянии
глашатай - "голосовик"
глушить - подавлять голос, предотвращать передачу звука на длинные расстояния
железо - увиденное, найденное в глубине
залежи - найденные в глубине
калашный (ряд) - торговля издалека, т.е. заморской дорогой и престижной продукцией 
класс - сложный
клизма - глубоко проникающая
клюшка - длинный крюк
колесо - движитель на дальние расстояния
колос - соцветие, для которого характерна удлинённая главная ось.
колосс - длинный, огромный
салага - послушный
слежение - "глазение" далеко
слог - длинные сочетания звуков
сложный - длинный путь для понимания
слуга - послушный, для слежения, на длинных посылках
служба - послушание, слежение
слух - способность принимать звук на расстоянии
хлыст - длинный
шёлк - (шёл) из-далека
шлюха - послушная
шлях - длинная дорога
шляхта - служивые, а не разбойники с большой дороги
</span><span viak="description">
Знаковые слова: глаз голос слух слог колесо колос железо шелк залог сложный класс залежи слежение служба глашатай

Слово "глаз" может быть прочитано наоборот, как "залог".

Фраза "глаз за глаз" тогда может быть истолковано как "залог за залог", т.е. обмен одной ценной бумаги на другую.

Здесь мы также видим, что значение "масонского" глаза на оборотной стороне доллара может состоять не только во всевидении, но и обозначать один из фундаментов долговых операций.

Глаз - голос. Практически одно и тоже по звучанию слово "голос" и "глаз". Т.к. считается, что слово "глаз" было заимствовано на западе во времена Петра (см. ниже), то возможно, что русское  слово "голос" перешло в западное слово "глаз" (glass). Функция Голоса - "достать" человека на расстоянии, функция Глаза (особенно в очках или с подзорной трубой) - увидеть издалека.

Салага, Слуга, Шлюха - послушные.
</span><span viak="summary">
Слово Глаз находится в смысловом поле "длинный", "дальний", "долгий", "расстояние", "сложный".
</span>
<span viak="reference">Из Н.Н.Вашкевича:

ГЛАЗ1 – "орган зрения, а также само зрение". (Ожегов). До ПетраI в обиходе было слово "око". Но при Петре  в России стали появляться привозимые из Европы стеклянные  протезы для очей, они назывались "glass"  –  стекла. И постепенно "глаз" вытеснило из обращения слово "око". (ЭНЗ, стр. 178).
     ♦От глядеть (см.).
ГЛАЗ2,кто старое помянет,тому глаз вон (пословица) – "не стоит вспоминать старое".
    ♦ Рус. глаз является переводом ар.عين ъайн"глаз", которое означает также "то же самое" (сравните не в бровь, а в глаз), т.е. старое. Имеется в виду:кто старое помянет, тому старое следует забыть.

ГОЛОС– "совокупность звуков, возникающих в результате колебания голосовых связок"; "мнение, высказывание". (Ожегов).
     ♦ От ар.قول гол(каул) "высказывание", "показание (напр. свидетеля)".
ЖЕЛЕЗО – "химический элемент, серебристо-белый металл, главная составная часть чугуна и стали". (Ожегов). 
     ♦ От ар. فولاذ  фу:ла:з, откуда также булат (см.). По месту в алфавите Ж соответствует F (W). Cм. статью Ж.
ЗАЛОГ – линг. "грамматическая категория глагола, выражающая различные отношения между субъектом и объектом действия". (Ахманова). 
     ♦ В этимологических словарях слово не отмечено. Происходит термин от ар. ذا  за: "который" + обратное прочтение ар. ج ه ل (جهل) гхл "быть неизвестным" (ар. буква х пишется как рус. о). "Неизвестный" – так называется форма страдательного залога глагола в ар. грамматике. Имеется в виду, что глагол в том случае, если деятель не известен (не упоминается в предложении), строится по особой модели (огласуется по-особому). Полное название: вазн мабний ли-л-магху:л – букв. "формула, построенная для неизвестного (деятеля)". В рус. языке, где подобные отношения выражаются синтаксически (строил > был построен), термин потерял точный смысл и совсем утратил мотивацию в рус. языке. См. другие грамматические термины: части речи, флексии, спряжение, предложение, субъект, объект, междометие, наречие. Анг. название залога (voice) происходит от рус. вес, перевод ар. وزن вазн "вес, формула, модель слова". 
СЛОГ1 – "манера речи". 
       ♦ От обратного прочтения рус. голос, родственно греч. глосса, англ. сленг, лат. lingua. Все эти слова восходят к ар. لغة луга "язык", "слово" (корень ЛГВ). Ар. سلج слг "создавать", откуда салигиййа "речь по наитию" (вопреки правилам), возможно от рус. голос. Ар. سلاج салла:г "красноречивый (о женихе)", вероятно, из русского. 
СЛОГ2 – "часть слова, произносительная единица речи". 
       ♦ От сложить.
СЛУГА – "работник в частном доме, в каком-н. заведении для выполнения различных услуг". (БЭКМ). 
       ♦ От ар. سلوك сулу:к "следование за кем.-л.", "хорошее (правильное) поведение"; سلك силк "служба, департамент", родственно слух1, заслуга, слушать, послушник (см.).
СЛУЖБА – "работа, занятия служащего, а также место его работы". (БЭКМ). 
       ♦ От ар. سلوك сулу:к "следование за кем.л.", "хорошее (правильное) поведение", откуда заслужить, от ар. ازاء سلوك иза:'' сулу:к "за хорошее поведение", سلك силк "служба, корпус (дипломатический)".
СЛУХ1 – "чувство восприятия звуков". (Ушаков). 
       ♦ От рус. слышать/слушать (см.).
СЛУХ2 – "сплетня, выдумка". (БЭКМ). 
       ♦ От обратного прочтения ар. خلوص хулу:с "освобождение", т.е. "то, что отпускается, распускается", ср. ар. إشاعة ''иша:ъа "слух", букв. "то, что распускается", ср. рус. распускать слухи. См. также толки, утка.
СЛУШАТЬ – "направлять слух на что-н."; "следовать чьим-н. советам, приказам". (БЭКМ). 
       ♦ От ар. سلوك сулу:к "следование вслед за кем-л.", родственно послушник. Ар. слово по форме есть масдар (отглагольное имя) от سلك салака "следовать за". Ар. سلس салиса "быть послушным" от рус. слушаться. 
ШЕЛК – "волокно, выделяемое гусеницами тутового шелкопряда", "нитки и ткань из такого волокна". Происхождение и история этого явно заимствованного слова не вполне ясны. (Черных).
       ♦ От обратного прочтения ар. قلس калас "отрыгивать, выделять слюну (о насекомых), мед (о пчёлах), пены (о море)", "переполниться (о сосуде)".  Ар. название шелка حرير хари:р, производное от корня حر харр "быть горячим" из русского, ввиду созвучия: шелк и щелок "жгучка", сюда же франц. происхождения саржа, от ар. سرج сараж "зажигать", греч. serika "шелка", от рус. серка "спичка". Все - ложные кальки с русского. Родственно шлак, шеллак (см.).
</span>
';
GO

exec spAddArticle 38363, N'Что в имени твоем: Челси', N'вяк, слова', N'
<span viak="word">Челси
ЧЛС - Челси
СЛЧ - силач случка случай сличать
кЛС - колосс класс кулисы клаустрофобия Санта-Клаус
СЛк - slacking ослик силки sleek
зЛк - злюка
кЛз - клизма clause(англ:условие) коллизия
СЛг - слуга sluggish
зЛЧ - злачный
</span>
';
GO

exec spAddArticle 38489, N'Что в имени твоем: Путин', N'вяк, имя, слова', N'
<p viak="name" dir="ltr">Путин

ПТН - путаный путина путана пытание питание потайной потный потоне(т) пятно пятни(ца) питон патен(т) птенец ПоТан(ку) потенциал
НТП - Нетопы(рь) OnTop Антипо(д) НеТипи(чный)
Ндб - НаДыбе надобно неудобно<br>бдН - бидон бодняк бедняк будни
ПдН - Падение поддон поднять
бТН - бетон батон бутан бутон
бфН - бафун</p>
<p viak="description" dir="ltr">Исторические паралели:
(Рас)Путин - убит в Декабре 1916, как условие февральский революции 1917 года. Раз-Путин.
Patton(Патон) - Американский генерал второй мировой. Убит.
пятнистый - Горбачев. Русский ПТН #2.
Путин#3 - Владимир Путин - действующий президент РФ.</p>
';
GO

exec spAddArticle 38894, N'Что в имени твоем: Пехота', N'бог, вяк, имя, слова', N'
<p viak="word" dir="ltr">Пехота

ПХТ - пехота пахота пахта (узб:хлопок) пихта пихать пахтать(рус:сбивать масло)
ПкТ - пукать пикет [пика] пакет покатый  picture (англ:картина)
ТкП - откуп [атака ткнуть]
бгТ - бегать богатырь богатый [бог]
Тгб - [тяготы]
бХТ - бухта бухтеть Бахтияр(узб имя)
ПХд - поход
бХд - обход обиход Бохадыр(узб имя)</p><p dir="ltr">Ясно видно смысловое поле слова Пехота: бегать, поход, обход в смысле &quot;ходить&quot;, &quot;передвигаться&quot;.</p><p dir="ltr">Бухта - место для похода (по морю), подхода с моря.
Богатырь -  &quot;пахотырь&quot;, &quot;пехотырь&quot;, &quot;беготырь&quot;, пехотинец-землепашец
Пахота - движение для разрыхления земли.
Богатый - путешествующий, ездящий по-делам</p><p dir="ltr">Слова <a href="http://viakviak.livejournal.com/25986.html">Бог</a>, Пика, Атака, Ткнуть, Тяготы взяты в квадратные скобки, чтобы исключить их из основного текста, но также показать их близость.</p><p dir="ltr">Представляется, что слово <a href="http://viakviak.livejournal.com/25986.html">Бог </a>может означать Движение, как одно из основных качеств Материи (см. также: <a href="http://viakviak.livejournal.com/11024.html">Аллах, Элохим</a>, <a href="http://viakviak.livejournal.com/12976.html">Яхве, Иегова</a>, <a href="http://viakviak.livejournal.com/39064.html">Господь</a>).</p>
';
GO

exec spAddArticle 39064, N'Что в имени твоем: Пешка', N'бог, вяк, государство, имя, история, оружие, слова', N'
<p viak="word" dir="ltr">Пешка</p>
ПШК - пешка пшик пушок пушка
ПШх - пешеход
бсК - босяк Баски(народ в Испании) Басков
бШК - башка Бишкек
ПсК - пуск писька Псков
КсП - Каспаров
кзб - Казбек
Псх - пасха посох по-суху псих писюха
хсП - hospice(англ:госпиталь для умирающих)
гсП - госпиталь господин Господь Гопитальеры(религиозный орден)</p>

<span viak="description">
Пешка - пешеход, босяк.
Каспаров - выдающийся шахматист
Госпитальеры - Представляется, название религиозного ордена Госпитальеры берет свое название от слова Господь. С другой стороны, слово Госпиталь берет от свое начало от Госпитальеры, как основателей приютов куда &quot;пускали&quot; больных в &quot;постели&quot;.
<b>Господь</b> - имя Бога в характеристике Пускающий (в рай), Отпускающий (грехи), Выпускающий (из рабства).
Пушка - орудие выПускающее снаряд, Пускающая дым.
Псков - Пропускающий
Пасха - история Пасхи вытекает из слов Господь и <a href="http://viakviak.livejournal.com/25986.html" target="_blank">Бог</a> как движение, уход: пасха, посох, по-суху, исход, exit, выход, уход, босиком, пешком, бас(громкий голос сверху), отпусти(мой народ), напасти(казни Египетские), пасти(народ), пустыня(через которую пропустили), пустились(бежать, в погоню).
</span>
';
GO

exec spAddArticle 39200, N'Что в имени твоем: Свет', N'вяк, слова', N'
<p viak="word" dir="ltr">Свет</p><p dir="ltr">СВТ - свет совет <a href="http://viakviak.livejournal.com/11024.html">святой</a>
ТВС - отвес
зВТ - завет завтра [зов] зевота
шбТ - шабат
СбТ - <a href="http://viakviak.livejournal.com/24060.html">суббота</a> сбыт саботаж сбыться
ТбС - тубус
СВд - свод свидание свадьба сведения [севодня]
дВС - Давос advise
зВд - завод
дВз - дивизия
збТ - забыть
збд - забудь</p><p dir="ltr">Свод - собрание, схождение, фокусировка (света)
Святой - &quot;светлый&quot; (<a href="http://viakviak.livejournal.com/11024.html">holy</a>) человек, кто сводит людей к богу
Совет - собрание, полезные сведения
Завод - Свод материалов, энергии, работников, специалистов в одном месте.
Дивизия - свод военных частей под одну команду.
Завет - оставить светлую память и указать светлый путь
Отвес - угол падения света в полдень
Завтра - светлый день после сегодняшнего вечера
Шабат - выходной как самый &quot;светлый&quot; день недели и свод (сбор) на молитву.
Саботаж - субботний отдых в рабочий день
Забыть - потерять сведения
Сегодня - сего дня. Произносится &quot;сево-дня&quot;, что несет в себе смысл светлого времени суток.
Совет - свод на обсужедние, чтобы пролить свет.
Сведения - свод сообщений, чтобы пролить свет.
Тубус - сведенный, скатанный, можно увидеть свет на другом конце
Зов - передача сведений
</p>
<p viak="summary">Создаётся впечатление, что слово Свет может происходить от слова Свод в смысле сбора, объединения, когда единение становится значительно большим, чем простая сумма составляющих. Например, если отдельные люди, каждый со своей свечкой (светом), сходятся вместе, их общий свет становится настолько значительным, чтобы освещать место и для тех, у кого своей свечи (пока) нет.</p>
';
GO

exec spAddArticle 39647, N'Переход Р - Л', N'вяк, переход', N'
<div viak="transition">Устойчивый переход Р - Л (Л-рассирование)</div>

<p viak="summary">Использование Л вместо Р особенно распространено у детей, которые не выговаривают &quot;Р&quot;.</p>
';
GO

exec spAddArticle 39863, N'Прямой перевод: Advise - Direct translation', N'english, вяк, перевод, слова', N'
<div viak="translation">Advise = Совет

ДВС - advise
СВт - совет <a href="http://viakviak.livejournal.com/39200.html">свет</a></div>
';
GO

exec spAddArticle 39939, N'Что в имени твоем: Плюс', N'вяк, слова', N'
<div viak="word">Плюс

ПЛС - плюс полюс полоса палас palas(англ:дворец) пульс police
СЛП - слепой sleep(англ:сон)
ПЛц - пыльца палец плац полиция Пельцер
бЛС - балясы bless(англ:благословить) bliss(англ:блаженство)
бЛз - блюз Белиз Белаз
зЛб - злоба</div>
';
GO

exec spAddArticle 40280, N'Что в имени твоем: Двигать', N'вяк, слова', N'
<div viak="word">Двигать
ДВГ - двигать двигатель
ДВж - движение</div>

Корень слова <span viak="word">Движение: ВЖ
ВЖ - движение вождение вождь важно
Вг - вагон вогнать вагина выгнуть
гВ - гавно говядина гувернант govern(англ:руководить)
бЖ - <a href="http://viakviak.livejournal.com/25986.html" target="_blank">боже</a> бежать
бг - бег <a href="http://viakviak.livejournal.com/25986.html" target="_blank">бог</a> <a href="http://viakviak.livejournal.com/38894.html" target="_blank">богач</a></span>
';
GO

exec spAddArticle 40640, N'Что в имени твоем: Цуцик', N'вяк, слова', N'
<div viak="word">Цуцик
ЦЦК - цуцик цицка цацка
ССК - сиська соска сосок соскок</div>

<span viak="summary">Очевидно, что слово Цуцик представляет собой мужскую форму слова Цицка (Сиська).</span>
';
GO

exec spAddArticle 40952, N'Self-Interest and Ignorance', N'english, вяк, закон, мнение', N'
<p dir="ltr">Self-Interest and Ignorance.</p><p dir="ltr">Ultimately, you have to pay or answer for everything you get or do (one way or another, more or less, now or later). Be aware of that and get ready for it.</p><p dir="ltr">What do people perceive as Good? Good is what people feel good about, what they know or think is good for them. People can learn or be told that.</p><p dir="ltr">It seems that all sins take root in Ignorance: ignorance to other people&rsquo;s interests, time, property, money, lives, &hellip;</p><p dir="ltr">People will always have self-interest. You should be well aware of the Ignorance, which comes with it.</p><p dir="ltr">Ignorance is an important Self-Interest preserving mechanism. It is also very important to be conscious about the Ignorance, and to not allow the Ignorance to become dominant, which will hurt the Self-Interest in the modern life settings.</p><p dir="ltr">Ignorance should serve Self-Interest, but it can easily harm Self-Interest, if not managed properly. The rules below are not constraining as laws are, but instead are an attempt to provide guidance for the taming of Ignorance in order to maximize Self-Interest.</p><p dir="ltr">Principal Rules of Self-Interest:

1. All people are &quot;pigs&quot;. Don&#39;t be one, try to be different. It&#39;s ok to be one, if necessary. Don&#39;t be with one. Don&#39;t expect much and appreciate the little things that you can glean from them.</p><p dir="ltr">2. You control the world around you, or the world controls you. Always have your best interest in mind. Remember why you are out there, observe the surroundings, and learn along the way. Obtain leverage and don&#39;t give your leverage away. Negotiate first to gain an advantage. There would be not enough &ldquo;ammo&rdquo; to make your way by force through everyone every time. Respect, learn and use the laws, customs, people&#39;s needs and beliefs. Find and use &quot;carrots&quot; and &quot;sticks&quot; as needed. Try to understand people, but realize that you will never know all the circumstances, so don&rsquo;t jump to conclusions. Face problems with everything you&#39;ve got to avoid prolonged confrontations. Make allies and pick your battles.</p><p dir="ltr">3. Everything is good in moderation, evil is in the extremes. Try to balance your life and find your own comfort zones. Avoid any kind of waste in your life, optimize, simplify, clean up, learn about yourself along the way and make your own routines to minimize the stress. Normal desires are the product of moderation. Extremes deform desires: depravities exaggerate and pervert them, excesses destroy them.</p><p dir="ltr">4. Everything will be fine. When you were born, your eternal soul received the vessel of your body in order to navigate this world. Take good care of it - you will be hold responsible. Stay positive and focused, don&rsquo;t lose hope, try to find peace, and adjust as needed.</p>
';
GO

exec spAddArticle 40970, N'Что в имени твоем: Волга', N'вяк, слова', N'
<span dir="ltr">Волга
ВЛГ - Волга влага влагалище иволга вульгарный
ГЛВ - голова главный
бЛГ - Болгария блог булыга
ГЛб - голубой глубокий глобус глобальный глыба Глеб голубь гульба</span>
<p viak="reason" dir="ltr">Представляются значимыми слова: главный, глубокий, влага.</p>
<p viak="summary" dir="ltr">Волга: глубокая, главная.</p>
';
GO

exec spAddArticle 41271, N'Что в имени твоем: Трамп', N'english, вяк, имя, слова', N'
<p viak="translation" dir="ltr">Трамп = Trump</p>
<p viak="name">Трамп
ТРМП - Trump(Трамп) Triump(h)(англ:триумф) трамп(лин) tramp(англ:бродяга, тащиться с трудом, <span style="font-family: arial, sans-serif-light, sans-serif; font-size: small; background-color: rgb(255, 255, 255);">утомительное путешествие</span>) ПМРТ - Помереть помирить помарать</p>
<p viak="summary" dir="ltr">Рассморение полного корня фамилии 45-то президента США показывает: утомительный путь на трамплин к триумфу - помирить или помарать или помереть. </p><p dir="ltr"><i>Looking at the last name of 45th president of USA using Russian consonant notation: tramping to the trampoline of triumph to make a peace or mess or die.</i></p>
';
GO

exec spAddArticle 41552, N'Что в имени твоем: Шток', N'слова', N'
<span viak="word">Шток

ШТК - шток штык штакетник штука шутка
КТШ - Катюша катыш
сТК - стояк стойка стук сток стакан stick(англ: палка) истукан сутки
КдШ - кадыш(евр.)
сдК - седок садки
Кдс - кудесник
</span>
<span viak="summary">Похоже, что слово "Шток" находится в смысловом поле "торчащий", "твердый".</span>
';
GO

exec spAddArticle 41969, N'Что в имени твоем: Пистолет', N'Вашкевич, вяк, оружие, слова', N'
<span viak="word">Пистолет

ПСТ - писто(лет,ль,ля) Пестель постель паста pasta(англ:макароны) пусто писать пастораль пасти пастух пустошь (от)пусти пастор пестик пастель(ные цвета) <i>post(англ:почта)</i>
бСТ - быстро баста (за)бастовка бестия <i>бастион Бастилия Бостон</i> бюст абстинент bust(англ:аррест) boost(англ:усиление)
Пзд - пи#да поздно опоздать
</span>
<span viak="summary">
Представляется, что слово Пистолет находится в смысловом поле &quot;пусто&quot;.
</span>
<span viak="description">
пасти - вывод в пустоши
пастбище - пасти-пища
пестик - пустенький, &quot;пизда&quot; растения
pasta - макароны с пустотой внутри
постель - пустующее место для человека
pasta - лапша с дыркой (макароны)
пастор - &quot;пастух&quot; людей
пи#да - &quot;пустота&quot; в теле женщины
пистоль - пусто(ль)
(за)бастовка - пустое времепровождение
бестия - из подземной пустоты
пестик - пи#да цветка
пастораль - пустошь
пастель - пустоватые (разведенные) цвета
абстинент - сексуальная &quot;пустышка&quot;
поздно - вне отведенного времени, в &quot;пустом&quot; времени
</span>
<span viak="reference">Из Н.Н.Вашкевича:

ПАСТА - "тестообразная масса", первоисточник греч. pasth "мучная подлива". (Черных). 
       ♦ От ар. بسط бассата "раскатывать тесто", сравните ар. معجون маъгу:н  "паста", от  عجنъагана "месить".
ПАСТИ – "следить за пасущимся скотом, домашним животным". (БЭКМ). 
       ♦ От обратного прочтения سيف сейф "то чем оберегают", "сабля, меч"; родственно сейф "металлический шкаф", родственно пёс, опасность, спасать (см.).
ПАСТОР – "протестантский священник"; нем. рastor < лат. pаstor пастух, пастырь. (БЭКМ). 
       ♦ От рус. пасти (см.). Другие лат. слова рус. происхождения: бицепс, аскорбинка, кардиология, латины, италики (см.).
ПАСТОРАЛЬ – "в европейском искусстве 14—18 вв.: драматическое или музыкальное произведение, идиллически изображающее жизнь пастухов и пастушек на лоне природы"; фр. pastorale < лат. pаstorаlis пастушеский. (БЭКМ). 
       ♦ Лат. слово от рус. пасти (см.)
ПИСАТЬ2, ничего не попишешь – "нет выхода".
       ♦ От ар. فشاشة фашша:ша "отмычка", т.е. "нет выхода". См. также пиши.
ПЍСАТЬ – "испускать мочу". (БЭКМ). 
       ♦ От рус. писَать. Аналогично ср. англ. penis и pencil, ар. زبر зубр и مزبار мизбар, что соответствует в рус. языке писка и писька. Дело в том, что в егип. мифе бык Апис (см.) покрывал богиню мудрости, небесную корову, Исиду 
   дважды: один раз красной писькой, другой - чёрной пиской.
ПИСК – "очень тонкий звук, крик". (БЭКМ). 
       ♦ От ар. فسى фаса: "выходить (о воздухе)". Родственно пуск (см.).
ПИССУАР – "раковина со стоком для мочи"; фр. pissoir < pisser испускать мочу, мочиться. (Крысин). 
       ♦ От рус. пَисать (см.).
ПИСТОЛЕТ – "короткоствольное ручное оружие для стрельбы на коротких расстояниях"; фр. pistolet. (БЭКМ). 
       ♦ От рус. пустой, т.е. трубка. Того же корня, что и пистон, пищаль, фистула, фиеста, фестиваль (см.).
ПИСТОН – "небольшой металлический колпачок со взрывчатым веществом для воспламенения заряда в патроне"; "заклепка в виде короткой трубочки для соединения плоских деталей, а также для окантовки отверстий в картоне, коже и т.п."; фр. piston. (БЭКМ). 
       ♦ От рус. пустой, т.е. трубочка. 
ПИТАТЬ1 – "кормить, снабжать пищей". (БЭКМ). 
       ♦ От ар. فتح фатах "обеспечивать пропитание (о Боге)", букв. "открывать", откуда فتح фатх "хлеб насущный". Идет от выражения فتح باب الرزق фатах ба:б ар-ризк, букв.: "открыть дверь пропитания".
ПИТАТЬ2 – "ощущать, переживать испытывать (доброту, уважение и т.п.)". 
       ♦ От обратного прочтения أتحف ''атхаф (корень тхф при обычной замене ар. х восьмеричной на рус. и восьмеричную) "оказывать кому-л. благосклонность, 
ПИЩАЛЬ – "старинная пушка или тяжёлое ружьё". (БЭКМ). 
       ♦ Того же корня, что и рус. пустой, пуск, пушка, запуск. Букв. "пускалка". Переход СТ в Щ ср. весть – вещать, СК в Щ – иск – ищу. Родственно пистолет, фистула, фиеста, фестиваль (см.).
ПУЗО – простореч. "то же, что живот". (БЭКМ). 
       ♦ От ар. فخ  фахх "дуть", букв. "надутое", родственно пузырь (см.), здесь реализовано чередование Х/З (Х/С). 
ПУЗЫРЬ – "наполненный воздухом прозрачный шарик в жидкости, жидкой массе ". (БЭКМ). 
       ♦ Того же корня, что и пузо, ср. ар. فخر фахара "гордиться", ср. рус. надувать щеки. Из рус. языка: ар. فزر фазар "лопаться", ''афзар "горбатый", т.е. спина пузырём. ср. فقع факаъа "лопаться" иفقاقيع   фака:ки:ъ "пузыри", "грибы". Сюда же فطر фитр "грибы". См. также чемпион, шампанское, шампунь, грибы.
ПУЛЯ – "заключённый в патрон небольшой снаряд для стрельбы из ружей, винтовок, пулемётов, револьверов". (БЭКМ). 
       ♦ От пулять (см.). Отсюда в ар. فول фу:л "бобы", فولة фу:ла "бобина". Ср. в ар.: بندق бундук "орех", "пуля", или рус. ядро.
ПУЛЯТЬ – "бросать чем–н. куда–н.". (БЭКМ). 
       ♦ От ар. فلاة фала: "свобода, чистое пространство, пустыня". Отсюда فلت фалат "пускать". Ср. пустыня и запускать (ракету)", пушка (см.). Родственно поле (см.).
ПУСК – "момент приведения в движение". (БЭКМ). 
       ♦ От ар. ар. فسحة фусха "свобода, простор". Возможно, что от рус. пуск в ар. языке или قصوف кусу:ф "бомбардировка" (М., с. 634). Родственно пушка, пустой.
ПУСКАТЬСЯ, пускаться во все тяжкие – "без удержу предаваться чему-либо предосудительному, обычно пьянству, разгулу". (ФСРЯ). 
       ♦  За рус. пускаться ар. فسوق фусу:к (фусу:'') "разврат, беспутство", производное от глагола  فسق фасак "свернуть с правильного пути", повторенное в форме фусу:'' в рус. во все, которое сопровождается определением тяжкие. Букв.: распутничать распутством тяжким. Похоже, что ар. слово из рус. пуск т.е. свобода, возможность предаваться чему угодно.
ПУСТОЙ – "ничем не заполненный, полый внутри, лишённый содержимого". (БЭКМ). 
       ♦ От ар. فسا фаса: "выходить наружу о воздухе". Родственно сопеть (в обратном прочтении).
ПУСТЫНЬ – "небольшой монастырь в труднодоступной пустынной местности"; "место, где живёт отшельник". (БЭКМ). 
       ♦ Того же корня, что и пустыня (см.). В ар. языке дает ар. تصوف тасаввуф (в обратном прочтении) "суфизм".
ПУСТЫНЯ – ♦ от пустой (см.).
ПУСТЬ – "образует повелительное наклонение глагола и вносит в предложение значение побудительности". (БЭКМ). 
       ♦ Того же происхождения, что и пустой, пустыня, пускай.  Общая идея – свобода. 
ПУХНУТЬ – "излишне увеличиваться". (БЭКМ). 
       ♦ От ар. фахх "раздуваться", нафах "надувать" или от родственного ему فاخ фа:х "распространяться, расширяться".
ПУЧИТЬ – "вздувать, делать выпуклым". (БЭКМ). 
       ♦ Того же корня, что и пухнуть (см.), но пучить глаза – от ар. بصص бассас "пялиться, пучить глаза". Родственно бачить. 
ПУШКА1 – "длинноствольное артиллерийское орудие с отлогой траекторией для стрельбы на дальние расстояния". (БЭКМ). 
       ♦ Того же корня, что и пуск (см.). Ср. пуск ракеты. Пусковые установки ракетчики называют пушками. Аналогично пуля (см.). Отсюда в ар. فشك фашак "патроны". 
ПУШКА2, пушкой не прошибёшь – "об упрямом человеке, 
     трудно поддающемся убеждению, доказательствам". (ФРЯ).
       ♦ Т.е. о человеке, не слышащем аргументы. Ср. хулиган (от рус. глухой). Речь идет о пушке, выстрелами из которой объявляют время, и которой можно разбудить человека. Пушкой во многих странах отбивают время по причине того, что евр. слово שעח "час" (ар. ساعة са:ъах) по-русски читается ПУШ. Конечное придыхание переходит в П как в продукты (см.).
ПУШКА3, брать на пушку – "действуя обманным путём, прибегая к различным уловкам, ухищрениям, добиваться от кого, либо, чего-либо". (ФСРЯ). 
       ♦ От ар. فشخ фашаха "обманывать и обижать, поступать несправедливо (в игре)".
</span>
';
GO

exec spAddArticle 42057, N'Что в имени твоем: Навь', N'вяк, материя, слова, смерть', N'
<span viak="word">
Навь

НВ - навь новь новый невод нива наив(ность) navy(англ:<span style="background-color: rgb(255, 255, 255); font-family: arial, sans-serif-light, sans-serif; font-size: small;">военно-морские силы)</span> навигатор
ВН - война воин вонь вынь <a href="https://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D0%BE%D0%BA" target="_blank">венок</a> веник ванна вино wind(англ:ветер) винт веяние ваяние Иван avon(кельт:река) <a href="https://ru.wikipedia.org/wiki/%D0%9E%D0%B2%D0%B5%D0%BD_(%D0%B7%D0%BD%D0%B0%D0%BA_%D0%B7%D0%BE%D0%B4%D0%B8%D0%B0%D0%BA%D0%B0)" target="_blank">овен</a> oven(англ:печь,духовка)
Нб - небо нёбо
бН - баня баян буян бен(евр:сын) ибн(араб:сын) Бонн Бен(джамен) убиен(ный)
</span><span viak="description">
баня - помещение с горячей водой (дар природы набранный из реки) для мытья
ванна - <span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);">резервуар </span>с  водой (дар природы набранный из реки) <span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">для купания</span>
ваяние - <span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">создание скульптур (</span>неживого)</div><div>веник - связка прутьев (дара природы)
<a href="https://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D0%BE%D0%BA" target="_blank">венок</a> - плетение из цветов (дара природы)
веяние - движение или использованние движения воздуха
вино - алкогольный напиток из ягод (дара природы)
винт - простейший механизм для работы в воде, для перемещения воды, или для движения в воде. По аналогии используется в других средах.
война - вооруженная борьба на реках и морях - территории Нави
вонь - запах Нави
вынь - достань невидимое - из Нави
navy - флот для войны на реках и морях - территории Нави
навигатор - navy+gater(англ: хозяин ворот в море)
невод - сеть для лова рыбы (дара природы) из Нави
нива - плодородное поле - место по(ЯВь)ления нового урожая (дара природы) из Нави
новый, новь  - по(ЯВь)ившийся из Нави
wind - ветер, сила природы
</span>
<span viak="summary">
Слово Навь представляется носителем характеристики "невидимого", "непознанного", "природа", "(водная) стихия".
</span><span viak="reference">
<a href="https://ru.wikipedia.org/wiki/%D0%AF%D0%B2%D1%8C,_%D0%9F%D1%80%D0%B0%D0%B2%D1%8C_%D0%B8_%D0%9D%D0%B0%D0%B2%D1%8C" target="_blank">Справка</a>: Явь, Правь и <b>Навь</b> - в современном русском неоязычестве &laquo;три стороны бытия&raquo;, впервые упоминается в Велесовой книге... <span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);">в аутентичных источниках по славянской мифологии и фольклору известен только термин &laquo;<b>навь</b>&raquo;... </span><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">Слово &laquo;<b>навь</b>&raquo; означает &laquo;мертвец&raquo; и &laquo;смерть&raquo;. Является славянским, и родственно древнегерманским аналогам в том же значении, восходя к индо-европейскому языку</span><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">... </span><b style="color: rgb(37, 37, 37); font-family: sans-serif;">Навь</b><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> в </span><a href="https://ru.wikipedia.org/wiki/%D0%A2%D0%BE%D0%BB%D0%BA%D0%BE%D0%B2%D1%8B%D0%B9_%D1%81%D0%BB%D0%BE%D0%B2%D0%B0%D1%80%D1%8C_%D0%B6%D0%B8%D0%B2%D0%BE%D0%B3%D0%BE_%D0%B2%D0%B5%D0%BB%D0%B8%D0%BA%D0%BE%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%8F%D0%B7%D1%8B%D0%BA%D0%B0" style="font-family: sans-serif; text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Толковый словарь живого великорусского языка">Толковом словаре Даля</a><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> трактуется как встречающийся в некоторых губерниях синоним слов </span><i style="color: rgb(37, 37, 37); font-family: sans-serif;"><a href="https://ru.wikipedia.org/wiki/%D0%A2%D1%80%D1%83%D0%BF" style="text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Труп">мертвец</a>, покойник, усопший, умерший</i><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;">. </span><a href="https://ru.wikipedia.org/wiki/%D0%A0%D1%8B%D0%B1%D0%B0%D0%BA%D0%BE%D0%B2,_%D0%91%D0%BE%D1%80%D0%B8%D1%81_%D0%90%D0%BB%D0%B5%D0%BA%D1%81%D0%B0%D0%BD%D0%B4%D1%80%D0%BE%D0%B2%D0%B8%D1%87" style="font-family: sans-serif; text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Рыбаков, Борис Александрович">Б. А. Рыбаков</a><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> в &laquo;Язычестве древних славян&raquo; пишет &quot;</span><a class="mw-redirect" href="https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D0%B2%D1%8C%D0%B8" style="font-family: sans-serif; text-decoration: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;" title="Навьи">Навьи</a><span style="background-color: rgb(255, 255, 255); color: rgb(37, 37, 37); font-family: sans-serif;"> &mdash; мертвецы или, точнее, невидимые души мертвецов... </span><span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);"><b>Навь </b>&mdash; это воплощение смерти, а само название связано с образом погребальной ладьи... </span><span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);"><b>Навьим </b>днём назывался </span><a class="mw-redirect" href="https://ru.wikipedia.org/wiki/%D0%9F%D0%BE%D0%BC%D0%B8%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5_%D0%B4%D0%BD%D0%B8" style="text-decoration: none; color: rgb(11, 0, 128); background: none rgb(255, 255, 255); font-family: sans-serif;" title="Поминальные дни">день общего поминовения</a><span style="color: rgb(37, 37, 37); font-family: sans-serif; background-color: rgb(255, 255, 255);"> покойников на Руси...</span>
</span>
';
GO

exec spAddArticle 42379, N'Прямой перевод: State - Direct translation', N'usa, вяк, закон, перевод, слова', N'
<span viak="translation">
State = статья
СТТ - статья, стоять, статус.
</span><span viak="summary">
Представляется, что английское слово State имеет полный русский аналог Статья в смысле статья закона, уложение.
Пример: Соединенные Штаты Америки - United States of America

<i viak="english">It seems that English word State has full Russian analog Статья (Statia) in a sense of article of the law.
Example: United States of America</i>
</span>
';
GO

exec spAddArticle 42563, N'Что в имени твоем: Март', N'смерть, число, вяк, слова', N'
<span viak="word">Март

МРТ - Март мертвый mortuary(англ:морг) Марат Марта мартышка maritime(англ:морской) postmortem(англ:посмертный) морить
ТРМ - терем тюрьма тарарам(рус:бесчинство) трюм трам(плин) <a href="http://viakviak.livejournal.com/41271.html" target="_blank">Трам(п)</a> тормоз trauma(англ:травма) тромб trumpet(англ:труба,трампет) tramp(англ:бродяга)
МРд - murder(англ:убийство) морда меридиан мародер (с)мерд (с)мердеть мириад(рус:10000) мордва Мурад Мюрад (Ель-)Мюрид
дРМ - даром дерьмо дармовой дурман дрёма Дуремар дермантин drum(англ:барабан) (аэро)дром dorm(itory)(англ:общежитие)
</span><span viak="description">
аэродром - &quot;конец&quot; воздушного пути, остановка для воздушного пути. См. также космодром.
дерьмо - испорченное
dormitory(англ:общежитие) - &quot;испорченный&quot; дом где живет не отдельная семья, а сборище разного народа.
drum(англ:барабан) - издает (смертельно) громкие звуки, играет марш смерти (на войне). Барабанный бой - это немелодичная (испорченная) музыка.
дрёма - сон, не жизнь.
мириад(рус:10000) - конец исчисления
морда - нечеловеческое лицо
смерд - недочеловек.
тарарам - испорченное поведение.
tramp(англ:бродяга, тащиться с трудом, утомительное путешествие) - &quot;испорченный&quot; длительным хождением.
трамплин - смертельно опасное сооружение для прыжков
тюрьма - место заключения, остановки жизни, &quot;испорченный&quot; дом, исправительный дом.
</span><span viak="summary">
Как мы видим, слово Март находится в смысловом поле &quot;смерть&quot;, включая Конец - &quot;смерть&quot; пути, Испортить - &quot;смерть&quot; качества, Остановить - &quot;смерть&quot; движения.
</span>
';
GO

exec spAddArticle 42783, N'Что в имени твоем: Сатана', N'Вашкевич, бог, вяк, имя, слова', N'
<span viak="word">Сатана

СТН - Сатана стан стоянка остановка стынуть сутана истина стена стон стенать сутенер установка установление Истанбул Астана Седан Стенька ситный стан(дарт)
СдН - сиденье судно ссадина седина Судан
СфН - сафьян сфинктер Safeen
НфС - Анфиса
</span><span viak="description">
истина - остановка гаданий и предположений, точный факт, установление правды.
Седан - широкая река во Франции, останавливающая движение.
сиденье - положение или мебель для позиции остановленного движения.
ситный - идиома &quot;друг ситный&quot; в смысле &quot;друг Сатаны&quot;.
ссадина - рана с уже остановленной кровью
стандарт - точное описание, истинный размер.
Стенька - в устойчивом сочетании &quot;Стенька Разин&quot; можно увидеть смысл Сатанинская Резня. С другой стороны, в имени Степана Разина этот смысл уже утерян.
стена - останавливает движение
стенать - издавать душераздирающие, сатанинские крики.
стынуть - замедление движения крови, приостановка жизненной энергии.
судно - средство передвижения по воде сидя.
сутенер - пособник в сатанинских утехах.
сфинктер - останавливающая мышца.
</span><span viak="summary">
Представляется, что слово Сатана изначально описывало понятие противодействия <a href="http://viakviak.livejournal.com/38894.html" target="_blank">движению</a>, которое олицетворяет слово <a href="http://viakviak.livejournal.com/25986.html" target="_blank">Бог</a>, а уже позже получило резко-негативный символический смысл, давая начало ряду слов, тоже имеющих отрицательный смысл.
</span><span viak="reference">
Из Н.Н.Вашкевича:

<b><span style="font-size:12pt;">САТАНА</span></b><span style="font-size:12pt;"> &ndash; &quot;дьявол, олицетворенное злое начало в различных мистических вероучениях&quot;; греч. satan, satanas &lt; др.-евр. sаtаn. (БЭКМ). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар. </span><span dir="RTL">شيطان</span> <i><span style="font-size:12pt;">шайта:н</span></i><span style="font-size:12pt;"> &quot;черт, сатана, дьявол&quot;. Или от ар. </span><span dir="RTL">ساطن</span> <i><span style="font-size:12pt;">са:тин</span></i><span style="font-size:12pt;"> &quot;зловредный&quot; (М., стр. 333). По облику схож с обезьяной, ср. </span><span dir="RTL">قرد</span> <i><span style="font-size:12pt;">кирд</span></i><span style="font-size:12pt;"> &quot;обезьяна, шайтан&quot; (от рус. <b>дурак</b>), или </span><span dir="RTL">نسناس</span> <i><span style="font-size:12pt;">насна:с</span></i><span style="font-size:12pt;"> (пейоративный повтор от <i>на:с</i> &quot;люди&quot;) </span><span style="font-size:12pt;">&quot;обезьяна&quot;,</span> <span dir="RTL">خناس</span> <i><u><span style="font-size:12pt;">х</span></u></i><i><span style="font-size:12pt;">анна:с</span></i><span style="font-size:12pt;"> &quot;дьявол, совратитель&quot;, где <i><u>х</u></i> &ndash; пейоративный аффикс (&quot;плохой из людей&quot;). Сатанинская функция &ndash; отвлечение от Истины, что осуществляется одинаковым с Истиной написанием в консонантной манере на рус. языке, ср. СТН = СТН, из-за чего <b>сатана</b> и <b>истина</b> становятся трудно различимыми. Например, <b>истина в вине </b>(или сатана?). Приписывается функция существа, призванного жарить людей в пекле, в аду. Это по созвучию с ар. </span><span dir="RTL">شيط</span> <i><span style="font-size:12pt;">шаййат</span></i><span style="font-size:12pt;"> &quot;обжигать, опалять&quot;. У Сатаны много имён, среди них наиболее существенно <b>Иблис</b>, которое в обратном прочтении по-арабски даёт </span><span dir="RTL">سلبي</span> <i><span style="font-size:12pt;">силби</span></i><span style="font-size:12pt;"> &quot;негатив&quot;, &quot;отрицание&quot;,</span><span style="font-size:12pt;"> &quot;минус&quot;, что прямо противопоставлено рус. БОЖЕ, которое в обратном прочтении по-арабски даёт значение &quot;позитив&quot;, &quot;плюс&quot;.</span><span style="font-size:12pt;"> Другое его имя: </span><span dir="RTL">رجيم</span> <i><span style="font-size:12pt;">раги:м</span></i><span style="font-size:12pt;"> &quot;побитый камнями&quot;, от <b>ругма</b> &quot;камень&quot;, &quot;надгробный камень&quot;, откуда </span><span dir="RTL">أرجم</span><span style="font-size:12pt;">&#39;<i>аргуму</i> &quot;кидаю камень в виновного&quot; (ср. <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/A.htm#АРГУМЕНТ1" style="color:purple;">аргумент</a></b>). В некоторых языках название камня созвучно с <i>сатана</i> (шайтан), повторяя эту ар. связь, ср.: англ. <b>стоун</b>, немецк. <b>штейн</b>. Родственно <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/vF.htm#ФАНТАЗИЯ" style="color:purple;">фантазия</a></b>, <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/S.htm#СТАНСЫ" style="color:purple;">стансы</a></b> (см.). В христианском богословии сатана ассоциируется&nbsp;&nbsp;с&nbsp;&nbsp;числом шесть по&nbsp;&nbsp;причине того, что полное произношение по-арабски числа шесть: <i>ситтун</i> (СТН) совпадает с записью СТН. По этой причине число 666 считается сатанинским вопреки текс</span><span style="font-size:12pt;">т</span><span style="font-size:12pt;">у, в котором оно обозначено как &quot;число человеческое&quot;. Для христианских монахов сатана ассоциируется также с женщиной по той же причине: ар. </span><span dir="RTL">ست</span> <i><span style="font-size:12pt;">ситтун</span></i><span style="font-size:12pt;"> &quot;женщина&quot; имеет тот же согласный костяк, что и <b>сатана</b> (СТН). Ср. созвучие в англ.:&nbsp;&nbsp;six и sex. Люди</span><span style="font-size:12pt;">,</span><span style="font-size:12pt;"> имеющие в имени буквы СТН, пытясь найти истину, иногда скатываются в фантазирование, ср. Константин Станиславский (СТН+СТН), театральная концепция которого сводилась к поиску приемов подачи фантазии как истины, откуда его сакраментальное &quot;Не верю!&quot;. Или всемирно известный фантаст Станислав Лем, букв. &quot;придумыватель миров (СТН + </span><span dir="RTL">العـوالم</span> <i><span style="font-size:12pt;">л</span></i><span style="font-size:12pt;">-<i>ъава:лем</i>)&quot; который ищет оправдание своей деятельности</span> <span style="font-size:12pt;">в необходимости гротеска, который </span><span style="font-size:12pt;"> недоступен ни для науки ни для философии: не существует &quot;ни гротескной физики, ни гротескной философии, если же какая-нибудь из них возникла бы, то это влечет автоматически отмену литературы&quot; (&quot;Концепция иллюзорной природы мира&quot; в Энц. словаре &quot;Человек&quot;). На самом деле в 20 веке таковые уже возникли благодаря Эйнштейну (Эйн-ШТН), который считал, что &quot;воображение важнее знаний&quot; (КЕЭ). По этому вопросу см. <b><a href="http://nnvashkevich.narod.ru/SLV/slvPA/B.htm#БОЛЬШОЙ6взрыв" style="color:purple;">Большой взрыв</a></b>.</span>

<b><span style="font-size:12pt;">СТЕНАТЬ </span></b><span style="font-size:12pt;">&ndash; &quot;стонать, кричать со стоном&quot;. (БЭКМ). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар.</span><span dir="RTL"> استأن</span> <i><span style="font-size:12pt;">иста&#39;нна</span></i><span style="font-size:12pt;"> &quot;стонать&quot;, </span><span dir="RTL">أنين</span> <i><span style="font-size:12pt;">&#39;ани:н</span></i><span style="font-size:12pt;"> &quot;стон&quot;. По созвучию с рус. <b>стена</b> у евреев стена плача.</span></span>
<div>
<span viak="reference"><b><span style="font-size:12pt;">СТЕНЬГА</span></b> <span style="font-size:12pt;">&ndash; &quot;вертикальный брус, составляющий продолжение мачты в высоту&quot;. (СИС). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар. </span><span dir="RTL">استنجى</span> <i><span style="font-size:12pt;">&#39;истанга</span></i><i><span style="font-size:12pt;">:</span></i><span style="font-size:12pt;"> &quot;рубить под корень (дерево)&quot;.</span></span>
</div><b><span style="font-size:12pt;">СФИНКТЕР</span></b><span style="font-size:12pt;"> &ndash; <i>анат.</i> &quot;система мышечных кольцевых волокон, расположенных вокруг какого-либо отверстия, закрывающих или суживающих его при своём сокращении. В пищеварительной и мочеполовой системах они являются регуляторами моментов поступления того или другого содержимого в следующие отделы. Сфинктер зрачка служит регулятором количества света, падающего на сетчатку&quot;; нем. sphinkter &lt; греч. sphinktеr сжиматель. (БМЭ). </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12pt;">&diams; От ар. </span><span dir="RTL">خناقة</span> <i><u><span style="font-size:12pt;">х</span></u></i><i><span style="font-size:12pt;">ина:кат</span></i><span style="font-size:12pt;"> &quot;удушье&quot;, &quot;уличная пробка&quot;. По созвучию со <b>сфинкс</b> в семантическом поле Египта сжимается сфинктор заднепроходного отверстия. Др. Египтяне считали, что все болезни происходят от прямой кишки. У жителей второго ареала (Египет, Германия, и др.) литерные болезни связаны с желудочно-кишечным трактом, поскольку он в организме пронумерован двойкой.</span>
</span>
';
GO

/*
exec spAddArticle , N'', N'', N'
<span viak="word">
</span>
';
GO

*/

SELECT N'<a href="http://viakviak.livejournal.com/' + cast(LiveJournalID as nvarchar)+ N'.html">' + Title + N'</a>'
FROM dbo.Article
ORDER BY LiveJournalID DESC

-- SELECT * FROM dbo.Article