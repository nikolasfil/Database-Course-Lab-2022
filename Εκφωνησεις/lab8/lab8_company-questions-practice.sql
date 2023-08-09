-- -----------------------------------------------------------------------------
-- 1. Βρείτε τον μέγιστο και τον ελάχιστο μισθό των εργαζομένων σε κάθε τμήμα, 
-- για όσα τμήματα έχουν 3 ή περισσότερους εργαζόμενους. Εμφανίστε το όνομα 
-- τμήματος, τον μέγιστο και τον μικρότερο μισθό (employee.salary).
-- Find the maximum and minimum salary of the employees in each department, for
-- the departments that have 3 or more employees. Show the department name, the
-- maximum and the minimum salary (employee.salary).
-- -----------------------------------------------------------------------------
-- SQL:

select deptname,max(salary), min(salary) 
from employee join department on workdept=deptno 
group by deptno 
having count(empno)>=3


-----kostas-----
SELECT d2.deptname, MAX(SALARY), MIN(SALARY)
FROM employee JOIN department d2 ON employee.workdept = d2.deptno 
GROUP BY WORKDEPT
HAVING COUNT(WORKDEPT) >= 3;

-- Αποτελέσματα:


-- -----------------------------------------------------------------------------
-- 2. Να βρεθεί ο μέσος όρος μισθού (employee.salary) των εργαζομένων ανά έτος 
-- πρόσληψης (employee.hiredate), αλλά μόνο για όσους έχουν βαθμίδα εκπαίδευσης 
-- (employee.EDLEVEL) μεγαλύτερο του 7. Παρουσιάστε και ταξινομήστε τα αποτελέ-
-- σματα ανα έτος πρόσληψης (year), μέσος όρος (m_oros).
-- Find the average salary of the employees per hire year (employee.hiredate), 
-- but only for those employees who have education (edlevel) more than 7.
-- Sort by hire year, and average salary.
-- -----------------------------------------------------------------------------
-- SQL:

select strftime("%Y", HIREDATE) as year,avg(salary) as mo
from employee
where edlevel>7
group by year
order by year,mo


---kostas----

SELECT strftime("%Y", HIREDATE) AS year, AVG(SALARY) AS m_oros
FROM employee 
WHERE EDLEVEL > 7
GROUP BY year
ORDER BY year;




-- Αποτελέσματα:


-- -----------------------------------------------------------------------------
-- 3. Οι συνολικές ετήσιες αμοιβές ενός εργαζόμενου υπολογίζονται από τον τύπο
-- SALARY+SALES*COMM+BONUS. Το bonus (employee.bonus) αποδίδεται μόνο αν ο 
-- εργαζόμενος έχει κάνει τουλάχιστον μία πώληση στο έτος (πίνακας sales). Η 
-- προμήθεια (employee.comm) υπολογίζεται ανάλογα με το πλήθος των πωλήσεων που 
-- έκανε ο εργαζόμενος στο έτος για το οποίο γίνεται ο υπολογισμός.
-- Υπολογίστε, ανά κωδικό εργαζόμενου, το ύψος της συνολικής του αμοιβής για το
-- έτος 2019.

-- The total yearly compensation for an employee is calculated by the formula
-- SALARY+SALES*COMM+BONUS. The bonus (employee.bonus) is given only if the 
-- employee has performed at least one sale in the year (in table 'sales'). The
-- commision (employee.comm) is proportional to the total number of sales that
-- the employee has performed in the give year.
-- Calculate, per employee number, his or her total compensation for the year
-- 2019.
-- -----------------------------------------------------------------------------
-- SQL:

select empno,salary +  bonus  + comm * count(salesid) 

from employee join sales on salesperson=empno

where strftime("%Y",salesdate)="2019"
group by empno 

UNION

SELECT empno,salary 
from employee left join sales on salesperson=empno
where salesdate is null
group by empno 


-----kostas---

SELECT e2.empno,
   count(salesperson) * comm + salary + count(DISTINCT salesperson) * bonus AS total
FROM employee e2
   LEFT JOIN sales s ON e2.empno = s.salesperson
WHERE strftime("%Y",salesdate) = "2019"
   OR salesdate IS NULL
GROUP BY empno;





-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 4. Να εμφανιστούν το ονοματεπώνυμο και ο μισθός όλων των εργαζομένων με μισθό
-- (employee.salary) μεγαλύτερο του μέσου όρου, και των οποίων ο χρόνος υπηρε-
-- σίας στην επιχείρηση είναι μικρότερος του μέσου όρου. 
-- Η διαφορά μεταξύ δύο ημερομηνιών, σε μέρες, υπολογίζεται χρησιμοποιώντας την 
-- julianday() για να μετατρέψουμε την ημερομηνία σε Ιουλιανή μέρα:
-- 
-- SELECT julianday('now') - julianday('2020-01-01');
-- 
-- Το παραπάνω υπολογίζει πόσες μέρες έχουν περάσει από την 1/1/2020 μέχρι τώρα.
--
-- Find the name, lastname and salary of all employees whose salary is greater
-- than the average salary (employee.salary) and whose time working in the com-
-- pany is less than the average time in the company.
-- The difference in days between two dates can be calculated with the function
-- julianday() which translates a date in a Julian day:
-- 
-- SELECT julianday('now') - julianday('2020-01-01');
--
-- This query calculates the days passed since 1/1/2020 until today.
-- -----------------------------------------------------------------------------
-- SQL:


SELECT firstname,lastname ,salary

from employee 

where salary > (select avg(salary) 
                from employee) 
                and 
                julianday('now')-julianday(hiredate) < (select avg(julianday('now')-julianday(hiredate)) from employee)



--------kostas---------
SELECT FIRSTNAME, LASTNAME, SALARY
FROM employee
WHERE SALARY > ( SELECT AVG(SALARY)
FROM employee )
AND (julianday(CURRENT_DATE) - julianday(HIREDATE)) < ( SELECT AVG(julianday(CURRENT_DATE) - julianday(HIREDATE))
FROM employee );
-- μέσος όρος
 SELECT avg(salary)
FROM employee e2 ;
-- όσοι έχουν μισθό μεγαλύτερο του μέσου όρου:
 SELECT FIRSTNAME, LASTNAME, SALARY
FROM employee
WHERE SALARY > ( SELECT AVG(SALARY)
FROM employee ) ;

SELECT datediff(now(), '2020-01-01');
-- μέσο όρος ετών απασχόλησης στην εταιρία
 SELECT AVG(datediff(CURRENT_DATE, HIREDATE))
FROM employee e ;
-- όσοι εργάζονται περισσότερο διάστημα από το μέσο όρο ετώ απασχόλησης
 SELECT FIRSTNAME, LASTNAME, datediff(CURRENT_DATE, HIREDATE), YEAR(HIREDATE)
FROM employee
WHERE datediff(CURRENT_DATE(), HIREDATE) > ( SELECT AVG(datediff(CURRENT_DATE, HIREDATE))
FROM employee );




-- Αποτελέσματα:

-- 5. Για κάθε έργο (κύριο ή υποέργο) βρείτε τον κωδικό, το όνομά του, και πόσες
-- ώρες τη βδομάδα απασχολούνται οι εργαζόμενοι στο έργο αυτό.
-- (Οι ώρες απασχόλησης καταγράφονται στον πίνακα emp_act, στο πεδίο emptime.
-- Το πεδίο αυτό αναφέρει το ποσοστό του εβδομαδιαίου χρόνου του που αφιερώνει
-- ένας εργαζόμενος σε ένα έργο. Θεωρείστε ότι ο κάθε εργαζόμενος εργάζεται 8 
-- ώρες κάθε μέρα.)
-- For every project, regardles if it is a subproject or a main project, find 
-- its number, its name, and how many hours per week the employees are occupied
-- with it. The hours per week are kept in table emp_act, in the field emptime.
-- The field records the % of the employee's weekly time in the project. Assume
-- that every employee works for 8 hours per day, 5 days per week.
-- -----------------------------------------------------------------------------
-- SQL:


SELECT p.projname,p.projno, sum(emptime)*0.4 
from project as p join emp_act as e on p.projno=e.projno
group by p.projno 


----kostas----

SELECT project.PROJNO,
    project.PROJNAME,
    SUM(emp_act.EMPTIME * 40 / 100) AS TotalHours
FROM (
        project
        JOIN emp_act ON project.PROJNO = emp_act.PROJNO
    )
GROUP BY project.PROJNO;
SELECT project.projno AS projno,
    project.projname AS projname,
    SUM(emp_act.emptime * 0.4) AS TotalHours
FROM project
    INNER JOIN emp_act ON project.projno = emp_act.projno
GROUP BY project.projno
ORDER BY project.projno;




-- Αποτελέσματα:
-- -----------------------------------------------------------------------------
-- 6. Να κατασκευαστεί κατάσταση που να περιέχει τον κωδικό, το επίθετο, τον 
-- μισθό (SALARY) και τον κωδικό του τμήματος που εργάζονται, για τους 
-- εργαζόμενους των οποίων η αμοιβή είναι μεγαλύτερη της μέσης αμοιβής του 
-- τμήματος στο οποίο εργάζονται. Ταξινομήστε με φθίνουσα αμοιβή και αλφαβητικά
-- με το επώνυμο.
-- Create a list that contains the employee number, the last name, the salary 
-- and the departmend number for those employees whose salary (employee.salary)
-- is greater than the average salary of the department they work in. Ordery by
-- descending salary and alphabetically by surname.
-- -----------------------------------------------------------------------------
-- SQL:


SELECT empno,lastname, salary,workdept
from employee as e
where salary > (select avg(salary) from employee as r where e.workdept=r.workdept)
order by salary desc,  lastname

-----kostas----


SELECT e.empno,
    e.lastname,
    e.salary,
    e.workdept
FROM employee AS e
WHERE e.salary > (
        SELECT avg(e2.salary)
        FROM employee AS e2
        WHERE e2.workdept = e.workdept
    )
ORDER BY salary DESC,
    e.lastname ASC;

select empno as empno,
    lastname as lastname,
    salary as salary,
    e1.workdept as workdept
from employee as e1
    join (
        select cast(avg(salary) as int) as avg_salary,
            workdept
        from employee
        group by workdept
    ) as e2 on e2.workdept = e1.workdept e1.salary > e2.avg_salary
order by e2.avg_salary desc,
    e1.lastname asc;



-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 7.Ζητούνται όσοι είναι υπεύθυνοι σε υποέργα όλων των κύριων έργων. Ανακτήστε 
-- τον κωδικό, το όνομα και το επίθετο των εργαζομένων που είναι υπεύθυνοι σε 
-- ένα τουλάχιστον υποέργο κάθε κύριου έργου.
-- (Μερικά κύρια έργα έχουν υποέργα. Το πεδίο MAJPROJ του πίνακα PROJECT δηλώνει
-- σε ποιο κύριο έργο ανήκει ένα υποέργο. Ο υπεύθυνος ενός έργου δηλώνεται στο 
-- πεδίο RESEMP).
-- -----------------------------------------------------------------------------
-- Απάντηση:

-- Αποτελέσματα:
