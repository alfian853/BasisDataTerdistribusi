package com.bdt.babynames;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/baby_names")
public class BabyNamesController {

    @Autowired
    BabyNamesRepository repository;

    @GetMapping("/{id}")
    BabyNames findById(@PathVariable("id") String id){
        BabyNames result = repository.findById(id).orElse(null);
        assert result == null;
        return result;
    }

    @PostMapping
    BabyNames postBabyNames(@RequestBody BabyNames babyNames){
        repository.insertNew(babyNames);
        return babyNames;
    }

    @PutMapping("/{id}")
    boolean editBabyNamesCount(@PathVariable("id") String id, @RequestParam("count") Integer count){
        repository.updateCount(id, count);
        return true;
    }

    @DeleteMapping("/{id}")
    boolean deleteBabyName(@PathVariable("id") String id){
        repository.deleteById(id);
        return true;
    }

    @GetMapping("/top_names")
    List<BabyNames> getTopBabyNamesForEachEthnicity(){
        return repository.getTopBabyNamesForEachEthnicity();
    }

    @GetMapping("/sum_names")
    List<BabyNames> countEthnicity(){
        return repository.countBabyForeachEthnicity();
    }
}
