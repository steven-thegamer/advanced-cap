using sap.cap.schema from '../db/schema';

service MainService {
    entity Employees as projection on schema.Employee {
        Employee.*,
        CASE
        WHEN SUM(Employee.projects.price) != NULL THEN SUM(Employee.projects.price)
        ELSE 0
        END as NetWorth : Decimal
    } group by Employee.ID;
    entity Departments as projection on schema.Department;
    @readonly entity Projects as projection on schema.Projects;
}