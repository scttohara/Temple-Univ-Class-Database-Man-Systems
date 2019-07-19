DROP TABLE STORE_EMPLOYEES_HRS_Rating;
DROP TABLE EMPLOYEE;
DROP TABLE DEPT_SUPER;
DROP TABLE STORES;

CREATE TABLE DEPT_SUPER
    (Emp_Dept			    NUMBER(2,0),
     Emp_super			    VARCHAR(10), 
CONSTRAINT Dept_PK PRIMARY KEY (Emp_Dept));


CREATE TABLE EMPLOYEE
    (Emp_Id 			    VARCHAR(6) NOT NULL,	
     Emp_salary 		    NUMBER(8,0) NOT NULL,
     Emp_Dept			    NUMBER(4,0), 
CONSTRAINT Emp_PK PRIMARY KEY (Emp_Id),
CONSTRAINT Dept_FK FOREIGN KEY (Emp_Dept) REFERENCES DEPT_SUPER(Emp_Dept));


CREATE TABLE STORES
    (Store_Name 		    VARCHAR(10)	 NOT NULL,
     Store_Mgr			    VARCHAR(25),
     Opening_Date			DATE, 
     Revenue                NUMBER(15),
CONSTRAINT Store_PK PRIMARY KEY (Store_Name));



CREATE TABLE STORE_EMPLOYEES_HRS_Rating
    (Store_Name			    VARCHAR(10) NOT NULL,	
     Emp_Id				    VARCHAR(6) NOT NULL,
     Hours_per_week		    NUMBER(4,0),
     Rating				    NUMBER(2,0),
CONSTRAINT Store_Name_FK FOREIGN KEY (Store_Name) REFERENCES STORES(Store_Name),
CONSTRAINT Emp_FK FOREIGN KEY (Emp_Id) REFERENCES EMPLOYEE(Emp_Id));


INSERT INTO dept_super (Emp_Dept, Emp_super) VALUES (10, 'Levine');
INSERT INTO dept_super (Emp_Dept, Emp_super) VALUES (12, 'Jones');
INSERT INTO dept_super (Emp_Dept, Emp_super) VALUES (15, 'Jones');
INSERT INTO employee (Emp_Id, Emp_salary, Emp_Dept) VALUES ('E-101', 60000, 10);
INSERT INTO employee (Emp_Id, Emp_salary, Emp_Dept) VALUES ('E-105', 55000, 12);
INSERT INTO employee (Emp_Id, Emp_salary, Emp_Dept) VALUES ('E-110', 43000, 10);
INSERT INTO employee (Emp_Id, Emp_salary, Emp_Dept) VALUES ('E-120', 45000, 15);
INSERT INTO stores (Store_Name, Store_Mgr, Opening_Date, revenue) VALUES ('PA_store', 'Jones', to_date('1/15/2015', 'MM/DD/YYYY'), 100000);
INSERT INTO stores (Store_Name, Store_Mgr, Opening_Date, revenue) VALUES ('NJ_store', 'Smith', to_date('3/1/2014', 'MM/DD/YYYY'), 200000);
INSERT INTO store_employees_hrs_rating (Store_Name, Emp_Id, Hours_per_week, Rating) VALUES ('PA_store', 'E-101', 25, 9);
INSERT INTO store_employees_hrs_rating (Store_Name, Emp_Id, Hours_per_week, Rating) VALUES ('PA_store', 'E-105', 40, 8);
INSERT INTO store_employees_hrs_rating (Store_Name, Emp_Id, Hours_per_week, Rating) VALUES ('PA_store', 'E-110', 10, 8);
INSERT INTO store_employees_hrs_rating (Store_Name, Emp_Id, Hours_per_week, Rating) VALUES ('NJ_store', 'E-101', 15, 7);
INSERT INTO store_employees_hrs_rating (Store_Name, Emp_Id, Hours_per_week, Rating) VALUES ('NJ_store', 'E-110', 30, 9);
INSERT INTO store_employees_hrs_rating (Store_Name, Emp_Id, Hours_per_week, Rating) VALUES ('NJ_store', 'E-120', 40, 9);


select s.store_name, s.store_mgr, e.emp_id, se.hours_per_week, s.revenue, to_char(s.opening_date, 'MM/DD/YYYY') as Opening_Date, 
e.emp_salary, ds.emp_super, ds.emp_dept, se.rating
from  employee e inner join dept_super ds on ds.emp_dept = e.emp_dept
                   inner join store_employees_hrs_rating se on e.emp_id = se.emp_id
                   inner join stores s on se.store_name = s.store_name; 
