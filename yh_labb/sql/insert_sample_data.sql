
-- I have used ChatGPT to generate data. 

-- =========================
-- core.school
-- =========================
INSERT INTO school (name)
VALUES ('YrkesCo');

-- =========================
-- core.school_location
-- =========================
INSERT INTO school_location (school_id, city)
SELECT s.school_id, c.city
FROM school s
CROSS JOIN (VALUES ('Stockholm'), ('Göteborg')) AS c(city)
WHERE s.name = 'YrkesCo';

-- =========================
-- core.program
-- =========================
INSERT INTO program (school_id, program_name)
SELECT school_id, 'Data Analytics'
FROM school
WHERE name = 'YrkesCo';

-- =========================
-- core.courses
-- =========================

INSERT INTO courses
(program_id, course_code, course_name, yh_credits, course_description)
SELECT
  p.program_id,
  c.course_code,
  c.course_name,
  c.yh_credits,
  c.course_description
FROM program p
JOIN (
  VALUES
    ('PAND', 'Pandas',        20, 'Data analysis with Pandas'),
    ('DCLN', 'Data Cleaning', 15, 'Cleaning and preparing data'),
    ('SQL',  'SQL',           25, 'SQL for analytics'),
    ('PYTH', 'Python',        30, 'Python programming'),
    ('BI',   'BI Systems',    15, 'Business Intelligence systems'),
    ('EXCL', 'Excel',         10, 'Excel for data analysis'),
    ('STOR', 'Storytelling',  10, 'Data storytelling and presentation')
) AS c(course_code, course_name, yh_credits, course_description)
ON TRUE
WHERE p.program_name = 'Data Analytics';



-- =========================
-- core.jobrole
-- =========================
INSERT INTO jobrole (role_name)
VALUES
  ('Utbildningsledare'),
  ('Lärare');

-- =========================
-- core.people
-- =========================
INSERT INTO people
SELECT gen_random_uuid()
FROM generate_series(1, 80);

-- =========================
-- core.personal_data
-- =========================
WITH p AS (
  SELECT
    people_id,
    ROW_NUMBER() OVER (ORDER BY people_id) AS rn
  FROM core.people
),
names AS (
  SELECT *
  FROM (VALUES
    (1,'Anna','Johansson','19990101-1001'),
    (2,'Erik','Andersson','19990102-1002'),
    (3,'Maria','Karlsson','19990103-1003'),
    (4,'Johan','Nilsson','19990104-1004'),
    (5,'Sara','Larsson','19990105-1005'),
    (6,'Daniel','Olsson','19990106-1006'),
    (7,'Emma','Persson','19990107-1007'),
    (8,'Oscar','Svensson','19990108-1008'),
    (9,'Linda','Gustafsson','19990109-1009'),
    (10,'Fredrik','Pettersson','19990110-1010'),
    (11,'Elin','Jonsson','19990111-1011'),
    (12,'Marcus','Jansson','19990112-1012'),
    (13,'Hanna','Hansson','20000101-1013'),
    (14,'Simon','Bengtsson','20000102-1014'),
    (15,'Josefine','Lindberg','20000103-1015'),
    (16,'Andreas','Forsberg','20000104-1016'),
    (17,'Karin','Sjoberg','20000105-1017'),
    (18,'Niklas','Engstrom','20000106-1018'),
    (19,'Matilda','Axelsson','20000107-1019'),
    (20,'Patrik','Lundberg','20000108-1020'),
    (21,'Sofia','Berg','20000109-1021'),
    (22,'Alexander','Holm','20000110-1022'),
    (23,'Therese','Wallin','20000111-1023'),
    (24,'Jonas','Eklund','20000112-1024'),
    (25,'Rebecca','Strom','20010101-1025'),
    (26,'Viktor','Lofgren','20010102-1026'),
    (27,'Isabella','Sandberg','20010103-1027'),
    (28,'Henrik','Aberg','20010104-1028'),
    (29,'Malin','Blom','20010105-1029'),
    (30,'Tobias','Norberg','20010106-1030'),
    (31,'Felicia','Rydberg','20010107-1031'),
    (32,'Robert','Kjellberg','20010108-1032'),
    (33,'Camilla','Nystrom','20010109-1033'),
    (34,'Pontus','Bjork','20010110-1034'),
    (35,'Amanda','Lindqvist','20010111-1035'),
    (36,'Sebastian','Oberg','20010112-1036'),

    (37,'Anna','Johansson','20020101-1037'),
    (38,'Erik','Andersson','20020102-1038'),
    (39,'Maria','Karlsson','20020103-1039'),
    (40,'Johan','Nilsson','20020104-1040'),
    (41,'Sara','Larsson','20020105-1041'),
    (42,'Daniel','Olsson','20020106-1042'),
    (43,'Emma','Persson','20020107-1043'),
    (44,'Oscar','Svensson','20020108-1044'),
    (45,'Linda','Gustafsson','20020109-1045'),
    (46,'Fredrik','Pettersson','20020110-1046'),
    (47,'Elin','Jonsson','20020111-1047'),
    (48,'Marcus','Jansson','20020112-1048'),
    (49,'Hanna','Hansson','20030101-1049'),
    (50,'Simon','Bengtsson','20030102-1050'),
    (51,'Josefine','Lindberg','20030103-1051'),
    (52,'Andreas','Forsberg','20030104-1052'),
    (53,'Karin','Sjoberg','20030105-1053'),
    (54,'Niklas','Engstrom','20030106-1054'),
    (55,'Matilda','Axelsson','20030107-1055'),
    (56,'Patrik','Lundberg','20030108-1056'),
    (57,'Sofia','Berg','20030109-1057'),
    (58,'Alexander','Holm','20030110-1058'),
    (59,'Therese','Wallin','20030111-1059'),
    (60,'Jonas','Eklund','20030112-1060'),
    (61,'Rebecca','Strom','20040101-1061'),
    (62,'Viktor','Lofgren','20040102-1062'),
    (63,'Isabella','Sandberg','20040103-1063'),
    (64,'Henrik','Aberg','20040104-1064'),
    (65,'Malin','Blom','20040105-1065'),
    (66,'Tobias','Norberg','20040106-1066'),
    (67,'Felicia','Rydberg','20040107-1067'),
    (68,'Robert','Kjellberg','20040108-1068'),
    (69,'Camilla','Nystrom','20040109-1069'),
    (70,'Pontus','Bjork','20040110-1070'),
    (71,'Amanda','Lindqvist','20040111-1071'),
    (72,'Sebastian','Oberg','20040112-1072'),

    (73,'Lars','Ek','19800101-2001'),
    (74,'Ingrid','Dahl','19790202-2002'),
    (75,'Per','Sund','19810303-2003'),
    (76,'Helena','Mark','19820404-2004'),
    (77,'Ulf','West','19780505-2005'),
    (78,'Eva','Nord','19840606-2006'),
    (79,'Mikael','Roos','19770707-2007'),
    (80,'Annika','Borg','19850808-2008')
  ) AS t(rn, first_name, last_name, ssn)
)
INSERT INTO core.personal_data
(people_id, first_name, last_name, social_security_number, email)
SELECT
  p.people_id,
  n.first_name,
  n.last_name,
  n.ssn,
  LOWER(
    n.first_name || '.' || n.last_name || p.rn ||
    CASE
      WHEN p.rn <= 72 THEN '@student.yrkesco.se'
      ELSE '@yrkesco.se'
    END
  )
FROM p
JOIN names n USING (rn);

-- =========================
-- core.students
-- =========================
INSERT INTO students (people_id, study_status, dropout_reason)
SELECT
  p.people_id,
  'aktiv' AS study_status,
  NULL     AS dropout_reason
FROM (
  SELECT people_id, ROW_NUMBER() OVER (ORDER BY people_id) AS rn
  FROM people
) p
WHERE p.rn <= 72;

-- =========================
-- core.program
-- =========================
INSERT INTO core.program (school_id, name)
SELECT school_id, 'Data Analytics'
FROM core.school;

-- =========================
-- core.employee
-- =========================

WITH ranked_people AS (
  SELECT
    people_id,
    ROW_NUMBER() OVER (ORDER BY people_id) AS rn
  FROM people
),
staff AS (
  SELECT
    people_id,
    rn,
    CASE
      WHEN rn IN (73,74,75,76) THEN 'Stockholm'
      ELSE 'Göteborg'
    END AS city,
    CASE
      WHEN rn IN (73,77) THEN 'Utbildningsledare'
      ELSE 'Lärare'
    END AS role_name
  FROM ranked_people
  WHERE rn > 72
)
INSERT INTO employee (
  employee_nr,
  people_id,
  location_id,
  jobrole_id,
  start_date
)
SELECT
  'EMP' || rn AS employee_nr,
  s.people_id,
  sl.location_id,
  jr.jobrole_id,
  DATE '2021-01-01'
FROM staff s
JOIN school_location sl ON sl.city = s.city
JOIN jobrole jr         ON jr.role_name = s.role_name;

-- =========================
-- core.company
-- =========================

INSERT INTO company (company_name, org_nr, has_f_tax)
VALUES
  ('DataConsult AB',        '556123-4567', TRUE),
  ('Analytics Partners AB', '559987-6543', TRUE);

-- =========================
-- core.consultants
-- =========================

WITH ranked_people AS (
  SELECT
    people_id,
    ROW_NUMBER() OVER (ORDER BY people_id) AS rn
  FROM people
)
INSERT INTO consultants (
  people_id,
  company_id,
  consultant_fee
)
SELECT
  rp.people_id,
  c.company_id,
  950.00
FROM ranked_people rp
JOIN company c
  ON (
       (rp.rn IN (73,74) AND c.company_name = 'DataConsult AB')
       OR
       (rp.rn IN (75,76) AND c.company_name = 'Analytics Partners AB')
     );


-- =========================
-- core.people_teaches_courses
-- =========================

INSERT INTO people_teaches_courses (people_id, course_id)
SELECT
  co.people_id,
  cr.course_id
FROM consultants co
JOIN courses cr
  ON cr.course_code IN ('PAND', 'SQL', 'PYTH', 'DCLN');

-- ============
-- Core.classes
-- ============

INSERT INTO core.classes
(program_id, location_id, people_id, class_name, start_date, end_date)
SELECT
  p.program_id,
  sl.location_id,
  e.people_id,
  cls.class_name,
  cls.start_date,
  cls.end_date
FROM core.program p
JOIN core.school_location sl
  ON sl.city IN ('Stockholm', 'Göteborg')
JOIN core.employee e
  ON e.location_id = sl.location_id
CROSS JOIN (
  VALUES
    ('DA21', DATE '2021-01-15', DATE '2023-06-15'),
    ('DA22', DATE '2022-01-15', DATE '2024-06-15'),
    ('DA23', DATE '2023-01-15', DATE '2025-06-15')
) AS cls(class_name, start_date, end_date)
WHERE p.program_name = 'Data Analytics'
AND e.people_id = (
  SELECT e2.people_id
  FROM core.employee e2
  WHERE e2.location_id = sl.location_id
  ORDER BY e2.people_id
  LIMIT 1
);

-- *******************
-- core people_classes
-- *******************
WITH students_rn AS (
  SELECT
    s.people_id,
    ROW_NUMBER() OVER (ORDER BY s.people_id) AS rn
  FROM core.students s
),
classes_rn AS (
  SELECT
    c.class_id,
    c.start_date,
    ROW_NUMBER() OVER (ORDER BY c.class_id) AS class_rn
  FROM core.classes c
)
INSERT INTO core.people_classes
(class_id, people_id, enrolled_date)
SELECT
  cr.class_id,
  sr.people_id,
  cr.start_date
FROM students_rn sr
JOIN classes_rn cr
  ON sr.rn BETWEEN (cr.class_rn - 1) * 12 + 1
                  AND cr.class_rn * 12;

-- *******************
-- core.people_courses
-- *******************

INSERT INTO core.people_courses
(people_id, course_id, attempt_no, exam_date, grade)
SELECT
  pc.people_id,
  c.course_id,
  1 AS attempt_no,
  c.end_date AS exam_date,
  CASE
    WHEN (ROW_NUMBER() OVER (PARTITION BY pc.people_id ORDER BY c.course_code)) % 10 = 0 THEN 'IG'
    WHEN (ROW_NUMBER() OVER (PARTITION BY pc.people_id ORDER BY c.course_code)) % 3 = 0 THEN 'VG'
    ELSE 'G'
  END AS grade
FROM core.people_classes pc
JOIN core.classes cl ON pc.class_id = cl.class_id
JOIN core.courses c  ON c.program_id = cl.program_id;

-- distribute grades for panda course

WITH ranked AS (
  SELECT
    pc.people_course_id,
    ROW_NUMBER() OVER (ORDER BY pc.people_id) AS rn,
    COUNT(*) OVER () AS total
  FROM core.people_courses pc
  JOIN core.courses c ON pc.course_id = c.course_id
  WHERE c.course_code = 'PAND'
)
UPDATE core.people_courses pc
SET grade =
  CASE
    WHEN r.rn <= r.total * 0.2 THEN 'IG'
    WHEN r.rn <= r.total * 0.7 THEN 'G'
    ELSE 'VG'
  END
FROM ranked r
WHERE pc.people_course_id = r.people_course_id;