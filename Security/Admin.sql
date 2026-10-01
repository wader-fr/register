CREATE ROLE [Admin]
    AUTHORIZATION [dbo];




GO



GO



GO



GO



GO
EXECUTE sp_addrolemember @rolename = N'Admin', @membername = N'Фатеев';


GO



GO
EXECUTE sp_addextendedproperty @name = N'descript', @value = N'Администратор', @level0type = N'USER', @level0name = N'Admin';

