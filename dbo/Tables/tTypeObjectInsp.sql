CREATE TABLE [dbo].[tTypeObjectInsp] (
    [IdTypeObjectInsp] INT           IDENTITY (1, 1) NOT NULL,
    [TypeObjectInsp]   VARCHAR (150) NULL,
    CONSTRAINT [PK_tTypeObjectInsp_IdTypeObjectInsp] PRIMARY KEY CLUSTERED ([IdTypeObjectInsp] ASC)
);

