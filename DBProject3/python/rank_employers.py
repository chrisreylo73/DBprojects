'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names:
Description: show recommendation scores for student-employer matching based on common interests
'''

from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base  
from sqlalchemy import Column, String, Integer, Boolean, create_engine, ForeignKey
from sqlalchemy.orm import sessionmaker, relationship
from student import Student
from employer import Employer

def jaccard(student, employer): 
    common = 0
    for studentInterest in student.interests: 
        found = False 
        for employerInterest in employer.interests: 
            if studentInterest.interest == employerInterest.interest: 
                found = True
                break
        if found:
            common += 1
    all = len(student.interests) + len(employer.interests) - common 
    return common / all

if __name__ == "__main__":

    # db connection and session creation
    db_string = "sqlite:///careers.db"
    db = create_engine(db_string)  
    Session = sessionmaker(db)  
    session = Session()

    # retrieve a student by email
    email = input('email? ')
    student = session.query(Student).filter(Student.email == email).one()
    print(student)

    # TODO: matching of the student to each employer
    