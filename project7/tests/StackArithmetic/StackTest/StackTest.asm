
@17                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@17                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

// pop first argument to D and move the sp
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
// pop secend argument and sub from D and move the sp
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
@IF_EQ0
D; JEQ		      // if D==0 so they are eq
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=0               //   ram[A] = 0  
@END0
0; JMP
(IF_EQ0)         // if they are eq so push -1
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=-1               //   ram[A] = -1  
(END0)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1
			
			

@17                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@16                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

// pop first argument to D and move the sp
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
// pop secend argument and sub from D and move the sp
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
@IF_EQ1
D; JEQ		      // if D==0 so they are eq
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=0               //   ram[A] = 0  
@END1
0; JMP
(IF_EQ1)         // if they are eq so push -1
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=-1               //   ram[A] = -1  
(END1)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1
			
			

@16                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@17                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

// pop first argument to D and move the sp
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
// pop secend argument and sub from D and move the sp
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
@IF_EQ2
D; JEQ		      // if D==0 so they are eq
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=0               //   ram[A] = 0  
@END2
0; JMP
(IF_EQ2)         // if they are eq so push -1
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=-1               //   ram[A] = -1  
(END2)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1
			
			

@892                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@891                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]                     
@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D                   
@IF_LT3      
D;JLT             //   if D<0 jump to label of TRUE   
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=0               //   ram[A] = 0                     
@END3        
0;JMP             //   jump to label of END           
(IF_LT3)                          
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=-1              //   ram[A] = -1                    
(END3)                            
@SP               //   A = 0                          
M=M+1             //   ram[0] = ram[0]+1      

					  

@891                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@892                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]                     
@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D                   
@IF_LT4      
D;JLT             //   if D<0 jump to label of TRUE   
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=0               //   ram[A] = 0                     
@END4        
0;JMP             //   jump to label of END           
(IF_LT4)                          
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=-1              //   ram[A] = -1                    
(END4)                            
@SP               //   A = 0                          
M=M+1             //   ram[0] = ram[0]+1      

					  

@891                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@891                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]                     
@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D                   
@IF_LT5      
D;JLT             //   if D<0 jump to label of TRUE   
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=0               //   ram[A] = 0                     
@END5        
0;JMP             //   jump to label of END           
(IF_LT5)                          
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=-1              //   ram[A] = -1                    
(END5)                            
@SP               //   A = 0                          
M=M+1             //   ram[0] = ram[0]+1      

					  

@32767                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@32766                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M               //   D = ram[A]                       
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M-D             //   D = ram[A]-D                     
@IF_GT6          
D;JGT             //   if D>0 jump to label of TRUE    
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=0               //   ram[A] = 0                       
@END6         
0;JMP             //   jump to label of END             
(IF_GT6)                            
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=-1              //   ram[A] = -1                      
(END6)                              
@SP               //   A = 0                            
M=M+1             //   ram[0] = ram[0]+1 

					  

@32766                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@32767                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M               //   D = ram[A]                       
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M-D             //   D = ram[A]-D                     
@IF_GT7          
D;JGT             //   if D>0 jump to label of TRUE    
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=0               //   ram[A] = 0                       
@END7         
0;JMP             //   jump to label of END             
(IF_GT7)                            
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=-1              //   ram[A] = -1                      
(END7)                              
@SP               //   A = 0                            
M=M+1             //   ram[0] = ram[0]+1 

					  

@32766                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@32766                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M               //   D = ram[A]                       
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M-D             //   D = ram[A]-D                     
@IF_GT8          
D;JGT             //   if D>0 jump to label of TRUE    
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=0               //   ram[A] = 0                       
@END8         
0;JMP             //   jump to label of END             
(IF_GT8)                            
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=-1              //   ram[A] = -1                      
(END8)                              
@SP               //   A = 0                            
M=M+1             //   ram[0] = ram[0]+1 

					  

@57                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@31                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@53                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M+D             //   D = ram[A]+D , add the secend
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			

@112                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			

@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
M=-M               //  ram[A] = -ram[A]
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			

@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M               //   D = ram[A]                       
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=D&M             //   D = D and ram[A]                     
M=D               //   ram[A] = D        
@SP               //   A = 0     
M=M+1             //   ram[0] = ram[0]+1
			

@82                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP               //   A = 0                           
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1 
D=M               //   D = ram[A]                      
@SP               //   A = 0                           
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1 
D=D|M             //   D = D or ram[A]                   
M=D               //   ram[A] = D                      
@SP               //   A = 0                           
M=M+1             //   ram[0] = ram[0]+1  

			

@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
M=!M              //   ram[A] = not ram[A]                                              
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1  

			
