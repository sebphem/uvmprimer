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
class env extends uvm_env;
   `uvm_component_utils(env);

   random_tester     random_tester_h;
   coverage   coverage_h;
   scoreboard scoreboard_h;
   command_monitor command_monitor_h;
   result_monitor  result_monitor_h;
   
   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

   //first this
   function void build_phase(uvm_phase phase);
      //why dont we need to make an instance of the add_tester
      //its because we can just overwrite the random tester with an add tester when we call uvm with add_test
      random_tester_h    = random_tester::type_id::create("random_tester_h",this);
      coverage_h  =  coverage::type_id::create ("coverage_h",this);
      scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
      command_monitor_h   = command_monitor::type_id::create("command_monitor_h",this);
      result_monitor_h = result_monitor::type_id::create("result_monitor_h",this);
      
      
   endfunction : build_phase

   //then this
   function void connect_phase(uvm_phase phase);
      
      result_monitor_h.ap.connect(scoreboard_h.analysis_export);
      command_monitor_h.ap.connect(scoreboard_h.cmd_f.analysis_export);
      command_monitor_h.ap.connect(coverage_h.analysis_export);

   endfunction : connect_phase

   //next would be end of elaboration
   
   //then start of simulation
   
   //then run
   
endclass
   