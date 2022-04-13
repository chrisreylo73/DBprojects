'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names:
Description: creates and populates a file-based embedded database
'''

import sqlite3

import sqlite3
from sqlite3 import Error


def create_connection(db_file):
    """ create a database connection to a SQLite database """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except Error as e:
        print(e)
    finally:
        if conn:
            conn.close()


# TODO: create and populate the database
if __name__ == '__main__':
    create_connection(
        r"C:\Users\chris\AppData\Local\Programs\Python\Python310\Lib\sqlite3\careers.db")
# C:\Users\jttom\AppData\Local\Programs\Python\Python310\Lib\sqlite3\careers.db

conn = sqlite3.connect('careers.db')
with open('create_db.sql') as f:
    conn.executescript(f.read())

conn.commit()
