package com.steven.cap.advanced;

import java.io.InputStream;
import java.util.Arrays;

import org.springframework.stereotype.Component;

import com.alibaba.excel.EasyExcel;
import com.sap.cds.services.cds.CdsUpdateEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import com.steven.cap.advanced.upload.NoModelDataListener;

import cds.gen.mainservice.Upload;
import cds.gen.mainservice.Upload_;

@Component
@ServiceName("MainService")
public class BatchFileHandler implements EventHandler {

    private final PersistenceService db;

    BatchFileHandler(PersistenceService db) {
        this.db = db;
    }

    @On(entity = Upload_.CDS_NAME, event = CqnService.EVENT_READ)
    public Upload getUploadSingleton() {
        return Upload.create();
    }

    @On
    public void handle_excel(CdsUpdateEventContext context, Upload upload) {
        InputStream is = upload.getFile();
        if (is != null) {
           //  EasyExcel.read(is, Products.class, new ProductListener()).sheet().doRead();
           EasyExcel.read(is, new NoModelDataListener(db)).sheet().doRead();
        };
      context.setResult(Arrays.asList(upload));
    }

}
