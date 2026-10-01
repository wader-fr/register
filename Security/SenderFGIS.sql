CREATE ROLE [SenderFGIS]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'ВласоваЭ';


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'Потоскуева';


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'Оплетина';


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'Новожилова';


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'Праведникова';


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'Жукова';


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'Фатеев';


GO
EXECUTE sp_addrolemember @rolename = N'SenderFGIS', @membername = N'Ковшенина';

