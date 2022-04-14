'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names: Juan Ruiz and Christian Lopez
Description: creates an Employer entity with a 1-many mapping to EmployerInterest and allows listing of all employers
'''

from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, Integer, Boolean, create_engine, ForeignKey
from sqlalchemy.orm import sessionmaker, relationship

Base = declarative_base()

# TODO: finish the object-relational mapping


class Employer(Base):
    __tablename__ = 'Employers'
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    size = Column(Integer, nullable=False)
    location = Column(String, nullable=False)
    forProfit = Column(Boolean, nullable=False)
    govern = Column(Boolean, nullable=False)
    # interests = relationship(
    #     "EmployerInterest", primaryjoin="Employer.id == EmployerInterest.id")
    interest = relationship(
        "EmployerInterest", back_populates="interest")

    def __str__(self):
        s = str(self.id) + ", " + str(self.name) + ", " + \
            str(self.size) + ", " + str(self.location) + ", " + \
            str(self.forProfit) + ", " + str(self.govern) + str(", [")
        for interest in self.interest:
            s += str(interest) + " "
        return s[0:len(s) - 1] + "]"
# TODO: finish the object-relational mapping


class EmployerInterest(Base):
    __tablename__ = 'EmployerInterests'
    id = Column(Integer, ForeignKey("Employers.id"), primary_key=True)
    abbrv = Column(String, ForeignKey("Interests.abbrv"), primary_key=True)
    interest = relationship(
        "Employer", back_populates="interest")

    def __str__(self):
        return str(self.abbrv)


if __name__ == "__main__":

    # db connection and session creation
    db_string = "sqlite:///careers.db"
    db = create_engine(db_string)
    Session = sessionmaker(db)
    session = Session()

    # TODO: list all employers
    employerInterestsQuery = session.query(Employer)
    for employerRow in employerInterestsQuery:
        print(employerRow)
