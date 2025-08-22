using sap.cap.schema from '../db/schema';

service MainService {

    entity Employees as projection on schema.Employee;
    entity Departments as projection on schema.Department;
    entity Projects as projection on schema.Projects;

    @readonly
    entity AllEntities as projection on schema.AllEntities;

}

annotate MainService.Projects with @(
    Aggregation : { ApplySupported  : {
        $Type : 'Aggregation.ApplySupportedType',
        GroupableProperties : [
            name,
            descr,
            difficulty_code
        ],
        AggregatableProperties : [
            {
                Property : price,
            },
            {
                Property : difficulty,
            },
            {
                Property : involvedEmployee,
            },
        ],
            Transformations : [
                'aggregate',
                'topcount',
                'bottomcount',
                'identity',
                'concat',
                'groupby',
                'filter',
                'expand',
                'search'
            ],
    }, 
    CustomAggregate #price : 'Edm.Decimal',
    },
);
