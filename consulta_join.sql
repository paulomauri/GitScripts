select worker.last_name, manager.last_name from hr.employees worker
join hr.employees mangaer 
on worker.manager_id = manager.employee_id
/
