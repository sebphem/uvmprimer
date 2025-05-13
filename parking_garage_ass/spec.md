## Practice Problem — Parking‑Garage Ticket Machine FSM

### Objective

Design a synchronous finite‑state machine that runs the control logic for an automated parking‑garage ticket machine. The machine issues tickets on entry, tracks time parked, calculates the fee, and raises the exit gate when payment is received.

### System‑level Behavior

1. **Entry lane**

   * A vehicle drives up to the entry sensor.
   * The driver presses a *REQUEST* button.
   * If paper is available, the machine prints a time‑stamped ticket, turns on a green *TAKE\_TICKET* light, and waits until the ticket is removed.
   * The entry gate opens, stays open for 5 s, then closes.
   * If paper is out, the machine flashes a red *OUT\_OF\_SERVICE* light and keeps the gate closed.

2. **Exit lane**

   * A vehicle drives up to the exit sensor.
   * The driver inserts the ticket; the machine reads the entry timestamp.
   * It computes the fee:

     * **First 30 min:** free
     * **>30 min and ≤2 h:** \$4 flat
     * **>2 h:** \$4 + \$2 for each additional started hour
     * **Max daily charge:** \$20
   * The fee is shown on a seven‑segment *FEE\_DISPLAY*.
   * The driver pays with \$2 and \$4 bills via a bill acceptor (no change given).
   * When the total paid ≥ fee, the *THANK\_YOU* light blinks twice and the exit gate opens for 5 s.
   * If the ticket is unreadable, the *SEE\_ATTENDANT* light turns on and the gate stays closed.

### Inputs (synchronous to `clk`, active high unless noted)

| Name               | Width | Description                           |
| ------------------ | ----- | ------------------------------------- |
| `clk`              | 1     | System clock (100 MHz)                |
| `reset_n`          | 1     | Asynchronous active‑low reset         |
| `entry_sensor`     | 1     | Car present at entry                  |
| `exit_sensor`      | 1     | Car present at exit                   |
| `request_btn`      | 1     | Driver presses entry “REQUEST”        |
| `ticket_removed`   | 1     | Ticket pulled from slot               |
| `ticket_inserted`  | 1     | Ticket inserted at exit               |
| `ticket_ok`        | 1     | Ticket timestamp read successfully    |
| `paper_empty`      | 1     | No paper in printer                   |
| `bill_2`           | 1     | \$2 bill accepted pulse               |
| `bill_4`           | 1     | \$4 bill accepted pulse               |
| `timeout_5s`       | 1     | Asserted by 5‑second timer module     |
| `parking_time_min` | 15    | Minutes parked (from real‑time clock) |

### Outputs

| Name                  | Width | Description                         |
| --------------------- | ----- | ----------------------------------- |
| `printer_cmd`         | 1     | Pulse to print ticket               |
| `take_ticket_lamp`    | 1     | Solid green until ticket is removed |
| `out_of_service_lamp` | 1     | Flashes 2 Hz when paper empty       |
| `entry_gate`          | 1     | Drives entry gate motor (1=open)    |
| `exit_gate`           | 1     | Drives exit gate motor (1=open)     |
| `fee_display`         | 8     | BCD value sent to 7‑segment driver  |
| `thank_you_lamp`      | 1     | Blink twice when paid               |
| `see_attendant_lamp`  | 1     | Solid on unreadable ticket          |

### Timing & Counters

* Use a free‑running 100 MHz clock.
* Implement a 5‑second timer triggered whenever either gate is commanded to open.
* Implement a debounce/synchronizer for `request_btn`.
* Monetary totals fit in a 6‑bit unsigned register (max \$63).

### Required States (minimum)

| Mnemonic      | Purpose                          |
| ------------- | -------------------------------- |
| `IDLE_E`      | Waiting at entry                 |
| `PRINT`       | Printing ticket                  |
| `WAIT_TAKE`   | Waiting for ticket removal       |
| `E_GATE_OPEN` | Entry gate opening / 5 s window  |
| `IDLE_X`      | Waiting at exit                  |
| `CALC_FEE`    | Compute parking cost             |
| `WAIT_PAY`    | Accepting bills                  |
| `X_GATE_OPEN` | Exit gate opening / 5 s window   |
| `ERROR`       | Paper empty or unreadable ticket |

Feel free to add substates for lamp flashing or payment counting.

### Deliverables

1. `ticket_fsm.sv`—Mealy or Moore FSM with an enum‑typed state register.
2. Parameterizable fee computation function.
3. A timer module (`timer_5s.sv`) you instantiate in the FSM.
4. Self‑checking testbench (`tb_ticket_fsm.sv`) that covers at least:

   * Normal entry → exit within 25 min (free).
   * Stay 90 min → pay \$4 with two \$2 bills.
   * Stay 5 h → ensure max charge \$20.
   * Paper empty at entry.
   * Unreadable ticket at exit.
   * Multiple cars queuing at both lanes.

### Constraints & Style

* Use `typedef enum logic [3:0]` for states.
* Register all outputs except simple lamps; lamps may be combinational from state bits.
* No `#delays`; use real timers or counters.
* Use synthesis‑friendly constructs (`always_ff`, `always_comb`).
* Provide `covergroup` or simple assertions that each state is reached in the testbench.

---

That should give you a realistic, multi‑path FSM to implement and test. Good luck—let me know if you’d like follow‑up hints or a review of your code once you have something written.
