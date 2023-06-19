module parsing;

import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;

class parsingClass
{
	string output="";    // global var "output" is the result output
	File tokensFile;
	

	void parsingClass(string path)
	{
		string fullFileName =  baseName(path); // the file name
		string fileName =  baseName(stripExtension(path));  // the file name (without th extntion)
		auto Tindex = lastIndexOf(fileName, 'T'); // 9
		string newFileName = fileName[0 .. Tindex];
		string destPath =  dirName(path); // the dir path
		string destenationFath = destPath~"\\"~newFileName~".xml";
		auto outputFile= File(destenationFath,"w");
		outputFile.write("<class>");

		this.tokensFile = File(path,"r");

		string token = getNextToken(tokensFile); // to ignore <tokens> tag

		output = output~""~getNextToken(tokensFile);  //class
		output = output~""~getNextToken(tokensFile); // Class name
		output = output~""~getNextToken(tokensFile);  // {
		writeln(output);
		output = output~""~parseClassVarDec(tokensFile);

		while(indexOf(checkNextToken(tokensFile) , "function") != -1 || indexOf(checkNextToken(tokensFile) , "method") != -1 || indexOf(checkNextToken(tokensFile) , "constructor") != -1)
		{
			writeln(output);
			output = output~""~subroutineDec(tokensFile);
		}

		output = output~""~getNextToken(tokensFile)~""~"\n</class>";    //  }  
		outputFile.write(output);

	}

	string getNextToken(File tokensFile)
	{
		string tmp = "\n"~""~strip(chomp(tokensFile.readln()));
		return tmp;

	}

	string checkNextToken(File tokensFile)
	{
		auto pos = tokensFile.tell();    // get the file corennt offset
		string tmp = strip(chomp(tokensFile.readln()));   // get the next token 
		//writeln(tmp);
		tokensFile.seek(pos, SEEK_SET);    // go back to the previous offset 
		return tmp;
	}

	string checkNextNextToken(File tokensFile)
	{
		auto pos = tokensFile.tell();    // get the file corennt offset
		string tmp = strip(chomp(tokensFile.readln()));   // get the next token to move forword to the nextNext token
		tmp = strip(chomp(tokensFile.readln()));   // get the nextNext token
		tokensFile.seek(pos, SEEK_SET);    // go back to the previous offset 
		return tmp;
	}

	bool isKeyWordConstant(File tokensFile){
		return (indexOf(checkNextToken(tokensFile) , "true") != -1 ||
				indexOf(checkNextToken(tokensFile) , "false") != -1 ||
				indexOf(checkNextToken(tokensFile) , "null") != -1 ||
				indexOf(checkNextToken(tokensFile) , "this") != -1 );
	}

	bool isunaryOp(File tokensFile){
		return (indexOf(checkNextToken(tokensFile) , "-") != -1 ||
				indexOf(checkNextToken(tokensFile) , "~") != -1 );
	}

	bool isIdentifier(File tokensFile){
		return (indexOf(checkNextToken(tokensFile) , "identifier") != -1);
	}

	bool containOp(string token)    // check if the token contain operator
	{
		string[] op = ["+" , "-" , "*" , "/", "&amp;" , "|" , "&gt;" , "&lt;" , "=" , "~"];
		auto operator = split(token);
		if(canFind(op,operator[1]))
			return true;
		return false;
	}


	string statements(File tokensFile)
	{
		string tmp = "\n<statements>";
		string state;

		while(indexOf(checkNextToken(tokensFile) , "let") != -1||
			  indexOf(checkNextToken(tokensFile) , "if") != -1||
			  indexOf(checkNextToken(tokensFile) , "while") != -1||
			  indexOf(checkNextToken(tokensFile) , "do") != -1||
			  indexOf(checkNextToken(tokensFile) , "return") != -1)
		{
			writeln(tmp);
			auto keyWord = split(checkNextToken(tokensFile));
			switch (keyWord[1])
			{
				case "let":		tmp=tmp~""~letStatement(tokensFile);
					break;
				case "if":		tmp=tmp~""~ifStatement(tokensFile);
					break;
				case "while":	tmp=tmp~""~whileStatement(tokensFile);
					break;
				case "do":		tmp=tmp~""~doStatement(tokensFile);
					break;
				case "return":	tmp=tmp~""~returnStatement(tokensFile);
					break;
				default: break;
			}
		}

		tmp=tmp~""~ "\n</statements>";
		return tmp;
	}

	string letStatement(File tokensFile)
	{
		string tmp = "\n<letStatement>";
		tmp = tmp~""~getNextToken(tokensFile);  // let
		tmp = tmp~""~getNextToken(tokensFile);   // var name

		if (indexOf(checkNextToken(tokensFile) , "[") != -1)
		{
			tmp = tmp~""~getNextToken(tokensFile);  //   [  
			tmp = tmp~""~expression(tokensFile);   //  expression 
			tmp = tmp~""~getNextToken(tokensFile); //   ]
		}

		tmp = tmp~""~getNextToken(tokensFile);   // = 
		tmp = tmp~""~expression(tokensFile);    // expression 

		tmp = tmp~""~getNextToken(tokensFile);  //;

		tmp = tmp~""~"\n</letStatement>";
		return tmp;
	}

	string ifStatement(File tokensFile)
	{
		string tmp = "\n<ifStatement>";
		tmp = tmp~""~ifWhileSyntact(tokensFile);
		if(indexOf(checkNextToken(tokensFile) , "else") != -1)
		{
			tmp = tmp~""~getNextToken(tokensFile);   //   else
			tmp = tmp~""~getNextToken(tokensFile);  //   {
			tmp = tmp~""~statements(tokensFile);   //    statements
			tmp = tmp~""~getNextToken(tokensFile);  //   }
		}

		tmp = tmp~""~"\n</ifStatement>";
		return tmp;
	}

	string whileStatement(File tokensFile)
	{

		string tmp = "\n<whileStatement>";
		tmp = tmp~""~ifWhileSyntact(tokensFile);
		tmp = tmp~""~"\n</whileStatement>";
		return tmp;
	}
	string ifWhileSyntact(File tokensFile)
	{
		string tmp = getNextToken(tokensFile);   // if     while
		tmp = tmp~""~getNextToken(tokensFile);    //   (
		tmp = tmp~""~expression(tokensFile);       //   expression
		tmp = tmp~""~getNextToken(tokensFile);     //   )
		tmp = tmp~""~getNextToken(tokensFile);     //    {
		tmp = tmp~""~statements(tokensFile);        //    statements
		tmp = tmp~""~getNextToken(tokensFile);      //  }

		return tmp;
	}


	string doStatement(File tokensFile)
	{
		string tmp = "\n<doStatement>";
		tmp = tmp~""~getNextToken(tokensFile);
		tmp = tmp~""~subroutineCall(tokensFile);
		tmp = tmp~""~getNextToken(tokensFile);
		tmp = tmp~""~"\n</doStatement>";
		return tmp;
	}


	string returnStatement(File tokensFile)
	{
		string tmp = "\n<returnStatement>";
		tmp = tmp~""~getNextToken(tokensFile);
		if(indexOf(checkNextToken(tokensFile) , ";") == -1 )
		{
			tmp = tmp~""~expression(tokensFile);
		}

		return tmp~""~getNextToken(tokensFile)~""~"\n</returnStatement>";
	}



	string parseClassVarDec(File tokensFile)
	{
		string tmp = "";

		while(indexOf(checkNextToken(tokensFile) , "static") != -1 || indexOf(checkNextToken(tokensFile) , "field") != -1 )
		{
			// output = output + add tab space

			tmp = tmp~""~"\n<classVarDec>";

			tmp = tmp~""~getNextToken(tokensFile);  //static/field 
			tmp = tmp~""~getNextToken(tokensFile); // int
			tmp = tmp~""~getNextToken(tokensFile);  //  a 

			while(indexOf(checkNextToken(tokensFile) , ",") != -1 )
			{
				tmp = tmp~""~getNextToken(tokensFile);  //,
				tmp = tmp~""~getNextToken(tokensFile); // b
			}

			tmp = tmp~""~getNextToken(tokensFile); // ;


			tmp = tmp~""~"\n</classVarDec>";


		}


		return tmp;
	}
	string varDec(File tokensFile)
	{
		string tmp = "\n<varDec>";
		tmp = tmp~""~getNextToken(tokensFile);  // var
		tmp = tmp~""~getNextToken(tokensFile);   // char
		tmp = tmp~""~getNextToken(tokensFile);   // key

		while (indexOf(checkNextToken(tokensFile) , ",") != -1)
		{
			tmp = tmp~""~getNextToken(tokensFile);  // , 
			tmp = tmp~""~getNextToken(tokensFile); //  key2

		}
		tmp = tmp~""~getNextToken(tokensFile);  //;
		tmp = tmp~""~"\n</varDec>";
		return tmp;
	}


	string subroutineBody(File tokensFile)
	{
		string tmp = "\n<subroutineBody>";

		tmp = tmp~""~getNextToken(tokensFile);    //  {
		while (indexOf(checkNextToken(tokensFile) , "var") != -1)
			tmp = tmp~""~varDec(tokensFile);

		tmp = tmp~""~statements(tokensFile);
		tmp = tmp~""~getNextToken(tokensFile);                // }
		tmp = tmp~""~"\n</subroutineBody>";

		return tmp;
	}

	string subroutineDec(File tokensFile)
	{
		string tmp = "\n<subroutineDec>";
		tmp = tmp~""~getNextToken(tokensFile);     //    function
		tmp = tmp~""~getNextToken(tokensFile);   //      void
		tmp = tmp~""~getNextToken(tokensFile);    //     main
		tmp = tmp~""~getNextToken(tokensFile);   //     (
		tmp = tmp~""~parameterList(tokensFile);   //       parama ,paramb. paramc ..... 
		tmp = tmp~""~getNextToken(tokensFile);    //   )
		tmp = tmp~""~ subroutineBody(tokensFile);  //  
		tmp = tmp~""~"\n</subroutineDec>";

		return tmp;
	}

	string subroutineCall(File tokensFile)
	{
		string tmp =getNextToken(tokensFile);
		string tmp2 = tmp;

		int x = 0;
		if(indexOf(checkNextToken(tokensFile),"(") != -1)
		{ x++;
			tmp = tmp~""~getNextToken(tokensFile);    //   (
			tmp = tmp~""~expressionList(tokensFile);       //   expression
			tmp = tmp~""~getNextToken(tokensFile);     //   )
		}
		if(indexOf(checkNextToken(tokensFile),".") != -1)
		{ x++;
			tmp = tmp~""~getNextToken(tokensFile);   // .
			tmp = tmp~""~getNextToken(tokensFile);  // new
			tmp = tmp~""~getNextToken(tokensFile);  // (
			tmp = tmp~""~expressionList(tokensFile);  
			tmp = tmp~""~getNextToken(tokensFile);
		}
		if(x==0)
		{
			return tmp2;
		}


		return tmp;
	}



	string expression(File tokensFile) {
		string tmp = "\n<expression>";
		string tmp1;

		tmp=tmp~""~term(tokensFile);
		while (containOp(checkNextToken(tokensFile)))
		{tmp1 = checkNextToken(tokensFile);
			tmp=tmp~""~ getNextToken(tokensFile);       // op
			tmp=tmp~""~ term(tokensFile);
		}
		tmp = tmp~""~"\n</expression>";
		return tmp;
	}

	string expressionList(File tokensFile)
	{
		string tmp = "";

		if(indexOf(checkNextToken(tokensFile),")") != -1)
		{
			tmp = tmp~""~"\n<expressionList>"~""~"\n</expressionList>";
			return tmp;
		}
		tmp = expression(tokensFile);
		while(tmp!=""&&indexOf(checkNextToken(tokensFile),",") != -1)
		{
			tmp = tmp~""~getNextToken(tokensFile)~""~expression(tokensFile);

		}
		if(tmp!="")
		{
			tmp = "\n<expressionList>"~""~tmp~""~"\n</expressionList>"; 

		}

		return tmp;
	}

	string parameterList(File tokensFile)
	{
		string tmp = "\n<parameterList>";
		if(indexOf(checkNextToken(tokensFile) , "void") != -1||indexOf(checkNextToken(tokensFile) , "int") != -1||indexOf(checkNextToken(tokensFile) , "boolean") != -1||indexOf(checkNextToken(tokensFile) , "char") != -1||indexOf(checkNextToken(tokensFile) , "identifier") != -1)
		{
			tmp = tmp~""~getNextToken(tokensFile);  // int a
			tmp = tmp~""~getNextToken(tokensFile);  // a
			while(indexOf(checkNextToken(tokensFile) , ",") != -1)
			{
				tmp = tmp~""~getNextToken(tokensFile);  // ,
				tmp = tmp~""~getNextToken(tokensFile);  // string 
				tmp = tmp~""~getNextToken(tokensFile);  // str
			}

		}
		if(indexOf(checkNextToken(tokensFile) , ")") != -1)
		{
			tmp = tmp~""~"\n</parameterList>";
			return tmp;
		}

		tmp = tmp~""~"</parameterList>";

		return tmp;
	}


	string term(File tokensFile)
	{
		string tmp = "\n<term>";
		string nextToken = checkNextToken(tokensFile);

		if(indexOf(checkNextToken(tokensFile) , "integerConstant") != -1||indexOf(checkNextToken(tokensFile) , "stringConstant") != -1 )
		{
			tmp = tmp~""~getNextToken(tokensFile);
			if (containOp(checkNextToken(tokensFile)))
				return tmp~""~"\n</term>";
		}

		if(indexOf(checkNextToken(tokensFile) , "(") != -1 )
		{
			tmp = tmp~""~getNextToken(tokensFile);
			tmp = tmp~""~expression(tokensFile);
			tmp = tmp~""~getNextToken(tokensFile);
			return tmp~""~"\n</term>";
		}

		if(isKeyWordConstant(tokensFile))
		{
			tmp = tmp~""~getNextToken(tokensFile);
		}
		if(isunaryOp(tokensFile))
		{
			tmp = tmp~""~getNextToken(tokensFile)~""~term(tokensFile);
		}
		if(isIdentifier(tokensFile))
		{
			if(indexOf(checkNextToken(tokensFile) , "[") != -1)
			{
				tmp = tmp~""~getNextToken(tokensFile)~""~getNextToken(tokensFile);  // var name [
				tmp = tmp~""~expression(tokensFile);               //  expression 
				tmp = tmp~""~getNextToken(tokensFile);           //   ]
			}
			else
			{

				tmp = tmp~""~subroutineCall(tokensFile);
				if(indexOf(checkNextToken(tokensFile) , "[") != -1)
				{
					tmp = tmp~""~getNextToken(tokensFile);  //  [
					tmp = tmp~""~expression(tokensFile);               //  expression 
					tmp = tmp~""~getNextToken(tokensFile);           //   ]
				}

			}

		}

		if (tmp =="\n<term>")
			return "";
		return tmp~""~"\n</term>";
	}

	

}


