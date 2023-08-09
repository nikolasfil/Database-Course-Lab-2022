-- -----------------------------------------------------------------------------
-- 1. Βρείτε τον μέγιστο και τον ελάχιστο μισθό των εργαζομένων σε κάθε τμήμα, 
-- για όσα τμήματα έχουν 3 ή περισσότερους εργαζόμενους. Εμφανίστε το όνομα 
-- τμήματος, τον μέγιστο και τον μικρότερο μισθό (employee.salary).
-- Find the maximum and minimum salary of the employees in each department, for
-- the departments that have 3 or more employees. Show the department name, the
-- maximum and the minimum salary (employee.salary).
-- -----------------------------------------------------------------------------
-- SQL:
SELECT d2.deptname, MAX(SALARY), MIN(SALARY)
FROM employee JOIN department d2 ON employee.workdept = d2.deptno 
GROUP BY WORKDEPT
HAVING COUNT(WORKDEPT) >= 3;
-- Αποτελέσματα:

-- ΔΙΟΙΚΗΣΗ	100000	13287
-- ΛΟΓΙΣΤΗΡΙΟ	90000	24000
-- ΤΜΗΜΑ ΠΩΛΗΣΕΩΝ	80000	10000
-- ΤΜΗΜΑ ΠΡΟΜΗΘΕΙΩΝ	50000	12000
-- ΔΙΑΦΗΜΙΣΤΙΚΟ ΤΜΗΜΑ	40000	10000
-- ΤΜΗΜΑ ΕΝΤΥΠΗΣ ΔΙΑΦΗΜΙΣΗΣ	25000	12000
-- ΤΜΗΜΑ ΗΛΕΚΤΡΟΝΙΚΗΣ ΔΙΑΦΗΜΙΣΗΣ	60000	29000
-- ΤΜΗΜΑ ΠΡΟΣΩΠΙΚΟΥ	20000	12500
-- ΤΜΗΜΑ ΠΡΟΣΛΗΨΕΩΝ	90000	25000
-- ΚΑΤΑΣΚΕΥΑΣΤΙΚΟ ΤΜΗΜΑ	50000	12000

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
SELECT strftime("%Y", HIREDATE) AS year, AVG(SALARY) AS m_oros
FROM employee 
WHERE EDLEVEL > 7
GROUP BY year
ORDER BY year;

-- Αποτελέσματα:
-- 1997	90000.0
-- 2005	35000.0
-- 2007	58600.0
-- 2011	90000.0
-- 2015	20472.0
-- 2016	12000.0
-- 2017	16643.5
-- 2018	42500.0


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
SELECT e2.empno,
   count(salesperson) * comm + salary + count(DISTINCT salesperson) * bonus AS total
FROM employee e2
   LEFT JOIN sales s ON e2.empno = s.salesperson
WHERE strftime("%Y",salesdate) = "2019"
   OR salesdate IS NULL
GROUP BY empno;

-- Σχόλια: 
-- το WHERE YEAR(salesdate)= 2019 OR salesdate IS NULL το θέλουμε για να 
-- εμφανιστούν όλες οι γραμμές του joined πίνακα
-- το count και το count distinct είναι μια λεπτή διαφορά, η δεύτερη μετρά μόνο
-- διακριτές τιμές στο salesperson, άρα θα είναι ή 0 ή 1.

-- Αποτελέσματα:
-- 000120	13287
-- 000121	30000
-- 000123	12000
-- 000128	22500
-- 000130	14000
-- 000132	15944
-- 000140	15944
-- 000142	22400
-- 000145	25000
-- 000154	30000
-- 000157	16800
-- 000165	19000
-- 000180	38700
-- 000187	24000
-- 000215	29000
-- 000231	10000
-- 000235	12000
-- 000237	14000
-- 000254	15000
-- 000274	12000
-- 000289	19000
-- 000333	12000
-- 000414	25000
-- 000452	10000
-- 000457	25000
-- 000478	16000
-- 000521	17200
-- 000556	19000
-- 000566	10000
-- 000578	16000
-- 000588	25000
-- 000651	16000
-- 000658	17000
-- 000666	12500
-- 000789	17000
-- 000874	12000
-- 000875	16000
-- 000947	18000
-- 121216	100000
-- 121217	90000
-- 121218	80000
-- 121220	40000
-- 121221	25000
-- 121222	60000
-- 121223	50000
-- 121224	20000
-- 121225	90000
-- 121226	55000
-- 121227	50000
-- 121228	50000

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

--ΓΙΩΡΓΟΣ	ΦΙΩΤΑΚΗΣ	30000
--ΚΑΛΛΙΟΠΗ	ΚΑΠΑΓΙΑΝΝΗ	80000
--ΧΡΙΣΤΙΝΑ	ΚΑΜΕΝΟΥ	40000
--ΑΝΤΩΝΗΣ	ΚΑΡΑΤΖΑΣ	60000
--ΙΩΑΝΝΑ	ΚΥΡΙΑΚΟΥ	55000
--ΚΥΡΙΑΚΟΣ	ΙΩΑΝΝΟΥ	50000


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
-- -----------------------------------------------------------------------------
-- SQL:
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
-- Αποτελέσματα
-- 003113   ΚΛΕΙΣΤΟ ΓΗΠΕΔΟ ΠΑΤΡΩΝ   108.0000
-- 003114   ΗΛΕΚΤΡΟΛΟΓΙΚΗ ΜΕΛΕΤΗ 40.0000
-- 003115   ΣΤΑΤΙΚΗ ΜΕΛΕΤΗ 120.0000
-- 003116   ΟΙΚΟΝΟΜΟΤΕΧΝΙΚΗ ΜΕΛΕΤΗ  24.0000
-- 003201   ΕΘΝΙΚΗ ΠΑΤΡΩΝ-ΚΟΡΙΝΘΟΥ  68.0000
-- 003202   ΗΛΕΚΤΡΟΛΟΓΙΚΗ ΜΕΛΕΤΗ 56.0000
-- 003203   ΣΤΑΤΙΚΗ ΜΕΛΕΤΗ 172.0000
-- 003204   ΟΙΚΟΝΟΜΟΤΕΧΝΙΚΗ ΜΕΛΕΤΗ  124.0000
-- 003301   ΠΩΛΗΣΗ ΤΣΙΜΕΝΤΟΥ  136.0000
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

--121216	ΚΑΠΡΑΛΟΣ	100000	Τ01
--121217	ΚΟΥΛΟΧΕΡΗΣ	90000	Τ02
--121225	ΛΙΑΚΟΠΟΥΛΟΣ	90000	Τ10
--121218	ΚΑΠΑΓΙΑΝΝΗ	80000	Τ03
--121222	ΚΑΡΑΤΖΑΣ	60000	Τ07
--121226	ΚΥΡΙΑΚΟΥ	55000	Τ11
--121228	ΙΩΑΝΝΟΥ	50000	Τ04
--121227	ΚΑΖΑΤΖΗΣ	50000	Τ12
--121223	ΠΟΛΥΧΡΟΝΑΚΗ	50000	Τ08
--121220	ΚΑΜΕΝΟΥ	40000	Τ05
--000180	ΓΕΩΡΓΙΟΥ	35000	Τ03
--121221	ΜΑΡΓΑΡΙΤΗΣ	25000	Τ06
--000142	ΧΑΣΑΠΟΓΛΟΥ	22400	Τ12
--121224	ΚΑΛΑΠΑΝΙΔΑΣ	20000	Τ09
--000556	ΓΚΙΟΚΑ	19000	Τ09


-- -----------------------------------------------------------------------------
-- 7.Ζητούνται όσοι είναι υπεύθυνοι σε υποέργα όλων των κύριων έργων. Ανακτήστε 
-- τον κωδικό, το όνομα και το επίθετο των εργαζομένων που είναι υπεύθυνοι σε 
-- ένα τουλάχιστον υποέργο κάθε κύριου έργου.
-- (Μερικά κύρια έργα έχουν υποέργα. Το πεδίο MAJPROJ του πίνακα PROJECT δηλώνει
-- σε ποιο κύριο έργο ανήκει ένα υποέργο. Ο υπεύθυνος ενός έργου δηλώνεται στο 
-- πεδίο RESEMP).
-- -----------------------------------------------------------------------------
-- SQL:
SELECT a.RESEMP,
    e2.firstname,
    e2.lastname
FROM project AS a
    JOIN employee e2 ON a.resemp = e2.empno
WHERE a.MAJPROJ IS NOT NULL
GROUP BY RESEMP
HAVING count(DISTINCT a.majproj) = (
        SELECT count(*)
        FROM project
        WHERE MAJPROJ IS NULL
            AND projno IN (
                SELECT majproj
                FROM project p
            )
    );
-- Αποτελέσματα:
-- 000289	ΑΛΕΚΑ	ΛΑΜΠΡΟΠΟΥΛΟΥ
