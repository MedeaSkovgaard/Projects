# SQL Project: "Personalized Nutrition — Tailoring Dietary Recommendations to an Individual’s Health Status"

# The aim of this project is to demonstrate the use of SQL, a relational database language, and Bash scripting by creating a database, building a food dataset, and working with the data to answer queries related to personalized nutrition. The project can also be used as a tutorial, as all steps are clearly demonstrated and explained in detail.
# The theoretical background of dietary recommendations is intentionally simplified in this document, as the main objective is to demonstrate SQL and Bash scripting methods. PostgreSQL is used as the relational database system.

# Project details:
# The underlying idea of this project is to recommend different foods depending on an individual’s health status. The demonstrated approach is applicable to both humans and other mammals, such as pigs or dogs. As an example, a person with chronic kidney disease is used.

# Literature:
# Kovesdy et al. (2025) Dietary Protein Intake Recommendations for Patients with Non-Dialysis-Dependent CKD: What Should Healthcare Providers Do?. Clin J Am Soc Nephrol 20(8):1154-1163. doi: 10.2215/CJN.0000000772.



# Initiate the Bash script by using the Bash shell
#!/bin/bash



# Define variables for later reference within the Bash script
USER="postgres"
DB="food"
Data="fooddata"
Results="foodsckd"



# Before running the SQL script, navigate to the directory where the psql.exe file is located
cd "C:/Program Files/PostgreSQL/18/pgAdmin 4/runtime"



# Start the SQL script
"C:/Program Files/PostgreSQL/18/pgAdmin 4/runtime/psql.exe" -U "$USER" <<EOF



-- Create the database
CREATE DATABASE $DB;



-- Call the database
\c $DB



-- Create a table for the complete food dataset

-- Columns of the dataset:
--   ID = ID of the food in the food table
--   Description = Description of the food (fx Chicken)
--   Category = Food category the food belongs to (fx Meat)
--   Size = The amount of the serving size when expressed as gram or ml
--   Energy = Nutritional content of energy per 100 gram (in MJ)
--   Protein = Nutritional content of protein per 100 gram (in gram)
--   Fat = Nutritional content of fat per 100 gram (in gram

CREATE TABLE $Data (
  ID SERIAL,
  Description VARCHAR(50),
  Category VARCHAR(50),
  Size NUMERIC(8,3),
  Energy NUMERIC(8,3),
  Protein NUMERIC(8,3),
  Fat NUMERIC(8,3)
);



-- Insert the food data into the dataset

INSERT INTO $Data (Description, Category, Size, Energy, Protein, Fat)
VALUES 
    ('Chicken Breast', 'Meat', 230, 0.46, 23.0, 0.9),
    ('Pork Chop', 'Meat', 350, 1.47, 15.0, 31.0),
    ('Milk', 'Dairy product', 250, 0.28, 3.5, 4.1),
    ('Quark', 'Dairy product', 250, 0.37, 17.0, 0.5),
    ('Yoghurt', 'Dairy product', 150, 0.27, 3.9, 3.8),
    ('Herring', 'Fish', 150, 1.03, 17.0, 19.0),
    ('Rice', 'Grains', 75, 1.48, 6.9, 0.6),
    ('Oats', 'Grains', 50, 1.43, 11.0, 4.7),
    ('Pasta', 'Grains', 300, 1.54, 13.0, 3.0),
    ('Lentil', 'Vegetables', 100, 1.28, 23.0, 0.6),
    ('Zucchini', 'Vegetables', 250, 0.08, 2.0, 0.4),
    ('Apple', 'Fruits', 200, 0.15, 0.3, 0.2);



-- Extract foods from the dataset based on dietary recommendations for chronic kidney disease

-- Regarding chronic kidney disease (non-dialysis-dependent) in a 60-kg male, a meal with a lower protein content is recommended. Kovesdy et al. (2025) suggest a dietary protein intake of 0.6 to 1.3 g per kg of body weight per day. For simplification, only a single food providing the full daily protein requirement is considered, although in reality a person consumes various protein-containing foods throughout the day. Therefore, the SQL query aims to find foods in the food table that provide neither an insufficient nor an excessive amount of protein. For a 60-kg person, this corresponds to a range of 36–78 g of protein per day.

CREATE TABLE $Results AS
SELECT *
FROM $Data
WHERE ((Protein/100)*Size) > 36.0 AND ((Protein/100)*Size) < 78.0;


-- The resulting table should include the following foods: chicken breast, pork chop, quark, and pasta

EOF
