from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, Integer, create_engine
from sqlalchemy.orm import sessionmaker

Base = declarative_base()


class Employee(Base):

    # table mapping
    __tablename__ = 'employees'

    # column mapping
    id = Column(Integer, primary_key=True)
    name = Column(String)
    sal = Column(Integer)

    def __str__(self):
        return str(self.id) + ", " + self.name + ", " + str(self.sal)


# db connection and session creation
db_string = "postgresql://hr_admin:135791@localhost:5432/hr"
db = create_engine(db_string)
Session = sessionmaker(db)
session = Session()

# simple search
employees = session.query(Employee)
for emp in employees:
    print(emp)
