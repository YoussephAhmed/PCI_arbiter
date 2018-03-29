module SimpleInitiator (start,clk,REQ,GNT,FRAME,IRDY,I_AM_OWNER , GLOBAL_IRDY,GLOBAL_FRAME);

input wire clk,GNT,start;
input wire GLOBAL_IRDY , GLOBAL_FRAME;
output reg REQ = 1,FRAME = 1,I_AM_OWNER = 0,IRDY =1  ;

integer counter = 0;

wire IDLE ;
assign IDLE = GLOBAL_FRAME & GLOBAL_IRDY ;

reg pipeline1 =1,pipeline2 =1,pipeline3 =1,pipeline4 =1,pipeline5 = 1 ;

always @(posedge clk)
begin
if(start & (GNT) & FRAME)
begin
	@(negedge clk)
	REQ<=0;
end
else if ((~GNT)  && IDLE & (~ REQ) )
begin
	@(negedge clk)
	REQ<=1;
	FRAME <= 0 ;
end
else if(~ pipeline4 && pipeline5)
begin
@(negedge clk)
FRAME <=1 ;
end


end

always @(posedge clk)
begin

if(~ pipeline1 && pipeline2)
begin
@(negedge clk)
IRDY <= 0;
end

else if (~ pipeline5)
begin
@(negedge clk)
IRDY <=1;
end

end


always @(posedge clk)
begin

 if ((~GNT)  && IDLE & (~ REQ) )
begin
	@(negedge clk)
	I_AM_OWNER<=1;
end
else if (~ pipeline5)
begin
@(negedge clk)
I_AM_OWNER<=0;
end

end


always @(posedge clk)
begin
pipeline1 <= FRAME ;
pipeline2 <= pipeline1;
pipeline3 <= pipeline2;
pipeline4 <= pipeline3;
pipeline5 <= pipeline4;


end


endmodule
