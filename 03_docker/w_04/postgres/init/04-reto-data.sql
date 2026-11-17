INSERT INTO academia.teachers (name, email) VALUES
('Carlos Ramirez', 'carlos@example.com'),
('Laura Molina', 'laura@example.com');

UPDATE academia.courses
SET teacher_id = 1
WHERE id = 1;

UPDATE academia.courses
SET teacher_id = 2
WHERE id = 2;

INSERT INTO academia.enrollments (student_id, course_id) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 2);

