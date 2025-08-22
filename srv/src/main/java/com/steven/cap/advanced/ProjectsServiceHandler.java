package com.steven.cap.advanced;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ResultBuilder;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnPredicate;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.steven.cap.advanced.utils.CheckDataVisitor;

import cds.gen.mainservice.MainService_;
import cds.gen.mainservice.Projects;
import cds.gen.mainservice.Projects_;

@Component
@ServiceName(MainService_.CDS_NAME)
public class ProjectsServiceHandler implements EventHandler {

    @Autowired
    CqnService mainService;

    @On(event = CqnService.EVENT_READ, entity = Projects_.CDS_NAME)
    public void getProjects(CdsReadEventContext context) {
        List<Projects> resultList = new ArrayList<>();
        CqnSelect cqnSelect = context.getCqn();

        // CqnSelect selectCopy = CQL.copy(select, new Modifier() {
        //     @Override
        //     public CqnStructuredTypeRef ref(CqnStructuredTypeRef ref) {
        //         // return CQL.to(Orders_.CDS_NAME).asRef();
        //         return CQL.entity(Projects_.class).asRef();
        //     }
        // });

        // context.setResult(mainService.run(selectCopy));

        CqnSelect select = Select.from(Projects_.class);

        Result result = mainService.run(select);
        result.forEach((row) -> {
            Projects resultRow = Projects.create();

            resultRow.setName(row.get("name").toString());
            resultRow.setCurrencyCode(row.get("currency_code").toString());
            resultRow.setDescr(row.get("descr").toString());
            resultRow.setDifficultyCode(row.get("difficulty_code").toString());
            resultRow.setId(row.get("ID").toString());
            BigDecimal priceValue = new BigDecimal(row.get("price").toString());;
            resultRow.setPrice(priceValue);
            resultRow.setInvolvedEmployeeId(row.get("involvedEmployee_id").toString());

            // filter
            CheckDataVisitor checkDataVisitor = new CheckDataVisitor(resultRow);
            try {
                CqnPredicate cqnPredicate = cqnSelect.where().get();
                cqnPredicate.accept(checkDataVisitor);
                if (checkDataVisitor.matches()) {
                    resultList.add(resultRow);
                }
            } catch (Exception e) {
                // No where conditions
                resultList.add(resultRow);
            }
        });

        long inlineCount = resultList.size();

        Result finalResult = ResultBuilder.selectedRows(resultList).inlineCount(inlineCount).result();
        context.setResult(finalResult);

    }

}
