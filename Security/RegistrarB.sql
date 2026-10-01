CREATE ROLE [RegistrarB]
    AUTHORIZATION [dbo];




GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Фатеев';


GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO
EXECUTE sp_addextendedproperty @name = N'descript', @value = N'Регистратор (бюджет)', @level0type = N'USER', @level0name = N'RegistrarB';

