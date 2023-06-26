module main11;
import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;
import programStructures;
import std.xml;


File tokensFile; // global file
void readTokenFile (string path)
{
	programStructure ps;
	//auto jackFiles = dirEntries(folderName, SpanMode.depth).filter!(f => f.name.endsWith(".xml")); // open jack file
	path ~= "\\result";
	auto jackFiles = dirEntries(path, SpanMode.depth).filter!(f => f.name.endsWith(".xml")); // open jack file
	foreach (jack; jackFiles)
	{
		if(jack.name.endsWith("T.xml"))
			continue;

		string output ="";
		//string fullFileName =  baseName(jack.name); // the file name
		//string fileName =  baseName(stripExtension(jack.name));  // the file name (without th extntion)
		//string destPath =  dirName(jack.name); // the dir path
		//string destenationFath = "C:\\Users\\general\\source\\repos\\targil5\\targil5\\"~destPath~""~"\\"~fileName~".vm";

		string fullFileName =  baseName(jack.name); // the file name
		//string fileName =  baseName(stripExtension(path));  // the file name (without th extntion)
		auto Tindex = lastIndexOf(fullFileName, '.'); // 9
		string newFileName = fullFileName[0 .. Tindex];
		string destPath =  dirName(path); // the dir path
		string destenationFath = destPath~"\\result\\"~newFileName~".vm";
		auto outputFile= File(destenationFath,"w");


		tokensFile = File(jack.name,"r");   // read the xxx.xml file

		ps = new programStructure();
		

		output = ps.parseClass();

		outputFile.write(output);

		outputFile.close();
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

	readTokenFile(folderPath);
	readln();         // press any key to close
	return 0;
}





