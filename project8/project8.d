module project7;

import std.stdio;
import vmParsser;
import codeWriter;
import constants;
import std.file;
import std.path;
import std.algorithm;;
import std.conv;
import std.stdio;
import std.file;
import std.path;
import std.algorithm;



void main(string[] args)
{
	// Check that there is exactly one argument.
    if (args.length != 2) {
        writeln("Usage: programname <path to folder>");
        return;
    }

	 vmParsser.VmParser parser;
	 codeWriter.codeWriter writer;


    // Get the path to the directory.
	 string folderPath = args[1];
	

	auto dFiles = dirEntries(folderPath, SpanMode.depth).filter!(f => f.name.endsWith(".vm"));
	writer = codeWriter.codeWriter.getInstance(folderPath);


	foreach (file; dFiles) {
		 parser = VmParser.getInstance(file.name);

         while(parser.hasMoreLiens())
		 {
			parser.advance();
			switch (parser.getCommandType())
			{
				case CommandType.C_ARITHMETIC:
					writer.writeArithmetic(parser.arg1());
					break;
				case CommandType.C_PUSH:
					writer.WritePushPop(CommandType.C_PUSH,parser.arg1(),parser.arg2() );
					break;
				case CommandType.C_POP:
					writer.WritePushPop(CommandType.C_POP,parser.arg1(),parser.arg2() );
					break;
				case CommandType.C_LABEL:
					writer.writeLabel(stripExtension(baseName(file.name)),parser.arg1() );
					break;
				case CommandType.C_GOTO:
					writer.writeGoto(stripExtension(baseName(file.name)),parser.arg1() );
					break;
				case CommandType.C_IFGOTO:
					writer.writeIf(stripExtension(baseName(file.name)),parser.arg1() );
					break;
				case CommandType.C_CALL:
					writer.writeCall(parser.arg1(),parser.arg2() );
					break;
				case CommandType.C_FUNCTION:
					writer.writeFunction(parser.arg1(),parser.arg2());
					break;
				case CommandType.C_RETURN:
					writer.writeReturn( );
					break;
				default:
					break;
			}

		 }
		 
        
    }
	writer.close();
}
