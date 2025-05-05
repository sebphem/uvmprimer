# notes

In the following example, making something static in a class changes it from having a copy in one instance of the class to it being shared across every instance of the class.

```systemverilog
class animal_cage #(type T);

   protected static T cage[$];

   static function void cage_animal(T l);
      cage.push_back(l);
   endfunction : cage_animal

   static function void list_animals();
      $display("Animals in cage:"); 
      foreach (cage[i])
        $display(cage[i].get_name());
   endfunction : list_animals

endclass : animal_cage
```

## static methods

methods that can be called from an object instead of by an instance

In python, this doesn't require making an instance, as the default object should be able to understand how to perform it

## class method

methods that can only be called from an instance and not the generic class


## protected

this just means that you cannot call the variable directly, it must come from a function within the class