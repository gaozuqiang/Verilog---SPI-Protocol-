module SPImaster (
    input  wire clk,       // System clock
    input  wire rst,       // Reset signal
    input wire start_tx,   // Start signal to transmit data
    input wire start_rx,   // Start signal to receive data
    output reg sclk,       // SPI clock
    output reg mosi,       // Master Out, Slave In
    input  wire miso,      // Master In, Slave Out
    output reg ss,         // Slave Select (Active Low)
    input [7:0] data_tx,   // Data to be transmitted
    output reg [7:0] data_rx  // Data received
);

reg [3:0] count;           // Transmission bit counter
reg [7:0] shift_rx;        // Shift register for received data
reg [7:0] shift_tx;        // Shift register for transmitted data
reg transmit;

// SPI Clock: Active only during transmission
always @(posedge clk or posedge rst) begin
    if (rst) begin
        sclk <= 1'b0;
    end
    else sclk <= ~sclk; 
end

// SPI Transmission and Reception
always @(posedge sclk or posedge rst) begin
    if (rst) begin
        ss <= 1'b1;
        mosi <= 1'b0;
        data_rx <= 8'b00000000;
        count <= 4'b1000;
    end
    else if (start_tx & count>0) begin
        ss <= 1'b0;
        mosi<=data_tx[count-1];
        count <= count - 1'b1;
    end
    else if (start_rx) begin
        ss <= 1'b0;
        data_rx <= {data_rx[6:0], miso}; // Receive data from slave
    end
    else if (!start_rx && !shift_tx)begin
        ss <= 1'b1;
    end
end

endmodule

