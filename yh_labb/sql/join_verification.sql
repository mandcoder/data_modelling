/* 
This join shows which program exists
and which "utbildningledare"  is responsible for the program. 
*/

SELECT pr.program_name,
pd.first_name,
pd.last_name
FROM core.program pr
JOIN core.people p ON pr.people_id = p.people_id
JOIN core.personal_data pd ON p.people_id = pd.people_id;

/*
This query shows how grades is distributed for Panda course.
*/

SELECT grade, COUNT(*)
FROM core.people_courses_grades pc
JOIN core.courses c ON pc.course_id = c.course_id
WHERE c.course_code = 'PAND'
GROUP BY grade;

/*
This query shows which consultants teach which 
courses and which company they represent 
*/

SELECT
  pd.first_name,
  pd.last_name,
  co.company_name,
  cr.course_code,
  cr.course_name
FROM core.people_teaches_courses ptc
JOIN core.consultants c      ON ptc.people_id = c.people_id
JOIN core.personal_data pd  ON c.people_id = pd.people_id
JOIN core.company co        ON c.company_id = co.company_id
JOIN core.courses cr        ON ptc.course_id = cr.course_id
ORDER BY co.company_name, pd.last_name, cr.course_code;