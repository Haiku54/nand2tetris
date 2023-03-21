

/// חיים גורן 207214909
/// נתן סייג 328944798

module EX0;

import std.stdio;
import std.string;
import std.file;
import std.conv;
import std.array;
import std.path;
import std.algorithm;

void HandleBuy(string productName, int amount, double price, File* outputFile) {
    outputFile.writeln("### BUY " ~ productName ~ " ###");
    outputFile.writeln(amount * price);
}

void HandleSell(string productName, int amount, double price, File* outputFile) {
    outputFile.writeln("$$$ CELL " ~ productName ~ " $$$");
    outputFile.writeln(amount * price);
}

void main(string[] args) {
    // Check that there is exactly one argument.
    if (args.length != 2) {
        writeln("Usage: programname <path to folder>");
        return;
    }

    // Get the path to the directory.
    string dirPath = args[1];
    //string dirPath = "C:\Users\חיים\Desktop\nand2tetris\part b\nand2tetris\targilim\tar0"
    // Get the name of the output file.
    string[] pathParts = dirPath.split("\\");
    string outputFileName = pathParts[$ - 1] ~ ".asm";

    // Open the output file for writing.
    File* outputFile = new File(outputFileName, "w");

    double totalBuy = 0.0;
    double totalSell = 0.0;

    // Get the list of files in the directory.
    auto dFiles = dirEntries(dirPath, SpanMode.depth).filter!(f => f.name.endsWith(".vm"));



    // Loop through the files.
    foreach (dFile; dFiles) {

		// Open the file for reading.
		File* inputFile = new File(dFile, "r");

		// Get the base name of the file (without the ".vm" extension).
		string baseName = stripExtension(baseName(dFile));

		// Write the file name to the output file.
		outputFile.writeln(baseName);


		// Loop through the lines in the file.
		// Loop through the lines in the file.
		foreach (line; inputFile.byLine()) {
			// Split the line into four words.
			string[] words = line.strip.split(" ").map!(a => to!string(a)).array;

			// Check the first word.
			if (words[0] == "buy") {
				// Call the HandleBuy function.
				HandleBuy(words[1], to!int(words[2]), to!double(words[3]), outputFile);
				totalBuy += to!double(words[2]) * to!double(words[3]);
			} else if (words[0] == "cell") {
				// Call the HandleSell function.
				HandleSell(words[1], to!int(words[2]), to!double(words[3]), outputFile);
				totalSell += to!double(words[2]) * to!double(words[3]);
			}



        }
		// Close the input file.
        outputFile.writeln();
		inputFile.close();
    }

    // Write the totals to the screen and the output file.
    outputFile.writeln();
    writeln("TOTAL BUY: ", totalBuy);
    writeln("TOTAL CELL: ", totalSell);
    outputFile.writeln("TOTAL BUY: " ~ to!string(totalBuy));
    outputFile.writeln("TOTAL CELL: " ~ to!string(totalSell));

    // Close the output file.
    outputFile.close();
}
