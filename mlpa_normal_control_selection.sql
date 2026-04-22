SELECT req_reqno AS labno FROM request
/* Criteria:
- Female patient
- Chinese ethnicity
- Wild type sequence (normal result)
- Recent sample from routine genetic assay */
WHERE req_sex = 'F'
AND req_reqno IN
	(SELECT testrslt_reqno FROM testrslt
	WHERE testrslt_member_ckey = 20026
	AND testrslt_varchar NOT LIKE '%Sanger%'
	AND testrslt_reqno IN 
		(SELECT testrslt_reqno FROM testrslt
		WHERE testrslt_member_ckey = 20021
		AND testrslt_text LIKE '%normal%'
		AND testrslt_status = 6
		AND testrslt_reqno IN
			(SELECT req_reqno FROM request_detail
			WHERE req_alpha_code = 'GENE-AZA'
			AND req_registered_date >= DATEADD(mm, -6, GETDATE())
			)
		)
	)
ORDER BY labno DESC