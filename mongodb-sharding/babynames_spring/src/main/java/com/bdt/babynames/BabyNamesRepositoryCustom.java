package com.bdt.babynames;

import java.util.List;

public interface BabyNamesRepositoryCustom {
    BabyNames insertNew(BabyNames babyNames);
    void updateCount(String id, Integer count);
    void deleteBabyNamesById(String id);
    List<BabyNames> getTopBabyNamesForEachEthnicity();
    List<BabyNames> countBabyForeachEthnicity();
}
