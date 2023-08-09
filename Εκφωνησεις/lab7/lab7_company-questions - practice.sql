-- -----------------------------------------------------------------------------
-- 1. Nα συντάξετε ένα ερώτημα όπου θα φαίνεται ποιες ειδικότητες (employee.job)
--  εργάζονται σε κάθε τμήμα. Tαξινομήστε ανά κωδικό τμήματος και ειδικότητα.
-- For each Department, show the jobs (employee.job) the employees are occupied 
-- with. Order the results by department number and job name 
-- -----------------------------------------------------------------------------
-- SQL:

select DISTINCT workdept,job 
from employee
order by workdept, job


-- Αποτελέσματα:

-- -------------------------------------------------------------------------
-- 2. Να βρεθεί το όνομα του τμήματος στο οποίο εργάζεται ο εργαζόμενος με 
-- κωδικό 000130. Χρησιμοποιήστε το JOIN.
-- Find the Department nubmer where employee 000130 works. Use JOIN.
-- -------------------------------------------------------------------------
-- SQL:

select deptname
from employee join department on workdept=deptno
where empno='000130'

-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 3. Βρείτε τα ονόματα και οι μισθοί (SALARY) όλων των διευθυντών (ΔΙΕΥΘΥΝΤΗΣ) 
-- ταξινομημένα με φθίνον ύψος μισθού και αύξουσα αλφ. σειρά επωνύμου.
-- Find the names and salaries (SALARY) of all managers (Job is 'ΔΙΕΥΘΥΝΤΗΣ')
-- ordered by descending salary and ascending lastname
-- -----------------------------------------------------------------------------
-- SQL:

select firstname,lastname , salary 
from employee
-- where job='ΔΙΕΥΘΥΝΤΗΣ'
where job like 'ΔΙΕΥΘΥΝΤΗΣ%'
order by salary desc, lastname

-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 4. Έστω ότι η επιχείρηση πρόκειται εν όψει των Χριστουγέννων να δώσει πρόσθε-
-- τη μηνιαία αμοιβή 300 ευρώ σε κάθε εργαζόμενο. Ειδικά για τους διευθυντές 
-- (ΔΙΕΥΘΥΝΤΗΣ) των τμημάτων η αμοιβή αυτή θα είναι 600 ευρώ. Να κατασκευάσετε 
-- τις μισθολογικές καταστάσεις του μήνα Δεκεμβρίου για όλους τους εργαζόμενους 
-- της επιχείρησης, πριν και μετά την αύξηση (αρ. Μητρώου, επώνυμο, όνομα, 
-- μισθός Δεκεμβρίου χωρίς το δώρο, μισθός Δεκεμβρίου με το δώρο). Να 
-- ταξινομήσετε τα αποτελέσματα αυτού του ερωτήματος κατά αλφαβητική σειρά με 
-- βάση το επίθετο. (Σημ. Το πεδίο SALARY έχει τον ετήσιο μισθό).
-- Μπορείτε να χρησιμοποιήσετε και τη ROUND, αν δε σας ενδιαφέρουν τα δεκαδικά.

-- The company intends to give a Christmas bonus of 300€ to each employee.
-- Especially for the managers of the departments (Job is 'ΔΙΕΥΘΥΝΤΗΣ'), the 
-- bonus is 600€. Create a payroll for the month December, where it is shown,
-- for each employee: empno, last name, first name, december salary without the
-- bonus, december salara including the bonus. Note that the field SALARY shows
-- the yearly salary. You can also use the round() function if you want to round
-- the results. 
-- -----------------------------------------------------------------------------
-- SQL:

select empno, lastname, firstname, salary/12 , salary/12 +300 
from employee
where job!='ΔΙΕΥΘΥΝΤΗΣ'

union 

select empno, lastname, firstname, salary/12 , salary/12 +300 
from employee
where job='ΔΙΕΥΘΥΝΤΗΣ'
order by lastname


-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 5. Να φτιάξετε μια κατάσταση που να περιέχει το όνομα, το επίθετο, 
-- την ειδικότητα, το όνομα του τμήματος που ανήκει και το επίθετο του διευθυντή
-- του αντίστοιχου τμήματος, για κάθε εργαζόμενο που δεν είναι αναλυτής 
-- (ΑΝΑΛΥΤΗΣ) και δεν είναι διευθυντής (ΔΙΕΥΘΥΝΤΗΣ), ταξινομημένα ανά επώνυμο 
-- και όνομα.
-- Create a listcontaining the name, the last name, the job name, the name of
-- the department where the employee belongs and the last name of the manager
-- of that department, for every employee who is not an analyst ('ΑΝΑΛΥΤΗΣ') or
-- a manager ('ΔΙΕΘΥΝΤΗΣ'). Ordery by last name and first name.
-- -----------------------------------------------------------------------------
-- SQL:

select e.firstname,e.lastname,e.job , d.deptname, r.lastname
from employee as e ,department as d, employee as r
where e.workdept=d.deptno and r.empno=d.mgrno and e.empno not in 
(select empno
from employee 
where job='ΑΝΑΛΥΤΗΣ' or job='ΔΙΕΥΘΥΝΤΗΣ'
)
order by e.lastname,e.firstname


ορ 


SELECT e.firstname,e.lastname,e.job,d.deptname ,t.lastname as manager
FROM employee as e ,department as d,employee as t
WHERE d.deptno=e.workdept AND e.job!='ΑΝΑΛΥΤΗΣ' AND e.job!='ΔΙΕΥΘΥΝΤΗΣ' AND d.mgrno=t.empno
ORDER BY e.lastname,e.firstname

-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 6. Ανακτήστε το όνομα και το επίθετο των εργαζομένων που συμμετέχουν στο 
-- πρότζεκτ 003301 περισσότερο από τον μισό τους χρόνο. 
-- (Το emp_act.emptime δείχνει το ποσοστό απασχόλησης ενός εργαζομένου σε κάποιο 
-- πρότζεκτ, δηλαδή αν EMPTIME = 60 => ο εργαζόμενος δουλεύει το 60% των 
-- εβδομαδιαίων ωρών απασχόλησης στο πρότεκτ). Θεωρήστε πως οι εργαζόμενοι 
-- δουλεύουν 5*8=40 ώρες την εβδομάδα. Ταξινομήστε με επίθετο και όνομα.
-- Show the name and last name of the employees who work in project 003301 more
-- than half their time. Note that emp_act.emptime shows how much time an emp-
-- loyee spends on a project, as a percentage of his or her weekly time, e.g.
-- emptime=60 means that the employee spends 60% of his or her time on the 
-- project (assume that the total time per week is 5*8=40 hours). Order by 
-- surname and name.
-- -----------------------------------------------------------------------------
-- SQL:

select firstname,lastname 
from employee as e join emp_act as t on t.empno=e.empno
where projno='003301' and t.emptime>51
order by lastname,firstname

-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 7. Βρείτε το όνομα και το επίθετο των εργαζόμενων που στο ή στα πρότζεκτ  που
-- εργάζονται είναι υπεύθυνος ο κ. KAZATZHΣ. (O υπεύθυνος κάθε πρότζεκτ 
-- δηλώνεται στο πεδίο project.resemp). Ταξινομήστε με επίθετο και όνομα.
-- Find the name and surname of the employees whose projects are supervised by
-- Mr. "ΚΑΖΑΤΖΗΣ". Each project's supervisor is found in project.resemp. Order
-- by surname and name.
-- -----------------------------------------------------------------------------
-- SQL:

select e.firstname,e.lastname 
from employee as e,emp_act as a,project as p , employee as t
where e.empno=a.empno and p.projno=a.projno 
and t.empno=p.resemp and t.lastname='ΚΑΖΑΤΖΗΣ'
order by e.lastname,e.firstname


-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 8. Ανακτήστε το όνομα και το επίθετο των εργαζομένων που δεν απασχολούνται σε
--  κανένα έργο και δεν είναι διευθυντές (ΔΙΕΥΘΥΝΤΗΣ). 
-- -----------------------------------------------------------------------------
-- Απάντηση:

SELECT DISTINCT lastname, firstname
FROM employee as e1
WHERE e1.empno NOT IN (SELECT e2.empno
                       FROM emp_act e2 where e2.emstdate<date() and e2.emenddate>date())
                and job!='ΔΙΕΥΘΥΝΤΗΣ'


-- Αποτελέσματα:

-- -----------------------------------------------------------------------------
-- 9. Να βρεθεί ο μέσος μισθός όλων των εργαζομένων γυναικών. 
-- (Το φύλο δηλώνεται στο πεδίο SEX)
-- Find the average salary of all women employees (empoloyee.sex='Θ')
-- -----------------------------------------------------------------------------
-- SQL:

select avg(salary) 
from employee
where sex='Θ'

-- Αποτελέσματα:
