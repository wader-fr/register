
CREATE PROCEDURE [dbo].[qEmpAppSel]

--DECLARE
	@IdDoc bigint = 74051
AS
BEGIN	
	DECLARE @IdDept varchar(10),
			@IdsEmp varchar(MAX)
	
	SELECT @IdDept = a.IdsDept
	FROM dbo.tAppointment a
	WHERE a.IdODoc = @IdDoc
			AND a.IdOTypeApp = 1
	
	SELECT @IdDept = '% ' + CONVERT(varchar(10), e.IdODept) + ' %'
	FROM dbo.tblEmployee e 
	WHERE e.lgn = USER_NAME()
		AND e.Roles NOT LIKE '%Admin%'
	
	
	
	SELECT @IdsEmp = a.IdsEmp
	FROM dbo.tAppointment a
	WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = 2
	
	SELECT e.IdEmployee, e.FullName + ' (' + d.sNameDept + ')' FullName, ISNULL(es.sel, 0) sel
	FROM dbo.tblEmployee e
			INNER JOIN dbo.tblDept d ON d.IdDept = e.IdODept
			LEFT OUTER JOIN (SELECT e.IdEmployee, -1 sel
							FROM dbo.tblEmployee e
							WHERE @IdsEmp LIKE '% ' + CONVERT(varchar(5), e.IdEmployee) + ' %') es ON es.IdEmployee = e.IdEmployee
	WHERE @IdDept LIKE '% ' + CONVERT(varchar(10), e.IdODept) + ' %'
		AND e.Fired = 0
		AND d.Act = 1
		ORDER BY d.IdDept, e.IdEmployee
		
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpAppSel] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpAppSel] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpAppSel] TO [Admin]
    AS [dbo];

