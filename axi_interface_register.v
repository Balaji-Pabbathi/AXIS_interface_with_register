module reg_module #(parameter DW=32)(
  input clk,
  input resetn,
  
  input [DW-1:0] s_axis_data,
  input s_axis_valid,
  input s_axis_last,
  output  s_axis_ready,
  
  input m_axis_ready,
  output reg m_axis_valid,
  output reg m_axis_last,
  output reg [DW-1:0] m_axis_data

);
  
  
  assign s_axis_ready=(resetn)?m_axis_ready:1'bz;
  
  
  always@(posedge clk)
    	begin
          if(~resetn)
            	begin
                  	m_axis_data<=32'bz;
                  	m_axis_valid<=1'bz;
                  	m_axis_last<=1'bz;
                  //  s_axis_ready<='z;
                end
          else if(s_axis_ready && s_axis_valid)
            	begin
                  	//s_axis_ready<=m_axis_ready;
                  	m_axis_data<=s_axis_data;
                  	m_axis_last<=s_axis_last;
                  	m_axis_valid<=s_axis_valid;
                end

          else
            	begin
                  	//s_axis_ready<=m_axis_ready;
                  	m_axis_data<=0;
                  	m_axis_last<=0;
                  	m_axis_valid<=0;
                end
            	
        end
  
endmodule
                  
                  
            	
  