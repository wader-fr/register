CREATE ROLE [RegistrarB]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'ВласоваЭ';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Ольга';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Старцева';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Оплетина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Жукова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Леготкина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Виленчик';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'КашинаМЕ';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Волкова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Кузовникова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Буракова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Фатеев';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Сибирякова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Ковшенина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Милютина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'ОГП';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'ОКГ';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Скулкина';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Трушникова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Молоснова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Шилоносова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'СеливановаЕ';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Таварова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'ОРП';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Титова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Ожгибесова';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'ГДП';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'ОГТ';


GO
EXECUTE sp_addrolemember @rolename = N'RegistrarB', @membername = N'Комягина';


GO
EXECUTE sp_addextendedproperty @name = N'descript', @value = N'Регистратор (бюджет)', @level0type = N'USER', @level0name = N'RegistrarB';

