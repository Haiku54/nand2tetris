import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;
import programStructures;
import Expressionss;
import symboleTables;
import main11;

class Statements{

	symboleTable st;
	symboleTable ft;
	
	
	Expressions Exp;
	this(symboleTable St,symboleTable Ft){
	st = St;
	ft = Ft;
	Exp = new Expressions(St , Ft);
	
	};

	string statements()
	{
		string output = "";
		string state;

		while(indexOf(checkNextToken() , "let") != -1||
			  indexOf(checkNextToken() , "if") != -1||
			  indexOf(checkNextToken() , "while") != -1||
			  indexOf(checkNextToken() , "do") != -1||
			  indexOf(checkNextToken() , "return") != -1)
		{

			throwNextToken(); // < # Statement> 
			auto keyWord = split(checkNextToken());
			switch (keyWord[1])
			{
				case "let":		output=output~""~letStatement();
					break;
				case "if":		output=output~""~ifStatement();
					break;
				case "while":	output=output~""~whileStatement();
					break;
				case "do":		output=output~""~doStatement();
					break;
				case "return":	output=output~""~returnStatement();
					break;
				default: break;
			}
		}
		throwNextToken(); // </statements>
		return output;
	}

	string letStatement( )
	{
		string output = "";
		throwNextToken();  //let
		string name = getTagValue();
    	KIND kind = ft.kindOf(name);
		if(kind == KIND.NONE) // not exsist in method scope
		{
			kind = st.kindOf(name);
		}
		int varIndex = ft.indexOf(name);
		if(varIndex == -1) // not exsist in method scope
		{
			varIndex = st.indexOf(name);
		}



		if (indexOf(checkNextToken() , "[") != -1)
		{
			throwNextToken();    //   [  
			throwNextToken();    //  expression 
			output = output~""~Exp.expression();
			throwNextToken(); // ]
			output = output~""~"push "~""~KindToString(kind)~""~" "~""~to!string(varIndex)~""~"\n"
				~""~"add\n";
			throwNextToken();    //   =
            throwNextToken();    //   expression  
			output = output~""~Exp.expression(); 
			output = output~""~"pop temp 0\n"
			~""~"pop pointer 1\n"
			~""~"push temp 0\n"
			~""~"pop that 0\n";

		}
		else
		{
			
			throwNextToken();    //  =  
			throwNextToken();    //  expression 
			output = output~""~Exp.expression();
			output = output~""~"pop "~""~KindToString(kind)~""~" "~""~to!string(varIndex)~""~"\n";
		
		}

		throwNextToken();    //  ; 
		throwNextToken();    //  </letStatement>  
		return output;
	}

	string ifStatement()
	{
		int index= ft.indexIf;
		ft.indexIf++;
		string output="";
		throwNextToken(); // if
        throwNextToken(); // (
        throwNextToken(); // expression
        output = output~""~Exp.expression();
		throwNextToken(); // )
		output = output~""~"if-goto IF_TRUE"~""~to!string(index)~""~"\n";
        output = output~""~"goto IF_FALSE"~""~to!string(index)~""~"\n";
        output = output~""~"label IF_TRUE"~""~to!string(index)~""~"\n";
        throwNextToken(); // {
        throwNextToken(); // <statments>
        output =output~""~statements();
        throwNextToken(); //}

	if(indexOf(checkNextToken() , "else") != -1)
	{
		output = output~""~"goto IF_END"~""~to!string(index)~""~"\n"~""~
			"label IF_FALSE"~""~to!string(index)~""~"\n";
			throwNextToken(); // else
			throwNextToken(); // {
			throwNextToken(); // <statements>
			output = output~""~statements();
			throwNextToken(); // }
			output = output~""~"label IF_END"~""~to!string(index)~""~"\n";
	}
	else
	{
	 output =output~""~"label IF_FALSE"~""~to!string(index)~""~"\n";
	}

	throwNextToken(); // </ifStatement>
	return output;
	}

	string whileStatement()
	{
		int index= ft.indexWhile;
		ft.indexWhile++;
		string output="";
		throwNextToken(); // while
        throwNextToken(); // (
        output = output~""~"label WHILE_EXP"~""~to!string(index)~""~"\n";
        throwNextToken(); // <expression>
        output = output~""~Exp.expression();
        throwNextToken(); // )
        output = output~""~"not\n"~""~
		"if-goto WHILE_END"~""~to!string(index)~""~"\n";
        throwNextToken(); // {
        throwNextToken(); // <statements>
        output = output~""~statements();
        throwNextToken(); // }
        output = output~""~"goto WHILE_EXP"~""~to!string(index)~""~"\n"~""~
		"label WHILE_END"~""~to!string(index)~""~"\n";
        throwNextToken(); // </whileStatement>
        return output;


	}
	string ifWhileSyntact()
	{
		string tmp = getNextToken();   // if     while
		tmp = tmp~""~getNextToken();    //   (
		tmp = tmp~""~Exp.expression();       //   expression
		tmp = tmp~""~getNextToken();     //   )
		tmp = tmp~""~getNextToken();     //    {
		tmp = tmp~""~statements();        //    statements
		tmp = tmp~""~getNextToken();      //  }

		return tmp;
	}


	string doStatement()
	{
		string output = "";
        throwNextToken(); // do\
		string f  = checkNextToken();
        if(indexOf(checkNextToken(),"<subroutineCall>")!=-1 )
		{
              throwNextToken(); // subroutineCall
		}
		output = output~""~Exp.subroutineCall();
		output = output~""~"pop temp 0\n";
		throwNextToken(); // ;
        throwNextToken(); // /doStatement>
        return output;
	}


	string returnStatement()
	{
		string output="";
		throwNextToken(); //  return
		if(indexOf(checkNextToken(),";")!=-1 )
		{
			output = output~""~"push constant 0\n";
		}
		else
		{
			throwNextToken(); //  <expression>
			output = output~""~Exp.expression();
		
		}
		
		output = output~""~"return\n";

		throwNextToken(); // ;
            throwNextToken(); // </returnStatement>
            return output;

	}

}
