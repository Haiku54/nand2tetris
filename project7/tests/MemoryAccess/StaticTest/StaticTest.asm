
@111                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@333                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@888                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  

@SP                 //   A = 0 (Address of Stack Pointer)
AM=M-1              //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                 //   D = ram[A] (D = value at the top of the stack)
@8                 //   A = address of the static variable static.{index}
M=D                 //   ram[A] = D (Store the value from the top of the stack in the static variable)


@SP                 //   A = 0 (Address of Stack Pointer)
AM=M-1              //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                 //   D = ram[A] (D = value at the top of the stack)
@3                 //   A = address of the static variable static.{index}
M=D                 //   ram[A] = D (Store the value from the top of the stack in the static variable)


@SP                 //   A = 0 (Address of Stack Pointer)
AM=M-1              //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                 //   D = ram[A] (D = value at the top of the stack)
@1                 //   A = address of the static variable static.{index}
M=D                 //   ram[A] = D (Store the value from the top of the stack in the static variable)


@3                //   A = address of the static variable static.{index}
D=M                 //   D = ram[A] (D = value of the static variable)
@SP                 //   A = 0 (Address of Stack Pointer)
A=M                 //   A = ram[0] (A = stack pointer)
M=D                 //   ram[A] = D (Store the value of the static variable at the top of the stack)
@SP                 //   A = 0 (Address of Stack Pointer)
M=M+1               //   M = M+1 (Increment stack pointer)
 

@1                //   A = address of the static variable static.{index}
D=M                 //   D = ram[A] (D = value of the static variable)
@SP                 //   A = 0 (Address of Stack Pointer)
A=M                 //   A = ram[0] (A = stack pointer)
M=D                 //   ram[A] = D (Store the value of the static variable at the top of the stack)
@SP                 //   A = 0 (Address of Stack Pointer)
M=M+1               //   M = M+1 (Increment stack pointer)
 

@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			

@8                //   A = address of the static variable static.{index}
D=M                 //   D = ram[A] (D = value of the static variable)
@SP                 //   A = 0 (Address of Stack Pointer)
A=M                 //   A = ram[0] (A = stack pointer)
M=D                 //   ram[A] = D (Store the value of the static variable at the top of the stack)
@SP                 //   A = 0 (Address of Stack Pointer)
M=M+1               //   M = M+1 (Increment stack pointer)
 

@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M+D             //   D = ram[A]+D , add the secend
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			
