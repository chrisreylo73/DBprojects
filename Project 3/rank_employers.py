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
    for studentInterest in student.interest:
        found = False
        # print("Student Interest:", end='')
        # print(studentInterest)
        for employerInterest in employer.interest:
            # print("Employer Interest:", end="")
            # print(employerInterest)
            if str(studentInterest) == str(employerInterest):
                found = True
                break
        if found:
            # print(common)
            common += 1
    all = len(student.interest) + len(employer.interest) - common
    return round((common / all), 2)


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

    employerInterestsQuery = session.query(Employer)
    for employerRow in employerInterestsQuery:
        print(employerRow, end='')
        print(": ", end="")
        print(jaccard(student, employerRow))
