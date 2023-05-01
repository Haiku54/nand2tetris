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

	static string POP_STATIC (int index) {
		return format("
@SP                 //   A = 0 (Address of Stack Pointer)
AM=M-1              //   A = ram[0]-1 (A = stack pointer - 1), M = M-1 (Decrement stack pointer)
D=M                 //   D = ram[A] (D = value at the top of the stack)
@%s                 //   A = address of the static variable static.{index}
M=D                 //   ram[A] = D (Store the value from the top of the stack in the static variable)
"
					  , index);
	}


	static string PUSH_STATIC (int index) {
		return format("
@%s                //   A = address of the static variable static.{index}
D=M                 //   D = ram[A] (D = value of the static variable)
@SP                 //   A = 0 (Address of Stack Pointer)
A=M                 //   A = ram[0] (A = stack pointer)
M=D                 //   ram[A] = D (Store the value of the static variable at the top of the stack)
@SP                 //   A = 0 (Address of Stack Pointer)
M=M+1               //   M = M+1 (Increment stack pointer)
 "
					  , index);
	}


	///gruop 4

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
(%s.%s)				// label %s
					  ",file_name,label_name,label_name);
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
		string return_address = "%s.RETURN_ADDRESS".format(function_name) ~ to!string(index);
		asm_code ~= "@%s\nD=A\n@SP\nA=M\nM=D\n@SP\nM=M+1\n".format(return_address);

		// Push LCL, ARG, THIS, and THAT
		asm_code ~= "@LCL\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n";
		asm_code ~= "@ARG\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n";
		asm_code ~= "@THIS\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n";
		asm_code ~= "@THAT\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n";

		// Reposition ARG
		asm_code ~= "@SP\nD=M\n@%d\nD=D-A\n@ARG\nM=D\n".format(5 + num_of_arg);

		// Reposition LCL
		asm_code ~= "@SP\nD=M\n@LCL\nM=D\n";

		// Jump to the function
		asm_code ~= "@%s\n0;JMP\n".format(function_name);

		// Declare the return address label
		asm_code ~= "(%s)\n".format(return_address);

		return asm_code;
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
		string asm_code;

		// FRAME = LCL
		asm_code ~= "@LCL\nD=M\n";

		// RET = *(FRAME - 5)
		asm_code ~= "@5\nA=D-A\nD=M\n@13\nM=D\n";

		// *ARG = pop()
		asm_code ~= "@SP\nM=M-1\nA=M\nD=M\n@ARG\nA=M\nM=D\n";

		// SP = ARG + 1
		asm_code ~= "@ARG\nD=M\n@SP\nM=D+1\n";

		// THAT = *(FRAME - 1)
		asm_code ~= "@LCL\nM=M-1\nA=M\nD=M\n@THAT\nM=D\n";

		// THIS = *(FRAME - 2)
		asm_code ~= "@LCL\nM=M-1\nA=M\nD=M\n@THIS\nM=D\n";

		// ARG = *(FRAME - 3)
		asm_code ~= "@LCL\nM=M-1\nA=M\nD=M\n@ARG\nM=D\n";

		// LCL = *(FRAME - 4)
		asm_code ~= "@LCL\nM=M-1\nA=M\nD=M\n@LCL\nM=D\n";

		// Goto RET
		asm_code ~= "@13\nA=M\n0;JMP\n";

		return asm_code;
	}



}






