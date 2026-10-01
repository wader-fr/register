CREATE ROLE [RegistrarM]
    AUTHORIZATION [dbo];




GO



GO



GO



GO



GO



GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Фатеев';


GO



GO



GO
EXECUTE sp_addextendedproperty @name = N'descript', @value = N'Регистратор', @level0type = N'USER', @level0name = N'RegistrarM';

