module SPIslave_tb();
reg start;
reg sclk;
reg ss;
reg mosi;
wire miso;
reg [7:0] data_tx;
wire [7:0]data_rx;

SPIslave u0(
    .start(start),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso),
    .ss(ss),
    .data_tx(data_tx),
    .data_rx(data_rx)
);

initial begin
    sclk=0; //generate clock
    forever #5 sclk=~sclk;
end 
initial begin
    $dumpfile("SPIslave.vcd");
    $dumpvars(0,SPIslave_tb);
    $monitor("Time=%0t | sclk=%b | ss=%b | mosi=%b | miso=%b | data_slave_tx=%b |data_slave_rx=%b |",
    $time, sclk, ss, mosi, miso, data_tx, data_rx);
    ss<=1;
    #10;
    ss<=0;
    mosi=1;
    #5
    mosi=1;
    #5
    mosi=1;
    #5
    mosi=1;
    #5
    mosi=1;
    #5
    mosi=1;
    #5
    mosi=1;
    #5
    mosi=1;
    #50;
    start=1;
    data_tx= 8'b10101010;
    #200;
    $finish;

end


endmodule