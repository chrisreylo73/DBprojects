'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names: Juan Ruiz and Christian Lopez
Description: creates Interest entity and allows listing of all interests
'''

from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, Integer, create_engine
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

# TODO: finish the object-relational mapping


class Interest(Base):
    __tablename__ = 'Interests'

    abbrv = Column(String, primary_key=True)
    descr = Column(String)

    def __str__(self):
        return str(self.abbrv) + ", " + str(self.descr)


if __name__ == "__main__":

    # db connection and session creation
    db_string = "sqlite:///careers.db"
    db = create_engine(db_string)
    Session = sessionmaker(db)
    session = Session()

    # TODO: list all interests
    interestQuery = session.query(Interest)
    for interestRow in interestQuery:
        print(interestRow)

    session.close()

# Interest referes to the Interest class
# interestQuery is a varible to the query
# interestRow is a place holder that referes to each row in table
