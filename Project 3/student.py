'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names: Juan Ruiz and Christian Lopez
Description: creates a Student entity with a 1-many mapping to StudentInterest and allows listing of all students
'''

from curses.ascii import EM
import re
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, Integer, create_engine, ForeignKey
from sqlalchemy.orm import sessionmaker, relationship

Base = declarative_base()

# TODO: finish the object-relational mapping


class Student(Base):
    __tablename__ = 'Students'
    email = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    major = Column(String)  # Might set to NOT NULL
    graduation = Column(String)  # Might set to NOT NULL
    # interest = relationship(
    #     "StudentInterest", primaryjoin="Student.email==StudentInterest.email")
    interest = relationship(
        "StudentInterest", back_populates="interest")

    def __str__(self):
        s = str(self.email) + ", " + str(self.name) + ", " + \
            str(self.major) + ", " + str(self.graduation) + str(", [")
        for interest in self.interest:
            s += str(interest) + " "
        return s[0:len(s) - 1] + "]"
# TODO: finish the object-relational mapping


class StudentInterest(Base):
    __tablename__ = 'StudentInterests'

    email = Column(String, ForeignKey("Students.email"), primary_key=True)
    abbrv = Column(String, ForeignKey("Interests.abbrv"), primary_key=True)
    interest = relationship(
        "Student", back_populates="interest")

    def __str__(self):
        return str(self.abbrv)


if __name__ == "__main__":

    # db connection and session creation
    db_string = "sqlite:///careers.db"
    db = create_engine(db_string)
    Session = sessionmaker(db)
    session = Session()

    # TODO: list all students
    studentInterestsQuery = session.query(Student)
    for studentRow in studentInterestsQuery:
        print(studentRow)
