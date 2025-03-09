module SPImaster_tb();
reg clk;
reg rst;
reg start_tx;
reg start_rx;
wire sclk;
wire mosi;
reg miso;
wire  ss;
reg [7:0] data_tx;
wire [7:0]data_rx;

SPImaster u0(
    .clk(clk),
    .rst(rst),
    .start_tx(start_tx),
    .start_rx(start_rx),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso),
    .ss(ss),
    .data_tx(data_tx),
    .data_rx(data_rx)
);

initial begin
    clk=0; //generate clock
    forever #5 clk=~clk;
end 
initial begin
    $dumpfile("SPImaster.vcd");
    $dumpvars(0,SPImaster_tb);
    $monitor("Time=%0t | clk=%b | sclk=%b | ss=%b | mosi=%b | miso=%b | data_master_tx=%b  data_master_rx=%b |",
    $time, clk, sclk, ss, mosi, miso, data_tx, data_rx);
    
    rst=1;
    start_rx=1'b0;
    start_tx= 1'b0;
    #10;
    rst=~rst;
    start_tx=1'b1;
    data_tx=8'b10101010;
    #200;
    start_tx=1'b0;
    start_rx=1'b1;
    miso=1;
    #1;
    miso=1;
    #1;
    miso=1;
    #1;
    miso=1;
    #1;
    miso=1;
    #400;
    start_rx=0;
    #10
    $finish;

end


endmodule