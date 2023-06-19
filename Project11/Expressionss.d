import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;
import programStructures;
import symboleTables;
import main11;


class Expressions {

	symboleTable st;
	symboleTable ft;

	this(symboleTable St,symboleTable Ft)
	{
		st = St;
	    ft  =  Ft;
	};

	string subroutineCall()
	{
		string output ="";
		string NextNextToken =checkNextNextToken();
		string NextNextTokenTagValue = checkTagValue(NextNextToken);

		if(NextNextTokenTagValue=="(")
		{ 
			output = output~""~"push pointer 0\n";
			string nameFunction = getTagValue();
			throwNextToken(); // (
			throwNextToken();  //<expressionList>
			string[2] tmpOutPut_And_listArg = expressionList(ft) ; 
				throwNextToken(); // )
				int num = to!int(tmpOutPut_And_listArg[0])+1;
				string tmpOutput = tmpOutPut_And_listArg[1];
				output = output~""~tmpOutput;
				output = output~""~"call "~""~ft.getClassName()~""~"."~""~nameFunction~""~" "~""~to!string(num)~""~"\n";


		}
		if(NextNextTokenTagValue==".")
		{ 
			bool inSymboleTable= false;
			// first check if it is father class
			// if not father class chack if it is object (var name) from other class  (in scopse tables)
			// if is not father class and not object (var name (Square 'square')  ) from other class it is have to be otherClass (Square.new)
			string name = getTagValue();
			string className = st.nameOfClass;

			throwNextToken();  // .
			string subroutineName = getTagValue();
			throwNextToken();  // (
			throwNextToken();  // <expressionList> 
			string tmpout="";
			int num;

		    KIND kind = ft.kindOf(name); // check in method scope
			if(kind==KIND.NONE)
			{
				kind = st.kindOf(name);    // check in class scope
				if(kind!=KIND.NONE)
				{
					inSymboleTable = true;
				}
			}
        	//ft.printTable();
			if(name == className) // is the father class
			{
				string[2] tmpOutPut_And_listArg = expressionList(ft) ; 
				throwNextToken();  // )
				num = to!int(tmpOutPut_And_listArg[0]);
				tmpout = tmpout~""~tmpOutPut_And_listArg[1];
				output = output~""~tmpout;
				output = output~""~"call "~""~className~""~"."~""~subroutineName~""~" "~""~to!string(num)~""~"\n";
				
			
			}
			else
			{
				string str = ft.typeOf(name); // check in method scope
				if(str=="")
				{
					str = st.typeOf(name);     // chack in class scope
					if(str!="")
					{
						inSymboleTable = true;
					}
				}


				

				if(str=="")   // other class
				{
					string[2] tmpOutPut_And_listArg = expressionList(ft) ; 
					throwNextToken();  // )
					num = to!int(tmpOutPut_And_listArg[0]);
					tmpout = tmpout~""~tmpOutPut_And_listArg[1];


				}
				else  // varName
				{
					if(inSymboleTable)
					{
						output = output~""~"push "~""~KindToString(kind)~""~" "~""~to!string(st.indexOf(name))~""~"\n";	
					}
					else
					{
						output = output~""~"push "~""~KindToString(kind)~""~" "~""~to!string(ft.indexOf(name))~""~"\n";
					}

					string[2] tmpOutPut_And_listArg = expressionList(ft) ; 
					throwNextToken();  // )
					num = to!int(tmpOutPut_And_listArg[0]) + 1;
					tmpout = tmpout~""~tmpOutPut_And_listArg[1];

				}
				output = output~""~tmpout;
				if(str=="")   // other class
				{
					output = output~""~"call "~""~name~""~"."~""~subroutineName~""~" "~""~to!string(num)~""~"\n";	
				}
				else
				{  
					if(inSymboleTable)
					{
						output = output~""~"call "~""~st.typeOf(name)~""~"."~""~subroutineName~""~" "~""~to!string(num)~""~"\n";	
					}
					else
					{
						output = output~""~"call "~""~ft.typeOf(name)~""~"."~""~subroutineName~""~" "~""~to!string(num)~""~"\n";
					}

				}
			
			}
			


			


		}
		if(indexOf(checkNextToken() , "</subroutioneCall>") != -1)
		{
				throwNextToken();  // )

		}

		return output;
	}



	string expression() {

		string output="";
		throwNextToken();    //  <term>
		output = term(ft);
		while (containOp(checkNextToken()))
		{
			string operator = getOperator();
			throwNextToken();    //  </term>
			output=output~""~ term(ft);
			output=output~""~operator;
		}
		
		
		throwNextToken();    // </expression>

		return output;
	}

	string[] expressionList(symboleTable ft)
	{
		int listArgs =0;
		string tmp = "";

		if(!(indexOf(checkNextToken() , "</expressionList>") != -1)){
			do {
					listArgs++;
				if (indexOf(checkNextToken() , ",") != -1)
					throwNextToken() ; //,
				throwNextToken() ; //  // <expression>
				tmp = tmp~""~expression();
				



			} while (indexOf(checkNextToken() , ",") != -1);
		}
		throwNextToken() ; //  </expressionList>
			
		string[]str = [to!string(listArgs),tmp];
		return str;

	}


	string term(symboleTable ft)
	{
		string nextToken = checkNextToken();
		string output="";
		string tmp="";
		bool flag=false;


		if(indexOf(checkNextToken() , "integerConstant") != -1)
		{
		  output = output~""~"push constant "~""~checkTagValue()~""~"\n";
		  throwNextToken(); // <integerConstant>  val  </integerConstant>
		  flag=true;
		}


		else if(indexOf(checkNextToken() , "stringConstant") != -1 )
		{
			string str = getStringConstantValue();
			output = output~""~"push constant "~""~to!string(str.length)~""~"\n"~""~
				 "call String.new 1\n";
			
			int temp;
			foreach(letter; str)
			{
				temp = to!int(letter);
			output = output~""~	"push constant "~""~to!string(temp)~""~"\n"~""~
			"call String.appendChar 2\n";
			
			}
			throwNextToken();  // <stringConstants> val </stringConstants>
			  flag=true;
		}

		else if(indexOf(checkNextToken() , "(") != -1 )
		{
			throwNextToken();   //(
			throwNextToken();  //  <expression>
			output = output~""~expression();
			throwNextToken();  // )
			  flag=true;
		}

		else if(isKeyWordConstant())
		{
			output = output~""~keyWordToVM();
			throwNextToken(); // <keyWordConstant>
			  flag=true;
		}
		
		else if(isunaryOp())
		{
			string unaryOp = checkNextToken();
			throwNextToken(); // -    ~
			throwNextToken();// <term>
			output = output~""~term(ft)~""~unaryToVM(unaryOp);
			  flag=true;


		}
		
		else if(isIdentifier())
		{
			  flag=true;
			if(indexOf(checkNextNextToken() , "(") != -1||indexOf(checkNextNextToken() , ".") != -1)
			{
				output = output~""~""~subroutineCall();

			}
			else
			{

				string name = checkTagValue();
				KIND kind = ft.kindOf(name);
				if(kind == KIND.NONE)
				{
					kind = st.kindOf(name);
				}
				int index = ft.indexOf(name);
				if(index == -1)
				{
					index = st.indexOf(name);
				}
				 throwNextToken(); // varName

				 if (indexOf(checkNextToken() , "[") != -1) 
				 {
					throwNextToken(); // [
						throwNextToken(); // <expression>
						string tempOutput = "";
						tempOutput = tempOutput~""~expression();
						throwNextToken(); // ]
						tempOutput = tempOutput~""~"push "~""~KindToString(kind)~""~" "~""~to!string(index)~""~"\n";
						tempOutput = tempOutput~""~"add\n";
						tempOutput = tempOutput~""~"pop pointer 1\n";
						tempOutput = tempOutput~""~"push that 0\n";
						output = output~""~tempOutput;
				 }
				 else
				 {
					
					output = output~""~"push "~""~KindToString(kind)~""~" "~""~to!string(index)~""~"\n";
				 
				 }


			}

		}
		else if(!flag)
		{
			throwNextToken(); // <subroutineCall>
			output = output~""~subroutineCall();
			// when it is gona enter here ?

		}

	throwNextToken();        // </term>
		return output;
	}



	bool containOp(string token)    // check if the token contain operator
	{
		string[] op = ["+" , "-" , "*" , "/", "&amp;" , "|" , "&gt;" , "&lt;" , "=" , "~"];
		auto operator = split(token);
		if(operator.length > 1)
		{
			if(canFind(op,operator[1]))
			{
			 return true;
			}
				
		}
		else
		{
		 return false;
		}
return false;

		
		
	}
	bool isKeyWordConstant(){
		return (indexOf(checkNextToken() , "true") != -1 ||
				indexOf(checkNextToken() , "false") != -1 ||
				indexOf(checkNextToken() , "null") != -1 ||
				indexOf(checkNextToken() , "this") != -1 );
	}

	bool isunaryOp(){
		return (indexOf(checkNextToken() , "-") != -1 ||
				indexOf(checkNextToken() , "~") != -1 );
	}

	bool isIdentifier(){
		return (indexOf(checkNextToken() , "identifier") != -1);
	}


	string unaryToVM(string unaryOp)
	{
		auto unop = split(unaryOp);
		if(unop[1]=="~")
			return "not\n";
		else if(unop[1]=="-")
			return "neg\n";
		else
			return "unaru op error";
	}

	string getOperator()
	{
	  string op = getTagValue();
	string tmp = "";

	switch (op)
	{
		case "+":		tmp = "add\n";
			break;
		case "-":		tmp = "sub\n";
			break;
		case "*":		tmp = "call Math.multiply 2\n";
			break;
		case "/":		tmp = "call Math.divide 2\n";
			break;
		case "&amp;":	tmp = "and\n";
			break;
		case "|":		tmp = "or\n";
			break;
		case "&lt;":		tmp = "lt\n";
			break;
		case "&gt;":		tmp = "gt\n";
			break;
		case "=":		tmp = "eq\n";
			break;
		default: break;
	}



	return tmp;
	}




	string keyWordToVM ()
	{
		string tmp="";
		string keyWord = checkTagValue();
		switch (keyWord)
		{
			case "true":		tmp = "push constant 0\n"~""~"not\n";
				break;
			case "false":		tmp = "push constant 0\n";
				break;
			case "null":		tmp = "push constant 0\n";
				break;
			case "this":		tmp = "push pointer 0\n";
				break;
	
			default: break;
		}
		return tmp;
	
	}

}





