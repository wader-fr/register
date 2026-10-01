CREATE VIEW [dbo].[vRep]
AS
SELECT        do.NumDocOut + CASE WHEN Suffics IS NOT NULL THEN '-' + Suffics END AS NumOutS, do.NumDocOut, do.DateDocOut, do.DateInspB + '  - ' + do.DateInspE AS InspDate, o.NameObject + ' ' + o.pAddress AS Object, r.Result, 
                         e_1.FirstName, e_1.Patronimic, e_1.LastName,
                             (SELECT        TOP (1) e.FirstName
                               FROM            dbo.tTLCDocOut AS tlc INNER JOIN
                                                         dbo.tblEmployee AS e ON e.IdEmployee = tlc.IdOEmp
                               WHERE        (tlc.IdODocOut = do.IdDocOut)) AS TLCFirstName,
                             (SELECT        TOP (1) e.Patronimic
                               FROM            dbo.tTLCDocOut AS tlc INNER JOIN
                                                         dbo.tblEmployee AS e ON e.IdEmployee = tlc.IdOEmp
                               WHERE        (tlc.IdODocOut = do.IdDocOut)) AS TLCPatronimic,
                             (SELECT        TOP (1) e.LastName
                               FROM            dbo.tTLCDocOut AS tlc INNER JOIN
                                                         dbo.tblEmployee AS e ON e.IdEmployee = tlc.IdOEmp
                               WHERE        (tlc.IdODocOut = do.IdDocOut)) AS TLCLastName,
                             (SELECT        TOP (1) NumProt
                               FROM            dbo.tProtocol AS p
                               WHERE        (IdODocOut = do.IdDocOut)) AS NumProt,
                             (SELECT        TOP (1) DateProt
                               FROM            dbo.tProtocol AS p
                               WHERE        (IdODocOut = do.IdDocOut)) AS DateProt, do.PathScan, do.DateSent, do.Sent
FROM            dbo.tDocOut AS do INNER JOIN
                         dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut LEFT OUTER JOIN
                         dbo.tblEmployee AS e_1 ON do.IdOEmp = e_1.IdEmployee LEFT OUTER JOIN
                         dbo.tblObject AS o ON do.IdOObject = o.IdObject LEFT OUTER JOIN
                         dbo.tblResult AS r ON do.IdOResult = r.IdResult

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[12] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "do"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 259
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dto"
            Begin Extent = 
               Top = 0
               Left = 327
               Bottom = 130
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e_1"
            Begin Extent = 
               Top = 93
               Left = 522
               Bottom = 223
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent = 
               Top = 11
               Left = 743
               Bottom = 306
               Right = 917
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 163
               Left = 286
               Bottom = 293
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 17
         Width = 284
         Width = 5010
         Width = 1500
         Width = 1695
         Width = 11955
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vRep';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vRep';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vRep';

