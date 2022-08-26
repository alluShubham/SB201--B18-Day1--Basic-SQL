mysql> CREATE TABLE Person (ID INT PRIMARY KEY, email VARCHAR(10));
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO person VALUES(1,"a@b.com");
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO person VALUES(2,"c@d.com");
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO person VALUES(3,"a@b.com");
Query OK, 1 row affected (0.00 sec)
=======================================================================

mysql> SELECT email FROM Person GROUP BY Email HAVING COUNT(Email) > 1;
+---------+
| email   |
+---------+
| a@b.com |
+---------+
1 row in set (0.00 sec)
==========================================================================

QUESTION 2
=======================================================================

mysql> CREATE DATABASE ORG;
Query OK, 1 row affected (0.01 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+     |
| mysql              |
| org                |
+--------------------+
17 rows in set (0.01 sec)
=======================================================================
mysql> USE ORG;
Database changed
=======================================================================
mysql> CREATE TABLE Worker (
    -> WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    -> FIRST_NAME CHAR(25),
    -> LAST_NAME CHAR(25),
    -> SALARY INT(15),
    -> JOINING_DATE DATETIME,
    -> DEPARTMENT CHAR(25)
    -> );
Query OK, 0 rows affected, 1 warning (0.03 sec)
=======================================================================

mysql> INSERT INTO Worker
    -> (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
    -> (001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
    -> (002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
    -> (003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
    -> (004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
    -> (005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
    -> (006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
    -> (007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
    -> (008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
Query OK, 8 rows affected, 8 warnings (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 8
=======================================================================

mysql> CREATE TABLE Bonus (
    -> WORKER_REF_ID INT,
    -> BONUS_AMOUNT INT(10),
    -> BONUS_DATE DATETIME,
    -> FOREIGN KEY (WORKER_REF_ID)
    -> REFERENCES Worker(WORKER_ID)
    -> ON DELETE CASCADE
    -> );
Query OK, 0 rows affected, 1 warning (0.04 sec)
=======================================================================

mysql> INSERT INTO Bonus
    -> (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
    -> (001, 5000, '16-02-20'),
    -> (002, 3000, '16-06-11'),
    -> (003, 4000, '16-02-20'),
    -> (001, 4500, '16-02-20'),
    -> (002, 3500, '16-06-11');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0
=======================================================================

mysql> CREATE TABLE Title (
    -> WORKER_REF_ID INT,
    -> WORKER_TITLE CHAR(25),
    -> AFFECTED_FROM DATETIME,
    -> FOREIGN KEY (WORKER_REF_ID)
    -> REFERENCES Worker(WORKER_ID)
    -> ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.04 sec)
=======================================================================

mysql> INSERT INTO Title
    -> (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    -> (001, 'Manager', '2016-02-20 00:00:00'),
    -> (002, 'Executive', '2016-06-11 00:00:00'),
    -> (008, 'Executive', '2016-06-11 00:00:00'),
    -> (005, 'Manager', '2016-06-11 00:00:00'),
    -> (004, 'Asst. Manager', '2016-06-11 00:00:00'),
    -> (007, 'Executive', '2016-06-11 00:00:00'),
    -> (006, 'Lead', '2016-06-11 00:00:00'),
    -> (003, 'Lead', '2016-06-11 00:00:00');
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0
=======================================================================

=>1. Write an SQL query to show the second highest salary from a Worker table.
mysql> SELECT MAX(SALARY) FROM Worker WHERE SALARY < (SELECT MAX(SALARY) FROM Worker);
+-------------+
| MAX(SALARY) |
+-------------+
|      300000 |
+-------------+
1 row in set (0.00 sec)
=======================================================================

=>2. Write an SQL query to determine the 5 highest salary from a Worker table
mysql> Select * from Worker ORDER BY SALARY DESC limit 5;
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | Admin      |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | Admin      |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | Account    |
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
5 rows in set (0.00 sec)
=======================================================================

=>3. Write an SQL query to show only even rows from a Worker table
mysql> Select * from Worker where (WORKER_ID % 2) = 1;
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | Admin      |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | Account    |
+-----------+------------+-----------+--------+---------------------+------------+
4 rows in set (0.00 sec)
=======================================================================

=>4. Write an SQL query to fetch the no. of workers for each department in the descending order from the Worker table.
mysql> SELECT DEPARTMENT, count(WORKER_ID) No_Of_Workers
    -> FROM worker
    -> GROUP BY DEPARTMENT
    -> ORDER BY No_Of_Workers DESC;
+------------+---------------+
| DEPARTMENT | No_Of_Workers |
+------------+---------------+
| Admin      |             4 |
| HR         |             2 |
| Account    |             2 |
+------------+---------------+
3 rows in set (0.00 sec)


================================================================
Question 3
================================================================
mysql> create table EmployeeDetails (EmpId int primary key, FullName varchar(20), ManagerId int, DateOfJoining date,
    -> City varchar(12));
Query OK, 0 rows affected (0.10 sec)

mysql> insert into EmployeeDetails values(121, "John Snow", 321, '2014-1-31', "Toronto");
Query OK, 1 row affected (0.01 sec)

mysql> insert into EmployeeDetails values(321, "Walter White", 986, '2015-1-30', "California");
Query OK, 1 row affected (0.00 sec)

mysql> insert into EmployeeDetails values(421, "Kuldeep Rana", 876, '2016-11-27', "New Delhi");
Query OK, 1 row affected (0.00 sec)

mysql> create table EmployeeSalary(EmpId int primary key, Project varchar(3), Salary int, Variable int);
Query OK, 0 rows affected (0.03 sec)

mysql> insert into EmployeeSalary values(121, "p1", 8000, 500);
Query OK, 1 row affected (0.01 sec)

mysql> insert into EmployeeSalary values(321, "p2", 10000, 1000);
Query OK, 1 row affected (0.00 sec)

mysql> insert into EmployeeSalary values(421, "p1", 12000, 0);
Query OK, 1 row affected (0.00 sec)
=======================================================================

=>1. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” 
and ending with any sequence of characters.
mysql> SELECT *  FROM EmployeeDetails WHERE FullName LIKE '__hn%';
+-------+-----------+-----------+---------------+---------+
| EmpId | FullName  | ManagerId | DateOfJoining | City    |
+-------+-----------+-----------+---------------+---------+
|   121 | John Snow |       321 | 2014-01-31    | Toronto |
+-------+-----------+-----------+---------------+---------+
1 row in set (0.00 sec)
=======================================================================

=>2. Write an SQL query to fetch common records between two tables.
mysql> select empd.fullname, empd.managerId,empd.dateofjoining,empd.city, es.project,es.salary,es.variable from
    ->  employeedetails empd cross join employeesalary es where empd.empid = es.empid;
+--------------+-----------+---------------+------------+---------+--------+----------+
| fullname     | managerId | dateofjoining | city       | project | salary | variable |
+--------------+-----------+---------------+------------+---------+--------+----------+
| John Snow    |       321 | 2014-01-31    | Toronto    | p1      |   8000 |      500 |
| Walter White |       986 | 2015-01-30    | California | p2      |  10000 |     1000 |
| Kuldeep Rana |       876 | 2016-11-27    | New Delhi  | p1      |  12000 |        0 |
+--------------+-----------+---------------+------------+---------+--------+----------+
3 rows in set (0.00 sec)
=======================================================================

=>3. Write an SQL query to fetch records that are present in one table but not in another table.
mysql> select empd.fullname, empd.managerId,empd.dateofjoining,empd.city from employeedetails empd left outer join
    ->  employeesalary es on empd.empid = es.empid;
+--------------+-----------+---------------+------------+
| fullname     | managerId | dateofjoining | city       |
+--------------+-----------+---------------+------------+
| John Snow    |       321 | 2014-01-31    | Toronto    |
| Walter White |       986 | 2015-01-30    | California |
| Kuldeep Rana |       876 | 2016-11-27    | New Delhi  |
+--------------+-----------+---------------+------------+
3 rows in set (0.00 sec)
=================================================================
=>4. Write an SQL query to find the maximum, minimum, and average salary of the employees.
mysql> SELECT Max(Salary), Min(Salary), AVG(Salary) FROM EmployeeSalary;
+-------------+-------------+-------------+
| Max(Salary) | Min(Salary) | AVG(Salary) |
+-------------+-------------+-------------+
|       12000 |        8000 |  10000.0000 |
+-------------+-------------+-------------+
1 row in set (0.00 sec)
=======================================================================

=>5. Fetch all the employees who are not working on any project.
mysql> select * from employeedetails empd inner join employeesalary es on es.empid = empd.empid and es.project is null;
Empty set (0.00 sec)
=======================================================================