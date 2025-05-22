/*** An AWS-compatibe script for creating the CyclingResults database ***/


USE [master]
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'CyclingResults')
BEGIN
    CREATE DATABASE [CyclingResults]
END
GO

ALTER DATABASE [CyclingResults] SET COMPATIBILITY_LEVEL = 160
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [CyclingResults].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO

ALTER DATABASE [CyclingResults] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CyclingResults] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CyclingResults] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CyclingResults] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CyclingResults] SET ARITHABORT OFF 
GO
ALTER DATABASE [CyclingResults] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CyclingResults] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CyclingResults] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CyclingResults] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CyclingResults] SET CURSOR_DEFAULT GLOBAL 
GO
ALTER DATABASE [CyclingResults] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CyclingResults] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CyclingResults] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CyclingResults] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CyclingResults] SET DISABLE_BROKER 
GO
ALTER DATABASE [CyclingResults] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CyclingResults] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CyclingResults] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CyclingResults] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CyclingResults] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CyclingResults] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CyclingResults] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CyclingResults] SET RECOVERY FULL 
GO
ALTER DATABASE [CyclingResults] SET MULTI_USER 
GO
ALTER DATABASE [CyclingResults] SET PAGE_VERIFY CHECKSUM 
GO
ALTER DATABASE [CyclingResults] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CyclingResults] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CyclingResults] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [CyclingResults] SET QUERY_STORE = ON
GO
ALTER DATABASE [CyclingResults] SET QUERY_STORE (
    OPERATION_MODE = READ_WRITE, 
    CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), 
    DATA_FLUSH_INTERVAL_SECONDS = 900, 
    INTERVAL_LENGTH_MINUTES = 60, 
    MAX_STORAGE_SIZE_MB = 1000, 
    QUERY_CAPTURE_MODE = AUTO, 
    SIZE_BASED_CLEANUP_MODE = AUTO, 
    MAX_PLANS_PER_QUERY = 200, 
    WAIT_STATS_CAPTURE_MODE = ON
)
GO

USE [CyclingResults]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Race]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Race](
	[RaceId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Year] [int] NOT NULL,
	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Race] PRIMARY KEY CLUSTERED 
(
	[RaceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RaceTeamInfo]    Script Date: 22/05/2025 10:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RaceTeamInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RaceTeamInfo](
	[RTID] [int] IDENTITY(1,1) NOT NULL,
	[TeamId] [int] NOT NULL,
	[RaceId] [int] NOT NULL,
	[TeamUrl] [varchar](255) NULL,
 CONSTRAINT [PK_RaceTeamInfo] PRIMARY KEY CLUSTERED 
(
	[RTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Rider]    Script Date: 22/05/2025 10:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rider]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Rider](
	[RiderId] [int] IDENTITY(1,1) NOT NULL,
	[BibNum] [int] NOT NULL,
	[CountryCode] [varchar](10) NOT NULL,
	[Team] [varchar](100) NOT NULL,
	[RiderName] [varchar](100) NOT NULL,
	[TeamId] [int] NULL,
 CONSTRAINT [PK_Rider] PRIMARY KEY CLUSTERED 
(
	[RiderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Stage]    Script Date: 22/05/2025 10:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Stage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Stage](
	[StageID] [int] IDENTITY(1,1) NOT NULL,
	[RaceName] [nvarchar](255) NULL,
	[StageIdentifier] [nvarchar](100) NOT NULL,
	[StageFullTitle] [nvarchar](512) NULL,
	[StageDateText] [nvarchar](50) NULL,
	[Distance] [nvarchar](50) NULL,
	[ProfileUrl] [nvarchar](1024) NULL,
	[ScrapedTimestamp] [datetime2](7) NOT NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[RaceId] [int] NOT NULL,
 CONSTRAINT [PK_Stages] PRIMARY KEY CLUSTERED 
(
	[StageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[StageResults]    Script Date: 22/05/2025 10:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StageResults]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StageResults](
	[StageResultID] [int] IDENTITY(1,1) NOT NULL,
	[StageID] [int] NOT NULL,
	[Rank] [int] NULL,
	[RiderName] [nvarchar](255) NULL,
	[RiderUrl] [nvarchar](1024) NULL,
	[TeamName] [nvarchar](255) NULL,
	[TeamUrl] [nvarchar](1024) NULL,
	[TimeOrGap] [nvarchar](100) NULL,
	[PcsPointsText] [nvarchar](50) NULL,
	[UciPointsText] [nvarchar](50) NULL,
 CONSTRAINT [PK_StageResults] PRIMARY KEY CLUSTERED 
(
	[StageResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Team]    Script Date: 22/05/2025 10:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Team]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [varchar](100) NOT NULL,
	[ShirtUrl] [varchar](255) NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Stages_RaceStageIdentifier]    Script Date: 22/05/2025 10:50:20 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Stage]') AND name = N'IX_Stages_RaceStageIdentifier')
CREATE NONCLUSTERED INDEX [IX_Stages_RaceStageIdentifier] ON [dbo].[Stage]
(
	[RaceName] ASC,
	[StageIdentifier] ASC,
	[StageDateText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_StageResults_RiderName]    Script Date: 22/05/2025 10:50:20 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[StageResults]') AND name = N'IX_StageResults_RiderName')
CREATE NONCLUSTERED INDEX [IX_StageResults_RiderName] ON [dbo].[StageResults]
(
	[RiderName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_StageResults_StageID]    Script Date: 22/05/2025 10:50:20 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[StageResults]') AND name = N'IX_StageResults_StageID')
CREATE NONCLUSTERED INDEX [IX_StageResults_StageID] ON [dbo].[StageResults]
(
	[StageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Stages_ScrapedTimestamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Stage] ADD  CONSTRAINT [DF_Stages_ScrapedTimestamp]  DEFAULT (getutcdate()) FOR [ScrapedTimestamp]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_StageResults_Stages]') AND parent_object_id = OBJECT_ID(N'[dbo].[StageResults]'))
ALTER TABLE [dbo].[StageResults]  WITH CHECK ADD  CONSTRAINT [FK_StageResults_Stages] FOREIGN KEY([StageID])
REFERENCES [dbo].[Stage] ([StageID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_StageResults_Stages]') AND parent_object_id = OBJECT_ID(N'[dbo].[StageResults]'))
ALTER TABLE [dbo].[StageResults] CHECK CONSTRAINT [FK_StageResults_Stages]
GO

USE [master]
GO
ALTER DATABASE [CyclingResults] SET READ_WRITE 
GO
