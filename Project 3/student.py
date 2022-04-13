'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names:
Description: creates a Student entity with a 1-many mapping to StudentInterest and allows listing of all students
'''

from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base  
from sqlalchemy import Column, String, Integer, create_engine, ForeignKey
from sqlalchemy.orm import sessionmaker, relationship

Base = declarative_base()

# TODO: finish the object-relational mapping
class Student(Base): 
    pass

# TODO: finish the object-relational mapping
class StudentInterest(Base):
    pass

if __name__ == "__main__":

    # db connection and session creation
    db_string = "sqlite:///careers.db"
    db = create_engine(db_string)  
    Session = sessionmaker(db)  
    session = Session()

    # TODO: list all students
    