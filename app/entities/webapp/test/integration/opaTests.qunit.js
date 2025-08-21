sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'entities/test/integration/FirstJourney',
		'entities/test/integration/pages/AllEntitiesList',
		'entities/test/integration/pages/AllEntitiesObjectPage'
    ],
    function(JourneyRunner, opaJourney, AllEntitiesList, AllEntitiesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('entities') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheAllEntitiesList: AllEntitiesList,
					onTheAllEntitiesObjectPage: AllEntitiesObjectPage
                }
            },
            opaJourney.run
        );
    }
);