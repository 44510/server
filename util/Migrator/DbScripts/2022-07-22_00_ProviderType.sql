-- Table: Provider (ProviderType)
IF COL_LENGTH('[dbo].[Provider]', 'ProviderType') IS NULL
BEGIN
    ALTER TABLE
        [dbo].[Provider]
    ADD
        [ProviderType] TINYINT NULL
END
GO

UPDATE
    [dbo].[Provider]
SET
    [ProviderType] = 0
WHERE
    [ProviderType] IS NULL
GO

ALTER TABLE
    [dbo].[Provider]
ALTER COLUMN
    [ProviderType] TINYINT NOT NULL
GO

-- View: Provider
IF EXISTS(SELECT * FROM sys.views WHERE [Name] = 'ProviderView')
BEGIN
    DROP VIEW [dbo].[ProviderView]
END
GO

CREATE VIEW [dbo].[ProviderView]
AS
SELECT
    *
FROM
    [dbo].[Provider]
GO

-- Stored Procedure: Provider_Create
IF OBJECT_ID('[dbo].[Provider_Create]') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[Provider_Create]
END
GO

CREATE PROCEDURE [dbo].[Provider_Create]
    @Id UNIQUEIDENTIFIER OUTPUT,
    @Name NVARCHAR(50),
    @BusinessName NVARCHAR(50),
    @BusinessAddress1 NVARCHAR(50),
    @BusinessAddress2 NVARCHAR(50),
    @BusinessAddress3 NVARCHAR(50),
    @BusinessCountry VARCHAR(2),
    @BusinessTaxNumber NVARCHAR(30),
    @BillingEmail NVARCHAR(256),
    @Status TINYINT,
    @UseEvents BIT,
    @Enabled BIT,
    @CreationDate DATETIME2(7),
    @RevisionDate DATETIME2(7),
    @ProviderType TINYINT
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO [dbo].[Provider]
    (
        [Id],
        [Name],
        [BusinessName],
        [BusinessAddress1],
        [BusinessAddress2],
        [BusinessAddress3],
        [BusinessCountry],
        [BusinessTaxNumber],
        [BillingEmail],
        [Status],
        [UseEvents],
        [Enabled],
        [CreationDate],
        [RevisionDate],
        [ProviderType]
    )
    VALUES
    (
        @Id,
        @Name,
        @BusinessName,
        @BusinessAddress1,
        @BusinessAddress2,
        @BusinessAddress3,
        @BusinessCountry,
        @BusinessTaxNumber,
        @BillingEmail,
        @Status,
        @UseEvents,
        @Enabled,
        @CreationDate,
        @RevisionDate,
        @ProviderType
    )
END
GO

-- Stored Procedure: Provider_Update
IF OBJECT_ID('[dbo].[Provider_Update]') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[Provider_Update]
END
GO

CREATE PROCEDURE [dbo].[Provider_Update]
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(50),
    @BusinessName NVARCHAR(50),
    @BusinessAddress1 NVARCHAR(50),
    @BusinessAddress2 NVARCHAR(50),
    @BusinessAddress3 NVARCHAR(50),
    @BusinessCountry VARCHAR(2),
    @BusinessTaxNumber NVARCHAR(30),
    @BillingEmail NVARCHAR(256),
    @Status TINYINT,
    @UseEvents BIT,
    @Enabled BIT,
    @CreationDate DATETIME2(7),
    @RevisionDate DATETIME2(7),
    @ProviderType TINYINT
AS
BEGIN
    SET NOCOUNT ON

    UPDATE
        [dbo].[Provider]
    SET
        [Name] = @Name,
        [BusinessName] = @BusinessName,
        [BusinessAddress1] = @BusinessAddress1,
        [BusinessAddress2] = @BusinessAddress2,
        [BusinessAddress3] = @BusinessAddress3,
        [BusinessCountry] = @BusinessCountry,
        [BusinessTaxNumber] = @BusinessTaxNumber,
        [BillingEmail] = @BillingEmail,
        [Status] = @Status,
        [UseEvents] = @UseEvents,
        [Enabled] = @Enabled,
        [CreationDate] = @CreationDate,
        [RevisionDate] = @RevisionDate,
        [ProviderType] = @ProviderType
    WHERE
        [Id] = @Id
END
GO
