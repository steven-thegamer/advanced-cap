using MainService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Employees with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : '{i18n>Name}',
        },
        {
            $Type : 'UI.DataField',
            Value : joinedDate,
            Label : '{i18n>JoinedDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : department_ID,
        },
    ],
    UI.SelectionFields : [
        name,
        gender_code,
        department_ID,
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>General}',
            ID : 'i18nGeneral',
            Target : '@UI.FieldGroup#i18nGeneral',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Department}',
            ID : 'i18nDepartment',
            Target : '@UI.FieldGroup#i18nDepartment',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>ProjectsInvolved}',
            ID : 'i18nProjectsInvolved',
            Target : 'projects/@UI.LineItem#i18nProjectsInvolved',
        },
    ],
    UI.FieldGroup #i18nGeneral : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : joinedDate,
                Label : '{i18n>JoinedDate}',
            },
            {
                $Type : 'UI.DataField',
                Value : gender_code,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : '{i18n>Email}',
            },
        ],
    },
    UI.FieldGroup #i18nDepartment : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : department.title,
                Label : '{i18n>DepartmentName}',
            },
            {
                $Type : 'UI.DataField',
                Value : department.description,
                Label : '{i18n>DepartmentDescription}',
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>Employee}',
        TypeNamePlural : '{i18n>Employees}',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
    },
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>AllEmployeesByDepartment}',
    },
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : joinedDate,
            Label : '{i18n>JoinedDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : gender_code,
        },
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>AllEmployeesByGender}',
    },

    Aggregation : { ApplySupported  : {
        $Type : 'Aggregation.ApplySupportedType',
        GroupableProperties : [
            ID,
            name,
            email,
            gender_code,
            joinedDate,
            projects,
            department
        ],
    }, },

);

annotate service.Employees with {
    name @Common.Label : '{i18n>Name}';
    gender @Common.Label : '{i18n>Gender}';
};

annotate service.Employees with {
    department @(
        Common.Label : '{i18n>Department}',
        Common.ExternalID : department.title,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Departments',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : department_ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : '{i18n>Department}',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Departments with {
    title @Common.Text : description
};

annotate service.Projects with @(
    UI.LineItem #i18nProjectsInvolved : [
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : descr,
        },
        {
            $Type : 'UI.DataField',
            Value : difficulty_code,
            Label : '{i18n>Difficulty}',
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            Label : '{i18n>Price}',
        },
    ]
);

