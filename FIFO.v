module FIFO (clk,address_in,address_out,write_enable,read_enable,full,empty);

input clk,write_enable,read_enable;
input wire [2:0] address_in;

output reg [2:0] address_out;
output reg full,empty;
reg [2:0] buffer [0:31];
reg [4:0]pointer=0;
integer i;
always@(posedge clk)//kda data da5la el FIFO
begin
      if(write_enable/*&&(address_in!=buffer[pointer])*/)
	begin
	empty=0;
	buffer[pointer]=address_in;
	pointer=pointer+1;
	end
end 

always@(negedge clk)//kda data tal3a bra el FIFO
begin
      if(read_enable)
	begin
	address_out=buffer[0];
	for(i=0;i<pointer;i=i+1)
	   begin
	   buffer[i]=buffer[i+1];
	   end
	  i=0;
	pointer=pointer-1;
	end
if(pointer==0)
begin
empty=1;
full=0;
end
else if(pointer==30)
begin
empty=0;
full=1;
end 
else if((pointer>0)&&(pointer<30))
begin
empty=0;
full=0;
end
end 






endmodule 

//////////////////////////////////////////////////////////////////////////////////////
module FIFO_tb;

reg clk,write_enable,read_enable;
reg [2:0] address;
wire [2:0] data;
wire full,empty;
always 
begin
#5
clk=~clk;
end
initial
begin
clk<=0;
write_enable<=1;
address<=0;



#10
address<=1;
#10
address<=2;
#10
address<=3;
#10
//write_enable<=0;
read_enable<=1;

end

FIFO F1(clk,address,data,write_enable,read_enable,full,empty);
endmodule 

