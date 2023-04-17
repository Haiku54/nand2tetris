
@10                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@0                        
D=A               //   D = A (A=index=offset)  
@LCL                               
D=M+D             //   D = ram[{segment}]+D (D=index=offset)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  
					  

@21                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@22                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@2                        
D=A               //   D = A (A=index=offset)  
@ARG                               
D=M+D             //   D = ram[{segment}]+D (D=index=offset)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  
					  

@1                        
D=A               //   D = A (A=index=offset)  
@ARG                               
D=M+D             //   D = ram[{segment}]+D (D=index=offset)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  
					  

@36                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@6                        
D=A               //   D = A (A=index=offset)  
@THIS                               
D=M+D             //   D = ram[{segment}]+D (D=index=offset)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  
					  

@42                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@45                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@5                        
D=A               //   D = A (A=index=offset)  
@THAT                               
D=M+D             //   D = ram[{segment}]+D (D=index=offset)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  
					  

@2                        
D=A               //   D = A (A=index=offset)  
@THAT                               
D=M+D             //   D = ram[{segment}]+D (D=index=offset)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  
					  

@510                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@6                        
D=A               //   D = A (A=index)  
@5
D=D+A             //   D = D + A (D=base_address+index)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  

@0               //   index to push (lcl 4, that 3 etc.)      
D=A               //   A=index=offset
@LCL               //   kind of the segment                               
A=M+D             //   A = ram[segment]+D (D=index=offset)                          
D=M               //   D = ram[A] - the value to push to haed of stack
@SP               //   A = 0                    
A=M               //   A = ram[0]                       
M=D               //   ram[A] = D                            
@SP               //   A = 0               
M=M+1             //   ram[0] = ram[0]+1 
					  

@5               //   index to push (lcl 4, that 3 etc.)      
D=A               //   A=index=offset
@THAT               //   kind of the segment                               
A=M+D             //   A = ram[segment]+D (D=index=offset)                          
D=M               //   D = ram[A] - the value to push to haed of stack
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

			

@1               //   index to push (lcl 4, that 3 etc.)      
D=A               //   A=index=offset
@ARG               //   kind of the segment                               
A=M+D             //   A = ram[segment]+D (D=index=offset)                          
D=M               //   D = ram[A] - the value to push to haed of stack
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

			

@6               //   index to push (lcl 4, that 3 etc.)      
D=A               //   A=index=offset
@THIS               //   kind of the segment                               
A=M+D             //   A = ram[segment]+D (D=index=offset)                          
D=M               //   D = ram[A] - the value to push to haed of stack
@SP               //   A = 0                    
A=M               //   A = ram[0]                       
M=D               //   ram[A] = D                            
@SP               //   A = 0               
M=M+1             //   ram[0] = ram[0]+1 
					  

@6               //   index to push (lcl 4, that 3 etc.)      
D=A               //   A=index=offset
@THIS               //   kind of the segment                               
A=M+D             //   A = ram[segment]+D (D=index=offset)                          
D=M               //   D = ram[A] - the value to push to haed of stack
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

			

@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			

@6                        
D=A               //   D = A (A=index)  
@5
D=D+A             //   D = D + A (D=base_address+index)  
A=D               //   A = D
D=M               //   D = ram[A] (A=base_address+index)  
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

			
