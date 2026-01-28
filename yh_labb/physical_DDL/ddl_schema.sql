CREATE SCHEMA IF NOT EXISTS core;

SET search_path TO core;

CREATE TABLE people (
    people_id UUID PRIMARY KEY DEFAULT gen_random_uuid()
);

CREATE TABLE school (
    school_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE school_location (
    location_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    school_id   UUID NOT NULL,
    city        VARCHAR(100) NOT NULL,

    CONSTRAINT fk_school_location_school
        FOREIGN KEY (school_id)
        REFERENCES school(school_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_school_location
        UNIQUE (school_id, city)
);

CREATE TABLE company (
    company_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_name VARCHAR(150) NOT NULL,
    org_nr VARCHAR(12) NOT NULL UNIQUE,
    has_f_tax BOOLEAN NOT NULL,
    CONSTRAINT chk_org_nr_format
        CHECK (org_nr ~ '^[0-9]{6}-?[0-9]{4}$')
);

CREATE TABLE core.program (
    program_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    program_name VARCHAR(150) NOT NULL,

    people_id    UUID NOT NULL,  -- utbildningsledare

    CONSTRAINT fk_program_people
        FOREIGN KEY (people_id)
        REFERENCES core.people(people_id)
        ON DELETE RESTRICT
);


CREATE TABLE courses (
    course_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    program_id UUID NULL,               -- NULL = fristående kurs
    course_code VARCHAR(50) NOT NULL UNIQUE,
    course_name VARCHAR(150) NOT NULL,
    yh_credits INTEGER NOT NULL,
    course_description TEXT,
    start_date DATE,
    end_date DATE,

    CONSTRAINT chk_yh_credits
        CHECK (yh_credits > 0),

    CONSTRAINT chk_course_dates
        CHECK (end_date IS NULL OR end_date >= start_date),

    CONSTRAINT fk_courses_program
        FOREIGN KEY (program_id)
        REFERENCES program(program_id)
        ON DELETE RESTRICT
);

CREATE TABLE jobrole (
    jobrole_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_name  VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employee (
    employee_nr VARCHAR(30) PRIMARY KEY,

    people_id   UUID NOT NULL UNIQUE,
    location_id UUID NOT NULL,      -- School_Location
    jobrole_id  UUID NOT NULL,

    start_date  DATE NOT NULL,
    end_date    DATE,

    CONSTRAINT fk_employee_people
        FOREIGN KEY (people_id)
        REFERENCES people(people_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_employee_location
        FOREIGN KEY (location_id)
        REFERENCES school_location(location_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_employee_jobrole
        FOREIGN KEY (jobrole_id)
        REFERENCES jobrole(jobrole_id)
        ON DELETE RESTRICT
);

CREATE TABLE consultants (
    people_id UUID PRIMARY KEY,
    company_id UUID NOT NULL,
    consultant_fee NUMERIC(10,2) NOT NULL,

    CONSTRAINT chk_consultant_fee
        CHECK (consultant_fee > 0),

    CONSTRAINT fk_consultants_people
        FOREIGN KEY (people_id)
        REFERENCES people(people_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_consultants_company
        FOREIGN KEY (company_id)
        REFERENCES company(company_id)
        ON DELETE RESTRICT
);

CREATE TABLE core.classes (
    class_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    program_id  UUID NOT NULL,
    location_id UUID NOT NULL,

    class_name  VARCHAR(100) NOT NULL,
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,

    CONSTRAINT chk_class_dates
        CHECK (end_date >= start_date),

    CONSTRAINT fk_classes_program
        FOREIGN KEY (program_id)
        REFERENCES core.program(program_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_classes_location
        FOREIGN KEY (location_id)
        REFERENCES core.school_location(location_id)
        ON DELETE RESTRICT
);


CREATE TABLE students (
    people_id UUID PRIMARY KEY,   -- ärver PK från people
    study_status VARCHAR(20) NOT NULL,
    dropout_reason TEXT,

    CONSTRAINT fk_students_people
        FOREIGN KEY (people_id)
        REFERENCES people(people_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_study_status
        CHECK (study_status IN ('aktiv', 'pausad', 'avslutad', 'avhoppad')),

    CONSTRAINT chk_dropout_reason
        CHECK (
            (study_status = 'avhoppad' AND dropout_reason IS NOT NULL)
            OR
            (study_status <> 'avhoppad' AND dropout_reason IS NULL)
        )
);


CREATE TABLE people_courses (
    people_course_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    people_id UUID NOT NULL,
    course_id UUID NOT NULL,
    attempt_no INTEGER NOT NULL,
    exam_date DATE,
    grade VARCHAR(2),

    CONSTRAINT uq_people_course_attempt
        UNIQUE (people_id, course_id, attempt_no),

    CONSTRAINT chk_attempt_positive
        CHECK (attempt_no > 0),

    CONSTRAINT chk_grade_values
        CHECK (grade IN ('IG', 'G', 'VG') OR grade IS NULL),

    CONSTRAINT fk_pc_people
        FOREIGN KEY (people_id)
        REFERENCES people(people_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_pc_courses
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE
);

CREATE TABLE people_classes (
    people_class_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    people_id UUID NOT NULL,
    class_id  UUID NOT NULL,

    enrolled_date DATE NOT NULL,
    left_date     DATE,

    CONSTRAINT uq_people_class
        UNIQUE (people_id, class_id),

    CONSTRAINT chk_left_after_enrolled
        CHECK (left_date IS NULL OR left_date >= enrolled_date),

    CONSTRAINT fk_people_classes_people
        FOREIGN KEY (people_id)
        REFERENCES people(people_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_people_classes_class
        FOREIGN KEY (class_id)
        REFERENCES classes(class_id)
        ON DELETE CASCADE
);

CREATE TABLE people_teaches_courses (
    people_id UUID NOT NULL,
    course_id UUID NOT NULL,

    CONSTRAINT pk_people_teaches_courses
        PRIMARY KEY (people_id, course_id),

    CONSTRAINT fk_ptc_people
        FOREIGN KEY (people_id)
        REFERENCES people(people_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ptc_courses
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE
);

CREATE TABLE personal_data (
    personal_data_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    people_id UUID NOT NULL UNIQUE,

    first_name VARCHAR(100) NOT NULL,
    last_name  VARCHAR(100) NOT NULL,

    social_security_number VARCHAR(13) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,

    CONSTRAINT chk_ssn_format
        CHECK (social_security_number ~ '^[0-9]{8}-[0-9]{4}$'),

    CONSTRAINT fk_personal_data_people
        FOREIGN KEY (people_id)
        REFERENCES people(people_id)
        ON DELETE CASCADE
);
