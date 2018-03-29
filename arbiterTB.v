module arbiterTB;

reg clk ;
wire [7:0] GNT;

wire [7:0] FRAMES , IRDYS, I_AM_OWNERS;
wire GLOBAL_IRDY , GLOBAL_FRAME;
wire [7:0]REQ;
reg [7:0] STARTS = 8'h00;


always 
begin
#5
clk <= ~ clk;
end

initial 
begin
clk <= 0 ;

# 20
STARTS[0] <= 1 ;

#20
STARTS[1] <=1;
#20
STARTS[2] <=1;
#20
STARTS[3] <=1;



#20 
STARTS[5] <=1;
#20
STARTS[7] <=1;
STARTS[1] <=0;
STARTS[0] <=0;
# 200
STARTS[3] <=0;
end

SpecializedMux myMux(I_AM_OWNERS,IRDYS,FRAMES,GLOBAL_IRDY,GLOBAL_FRAME);

arbiter A(clk,REQ,GNT,GLOBAL_FRAME,GLOBAL_IRDY, 1'b1);

SimpleInitiator simple0 (STARTS[0],clk,REQ[0],GNT[0],FRAMES[0],IRDYS[0],I_AM_OWNERS[0] , GLOBAL_IRDY,GLOBAL_FRAME);
SimpleInitiator simple1 (STARTS[1],clk,REQ[1],GNT[1],FRAMES[1],IRDYS[1],I_AM_OWNERS[1] , GLOBAL_IRDY,GLOBAL_FRAME);
SimpleInitiator simple2 (STARTS[2],clk,REQ[2],GNT[2],FRAMES[2],IRDYS[2],I_AM_OWNERS[2] , GLOBAL_IRDY,GLOBAL_FRAME);
SimpleInitiator simple3 (STARTS[3],clk,REQ[3],GNT[3],FRAMES[3],IRDYS[3],I_AM_OWNERS[3] , GLOBAL_IRDY,GLOBAL_FRAME);
SimpleInitiator simple4 (STARTS[4],clk,REQ[4],GNT[4],FRAMES[4],IRDYS[4],I_AM_OWNERS[4] , GLOBAL_IRDY,GLOBAL_FRAME);
SimpleInitiator simple5 (STARTS[5],clk,REQ[5],GNT[5],FRAMES[5],IRDYS[5],I_AM_OWNERS[5] , GLOBAL_IRDY,GLOBAL_FRAME);
SimpleInitiator simple6 (STARTS[6],clk,REQ[6],GNT[6],FRAMES[6],IRDYS[6],I_AM_OWNERS[6] , GLOBAL_IRDY,GLOBAL_FRAME);
SimpleInitiator simple7 (STARTS[7],clk,REQ[7],GNT[7],FRAMES[7],IRDYS[7],I_AM_OWNERS[7] , GLOBAL_IRDY,GLOBAL_FRAME);



endmodule
