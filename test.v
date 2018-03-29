module test;
reg clk,FRAME,pipeline1,pipeline2,pipeline3,pipeline4,pipeline5;

always @(posedge clk)
begin
pipeline1 <= FRAME ;
pipeline2 <= pipeline1;
pipeline3 <= pipeline2;
pipeline4 <= pipeline3;
pipeline5 <= pipeline4;


end
always
begin
#5
clk=~clk;
end
initial
begin
clk=0;
FRAME=0;
end
endmodule 