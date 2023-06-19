import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;
import jackTokenizer;
import parsing;
//import main11;

void parserFunc(string path)
{
	
	auto jackFiles = dirEntries(path~"\\result", SpanMode.depth).filter!(f => f.name.endsWith("T.xml")); // open jack file
	foreach (jack; jackFiles)
	{
	
		string a = jack.name;
		parsing.parsingClass parser = new parsing.parsingClass();
		parser.parsingClass(a);
		
	}

}


int main(string[] args)
{
	// Check that there is exactly one argument.
	if (args.length != 2) {
		writeln("Usage: programname <path to folder>");
		return 0;
	}


	// Get the path to the directory.
	string folderPath = args[1];

	jackTokenizer.jackTokenizer Tokenizer;
	Tokenizer = new jackTokenizer.jackTokenizer() ;


	auto jackFiles = dirEntries(folderPath, SpanMode.depth).filter!(f => f.name.endsWith(".jack")); // open jack file
	foreach (jack; jackFiles)
	{
		Tokenizer.jackTokenizer(jack.name);
	}

	parserFunc(folderPath);

	writeln("We do it :) !!!!");
	//main11.main([folderPath]);
	readln();         // press any key to close
	return 0;

}

