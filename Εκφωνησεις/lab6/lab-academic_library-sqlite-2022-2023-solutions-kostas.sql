-- ---------------------------------------------------------------------------------
-- 1. Εμφανίστε τους τίτλους όλων των καταχωρημένων βιβλίων στη βάση δεδομένων κατά 
-- αλφαβητική σειρά. Επιθυμούμε να εμφανίσουμε εκείνες μόνο τις εγγραφές που 
-- αρχίζουν από «D».
-- 1. Show all book titles that are stored in the database in alphabetical order. We
-- wish to show only those starting with "D"
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT titlos
FROM ENTYPO
WHERE titlos LIKE "D%"
ORDER BY titlos;


-- Αποτελέσματα/Results:
titlos
Data structures,  files and databases
Database : structured techniques for design,  performance,  and management
Database analysis and design
Database design
Database modeling and design : the entity-relationship approach
Database processing : fundamentals,  design,  implementation
Database system concepts
Database: a primer
-- ---------------------------------------------------------------------------------
-- 2. Αλλάξτε το κριτήριο ώστε να εμφανίζονται μόνο οι εγγραφές που αρχίζουν από «Α»
-- έως και «F», χρησιμοποιώντας τον τελεστή Βetween.
-- 2. Modify the query to show onlye the records that start with "A" until and 
-- including "F" using the Βetween operator.
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT titlos
FROM ENTYPO
WHERE titlos BETWEEN "A%" AND "G%"
ORDER BY titlos;

-- Αποτελέσματα:
titlos
An introduction to database systems
Conceptual schema and relational database design : a fact oriented
Data structures,  files and databases
Database : structured techniques for design,  performance,  and management
Database analysis and design
Database design
Database modeling and design : the entity-relationship approach
Database processing : fundamentals,  design,  implementation
Database system concepts
Database: a primer
Fundamental concepts of information modeling
Fundamentals of data normalization
Fundamentals of database systems
-- ---------------------------------------------------------------------------------
-- 3. Εμφανίστε τους τίτλους των βιβλίων που περιέχουν την λέξη «database». 
-- Τα αποτελέσματα να παρουσιάζονται σε αντίστροφη αλφαβητική σειρά.
-- 3. Show the book titles that contain "database". Show the results in inverted
-- alphabetical order.
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT titlos
FROM ENTYPO
WHERE titlos LIKE "%database%"
ORDER BY titlos DESC;

-- Αποτελέσματα:
titlos
SQL and relational databases
Relational database design with microcomputer applications
Principles of database systems
Principles of database and knowledgebase systems
Object-oriented databases
Object-oriented concepts,  databases and applications
Managing your information : how to design and create a textual database
Handbook of relational database design
Fundamentals of database systems
Database: a primer
Database system concepts
Database processing : fundamentals,  design,  implementation
Database modeling and design : the entity-relationship approach
Database design
Database analysis and design
Database : structured techniques for design,  performance,  and management
Data structures,  files and databases
Conceptual schema and relational database design : a fact oriented
An introduction to database systems
-- ---------------------------------------------------------------------------------
-- 4. Εμφανίστε τους τίτλους όλων των βιβλίων που περιέχουν τη λέξη «Database» ή τη 
-- λέξη «Sql». Ταξινομήστε τα αποτελέσματα σε αλφαβητική σειρά και εμφανίστε μόνο τα 
-- 10 πρώτα αποτελέσματα.
-- 4. Show the book titles containing "Database" or "Sql". Order the results in
-- alphabetical order and show only the first ten results.
-- (https://www.sqlite.org/lang_select.html#limitoffset)
-- ---------------------------------------------------------------------------------
-- SQL: 
SELECT titlos
FROM ENTYPO
WHERE titlos LIKE "%Database%" OR "%Sql%"
ORDER BY titlos LIMIT 10;

-- Αποτελέσματα:
titlos
An introduction to database systems
Conceptual schema and relational database design : a fact oriented
Data structures,  files and databases
Database : structured techniques for design,  performance,  and management
Database analysis and design
Database design
Database modeling and design : the entity-relationship approach
Database processing : fundamentals,  design,  implementation
Database system concepts
Database: a primer
-- ---------------------------------------------------------------------------------
-- 5. Εμφανίστε τους κωδικούς των μελών που έχουν δανειστεί βιβλία, τα οποία αυτή τη στιγμή 
-- δεν είναι ακόμη  υποχρεωμένοι να επιστρέψουν.
-- (https://sqlite.org/lang_datefunc.html)
-- 5. Show the ids of the members who have borrowed books which they don't have 
-- to return yet, i.e. return date is not overdue.
-- (https://sqlite.org/lang_datefunc.html)
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT kod_melous
FROM DANEIZETAI 
WHERE im_epistrofis>date('now');

-- Αποτελέσματα:
kod_melous
13
24
29
9
12
24
-- ---------------------------------------------------------------------------------
-- 6. Εμφανίστε τους κωδικούς των μελών που έχουν δανειστεί βιβλία, τα οποία δεν έχουν
-- ακόμη επιστρέψει
-- 7. Show the ids of the members who have borrowed books which they have not yet
-- returned.
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT D.kod_melous
FROM DANEIZETAI AS D
WHERE (D.kod_entypou,D.ar_entypou,D.im_daneismou) NOT IN (SELECT EP.kod_entypou,EP.ar_entypou,EP.im_daneismou
							FROM EPISTREFEI AS EP)
-- Αποτελέσματα:
kod_melous
13
24
29
9
6
12
7
5
-- ---------------------------------------------------------------------------------
-- 7. Εμφανίστε, από μια φορά τον καθένα, τους τίτλους όλων των βιβλίων που έχουν 
-- δανειστεί τα μέλη της  «Ακαδημαϊκής  Βιβλιοθήκης», τώρα ή στο παρελθόν, ταξινομημένους
-- κατά όνομα.
-- Δοκιμάστε να το κάνετε με δύο τρόπους, μια με DISTINCT, μια χωρίς.
-- 7. Show, the titles of the books that have been borrowed by the library's 
-- members, currently or in the past, ordered by title. Show each title only once.
-- Try to do it twice: Once by using DISTINCT, once without.
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT DISTINCT E.titlos
FROM ENTYPO AS E
WHERE E.kod_entypou IN (SELECT D.kod_entypou
			FROM DANEIZETAI AS D);

(χωρίς DISTINCT παίρνω τα ίδια αποτελέσματα)

SELECT E.titlos
FROM ENTYPO AS E
WHERE E.kod_entypou IN (SELECT D.kod_entypou
			FROM DANEIZETAI AS D);

-- Αποτελέσματα:
titlos
Database design
Visual Basic for Windows inside & out
Conceptual schema and relational database design : a fact oriented
Visual basic [programming]
Relational database design with microcomputer applications
Database: a primer
Handbook of relational database design
Using Visual Basic : writing Windows applications
A visual introduction to SQL
Database : structured techniques for design,  performance,  and management
Database processing : fundamentals,  design,  implementation
Database analysis and design
Principles of database systems
Fundamentals of database systems
Object-oriented databases
Visual Basic : easy Windows programming
Logical data base design
Understanding SQL
Managing your information : how to design and create a textual database
The Microsoft Visual Basic workshop
Running Visual Basic For Windows (Version 2)
The Microsoft Visual Basic for MS-DOS workshop
Running Microsoft Access
-- ---------------------------------------------------------------------------------
-- 8. Εμφανίστε τα μέλη (ονοματεπώνυμο) της βιβλιοθήκης που έχουν δανεισμένα βιβλία
-- τώρα αλλά δεν έχουν άλλον δανεισμό στο ιστορικό τους εκτός από τον τρέχοντα. 
-- Αγνοήστε αυτούς που έχουν  παλιότερους δανεισμούς και που δεν
-- επιστράφηκαν ακόμα.
-- 8. Show the library's members (name and lastname) who are currently having
-- borrowed books, but who have not had borrowed any books in the past. 
-- Ignore those who have borrowed in the past but have not return the books yet.
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT M.onoma
FROM MELOS AS M,DANEIZETAI AS D
WHERE M.kod_melous=D.kod_melous AND D.im_epistrofis>date('now')
	AND M.kod_melous NOT IN (SELECT EP.kod_melous
				FROM EPISTREFEI AS EP);
-- Αποτελέσματα:
onoma
Καπερώνης Γιάννης
Ζαφειρίου Νίκος
-- ---------------------------------------------------------------------------------
-- 9. Εμφανίστε τον τίτλο και τον αριθμό εντύπου των βιβλίων που θα έπρεπε
-- να είχαν επιστραφεί, αλλά λείπουν, ταξινομημένα με βάση τις ημέρες καθυστέρησης.
-- 9. Show the title and print id of the books that should have been returned, but
-- are still missing (not returned), order by the ammount of days overdue.
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT E.titlos,E.kod_entypou
FROM ENTYPO AS E,DANEIZETAI AS D
WHERE E.kod_entypou=D.kod_entypou AND D.im_epistrofis<date('now') 
AND (D.kod_melous,D.kod_entypou,D.ar_entypou) NOT IN (SELECT EP.kod_melous,EP.kod_entypou,EP.ar_entypou
				FROM EPISTREFEI AS EP, DANEIZETAI AS D
				WHERE D.kod_melous=EP.kod_melous AND D.kod_entypou=EP.kod_entypou AND D.ar_entypou=EP.ar_entypou)
ORDER BY (date('now')-D.im_epistrofis);

-- Αποτελέσματα:
titlos	kod_entypou
Database analysis and design	35
Understanding SQL	45
Managing your information : how to design and create a textual database	47


-- Conceptual schema and relational database design : a fact oriented	14
-- Relational database design with microcomputer applications	19
-- Using Visual Basic : writing Windows applications	29
-- Database analysis and design	35
-- Principles of database systems	36
-- Understanding SQL	45
-- Managing your information : how to design and create a textual database	47
-- ---------------------------------------------------------------------------------
-- 10. Εμφανίστε τον κωδικό μέλους όσων μελών έχουν επιστρέψει βιβλία με καθυστέρηση.
-- 10. Show the member id of the members who have returned books past the return date.
-- ---------------------------------------------------------------------------------
-- SQL:
SELECT DISTINCT EP.kod_melous
FROM EPISTREFEI AS EP, DANEIZETAI AS D
WHERE EP.kod_melous=D.kod_melous AND D.im_daneismou=EP.im_daneismou 
	AND EP.im_pou_epistrafike>D.im_epistrofis AND EP.kod_entypou=D.kod_entypou
	AND D.ar_entypou=EP.ar_entypou;

-- Αποτελέσματα:
kod_melous
14
24
25
27

