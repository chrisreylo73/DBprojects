-- Team Members: Juan Ruiz, Chris Lopez

-- TODOd: create the cms database
CREATE DATABASE cms;

-- TODOd: "open" the database for use
\c cms

-- TODO: (optional) drop all tables

-- TODO: create all tables (with primary keys, NULL constraints, and foreign keys)

-- TODO: create users 

-- TODO: grant access to users 

-- TODO: answer all queries

-- a) List all diagnostic names in alphabetical order.   
  
-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition).   
  
-- c) List the total number of providers.  
  
-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state). 

-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order 

-- f) List the number of providers per RUCA code (showing the code and description)

-- g) Show the DRG description for code 308
  
-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.  

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals.   
 
-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?  

-- TODO (optional) - BONUS POINTS: prove that you didn't do the normalization only using your "guts" but also what you learned in class; show all 2NF or 3NF violations and normalization steps in detail and you will get up to +10 points.
