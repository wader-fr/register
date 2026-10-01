CREATE ROLE [Boss]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'ВласоваЭ';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Оплетина';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Паздерина';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Кравченко';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Кузовникова';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Фатеев';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Ковшенина';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Шляпников';


GO
EXECUTE sp_addrolemember @rolename = N'Boss', @membername = N'Рыбкина';

