using MainService as service from '../../srv/services';
annotate service.Projects with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
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

