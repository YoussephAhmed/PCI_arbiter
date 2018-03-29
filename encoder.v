

module encoder(REQ, output_binary);

input wire [7:0] REQ;

output reg [2:0] output_binary;

always@(REQ)
begin
@(negedge REQ[0])
output_binary<=3'b000;
@(negedge REQ[1])
output_binary<=3'b001;
@(negedge REQ[2])
output_binary<=3'b010;
@(negedge REQ[3])
output_binary<=3'b011;
@(negedge REQ[4])
output_binary<=3'b100;
@(negedge REQ[5])
output_binary<=3'b101;
@(negedge REQ[6])
output_binary<=3'b110;
@(negedge REQ[7])
output_binary<=3'b111;
end
endmodule


module encoder_tb;

reg [7:0] input_dec;

wire [2:0] output_binary;


initial
begin

$monitor("input = %d , output = %b " , input_dec , output_binary);


#10 input_dec = 5;
#10 input_dec = 3;
#10 input_dec = 7;







end

encoder encoder1(input_dec, output_binary);
endmodule 