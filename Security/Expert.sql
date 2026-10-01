CREATE ROLE [Expert]
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



GO



GO



GO



GO
EXECUTE sp_addrolemember @rolename = N'Expert', @membername = N'Паздерина';


GO



GO
EXECUTE sp_addrolemember @rolename = N'Expert', @membername = N'Яковкина';


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



GO



GO
EXECUTE sp_addrolemember @rolename = N'Expert', @membername = N'Фатеев';


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
EXECUTE sp_addextendedproperty @name = N'descript', @value = N'Эксперт', @level0type = N'USER', @level0name = N'Expert';

