
@3030                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP                //   A = 0 (Address of Stack Pointer)
AM=M-1             //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                //   D = ram[A] (D = value at the top of the stack)
@THIS                //   A = address of the pointer segment (THIS or THAT)
M=D                //   ram[A] = D (Store the value from the top of the stack in the pointer segment)


@3040                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP                //   A = 0 (Address of Stack Pointer)
AM=M-1             //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                //   D = ram[A] (D = value at the top of the stack)
@THAT                //   A = address of the pointer segment (THIS or THAT)
M=D                //   ram[A] = D (Store the value from the top of the stack in the pointer segment)


@32                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@2                        
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
					  
					  

@46                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@6                        
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
					  
					  

@THIS                //   A = address of the pointer segment (THIS or THAT)
D=M                //   D = ram[A] (D = value of the pointer)
@SP                //   A = 0 (Address of Stack Pointer)
A=M                //   A = ram[A] (A = stack pointer)
M=D                //   ram[A] = D (Push the pointer value onto the stack)
@SP                //   A = 0 (Address of Stack Pointer)
M=M+1              //   M = M+1 (Increment stack pointer)


@THAT                //   A = address of the pointer segment (THIS or THAT)
D=M                //   D = ram[A] (D = value of the pointer)
@SP                //   A = 0 (Address of Stack Pointer)
A=M                //   A = ram[A] (A = stack pointer)
M=D                //   ram[A] = D (Push the pointer value onto the stack)
@SP                //   A = 0 (Address of Stack Pointer)
M=M+1              //   M = M+1 (Increment stack pointer)


@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M+D             //   D = ram[A]+D , add the secend
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			

@2               //   index to push (lcl 4, that 3 etc.)      
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
D=M-D             //   D = ram[A]-D , sub the secend from first
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			

@6               //   index to push (lcl 4, that 3 etc.)      
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

			
