'''
CS3810 - Principles of Database Systems - Spring 2022
Instructor: Thyago Mota
Student Names: Juan Ruiz and Christian Lopez
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
    path = input("Please enter in sqlite careers.db path: ")
    create_connection(path)
# C:\Users\jttom\AppData\Local\Programs\Python\Python310\Lib\sqlite3\careers.db

conn = sqlite3.connect('careers.db')
with open('create_db.sql') as f:
    conn.executescript(f.read())

conn.commit()
