using MainService as service from '../../srv/services';
annotate service.AllEntities with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : entityName,
            Label : '{i18n>EntityName}',
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
            Label : '{i18n>Description}',
        },
        {
            $Type : 'UI.DataField',
            Value : namespace,
            Label : '{i18n>Namespace}',
        },
        {
            $Type : 'UI.DataField',
            Value : service,
            Label : '{i18n>Service}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>General}',
            ID : 'i18nGeneral',
            Target : '@UI.FieldGroup#i18nGeneral',
        },
    ],
    UI.FieldGroup #i18nGeneral : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : entityName,
                Label : '{i18n>EntityName}',
            },
            {
                $Type : 'UI.DataField',
                Value : Description,
                Label : '{i18n>Description}',
            },
            {
                $Type : 'UI.DataField',
                Value : namespace,
                Label : '{i18n>Namespace}',
            },
            {
                $Type : 'UI.DataField',
                Value : service,
                Label : '{i18n>Service}',
            },
        ],
    },
);

