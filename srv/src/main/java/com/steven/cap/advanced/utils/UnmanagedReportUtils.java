package com.steven.cap.advanced.utils;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import org.apache.commons.lang3.builder.CompareToBuilder;

import com.sap.cds.ql.cqn.CqnElementRef;
import com.sap.cds.ql.cqn.CqnSortSpecification;

import cds.gen.mainservice.AllEntities;

public class UnmanagedReportUtils {

    private static final Map<String, Function<AllEntities, ?>> SORT_MAP;
    static {
        Map<String, Function<AllEntities, ?>> sortParameter = new HashMap<>();
        sortParameter.put("entityName", AllEntities::getEntityName);
        sortParameter.put("Description", AllEntities::getDescription);
        sortParameter.put("service", AllEntities::getService);
        sortParameter.put("namespace", AllEntities::getNamespace);
        SORT_MAP = Collections.unmodifiableMap(sortParameter);
    }

    public static List<AllEntities> sort(List<CqnSortSpecification> select, List<AllEntities> entities){
        if (entities == null || entities.isEmpty() || select == null || select.isEmpty()) return entities;
        entities.sort( (entity1, entity2) -> {
            CompareToBuilder compareToBuilder = new CompareToBuilder();
            for (CqnSortSpecification sort : select){
                CqnElementRef elementRef = (CqnElementRef) sort.value();
                String sortKey = elementRef.displayName();
                String order = sort.order().sort;
                if ("desc".equals(order)){
                    Object parameter1 = SORT_MAP.get(sortKey).apply(entity1);
                    Object parameter2 = SORT_MAP.get(sortKey).apply(entity2);
                    compareToBuilder.append(parameter2,parameter1);
                }
                else if ("asc".equals(order)){
                    Object parameter1 = SORT_MAP.get(sortKey).apply(entity1);
                    Object parameter2 = SORT_MAP.get(sortKey).apply(entity2);
                    compareToBuilder.append(parameter1,parameter2);
                }
            }
            return compareToBuilder.toComparison();
        } );
        return entities;
    }

    public static List<? extends Map<String, ?>> getTopSkip(long top, long skip,
            List<? extends Map<String, ?>> entities) {
        int topInt = (int) top;
        int skipInt = (int) skip;

        if (topInt == 0) {
            return entities;
        } else {
            if (entities.size() >= topInt) return entities.subList(skipInt, topInt - 1);
            else return entities.subList(skipInt, entities.size());
        }

    }
}