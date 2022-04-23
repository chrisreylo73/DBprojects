""" mongosh "mongodb+srv://cluster0.ipbv8.mongodb.net/myFirstDatabase" --apiVersion 1 --username admin """
# db.createCollection('employees')
# db.employees.find(
## db.employees.insert({id: 1, name: 'San Mai Tai', sal: 35000})
## db.employees.insert({id: 2, name:'Morbid Mojito' , sal: 65300})
## db.employees.insert({id: 2, name: 'Thyoga Mota' ,email :'hisemail' })


""" 
/// open fresh database name students 
use students 
/// create a new collection also name students 
db.createCollection("students") 
/// insert some documents into students 
db.students.insert({"id": 1, "name": "John"}) 
db.students.insert({"id": 2, "name": "Anna", "courses": ["CS120", "CS265"]}) 
db.students.insert({"name": "Jane", "year": 2022, "major": "Chemistry"}) 
/// list all of the documents in students print("list all of the documents in students:") 
db.students.find() 
/// a simple select print("a simple select:") 
db.students.find({"year": 2022}) 
/// a simple projection print("a simple projection:") 
db.students.find({}, {"name": 1}) 
/// a selection and projection print("a selection and projection:") 
db.students.find({"year": 2022}, {"name": 1})
"""

import pymongo
server = 'cluster0.qpbri.mongodb.net'
user = 'admin'
password = '135791'
client = pymongo.MongoClient(
    f'mongodb+srv://{user}:{password}@{server}/?retryWrites=true&w=majority')
db = client.students
students = db.students
cursor = students.find({})
for student in cursor:
    print(student)
client.close()
