module constants;
import std.string;
import std.stdio;
import std.conv;


enum CommandType {
    C_ARITHMETIC,
    C_PUSH,
    C_POP,
    C_LABEL,
    C_GOTO,
    C_IFGOTO,
    C_FUNCTION,
    C_RETURN,
    C_CALL
}

 class asmCode
{
	static string ADD()
	{
		return "
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M+D             //   D = ram[A]+D , add the secend
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			";
	}

	static string SUB()
	{
		return "
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
M=D               //   ram[A] = D (the result)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			";

	}

	static string NEG()
	{
		return "
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
M=-M               //  ram[A] = -ram[A]
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1

			";
	}


	static string EQ(int index)
	{
		return format("
// pop first argument to D and move the sp
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]
// pop secend argument and sub from D and move the sp
@SP               //   A = 0 
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D , sub the secend from first
@IF_EQ%s
D; JEQ		      // if D==0 so they are eq
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=0               //   ram[A] = 0  
@END%s
0; JMP
(IF_EQ%s)         // if they are eq so push -1
@SP               //   A = 0                          
A=M               //   A = ram[0]
M=-1               //   ram[A] = -1  
(END%s)
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1
			
			",index,index,index,index);
	}


	static string GT(int index)
	{
		return format("
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M               //   D = ram[A]                       
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M-D             //   D = ram[A]-D                     
@IF_GT%s          
D;JGT             //   if D>0 jump to label of TRUE    
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=0               //   ram[A] = 0                       
@END%s         
0;JMP             //   jump to label of END             
(IF_GT%s)                            
@SP               //   A = 0                            
A=M               //   A = ram[0]                       
M=-1              //   ram[A] = -1                      
(END%s)                              
@SP               //   A = 0                            
M=M+1             //   ram[0] = ram[0]+1 

					  ",index,index,index,index);
	}

	static string LT(int index)
	{
		return format("
@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M               //   D = ram[A]                     
@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
D=M-D             //   D = ram[A]-D                   
@IF_LT%s      
D;JLT             //   if D<0 jump to label of TRUE   
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=0               //   ram[A] = 0                     
@END%s        
0;JMP             //   jump to label of END           
(IF_LT%s)                          
@SP               //   A = 0                          
A=M               //   A = ram[0]                     
M=-1              //   ram[A] = -1                    
(END%s)                            
@SP               //   A = 0                          
M=M+1             //   ram[0] = ram[0]+1      

					  ",index,index,index,index);
	}


	static string AND()
	{
		return "
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=M               //   D = ram[A]                       
@SP               //   A = 0                            
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1  
D=D&M             //   D = D and ram[A]                     
M=D               //   ram[A] = D        
@SP               //   A = 0     
M=M+1             //   ram[0] = ram[0]+1
			";
	}


	static string OR()
	{
		return "
@SP               //   A = 0                           
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1 
D=M               //   D = ram[A]                      
@SP               //   A = 0                           
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1 
D=D|M             //   D = D or ram[A]                   
M=D               //   ram[A] = D                      
@SP               //   A = 0                           
M=M+1             //   ram[0] = ram[0]+1  

			";
	}


	static string NOT()
	{
		return "
@SP               //   A = 0                          
AM=M-1            //   A = ram[0]-1, ram[0] = ram[0]-1
M=!M              //   ram[A] = not ram[A]                                              
@SP               //   A = 0
M=M+1             //   ram[0] = ram[0]+1  

			";
	}


	// gruop 1 - LCL ARG THIS THAT


	static string PUSH_LCL_ARG_THIS_THAT(string segment, int index)
	{
		return format("
@%s               //   index to push (lcl 4, that 3 etc.)      
D=A               //   A=index=offset
@%s               //   kind of the segment                               
A=M+D             //   A = ram[segment]+D (D=index=offset)                          
D=M               //   D = ram[A] - the value to push to haed of stack
@SP               //   A = 0                    
A=M               //   A = ram[0]                       
M=D               //   ram[A] = D                            
@SP               //   A = 0               
M=M+1             //   ram[0] = ram[0]+1 
					  "
					  ,index,segment);
	}


	static string POP_LCL_ARG_THIS_THAT(string segment, int index)
	{
		return format("
@%s                        
D=A               //   D = A (A=index=offset)  
@%s                               
D=M+D             //   D = ram[{segment}]+D (D=index=offset)  
@R13              //   A = R13 (General-purpose register)
M=D               //   ram[R13] = D
@SP               //   A = 0
AM=M-1            //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M               //   D = ram[A] (D = value at the top of the stack)
@R13              //   A = R13
A=M               //   A = ram[R13] (A = address to store the value)
M=D               //   ram[A] = D (store the value in the specified segment and index)
					  
					  "
					  ,index,segment);
	}




	/// gruop 2

	static string PUSH_TEMP(int index) {
		return format("
@%s                        
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

					  "
					  ,index);
	}


	static string POP_TEMP(int index) {
		return format("
@%s                        
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
					  "
					  ,index);
	}



/// gruop 3

	static string POP_STATIC (string file_name,int index) {
		return format("
@SP                 //   A = 0 (Address of Stack Pointer)
AM=M-1              //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                 //   D = ram[A] (D = value at the top of the stack)
@%s.%s                 //   A = address of the static variable static.{index}
M=D                 //   ram[A] = D (Store the value from the top of the stack in the static variable)
"
					 , file_name, index);
	}


	static string PUSH_STATIC (string file_name,int index) {
		return format("
@%s.%s                //   A = address of the static variable static.{index}
D=M                 //   D = ram[A] (D = value of the static variable)
@SP                 //   A = 0 (Address of Stack Pointer)
A=M                 //   A = ram[0] (A = stack pointer)
M=D                 //   ram[A] = D (Store the value of the static variable at the top of the stack)
@SP                 //   A = 0 (Address of Stack Pointer)
M=M+1               //   M = M+1 (Increment stack pointer)
 "
					  ,file_name, index);
	}


	//gruop 4

	static string PUSH_POINTER(int index) {
		string segment = index == 0 ? "THIS" : "THAT";

		return format("
@%s                //   A = address of the pointer segment (THIS or THAT)
D=M                //   D = ram[A] (D = value of the pointer)
@SP                //   A = 0 (Address of Stack Pointer)
A=M                //   A = ram[A] (A = stack pointer)
M=D                //   ram[A] = D (Push the pointer value onto the stack)
@SP                //   A = 0 (Address of Stack Pointer)
M=M+1              //   M = M+1 (Increment stack pointer)
"
					  , segment);
	}


	static string POP_POINTER(int index) {
		string segment = index == 0 ? "THIS" : "THAT";

		return format("
@SP                //   A = 0 (Address of Stack Pointer)
AM=M-1             //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                //   D = ram[A] (D = value at the top of the stack)
@%s                //   A = address of the pointer segment (THIS or THAT)
M=D                //   ram[A] = D (Store the value from the top of the stack in the pointer segment)
"
					  , segment);
	}




	// gruop 5 - constant

	static string PUSH_CONSTANT(int index)
	{
		return format("
@%s                                   
D=A               //   D = index
@SP               //   A = 0                     
A=M               //   A = ram[0]                          
M=D               //   ram[A] = D
@SP               //   A = 0                  
M=M+1             //   ram[0] = ram[0]+1  

					  ",index);
	}

	// project8




	static string LABEL(string file_name, string label_name)
	{
		return format("
(%s.%s)				// 
					  ",file_name,label_name);
	}


	static string GOTO(string file_name, string label_name)
	{
		return format("
@%s.%s			// load address for jump
0; JMP			// jmp to address
					  ",file_name,label_name);
	}


	// This function generates assembly code for an IF-GOTO statement with a given file and label name.
	static string IFGOTO(string file_name, string label_name)
	{
		return format(
					  "
 @SP          // Set the A register to the address of the stack pointer
 M=M-1        // Decrement the stack pointer by 1
 A=M          // Set the A register to the address of the new top element of the stack
 D=M          // Store the value at the address in the A register (the top of the stack) in the D register
 @%s.%s       // Set the A register to the given file and label name (formatted as file_name.label_name)
 D; JNE       // Jump to the address in the A register (the given label) if the value in the D register is not equal to 0

					  ", file_name, label_name); // These are the format specifiers for the file and label names
	}



	/*static string PUSH_RETURN_ADDRESS(string function_name ,int index)
	{
		return format(
 "
@%s.RETURN_ADDRESS%s
D=A             // Store the return address in register D
@SP             // Load the value of the stack pointer
A=M             // Set the address register to the address pointed to by the stack pointer
M=D             // Store the return address (from register D) at the current stack pointer address
@SP             // Load the value of the stack pointer again
M=M+1           // Increment the stack pointer

 ", function_name, index); // These are the format specifiers for the file and label names
	}*/


	static string CALL(string function_name, int num_of_arg, int index) {
		string asm_code;

		// Push the return address (a unique label based on the index)
		string return_address = "%s.RETURN_ADDRESS%s".format(function_name,index);

		return format("
					  // ++++++++++++++ CALL ++++++++++++++  
                
// *** push return-address *** 
@%s
D=A               //           
@SP               //   A = 0              
A=M               //   A = ram[0]         
M=D               //   ram[ram[0]] =         
@SP               //   A = 0              
M=M+1             //   ram[0] = ram[0]+1  

// *** push LCL ***	
@LCL              //   A = LCL     
D=M               //   D = ram[LCL] 
@SP               //   A = 0                                     
A=M               //   A = ram[0]                                
M=D               //   ram[ram[0]] = D                                
@SP               //   A = 0                                     
M=M+1             //   ram[0] = ram[0]+1                         

// *** push ARG *** 	
@ARG              //   A = ARG      
D=M               //   D = ram[ARG]           
@SP               //   A = 0             
A=M               //   A = ram[0]        
M=D               //   ram[ram[0]] = D        
@SP               //   A = 0             
M=M+1             //   ram[0] = ram[0]+1 

// *** push THIS *** 	
@THIS             //   A = THIS     
D=M               //   D = ram[THIS]           
@SP               //   A = 0             
A=M               //   A = ram[0]        
M=D               //   ram[ram[0]] = D        
@SP               //   A = 0             
M=M+1             //   ram[0] = ram[0]+1 

// *** push THAT ***   	
@THAT             //   A = THAT
D=M               //   D = ram[THAT]           
@SP               //   A = 0             
A=M               //   A = ram[0]        
M=D               //   ram[ram[0]] = D        
@SP               //   A = 0             
M=M+1             //   ram[0] = ram[0]+1 

// *** ARG = SP-n-5 ***	
@SP               //   A = 0     
D=M               //   D = ram[0]
@%s
D=D-A             //   D = D-{numARG}
@5                //   A = 5
D=D-A             //   D = D-5
@ARG              //   A = ARG
M=D               //   ram[ARG] = D

// *** LCL = SP ***
@SP              //   A = 0     
D=M              //   D = ram[0]
@LCL             //   A = LCL     
M=D              //   ram[LCL] = ram[SP]

// *** goto g *** 	
@%s  
0;JMP            //   jump to {nameOfFunction}

// *** label return-address *** 
(%s)  

// ++++++++++++++ END CALL ++++++++++++++  

"
					  ,return_address,num_of_arg,function_name,return_address);


	}


	static string FUNCTION(string function_name, int num_of_arg) {
		return format(
				  "
// label function name
(%s)

@%s
D = A
@%s.End
D; JEQ
(%s.Loop)
@SP
A = M
M = 0
@SP
M = M+1
@%s.Loop
D = D-1 ;JNE
(%s.End)
	"
					  ,function_name, num_of_arg, function_name,function_name,function_name,function_name);
	}


	static string RETURN() {
return "
// ++++++++++++++ RETURN ++++++++++++++

// *** FRAME = LCL ***
@LCL             //   A = LCL      
D=M              //   D = ram[LCL] 

// *** RET = *(FRAME-5) ***
// *** RAM[13] = (LOCAL-5) *** 
@5               //   A = 5             
A=D-A            //   A = D-5        
D=M              //   D = ram[D-5]        
@13              //   A = 13             
M=D              //   ram[13] = D 

// ***[ *ARG = pop() ]***
@SP  	           //   A = 0
M=M-1            //   ram[0] = ram[0]-1           
A=M              //   A = ram[0]              
D=M              //   D = ram[ram[0]]         
@ARG             //   A = ARG         
A=M              //   A = ram[ARG]              
M=D              //   ram[ram[ARG]] = ram[ram[0]]  

// *** SP = ARG+1 ***
@ARG             //   A = ARG 
D=M              //   D = ram[ARG]  
@SP              //   A = 0     
M=D+1	           //   ram[SP] = ram[ARG]+1

// *** THAT = *(FRAME-1) ***
@LCL             //   A = LCL       
M=M-1            //   ram[LCL] = ram[LCL]-1  
A=M              //   A = ram[LCL]         
D=M              //   D = ram[ram[LCL]]  
@THAT            //   A = THAT
M=D              //   A[THAT] = ram[ram[LCL]]

// *** THIS = *(FRAME-2) ***
@LCL             //   A = LCL              
M=M-1            //   ram[LCL] = ram[LCL]-1
A=M              //   A = ram[LCL]         
D=M              //   D = ram[ram[LCL]]           
@THIS            //   A = THIS             
M=D              //   A[THIS] = ram[ram[LCL]]          

// *** ARG = *(FRAME-3) ***
@LCL             //   A = LCL              
M=M-1            //   ram[LCL] = ram[LCL]-1
A=M              //   A = ram[LCL]         
D=M              //   D = ram[ram[LCL]]           
@ARG             //   A = ARG             
M=D			   //   A[ARG] = ram[ram[LCL]]          	

// *** LCL = *(FRAME-4) ***
@LCL             //   A = LCL              
M=M-1            //   ram[LCL] = ram[LCL]-1
A=M              //   A = ram[LCL]         
D=M              //   D = ram[ram[LCL]]           
@LCL             //   A = LCL              
M=D		       //   A[LCL] = ram[ram[LCL]]          

// *** goto RET ***
@13              //   A = 13              
A=M              //   A = ram[13]
0; JMP           //   jump to ram[ram[13]] 

// ++++++++++++++ END RETURN ++++++++++++++

";
	}


	static string BOOTSTRAP()
	{
		return "
// ++++++++++++++ BOOTSTRAPPING ++++++++++++++

// *** SP = 256 ***

@256
D=A
@SP
M=D

// *** call Sys.init ***

// push return-address
@Sys.init.RETURN_ADDRESS0
D=A
@SP
A=M
M=D
@SP
M=M+1

// push LCL
@LCL  
D=M
@SP
A=M
M=D
@SP
M=M+1

// push ARG
@ARG  
D=M
@SP
A=M
M=D
@SP
M=M+1

// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1

// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1

// ARG = SP-n-5 
@SP
D=M
@0
D=D-A
@5
D=D-A
@ARG
M=D

// LCL = SP 
@SP
D=M
@LCL
M=D

@Sys.init
0;JMP

(Sys.init.RETURN_ADDRESS0)

// ++++++++++++++ END BOOTSTRAPPING ++++++++++++++

					  ";

	}



}






