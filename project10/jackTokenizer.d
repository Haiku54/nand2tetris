module jackTokenizer;
import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;

string[] keyWords = ["class", "constructor", "function", "method","field"
					 , "static", "var", "int","char","boolean"
		,"void","true","false","null","let","do","if"
		,  "else","while","return","this" ];

char[] symbols = ['{' , '}' , '(' , ')' , '[' , ']' , '.' , ',' , ';' , '+' , '-' , '*' , '/' , '&' , '|' , '<' , '>' , '=' , '~'];

enum TokenizerState {
	START,
	IDENTIFIER,
	INTEGER_CONSTANT,
	SYMBOL,
	STRING_CONSTANT
}

class jackTokenizer
{

	void jackTokenizer(string path)
	{
		string fullFileName =  baseName(path); // the file name
		string fileName =  baseName(stripExtension(path));  // the file name (without th extntion)
		string destPath =  dirName(path); // the dir path
		if(!exists(destPath~"\\result"))mkdir(destPath~"\\result");
		string destenationFath = destPath~"\\result\\"~fileName~"T.xml";
		auto startTok= File(destenationFath,"w");
		startTok.write("<tokens>\n");
		startTok.close();
		File jackRead = File(path,"r");
		while(!jackRead.eof())
		{
			string line = strip(chomp(jackRead.readln()));
			if(startsWith(line,"//")||startsWith(line,"/**")||startsWith(line,"*")||line=="") continue;
			line = split(line,"//")[0];
			tokenizer(line, destenationFath); 
			auto command = split(line);

		}

		auto endTok= File(destenationFath,"a+");
		endTok.write("</tokens>\n");
	}

	void tokenizer(string str, string path)
	{
		TokenizerState currentState = TokenizerState.START;
		string token = "";
		bool isString = false;
		bool isNumber = false;

		for (int i = 0; i < str.length; i++)
		{
			char chr = str[i];

			switch (currentState)
			{
				case TokenizerState.START:
					if (((chr > 64 && chr < 91) || (chr > 96 && chr < 123)) && !isString && !isNumber) // abAB
					{
						currentState = TokenizerState.IDENTIFIER;
						token = token ~ "" ~ chr;
					}

					else if ((token == "") && (chr > 47 && chr < 58) && !isString) // is intger
					{
						isNumber = true;
						token = token ~ "" ~ chr;
						currentState = TokenizerState.INTEGER_CONSTANT;
					}

					else if (isString)
					{
						if (chr != '"')
						{
							token = token ~ "" ~ chr;
						}
						else
						{
							isString = false;
							currentState = TokenizerState.STRING_CONSTANT;
							i = i-1;
						}
					}
					else if (chr == '"' && currentState != TokenizerState.STRING_CONSTANT)
					{
						isString = true;
					}
					else if ((canFind(symbols, chr) && token == "") && !isString && !isNumber)
					{
						currentState = TokenizerState.SYMBOL;
						token=token~chr;
						i = i-1;
					}
					break;





				case TokenizerState.IDENTIFIER:
					if (chr == 32 || (canFind(symbols, chr) && !isString))
					{
						if (chr != 32) i=i-1;
						if (canFind(keyWords, token))
						{
							printKeyWord(path, token);
							token = "";
							currentState = TokenizerState.START;
						}
						else
						{
							printIdentifier(path, token);
							token = "";
							currentState = TokenizerState.START;
						}
					}

					else if (canFind(symbols, chr) && !isString)
					{
						printIdentifier(path, token);
						token = "";
						currentState = TokenizerState.START;
						i=i-1;
					}
					else
					{
						token = token ~ "" ~ chr;
					}
					break;

				case TokenizerState.INTEGER_CONSTANT:
					if (chr != 32 && !canFind(symbols, chr))
					{
						token = token ~ "" ~ chr;
					}
					else
					{
						printIntegerConstant(path, token);
						token = "";
						isNumber = false;
						currentState = TokenizerState.START;
						i = i-1;
					}
					break;

				case TokenizerState.SYMBOL:
					printSymbol(path, token);
					token = "";
					currentState = TokenizerState.START;
					break;

				case TokenizerState.STRING_CONSTANT:
					printStringConstant(path, token);
					token = "";
					currentState = TokenizerState.START;
					break;
				default:
					break;
			}
		}
	}

	void printIntegerConstant(string path,string IntegerConstant)
	{
		auto jackFileOutput= File(path,"a+");
		jackFileOutput.write("<integerConstant> ",IntegerConstant," </integerConstant>\n");
	}


	void printKeyWord(string path,string keyWord)
	{
		auto jackFileOutput= File(path,"a+");
		jackFileOutput.write("<keyword> ",keyWord," </keyword>\n");
	}

	void printIdentifier(string path,string identifier)
	{
		auto jackFileOutput= File(path,"a+");
		jackFileOutput.write("<identifier> ",identifier," </identifier>\n");
	}


	void printStringConstant(string path,string StringConstant)
	{
		auto jackFileOutput= File(path,"a+");
		jackFileOutput.write("<stringConstant> ",StringConstant," </stringConstant>\n");
	}

	void printSymbol(string path,string symbol)
	{
		string tmp=symbol;
		switch (symbol)
		{
			case "<":  tmp="&lt;";
				break;
			case ">": tmp="&gt;"; 
				break;
			case "&": tmp="&amp;";  
				break;
			default: break;
		}
		if(symbol[0] == '"')
		{
			tmp="&quet;";
		}
		auto jackFileOutput= File(path,"a+");
		jackFileOutput.write("<symbol> ",tmp," </symbol>\n");
	}



	
}
