* Lesson 32: Introduction to SAS SQL;
* Example 32.7 The following SAS program uses CASE operator to assign 
  different salary raise plans for each salary range;
libname stat482 "C:\Data_SAS";
proc sql;
	select name, 
		department, 
		employee_annual_salary label = 'salary' format = dollar12.2,
		'next year raise:',
	case
		when employee_annual_salary = . then .
		when employee_annual_salary < 85000 then 0.05
		when 85000 <= employee_annual_salary < 125000 then 0.03
		when employee_annual_salary >= 125000 then 0.01 
	else 0 
		end as raise format = percent8.
	from stat482.salary;
quit;

* Example 32.8 The following program uses the simpler form of CASE construct 
  to decide compensation (Yes or N/A) based on departments:;
* alert, it is case sensitive when department = 'POLICE' ;
proc sql outobs= 20;
	select name,
		department,
		employee_annual_salary label = 'salary' format = dollar12.2,
	case 
		when department = 'POLICE' then 'yes'
		when department = 'fire'  then 'yes'
		else 'N/A' 
		end as compensaion 
	from stat482.salary;
quit;


