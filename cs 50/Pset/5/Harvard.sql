-- 1.Find a student’s historical course enrollments, based on their ID:
SELECT "courses"."title", "courses"."semester"
FROM "enrollments"
JOIN "courses" ON "enrollments"."course_id" = "courses"."id" -- SEARCH courses USING INTEGER PRIMARY KEY (rowid=?)
JOIN "students" ON "enrollments"."student_id" = "students"."id"   -- SEARCH enrollments USING INDEX search_by_student_id (student_id=?)
WHERE "students"."id" = 3; --SEARCH students USING INTEGER PRIMARY KEY (rowid=?)

drop index "search_by_enrollment";
create INDEX "search_by_enrollment" -- 这里只用学生id建立index，而用不上课程id（考虑到检索时join的顺序，先按student_id再按course_id合并，倒着？）
on "enrollments"("student_id")

create INDEX "search_by_enrollment"
on "enrollments"("student_id", "course_id")

--  Find all students who enrolled in Computer Science 50 in Fall 2023:
EXPLAIN query plan
SELECT "id", "name"
FROM "students"
WHERE "id" IN ( --SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
    SELECT "student_id"
    FROM "enrollments" -- scan here
    WHERE "course_id" = ( --SEARCH enrollments USING INDEX search_by_course_id (course_id=?)
        SELECT "id"
        FROM "courses" -- scan here
        WHERE "courses"."department" = 'Computer Science' -- SEARCH courses USING COVERING INDEX search_by_course
        AND "courses"."number" = 50
        AND "courses"."semester" = 'Fall 2023'
    )
);


create index "search_by_course"
on "courses"("department", "number", "semester", "title") -- 创建一个包含课程所有信息的检索，之后如果用上课程标题，也不用再额外创建检索。

-- Sort courses by most- to least-enrolled in Fall 2023:
explain query plan
SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title", COUNT(*) AS "enrollment"
FROM "courses"
JOIN "enrollments" ON "enrollments"."course_id" = "courses"."id" -- SEARCH enrollments USING COVERING INDEX search_by_course_id (course_id=?)
WHERE "courses"."semester" = 'Fall 2023' -- SCAN courses
GROUP BY "courses"."id"
ORDER BY "enrollment" DESC;

-- Find all computer science courses taught in Spring 2024:
explain query plan
SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title"
FROM "courses"
WHERE "courses"."department" = 'Computer Science' -- SEARCH courses USING COVERING INDEX search_by_course (department=?)
AND "courses"."semester" = 'Spring 2024';


-- Find the requirement satisfied by “Advanced Databases” in Fall 2023:
explain query plan
SELECT "requirements"."name"
FROM "requirements"
WHERE "requirements"."id" = ( -- SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
    SELECT "requirement_id"
    FROM "satisfies"
    WHERE "course_id" = ( -- SEARCH satisfies USING INDEX search_by_course_id(requirement) (course_id=?)
        SELECT "id"
        FROM "courses"
        WHERE "title" = 'Advanced Databases' -- SCAN courses
        AND "semester" = 'Fall 2023'
    )
);

create index "search_by_course_id(requirement)"
on "satisfies"("course_id"); -- 目前只满足第一个要检索的地方

-- Find how many courses in each requirement a student has satisfied:
EXPLAIN query plan
SELECT "requirements"."name", COUNT(*) AS "courses"
FROM "requirements"
JOIN "satisfies" ON "requirements"."id" = "satisfies"."requirement_id" -- SEARCH satisfies USING INDEX search_by_course_id(requirement) (course_id=?)
WHERE "satisfies"."course_id" IN (
    SELECT "course_id"
    FROM "enrollments"
    WHERE "enrollments"."student_id" = 8 -- SEARCH enrollments USING INDEX search_by_student_id (student_id=?)
)
GROUP BY "requirements"."name"; -- SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)

-- Search for a course by title and semester:
explain query plan
SELECT "department", "number", "title"
FROM "courses" --
WHERE "title" LIKE 'History%' -- SCAN courses
AND "semester" = 'Fall 2023';
