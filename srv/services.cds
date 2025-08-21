using sap.cap.schema from '../db/schema';

service MainService {

    entity Employees as projection on schema.Employee;
    entity Departments as projection on schema.Department;

    @readonly
    entity AllEntities as projection on schema.AllEntities;

}