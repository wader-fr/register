CREATE TABLE [dbo].[tTLCEmp] (
    [IdTLCEmp]      INT           IDENTITY (1, 1) NOT NULL,
    [AttestatTLC]   NVARCHAR (20) NOT NULL,
    [TLCLastName]   NVARCHAR (20) NOT NULL,
    [TLCFirstName]  NVARCHAR (20) NOT NULL,
    [TLCPatronimic] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_tTLCEmp] PRIMARY KEY CLUSTERED ([IdTLCEmp] ASC),
    CONSTRAINT [CK_tTLCFirstName] CHECK (len([TLCFirstName])>(1)),
    CONSTRAINT [CK_tTLCPatrinimic] CHECK (len([TLCPatronimic])>(1)),
    CONSTRAINT [FK_tTLCEmp_tAttestatTLC] FOREIGN KEY ([AttestatTLC]) REFERENCES [dbo].[tAttestatTLC] ([AttestatTLC])
);

