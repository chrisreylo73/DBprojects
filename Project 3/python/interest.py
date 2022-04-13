'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names:
Description: creates Interest entity and allows listing of all interests
'''

from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base  
from sqlalchemy import Column, String, Integer, create_engine
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

# TODO: finish the object-relational mapping
class Interest(Base): 
    pass

if __name__ == "__main__":

    # db connection and session creation
    db_string = "sqlite:///careers.db"
    db = create_engine(db_string)  
    Session = sessionmaker(db)  
    session = Session()

    # TODO: list all interests
    