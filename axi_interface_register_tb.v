module tb;
  
  parameter DW=32; 
  
  reg clk;
  
  reg resetn;
  
  reg [DW-1:0] s_data;
  
  reg s_valid;
  
  reg s_last;
  
  reg m_ready;
  
  wire s_ready;
  
  wire m_valid;
  
  wire [DW-1:0] m_data;
  
  wire m_last;
  
  reg_module uut(clk,resetn,s_data,s_valid,s_last,s_ready,m_ready,m_valid,m_last,m_data);
  
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars;
  end  
  
  
  

  //clock generation
  
  initial begin
    	clk=0;
    forever #5 clk=~clk;
  end  
  
  
  initial begin
     resetn=0;
     m_ready=0;
    #10;
    	resetn=1;
    fork
      generate_ready;
      generate_axi(11);
      
    join_any 
    
    @(posedge clk);
     s_data<=0;
                  s_valid<=0;
                  s_last<=0;	
    
 
    #100;
    generate_axi_valid_change(6);
    	
    @(posedge clk)
    @(posedge clk)
    	$finish;
    	
  end
  
  
  task generate_axi(input [3:0] count);
    integer  counter;
    	begin
          counter=0;
          while(counter<(count-1))
           
            	begin
                   @(posedge clk)
                  if(m_ready==0)
                    begin
                    s_data<=s_data;
                  	s_valid<=1;
                  	s_last<=0;
                    end 	
                 else	
                  	begin
                  s_data<={$random}%60;
                  s_valid<=1;
                  s_last<=0;
                      counter=counter+1;
                    end 
                  
                end
          @(posedge clk)
          		begin
                  s_data<={$random}%60;
                  s_valid<=1;
                  s_last<=1;
                  counter<=0;
                end
        end
  endtask
  
  
  
   task generate_axi_valid_change(input [3:0] count);
    integer  counter=0;
    	begin
          while(counter<(count-1))
           
            	begin
                   @(posedge clk)
                  if(m_ready==0)
                    begin
                    s_data<=s_data;
                  	s_valid<=s_valid;
                  	s_last<=0;
                    end 	
                 else	
                  	begin
                  s_data<={$random}%60;
                  s_valid<=$random;
                  s_last<=0;
                      counter=counter+1;
                    end 
                  
                end
          @(posedge clk)
          		begin
                  s_data<={$random}%60;
                  s_valid<=1;
                  s_last<=1;
                  counter<=0;
                end
        end
  endtask
  
  task generate_ready;
    
    begin
      forever 
        	begin
              @(posedge clk) #1 m_ready<=$random;
            end  
    end
  endtask
  
    
  
  
  
endmodule
