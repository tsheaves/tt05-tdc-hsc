`default_nettype none

module tt_um_seven_segment_seconds(
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    localparam n = 4;
    assign uo_out  [7:n]  = 4'b0;
    assign uio_out [7:0]  = 8'b0;
    assign uio_oe  [7:0]  = 8'b0;

    genvar i;
    wire [n:0] conn;
    wire [n-1:0] out_r;
    wire launch_clk, capture_clk;
    reg pulse_in;

    assign launch_clk  = ui_in[1];
    assign capture_clk = ui_in[2];
    
    always@(posedge launch_clk) begin
        pulse_in <= ui_in[0];
    end

    assign conn[0] = pulse_in;

    generate
        for (i = 0; i<n; i+=1) begin : gen_cells
            sky130_fd_sc_hd__buf_1 buff0(
                .X(conn[i+1]),  
                .A(conn[i])
            );
            sky130_fd_sc_hd__dfbbp_1 dfbbp0(
                .Q(out_r[i]),
                .Q_N(),
                .D(conn[i+1]),
                .CLK(capture_clk),
                .SET_B(1'b1),
                .RESET_B(rst_n)
            );
        end
    endgenerate
    
    assign uo_out[n-1:0] = out_r;
                
endmodule
