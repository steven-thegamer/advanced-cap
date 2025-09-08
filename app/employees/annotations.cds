using MainService as service from '../../srv/services';
annotate service.Employees with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : '{i18n>Id}',
        },
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : '{i18n>Name}',
        },
        {
            $Type : 'UI.DataField',
            Value : gender_code,
            Label : '{i18n>Gender}',
        },
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
            Label : 'Department',
            ID : 'Department',
            Target : '@UI.FieldGroup#Department',
        },
    ],
    UI.FieldGroup #i18nGeneral : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : 'name',
            },
            {
                $Type : 'UI.DataField',
                Value : joinedDate,
                Label : 'joinedDate',
            },
            {
                $Type : 'UI.DataField',
                Value : gender_code,
                Label : 'gender_code',
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : 'email',
            },
        ],
    },
    UI.FieldGroup #General : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.FieldGroup #Department : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : department.title,
                Label : 'title',
            },
            {
                $Type : 'UI.DataField',
                Value : department.description,
                Label : 'description',
            },
        ],
    },
    UI.FieldGroup #Photo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : photo.photo,
                Label : 'photo',
            },
            {
                $Type : 'UI.DataField',
                Value : photo.submittedAt,
                Label : 'submittedAt',
            },
        ],
    },
);

