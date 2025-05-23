/*
   Copyright 2013 Ray Salemi

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
class add_test extends random_test;
   `uvm_component_utils(add_test);

   
   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      //set the type of random tester to be add_tester
      random_tester::type_id::set_type_override(add_tester::get_type());
      // start the build phase of the random tester THAT CALLS RANDOM_TEST
      // RANDOM TEST CREATES ENV WHICH CREATES RANDOM_TESTER WHICH IS ACTUALLY ADD TESTER
      super.build_phase(phase);
   endfunction : build_phase
  
endclass
   