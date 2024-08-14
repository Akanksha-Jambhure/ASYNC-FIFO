`timescale 1us / 1ps
module tb_async_fifo();

	parameter DATA_SIZE=8;
	reg [DATA_SIZE-1:0] wr_data;
	reg wr_en;
	reg wr_clk;
	reg wr_rstn;
	reg rd_en;
	reg rd_clk;
	reg rd_rstn;
	wire [DATA_SIZE-1:0] rd_data;
	wire wr_full;
	wire rd_empty;
	
	always#5 rd_clk = ~rd_clk;
	always#10 wr_clk = ~wr_clk;
	
	integer i;
	
	initial begin
	   //Read and Write
		rd_clk=0;wr_clk=0;
		rd_rstn=1;wr_rstn=1;wr_en=1;rd_en=0;
		#3 rd_rstn=0; wr_rstn=0;
		#10 rd_rstn=1;
		#10 wr_rstn=1; 
		rd_en=1;
		for(i=10;i<17;i=i+1) begin
      #20 wr_data = i + 1;
		end
		#10 wr_en=0;
		#20 
		
		// Write full
		rd_rstn=1;wr_rstn=1;wr_en=1;rd_en=0;
		#3 rd_rstn=0; wr_rstn=0;
		#10 rd_rstn=1;
		#10 wr_rstn=1; 
		rd_en=1;
		for(i=10;i<14;i=i+1) begin
      #20 wr_data = 2*i + 1;
		end
		#10 rd_en=0;
		
		//Read empty
		#500
		rd_rstn=1;wr_rstn=1;wr_en=0;rd_en=0;
		#3 rd_rstn=0; wr_rstn=0;
		#10 rd_rstn=1;
		#10 wr_rstn=1; 
		rd_en=1;
		#200 $finish;
	end
 
 async_fifo_final dut
 (
		.wr_data(wr_data),
		.wr_clk(wr_clk),
		.wr_en(wr_en),
		.wr_rstn(wr_rstn),
		.rd_clk(rd_clk), 
		.rd_en(rd_en), 
		.rd_rstn(rd_rstn),
		.rd_data(rd_data),
		.wr_full(wr_full),
		.rd_empty(rd_empty)
 );
 
endmodule 