CREATE DATABASE cms;

USE cms;

CREATE TABLE user (
                      id INT PRIMARY KEY AUTO_INCREMENT,
                      name VARCHAR(100) NOT NULL,
                      email VARCHAR(100) UNIQUE NOT NULL,
                      password VARCHAR(100) NOT NULL,
                      role VARCHAR(50) NOT NULL
);

CREATE TABLE complaint (
                           complaint_id INT PRIMARY KEY AUTO_INCREMENT,
                           employee_id INT NOT NULL,
                           title VARCHAR(255),
                           description TEXT,
                           status VARCHAR(50) DEFAULT 'pending',
                           remarks TEXT,
                           date DATE,
                           FOREIGN KEY (employee_id) REFERENCES user(id)
);

insert into user(name,email,password,role)values("sasanka","silvakssd@gmail.com","1234","Employee");

insert into user(name,email,password,role)values("shamindu","kssds1212@gmail.com","1234","Admin");

insert into complaint(complaint_id,employee_id,title,description,status,remarks,date)values (1,1,"nothing",'none',"pending",'none','2024-12-10');


