package com.steven.cap.advanced.upload;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.alibaba.excel.util.ListUtils;
import com.sap.cds.ql.Upsert;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.mainservice.Employees;
import cds.gen.mainservice.Employees_;

public class NoModelDataListener extends AnalysisEventListener<Map<Integer, String>> {

    private PersistenceService db;
    private static final int BATCH_COUNT = 5;
    private List<Map<Integer, String>> cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);


    public NoModelDataListener(PersistenceService db) {
       this.db = db;
   }

    @Override
    public void doAfterAllAnalysed(AnalysisContext arg0) {
        // TODO Auto-generated method stub
        saveData();
    }

    @Override
    public void invoke(Map<Integer, String> data, AnalysisContext context) {
        cachedDataList.add(data);
        if (cachedDataList.size() >= BATCH_COUNT) {
            saveData();
            cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);
        }
    }

    private void saveData() {
        for (int i = 0; i < cachedDataList.size(); i++) {
            Map<Integer, String> map = cachedDataList.get(i);
            Employees employee = Employees.create();
            for (Integer key : map.keySet()) {
                switch (key) {
                    case 0 -> employee.setId(map.get(key));
                    case 1 -> employee.setName(map.get(key));
                    case 2 -> employee.setGenderCode(map.get(key));
                    case 4 -> {
                        LocalDate localDate = LocalDate.parse(map.get(key));
                        employee.setJoinedDate(localDate);
                    }
                    case 5 -> employee.setEmail(map.get(key));
                }
            }
        //  Products updatedProducts = adminService.run(Update.entity(PRODUCTS).data(product)).single(Products.class);
        db.run(Upsert.into(Employees_.CDS_NAME).entry(employee));
        }
    }

}
