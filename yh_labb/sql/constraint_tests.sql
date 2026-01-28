
-- following statements will not work

UPDATE core.courses 
SET yh_credits = -10
WHERE course_code = 'PAND';


INSERT INTO core.company (
    company_name,
    org_nr,
    has_f_tax
)
VALUES (
    'Fake Company AB',
    'ABC-123',
    TRUE
);

UPDATE core.consultants
SET consultant_fee = -500
WHERE company_id = '712eb850-491e-4045-8ec4-e68d52563913';




