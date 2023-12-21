-- Χρησιμοποιήστε τη συλλογή lakes:
-- Use the 'lakes' collection:
-- db.lakes.find().limit(1).pretty()

---

-- 1. Πόσες λίμνες υπάρχουν στη συλλογή;
-- 1. How many lakes are there in the collection?

---

-- Mongo query:

```jsx
db.lakes.countDocuments();
```

-- Αποτελέσματα/results:
62

---

-- 2. Ποια η έκταση των λιμνών που το όνομά τους περιέχει τη λέξη «Καστοριά»;
-- Εμφανίστε το όνομα και την έκταση.
-- 2. How much area do the lakes cover that contain in their name the word
-- "Καστοριά". Show the name and the ammount of area these lakes cover.

---

-- Mongo query:

-- Αποτελέσματα/results:

```jsx
db_lakes >
  db.lakes.aggregate([
    { $match: { name: { $regex: /Καστοριά/ } } },
    { $project: { name: 1, area: 1 } },
  ]);
```

```jsx
[
  {
    _id: ObjectId("5def408602353b0fed0c04c8"),
    name: "Ορεστιάδα (Καστοριάς)",
    area: 28.655,
  },
];
```

---

-- 3. Βρείτε τα ονόματα των λιμνών του νομού Αιτωλοακαρνανίας.
-- 3. Find the names of the lakes of the "Bezirk" "Αιτωλοακαρνανία".

---

-- Mongo query:

```jsx
db_lakes >
  db.lakes.aggregate([
    { $match: { "region.area": { $regex: /Αιτωλοακαρνανία/ } } },
    { $project: { name: 1, _id: 0 } },
  ]);
```

-- Αποτελέσματα/results:

```jsx
[
  { name: "Τριχωνίδα" },
  { name: "Κόκκαλα" },
  { name: "Αμβρακία" },
  { name: "Λυσιμαχία" },
  { name: "Οζερός" },
  { name: "Βουλκαρία" },
  { name: "Σαλτίνη" },
  { name: "Μικρή Σαλτίνη" },
  { name: "Κρεμαστών" },
  { name: "Καστρακίου" },
  { name: "Στράτου" },
];
```

---

-- 4. Ποια είναι η Ελληνική λίμνη με το μικρότερο βάθος;
-- 4. Which lake is the most shallow?

---

-- Mongo query:

```jsx
db_lakes >
  db.lakes
    .find({ depth: { $exists: true } })
    .sort({ depth: 1 })
    .limit(1);
```

-- Αποτελέσματα/results:

```jsx
[
{
\_id: ObjectId("5def408502353b0fed0c04c5"),
name: 'Κορώνεια',
region: { region: 'Μακεδονία', area: [ 'Θεσσαλονίκη' ] },
area: 42.823,
length: 10.75,
width: 5.05,
depth: 1,
altitude: 100
}
]
```

---

-- 5. Ποια είναι η Ελληνική λίμνη με τη μεγαλύτερη έκταση;
-- 5. Which lake covers the biggest area?

---

-- Mongo query:

```jsx
db_lakes >
  db.lakes
    .find({ area: { $exists: true } })
    .sort({ area: -1 })
    .limit(1);
```

-- Αποτελέσματα/results:

```jsx
[
{
\_id: ObjectId("5def408502353b0fed0c04c1"),
name: 'Τριχωνίδα',
region: { region: 'Στερεά Ελλάδα', area: [ 'Αιτωλοακαρνανία' ] },
area: 95.84,
length: 18.1,
width: 8.2,
depth: 58,
altitude: 22
}
]
```

---

-- 6. Τα ονόματα όλων των λιμνών της Κρήτης;
-- 6. Return the names of all lakes in Crete ("Κρήτη" region).

---

-- Mongo query:

```jsx
db.lakes.aggregate([
  { $match: { "region.region": { $regex: /Κρήτη/ } } },
  { $project: { name: 1, _id: 0 } },
]);
```

-- Αποτελέσματα/results:

```jsx
[{ name: "Κουρνά" }, { name: "Ποταμών" }];
```

---

-- 7. Πόσες σημαντικές λίμνες έχει η Πελοπόννησος (δλδ με επιφάνεια πάνω από
-- 1 τ.χλμ.)
-- 7. How many important lakes does the Peloponnese contain? ("Πελοπόννησος"
-- region)

---

-- Mongo query:

```jsx
db.lakes
  .find({
    $and: [
      { area: { $gt: 1 } },
      { "region.region": { $regex: /Πελοπόννησος/ } },
    ],
  })
  .count();
```

-- Αποτελέσματα/results:

4
