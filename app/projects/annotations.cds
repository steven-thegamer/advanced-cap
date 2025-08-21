using MainService as service from '../../srv/services';
annotate service.Projects with @(
    UI.LineItem : [
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
        ],
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
    },

    UI.PresentationVariant #mixed: {
        GroupBy : [
            currency
        ],
        Visualizations : [
            '@UI.Chart#alpChart',
            '@UI.LineItem'
        ],

    },

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
    UI.Chart #alpChart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Dimensions : [
            difficulty_code,
        ],
        Measures : [
            price,
        ],
        Title : '{i18n>AllProjectsPricing}',
        
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
        Text : 'Table View',
    },
    UI.Chart #chartView : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bar,
        Dimensions : [
            difficulty_code,
        ],
        Measures : [
            price,
        ],
    },
    UI.SelectionPresentationVariant #chartView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.Chart#chartView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Chart View',
    },
);

