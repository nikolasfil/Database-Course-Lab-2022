

with open('lab-academic-library-questions.txt','rb') as f:
    for i in f:
        if i==b'-- Αποτελέσματα:':
            print(i)
