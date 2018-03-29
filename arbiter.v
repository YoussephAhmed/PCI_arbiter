module arbiter (clk,REQ,GNT,GLOBAL_FRAME,GLOBAL_IRDY,TRDY_GLOBAL);//(clk,REQ,GNT,GLOBAL_FRAME,GLOBAL_IRDY, 1'b1);


input clk,GLOBAL_IRDY,GLOBAL_FRAME,TRDY_GLOBAL;
input  [7:0] REQ;
output reg [7:0]GNT;
reg [2:0] address_out;
reg [2:0] init_add;
 reg full,empty;
 reg  write_enable=0,read_enable;

wire IDLE ;
assign IDLE = GLOBAL_FRAME & GLOBAL_IRDY ;

//encoder E1(REQ, init_add);

//FIFO F1(clk,init_add,address_out,write_enable,read_enable,full,empty);


always@(posedge clk)
begin 

if(IDLE/*&&(GNT==8'b11111111)*/&&!empty)
begin
read_enable=1;
@(negedge clk)

begin

case(address_out)
3'b000:GNT=8'b11111110;
3'b001:GNT=8'b11111101;
3'b010:GNT=8'b11111011;
3'b011:GNT=8'b11110111;
3'b100:GNT=8'b11101111;
3'b101:GNT=8'b11011111;
3'b110:GNT=8'b10111111;
3'b111:GNT=8'b01111111;
//3'bx:GNT=11111111;

default:GNT=8'b11111111;
endcase

read_enable=0;
end

end
end

always@(REQ)
begin
@(negedge REQ[0])

begin
init_add<=3'b000;
write_enable=1;
end

@(negedge REQ[1])

begin
init_add<=3'b001;
write_enable=1;
end

begin
@(negedge REQ[2])
init_add<=3'b010;
write_enable=1;
end

@(negedge REQ[3])
begin
init_add<=3'b011;
write_enable=1;
end

@(negedge REQ[4])
begin
init_add<=3'b100;
write_enable=1;
end


@(negedge REQ[5])
begin
init_add<=3'b101;
write_enable=1;
end


@(negedge REQ[6])
begin
init_add<=3'b110;
write_enable=1;
end

begin
@(negedge REQ[7])
init_add<=3'b111;
write_enable=1;
end



end



///////////////////////////////////////////////////////////////////////////////////////////////////
reg [2:0] buffer [0:31];
reg [4:0]pointer=0;
integer i;


always@(posedge clk)//kda data da5la el FIFO
begin
      if(write_enable/*&&(init_add!=buffer[pointer])*/)
	begin
	empty=0;
	buffer[pointer]=init_add;
	pointer=pointer+1;
	write_enable=0;
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////
initial
begin
GNT=8'b11111111;
end
endmodule 
/*
initial
begin

GNT<=11111111;
#1;
end
*/