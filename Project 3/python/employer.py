'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names:
Description: creates an Employer entity with a 1-many mapping to EmployerInterest and allows listing of all employers
'''

from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base  
from sqlalchemy import Column, String, Integer, Boolean, create_engine, ForeignKey
from sqlalchemy.orm import sessionmaker, relationship

Base = declarative_base()

# TODO: finish the object-relational mapping
class Employer(Base): 
    pass

# TODO: finish the object-relational mapping
class EmployerInterest(Base):
    pass

if __name__ == "__main__":

    # db connection and session creation
    db_string = "sqlite:///careers.db"
    db = create_engine(db_string)  
    Session = sessionmaker(db)  
    session = Session()

    # TODO: list all employers
    