module SPIslave (
    input  wire sclk,      // SPI Clock from Master
    input  wire ss,        // Slave Select (Active Low)
    input  wire start,      // start transmit data
    input  wire mosi,      // Master Out, Slave In
    output reg miso,      // Master In, Slave Out
    input  [7:0]data_tx,     // data to be transmited from slave to master
    output reg [7:0]data_rx     // data to be received to be displayed
);
    reg [3:0] count;          // Bit counter

    always @(posedge sclk or posedge ss) begin
        if (ss) begin //slave not active 
            count<=4'b1000;
            miso<=0;
            data_rx<=8'b00000000;
        end
        else if (start && ~ss && count>0) begin //active slave start transmiting data
            miso<=data_tx[count-1];
            count<=count - 1'b1;
        end
        else if(~ss)begin //active slave receiving data
            data_rx<={data_rx[6:0],mosi};
        end 
    end
endmodule
