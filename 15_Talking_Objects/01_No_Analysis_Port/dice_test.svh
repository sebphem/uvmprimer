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
class dice_test extends uvm_test;
   `uvm_component_utils(dice_test);

   dice_roller dice_roller_h;
   coverage coverage_h;
   histogram histogram_h;
   average average_h;

   function void build_phase(uvm_phase phase);
      coverage_h = new("coverage_h", this);
      histogram_h = new("histogram_h",this);
      average_h     = new("average_h",this);
      dice_roller_h = new("dice_roller_h",this);
   endfunction : build_phase


   //kinda bad because we are procedurally just calling functions and connecting them here
   task run_phase(uvm_phase phase);
      int the_roll;
      phase.raise_objection(this);
      repeat (20) begin
         the_roll = dice_roller_h.two_dice();
         coverage_h.write(the_roll);
         histogram_h.write(the_roll);
         average_h.write(the_roll);
      end
      phase.drop_objection(this);
   endtask : run_phase
   
   function new(string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new
   
endclass : dice_test

