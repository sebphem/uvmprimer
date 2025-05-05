# notes

## polymorphism

- if you have two instances of an extension to a class, you can store the same information in them with different behavior/implementations of functions 



## Real vs virtual classes

Real class
- All of the functions are well defined
- If inheriting from a child class, real functions in the real class will overwrite real functions from the child


Virtual class
- Functions have default implementations
- If inheriting functions from child class, all the virtual 


Base class non virtual with same function signature takes over if the function is not virtual


If a function is pure virtual, this means that the base  (parent) class won't even have an implementation

```systemverilog
pure virtual
```

You can't make an instance of the virtual class

```systemverilog
virtual class animal;

endclass;
```