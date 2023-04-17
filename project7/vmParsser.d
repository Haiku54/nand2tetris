module vmParsser;

import std.stdio;
import std.string;
import std.file;
import std.conv;
import std.array;
import std.path;
import std.algorithm;
import constants;



class VmParser {
    private static VmParser _instance;
    private File* inputFile ;
    private typeof(inputFile.byLine())  lines;
    private string[] current_Command ;

    // Private constructor
    private this(string inputFilePath) {
        this.inputFile = new File(inputFilePath, "r");
        this.lines = inputFile.byLine();
    }

    // Static method to access the singleton instance
    public static VmParser getInstance(string inputFilePath) {
        if (_instance is null) {
            _instance = new VmParser(inputFilePath);
        }
        else
		{
            _instance.inputFile = new File(inputFilePath, "r");
            _instance.lines = _instance.inputFile.byLine();
		}

        return _instance;
    }


    public bool hasMoreLiens()
	{
        return !this.lines.empty;
	}


    public void advance()
	{
        if(this.hasMoreLiens())
		{
            this.current_Command = this.lines.front.strip.split(" ").map!(a => to!string(a)).array;
            while ( (this.current_Command.empty && this.hasMoreLiens()) || (this.current_Command[0]=="//" && this.hasMoreLiens()))
			{
                this.lines.popFront(); // Move to the next line
                this.current_Command = this.lines.front.strip.split(" ").map!(a => to!string(a)).array;
			}
            this.lines.popFront(); // Move to the next line
		}
	}


	public CommandType getCommandType() {
		switch (this.current_Command[0]) {
			case "add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not":
				return CommandType.C_ARITHMETIC;
			case "push":
				return CommandType.C_PUSH;
			case "pop":
				return CommandType.C_POP;
				// Add more cases for other command types as needed
			default:
				throw new Exception("Unknown command: " ~ this.current_Command[0]);
		}
	}


    string arg1()
	{
        if (getCommandType == CommandType.C_ARITHMETIC){
            return this.current_Command[0];
		}
        return this.current_Command[1];
	}


    int arg2()
	{
        if (getCommandType == CommandType.C_PUSH || getCommandType == CommandType.C_POP){
            return to!int(this.current_Command[2]);
		}
        return false;
	}
}



//auto vmParser = VmParser.getInstance("inputFileName.vm");
//vmParser.parse();
