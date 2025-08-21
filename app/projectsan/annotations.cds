using MainService as service from '../../srv/services';
annotate service.Projects with @(
    UI.KPI #PriceKPI : {
        $Type : 'UI.KPIType',
        DataPoint : ![@UI.DataPoint#PriceTarget],
        SelectionVariant : {
            SelectOptions : [
                {
                    $Type : 'UI.SelectOptionType',
                    PropertyName : price,
                    Ranges : [
                        {
                            $Type : 'UI.SelectionRangeType',
                            Sign : #I,
                            Option : #GT,
                            Low : 0,
                        },
                    ],
                },
            ],
        },
        Detail : {
            $Type : 'UI.KPIDetailType',
            DefaultPresentationVariant : ![@UI.PresentationVariant#KPI],
        },
    },
    UI.DataPoint #PriceTarget : {
        $Type : 'UI.DataPointType',
        Title : '{i18n>PriceKpi}',
        Description : '{i18n>PricesInProjects}',
        Value : price,
        Criticality : #Neutral,
    },

    UI.PresentationVariant #KPI: {
                $Type         : 'UI.PresentationVariantType',
                Visualizations: [
                                // '@UI.LineItem',
                                ![@UI.Chart#chartAverage],],
                Text          : 'Price Average'
            },

);

