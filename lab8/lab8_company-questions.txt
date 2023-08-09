-- -----------------------------------------------------------------------------
-- 1. Βρείτε τον μέγιστο και τον ελάχιστο μισθό των εργαζομένων σε κάθε τμήμα, 
-- για όσα τμήματα έχουν 3 ή περισσότερους εργαζόμενους. Εμφανίστε το όνομα 
-- τμήματος, τον μέγιστο και τον μικρότερο μισθό (employee.salary).
-- Find the maximum and minimum salary of the employees in each department, for
-- the departments that have 3 or more employees. Show the department name, the
-- maximum and the minimum salary (employee.salary).
-- -----------------------------------------------------------------------------
-- SQL:

SELECT max(salary),avg(salary) from employee join department on workdept=deptno  GROUP by deptno having count(empno)>=3


-- Αποτελέσματα:

100000	31835.0
90000	42250.0
80000	27714.2857142857
50000	26000.0
40000	18000.0
25000	17000.0
60000	39666.6666666667
20000	17125.0
90000	41250.0
50000	20733.3333333333

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

select avg(salary) as m_oros,strftime("%Y",hiredate) as etos  from employee group by etos having edlevel>7 ORDER by etos,m_oros

-- Αποτελέσματα:

90000.0	1997
35000.0	2005
58600.0	2007
28188.8	2015
34666.6666666667	2016
17947.2857142857	2017

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


-- Αποτελέσματα:

000120	13287
000121	30000
000123	12000
000128	22500
000130	14000
000132	15944
000140	15944
000142	22400
000145	25000
000154	30000
000157	16800
000165	19000
000180	38700
000187	24000
000215	29000
000231	10000
000235	12000
000237	14000
000254	15000
000274	12000
000289	19000
000333	12000
000414	25000
000452	10000
000457	25000
000478	16000
000521	17200
000556	19000
000566	10000
000578	16000
000588	25000
000651	16000
000658	17000
000666	12500
000789	17000
000874	12000
000875	16000
000947	18000
121216	100000
121217	90000
121218	80000
121220	40000
121221	25000
121222	60000
121223	50000
121224	20000
121225	90000
121226	55000
121227	50000
121228	50000

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


-- Αποτελέσματα:

ΓΙΩΡΓΟΣ	ΦΙΩΤΑΚΗΣ	30000
ΚΑΛΛΙΟΠΗ	ΚΑΠΑΓΙΑΝΝΗ	80000
ΧΡΙΣΤΙΝΑ	ΚΑΜΕΝΟΥ	40000
ΑΝΤΩΝΗΣ	ΚΑΡΑΤΖΑΣ	60000
ΙΩΑΝΝΑ	ΚΥΡΙΑΚΟΥ	55000
ΚΥΡΙΑΚΟΣ	ΙΩΑΝΝΟΥ	50000


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



-- Αποτελέσματα:

ΚΛΕΙΣΤΟ ΓΗΠΕΔΟ ΠΑΤΡΩΝ	003101	108.0
ΗΛΕΚΤΡΟΛΟΓΙΚΗ ΜΕΛΕΤΗ	003114	40.0
ΣΤΑΤΙΚΗ ΜΕΛΕΤΗ	003115	120.0
ΟΙΚΟΝΟΜΟΤΕΧΝΙΚΗ ΜΕΛΕΤΗ	003116	24.0
ΕΘΝΙΚΗ ΠΑΤΡΩΝ-ΚΟΡΙΝΘΟΥ	003201	68.0
ΗΛΕΚΤΡΟΛΟΓΙΚΗ ΜΕΛΕΤΗ	003202	56.0
ΣΤΑΤΙΚΗ ΜΕΛΕΤΗ	003203	172.0
ΟΙΚΟΝΟΜΟΤΕΧΝΙΚΗ ΜΕΛΕΤΗ	003204	124.0
ΠΩΛΗΣΗ ΤΣΙΜΕΝΤΟΥ	003301	136.0


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


-- Αποτελέσματα:

121216	ΚΑΠΡΑΛΟΣ	100000	Τ01
121217	ΚΟΥΛΟΧΕΡΗΣ	90000	Τ02
121225	ΛΙΑΚΟΠΟΥΛΟΣ	90000	Τ10
121218	ΚΑΠΑΓΙΑΝΝΗ	80000	Τ03
121222	ΚΑΡΑΤΖΑΣ	60000	Τ07
121226	ΚΥΡΙΑΚΟΥ	55000	Τ11
121228	ΙΩΑΝΝΟΥ	50000	Τ04
121227	ΚΑΖΑΤΖΗΣ	50000	Τ12
121223	ΠΟΛΥΧΡΟΝΑΚΗ	50000	Τ08
121220	ΚΑΜΕΝΟΥ	40000	Τ05
000180	ΓΕΩΡΓΙΟΥ	35000	Τ03
121221	ΜΑΡΓΑΡΙΤΗΣ	25000	Τ06
000142	ΧΑΣΑΠΟΓΛΟΥ	22400	Τ12
121224	ΚΑΛΑΠΑΝΙΔΑΣ	20000	Τ09
000556	ΓΚΙΟΚΑ	19000	Τ09

-- -----------------------------------------------------------------------------
-- 7.Ζητούνται όσοι είναι υπεύθυνοι σε υποέργα όλων των κύριων έργων. Ανακτήστε 
-- τον κωδικό, το όνομα και το επίθετο των εργαζομένων που είναι υπεύθυνοι σε 
-- ένα τουλάχιστον υποέργο κάθε κύριου έργου.


-- (Μερικά κύρια έργα έχουν υποέργα. Το πεδίο MAJPROJ του πίνακα PROJECT δηλώνει
-- σε ποιο κύριο έργο ανήκει ένα υποέργο. Ο υπεύθυνος ενός έργου δηλώνεται στο 
-- πεδίο RESEMP).
-- -----------------------------------------------------------------------------
-- Απάντηση:

SELECT firstname,lastname,empno
from project join employee on empno=resemp
group by resemp
having count(majproj)=(SELECT count(*) from (SELECT majproj,count(projno) from project where majproj is not Null GROUP by majproj )) 
	
-- Αποτελέσματα:
ΑΛΕΚΑ	ΛΑΜΠΡΟΠΟΥΛΟΥ	000289
