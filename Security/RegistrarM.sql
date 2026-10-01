CREATE ROLE [RegistrarM]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'ВласоваЭ';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Оплетина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Леготкина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Ельшина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Кузовникова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Фатеев';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Сибирякова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarM', @membername = N'Ковшенина';


GO
EXECUTE sp_addextendedproperty @name = N'descript', @value = N'Регистратор', @level0type = N'USER', @level0name = N'RegistrarM';

