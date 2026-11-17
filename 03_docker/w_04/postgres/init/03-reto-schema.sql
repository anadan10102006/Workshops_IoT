CREATE TABLE IF NOT EXISTS academia.teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL
);

ALTER TABLE academia.courses
ADD COLUMN IF NOT EXISTS teacher_id INTEGER;

ALTER TABLE academia.courses
ADD CONSTRAINT fk_courses_teacher
FOREIGN KEY (teacher_id)
REFERENCES academia.teachers(id);

CREATE TABLE IF NOT EXISTS academia.enrollments (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES academia.students(id),
    FOREIGN KEY (course_id) REFERENCES academia.courses(id),
    UNIQUE (student_id, course_id)
);

