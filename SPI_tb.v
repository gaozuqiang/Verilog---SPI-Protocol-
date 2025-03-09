module SPI_tb;
    reg clk;
    reg rst; 
    reg master_start_rx;
    reg master_start_tx;
    reg slave_start_tx; 
    reg [7:0] data_master_tx;//master data to transmit
    reg [7:0] data_slave_tx; //slave data to transmit
    wire sclk; 
    wire mosi; 
    wire miso; 
    wire ss;
    wire [7:0]data_slave_rx; // slave recieve
    wire [7:0]data_master_rx; // master recieve

SPImaster master(
    .clk(clk),
    .rst(rst),
    .start_tx(master_start_tx),
    .start_rx(master_start_rx),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso),
    .ss(ss),
    .data_tx(data_master_tx),
    .data_rx(data_master_rx)
);

SPIslave slave(
    .sclk(sclk),
    .ss(ss),
    .start(master_start_rx),
    .mosi(mosi),
    .miso(miso),
    .data_rx(data_slave_rx),
    .data_tx(data_slave_tx)
);
initial begin
    clk=0; //generate clock
end
always #5 clk=~clk;

initial begin
    $dumpfile("SPI.vcd");
    $dumpvars(0,SPI_tb);
    $monitor("Time=%0t | clk=%b | sclk=%b | ss=%b | mosi=%b | miso=%b | data_master_tx=%b | data_master_rx=%b | data_slave_tx=%b | data_slave_rx=%b",
    $time, clk, sclk, ss, mosi, miso, data_master_tx, data_master_rx, data_slave_tx, data_slave_rx);
    rst=1;
    #5;
    rst=0;
    master_start_tx=1;
    data_master_tx= 8'b10101010;
    #165;
    master_start_rx=1;
    data_slave_tx=8'b11111111;
    #175;
    $finish;

end
    
endmodule
