CREATE TABLE [dbo].[tObjectInsp] (
    [IdObjectInsp]  BIGINT        IDENTITY (1, 1) NOT NULL,
    [ObjectInsp]    VARCHAR (250) NULL,
    [IdOTypeObject] INT           NULL,
    CONSTRAINT [PK_tObjectInsp_IdObjectInsp] PRIMARY KEY CLUSTERED ([IdObjectInsp] ASC),
    CONSTRAINT [FK_tObjectInsp_tTypeObjectInsp] FOREIGN KEY ([IdOTypeObject]) REFERENCES [dbo].[tTypeObjectInsp] ([IdTypeObjectInsp])
);

