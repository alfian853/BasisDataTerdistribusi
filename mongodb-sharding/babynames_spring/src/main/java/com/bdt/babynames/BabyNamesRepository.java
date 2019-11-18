package com.bdt.babynames;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface BabyNamesRepository extends MongoRepository<BabyNames, String>, BabyNamesRepositoryCustom {
}
