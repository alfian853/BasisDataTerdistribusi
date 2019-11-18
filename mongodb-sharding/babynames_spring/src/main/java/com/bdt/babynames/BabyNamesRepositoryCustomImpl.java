package com.bdt.babynames;


import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.TypedAggregation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import java.util.List;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.*;

public class BabyNamesRepositoryCustomImpl implements BabyNamesRepositoryCustom{

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public BabyNames insertNew(BabyNames babyNames) {
        mongoTemplate.insert(babyNames,"baby_names");
        return babyNames;
    }

    @Override
    public void updateCount(String id, Integer count) {
        Query query = new Query(Criteria.where("id").is(id));
        Update update = new Update();
        update.set("count",count);
        mongoTemplate.updateFirst(query, update, BabyNames.class);
    }

    @Override
    public void deleteBabyNamesById(String id) {
        mongoTemplate.remove(new Query(Criteria.where("id").is(id)), BabyNames.class);
    }

    @Override
    public List<BabyNames> getTopBabyNamesForEachEthnicity() {
        TypedAggregation<BabyNames> aggregation = newAggregation(BabyNames.class,
                sort(Sort.by(Sort.Direction.DESC,"count")),
                group("ethnicity").first("$$ROOT").as("maxData"),
                aggregationOperationContext -> new Document("$addFields",
                        new Document("firstName","$maxData.firstName")
                        .append("_id",null)
                        .append("year","$maxData.year")
                        .append("ethnicity","$maxData.ethnicity")
                        .append("gender","$maxData.ethnicity")
                        .append("count","$maxData.count")
                ),
                project().andExclude("maxData")
        );
        return mongoTemplate.aggregate(aggregation,BabyNames.class).getMappedResults();
    }

    @Override
    public List<BabyNames> countBabyForeachEthnicity() {
        TypedAggregation<BabyNames> aggregation = newAggregation(BabyNames.class,
                group("ethnicity").sum("$count").as("count"),
                aggregationOperationContext -> new Document("$addFields",
                        new Document("ethnicity","$_id")
                ),
                project().andExclude("_id")
        );
        return mongoTemplate.aggregate(aggregation,BabyNames.class).getMappedResults();
    }
}
