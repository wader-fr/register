CREATE ROLE [Admin]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'Admin', @membername = N'ВласоваЭ';


GO
EXECUTE sp_addrolemember @rolename = N'Admin', @membername = N'Оплетина';


GO
EXECUTE sp_addrolemember @rolename = N'Admin', @membername = N'Кравченко';


GO
EXECUTE sp_addrolemember @rolename = N'Admin', @membername = N'Щелчкова';


GO
EXECUTE sp_addrolemember @rolename = N'Admin', @membername = N'Фатеев';


GO
EXECUTE sp_addrolemember @rolename = N'Admin', @membername = N'Титова';


GO
EXECUTE sp_addextendedproperty @name = N'descript', @value = N'Администратор', @level0type = N'USER', @level0name = N'Admin';

