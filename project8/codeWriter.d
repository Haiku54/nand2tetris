module codeWriter;
import std.stdio;
import std.string;
import std.file;
import std.conv;
import std.array;
import std.path;
import std.algorithm;
import constants;

class codeWriter
{
	private static codeWriter _instance;
    private File* outputFile ;
    private int arthJumpFlag;
    private int callFuncFlag;


    // Private constructor
    private this(string outputFilePath) {
        this.outputFile = new File(outputFilePath~"\\"~baseName(outputFilePath)~".asm", "w");
        arthJumpFlag = 0;
        callFuncFlag = 1;
    }


    // Static method to access the singleton instance
    public static codeWriter getInstance(string outputFilePath) {
        if (_instance is null) {
            _instance = new codeWriter(outputFilePath);
        }

        return _instance;
    }


    public void setFileName(string outputFilePath)
	{
         this.outputFile = new File(stripExtension(outputFilePath)~".asm", "w");
        arthJumpFlag = 0;
	}



	public void writeArithmetic(string command) {
        switch (command) {
            case "add":
                this.outputFile.writeln("//add"~"\n"~asmCode.ADD());
                break;

            case "sub":
                this.outputFile.writeln("//sub"~"\n"~asmCode.SUB());
                break;

            case "neg":
                this.outputFile.writeln("//neg"~"\n"~asmCode.NEG());
                break;

            case "eq":
                this.outputFile.writeln("//eq"~"\n"~asmCode.EQ(this.arthJumpFlag));
                this.arthJumpFlag++;
                break;

            case "gt":
                this.outputFile.writeln("//gt"~"\n"~asmCode.GT(this.arthJumpFlag));
                this.arthJumpFlag++;
                break;

            case "lt":
                this.outputFile.writeln("//lt"~"\n"~asmCode.LT(this.arthJumpFlag));
                this.arthJumpFlag++;
                break;

            case "and":
                this.outputFile.writeln("//and"~"\n"~asmCode.AND());
                break;

            case "or":
                this.outputFile.writeln("//or"~"\n"~asmCode.OR());
                break;

            case "not":
                this.outputFile.writeln("//not"~"\n"~asmCode.NOT());
                break;

            default:
                throw new Exception("Unknown arithmetic command: " ~ command);
        }
    }


    public void WritePushPop(CommandType command, string segment, int index)
	{
        switch (command)
		{
            case CommandType.C_PUSH:

                switch (segment){
                    case "constant":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.PUSH_CONSTANT(index));
                        break;
                    case "local","argument","this","that":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.PUSH_LCL_ARG_THIS_THAT(segmentConversionforHACK(segment),index));
                        break;
                    case "temp":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.PUSH_TEMP(index));
                        break;
					case "static":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.PUSH_STATIC(index));
                        break;
					case "pointer":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.PUSH_POINTER(index));
                        break;
                    default:
                        throw new Exception("Unknown segment: " ~ segment);
				}
                break;

            case CommandType.C_POP:
				switch (segment){
                    case "local","argument","this","that":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.POP_LCL_ARG_THIS_THAT(segmentConversionforHACK(segment),index));
                        break;
                    case "temp":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.POP_TEMP(index));
                        break;
                    case "static":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.POP_STATIC(index));
                        break;
					case "pointer":
                        this.outputFile.writeln("//"~segment~"\n"~asmCode.POP_POINTER(index));
                        break;
                    default:
                        throw new Exception("Unknown segment: " ~ segment);
				}
                break;

            default:
                throw new Exception("Unknown command: " );
		}

	}



	public void writeLabel(string file_name,string label_name) {
		this.outputFile.writeln("// label "~label_name~"\n"~asmCode.LABEL(file_name, label_name));
    }

	public void writeGoto(string file_name,string label_name) {
		this.outputFile.writeln("// Go to "~label_name~"\n"~asmCode.GOTO(file_name, label_name));
    }

	public void writeIf(string file_name,string label_name) {
		this.outputFile.writeln("//if Go to\n"~asmCode.IFGOTO(file_name, label_name));
    }

	public void writeFunction(string func_name,int n_arg) {
		this.outputFile.writeln("//function \n"~asmCode.FUNCTION(func_name, n_arg));
    }
 
	public void writeCall(string func_name,int n_arg) {
		this.outputFile.writeln("//Function Call \n"~asmCode.CALL(func_name, n_arg, this.callFuncFlag));
        this.callFuncFlag++;
    }
	public void writeReturn() {
		this.outputFile.writeln("//Return\n"~asmCode.RETURN());
    }

	public void writeBootStrap() {
		this.outputFile.writeln("//Boot Strap\n"~asmCode.BOOTSTRAP());
    }

    public void close()
	{
        this.outputFile.close();
	}

    private string segmentConversionforHACK(string segment)
	{
        if(segment == "local")
            segment = "LCL";
        else if(segment == "argument")
            segment = "ARG";
        return toUpper(segment);
	}
}

