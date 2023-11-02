`default_nettype none

(* keep_hierarchy *)
module tt_um_seven_segment_seconds #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    assign uo_out [7:1]  = 7'b0;
    assign uio_out [7:0] = 8'b0;
    assign uio_oe [7:0]  = 8'hFF;
    
    (* keep *) wire buff_in;
    (* keep *) wire buff_out;

    assign uo_out[0] = buff_out;
    assign ui_in[0] = buff_in;

    sky130_fd_sc_hd__buf_1 delay0(.X(buff_out),  .A(buff_in));

endmodule
