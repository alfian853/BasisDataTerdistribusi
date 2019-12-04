package com.bdt.babynames;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/baby_names")
public class BabyNamesController {

    @Autowired
    BabyNamesRepository repository;

    @GetMapping("/{id}")
    BabyNames findById(@PathVariable("id") Integer id){
        BabyNames result = repository.findById(id).orElse(null);
        assert result == null;
        return result;
    }

    @PostMapping
    BabyNames postBabyNames(@RequestBody BabyNames babyNames){
        repository.save(babyNames);
        return babyNames;
    }

    @PutMapping("/{id}")
    boolean editBabyNamesCount(@PathVariable("id") Integer id, @RequestParam("count") Integer count){
        BabyNames babyNames = repository.findById(id).get();
        babyNames.setCount(count);
        repository.save(babyNames);
        return true;
    }

    @DeleteMapping("/{id}")
    boolean deleteBabyName(@PathVariable("id") Integer id){
        repository.deleteById(id);
        return true;
    }

}
