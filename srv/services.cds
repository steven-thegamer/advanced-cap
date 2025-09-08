using sap.cap.schema from '../db/schema';

service MainService {

    @odata.draft.enabled
    entity Employees as projection on schema.Employee;
    entity Departments as projection on schema.Department;
    entity Upload as projection on schema.Upload;
}