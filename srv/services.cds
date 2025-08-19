using sap.cap.schema from '../db/schema';

service MainService @(requries:'authenticated-user') {

    entity Employees @(restrict: [
        {
            grant: ['*'],
            to   : 'Manager_Role'
        },
        {
            grant: ['READ'],
            to   : 'Employee_Role'
        }
    ]) as projection on schema.Employee;
    entity Departments as projection on schema.Department;

}