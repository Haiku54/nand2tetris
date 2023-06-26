
//module programStructure;
import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;
import Statementss;
import std.xml;
import symboleTables;
import main11;
import Statementss;
//========================================== help functions ===========================================
string getNextToken()
{
	string tmp = "\n"~""~strip(chomp(tokensFile.readln()));
	//writeln(tmp);
	return tmp;

}

void throwNextToken()
{
	string tmp = "\n"~""~strip(chomp(tokensFile.readln()));
	//writeln(tmp);
	
}

string checkNextToken()
{
	auto pos = tokensFile.tell();    // get the file corennt offset
	string tmp = strip(chomp(tokensFile.readln()));   // get the next token 
	//writeln("the next token is:",tmp);
	tokensFile.seek(pos, SEEK_SET);    // go back to the previous offset 
	return tmp;
}

string checkNextNextToken()
{
	auto pos = tokensFile.tell();    // get the file corennt offset
	string tmp = strip(chomp(tokensFile.readln()));   // get the next token to move forword to the nextNext token
	tmp = strip(chomp(tokensFile.readln()));   // get the nextNext token
	tokensFile.seek(pos, SEEK_SET);    // go back to the previous offset 
	return tmp;
}


string KindToString(KIND k)
{
	string tmp="";
	switch (k)
	{
		case KIND.STATIC:	tmp = "static";
			break;
		case KIND.FIELD:	  tmp = "this";
			break;
		case KIND.VAR:		   tmp = "local";
			break;
		case KIND.ARG:		   tmp = "argument";
			break;
		default: break;
	}
	return tmp;
}



string getTagValue()
{
auto keyWord = split(getNextToken());
	return keyWord[1];
}

string checkTagValue()
{
	auto keyWord = split(checkNextToken());
	return keyWord[1];
}
string checkTagValue(string tokens)
{
	auto keyWord = split(tokens);
	return keyWord[1];
}
string getStringConstantValue()
{
	//auto Tindex = lastIndexOf(fileName, 'T'); // 9
	//string newFileName = fileName[0 .. Tindex];
	string str = checkNextToken();   //<stringConstant> hello world </stringConstant>


	int index = cast(int)lastIndexOf(str," </stringConstant>");

	string str2 = str[0..index];                    //<stringConstant> hello world
	index = cast(int)lastIndexOf(str2,">");

	string str3 = str2[index+2 .. str2.length];  //  hello world
	
	return str3;
}


//==================================================================================================================  



class programStructure{

	
	this(){};
	Statements stat;
    string classNAme = "";
	symboleTable st = new symboleTable("");  // symboleTable
	symboleTable ft = new symboleTable("");  // functionTable

	

	string parseClass()
	{
		st.startSubroutine();
        string output="";
		throwNextToken();         // <class>
        throwNextToken();         // class
		//string type_class = getTagValue(); 
		//st.setClassType(type_class);
        classNAme = getTagValue();  // calssName
		st.setClassName(classNAme);
		//st.printTable();



		throwNextToken();   //{
		while(indexOf(checkNextToken() , "classVarDec") != -1 )
		{
			throwNextToken();  
			parseClassVarDec();
		}
		while(indexOf(checkNextToken() , "subroutineDec") != -1 )
		{
			throwNextToken();      //  <subroutineDec>
			output = output~""~subroutineDec(st);
		}

		throwNextToken();    //  }
        throwNextToken();  // <class>
		return output;



	}

	void parameterList()
	{

 
		KIND kind = KIND.ARG;
		

		do {
			if(indexOf(checkNextToken() , ",") != -1)
			{
				throwNextToken(); // ,
			}
			string type = getTagValue();
			string name = getTagValue();
			
			ft.define( name,  type, "arg");

			
		} while (indexOf(checkNextToken() , ",") != -1);
		throwNextToken(); // </parameterList>


	}

	string subroutineDec(symboleTable st)
	{
		ft.startSubroutine();
		//ft.printTable();

		ft.setClassName(st.getClassName());   // the class of the functions
		string tmp = checkNextToken();
		string output= "";
		tmp = checkTagValue(); 
		switch (tmp)
		{
			case "constructor":
				throwNextToken();  //c-tor
				throwNextToken();  //type
				throwNextToken();  //sunboutinName
				throwNextToken();  //(
				throwNextToken();  //<parameterList>
				if(!(indexOf(checkNextToken() , "</parameterList>") != -1)){
                  parameterList();
				}
				else{
				throwNextToken(); // </parameterList>
				}
				throwNextToken();    // )
				throwNextToken(); // <subrotineBody>
				string subRoutinOutput=subroutineBody( ft ,st);
				output= output~""~"function "~""~to!string(st.getClassName())~""~".new "~""~to!string(st.getVarCount(KIND.VAR))~""~"\n"
					~""~"push constant "~""~to!string(st.getVarCount(KIND.FIELD))~""~"\n"
					~""~"call Memory.alloc 1\n"
					~""~"pop pointer 0\n"
					~""~subRoutinOutput;
				break;
				case "function":
					//ft.define("this",ft.getClassName(),"arg"); // new--
					if(st.getClassName() != "Main")
					{
						ft.define("this",ft.getClassName(),"arg");
					}
                    throwNextToken(); // function
					throwNextToken(); // type
					string name =  getTagValue();
					 throwNextToken(); // (
					 throwNextToken(); //  <parameterList>
					 if(!(indexOf(checkNextToken() , "</parameterList>") != -1)){
						parameterList();
					 }
					 else
					 {
						throwNextToken(); //  <parameterList>  there are no  parameters
					 }

					 throwNextToken();   //   )
					 throwNextToken();  //     <subrotineBoby>
				     string subRoutinOutput=subroutineBody( ft ,st);
					 output= output~""~"function "~""~to!string(st.getClassName())~""~"."~""~name ~""~" "~""~to!string(ft.getVarCount(KIND.VAR))~""~"\n"
				     ~""~subRoutinOutput;
					break;

				case "method":
					ft.define("this",ft.getClassName(),"arg"); // new--
                    throwNextToken(); // method
					string type =  getTagValue();
					string name =  getTagValue();
					throwNextToken(); // (
					throwNextToken(); //  <parameterList>
					if(!(indexOf(checkNextToken() , "</parameterList>") != -1)){
						parameterList();
					}
					else
					{
						throwNextToken(); //  <parameterList>  there are no  parameters
					}

					throwNextToken();   //   )
					throwNextToken();  //     <subrotineBoby>
					string subRoutinOutput=subroutineBody(ft ,st);
					output= output~""~"function "~""~to!string(st.getClassName())~""~"."~""~name~""~" "~""~to!string(ft.getVarCount(KIND.VAR))~""~"\n"
					~""~"push argument 0\n"
						~""~"pop pointer 0\n"
						~""~subRoutinOutput;
					if(name == "run")
						ft.printTable();
					break;
			default: break;

		}
		
		throwNextToken();   //   // </subroutineDec>
		//ft.printTable();
		//st.printTable();
		
		return output;
	}

	void parseClassVarDec()
	{
		 
		string kind=getTagValue(); 
		string type = getTagValue();
		string name;
		do{
			if(indexOf(checkNextToken() , ",") != -1)
			{
				throwNextToken();   
			}
			name = getTagValue();
			st.define(name,type,kind);
			
			KIND ko = st.kindOf(name);
			string to =  st.typeOf(name);
			int io =  st.indexOf(name);


			
		}while(indexOf(checkNextToken() , ",") != -1);

		throwNextToken();  // ;
		throwNextToken();  //</classVarDec>
		
	}
	void varDec()
	{
		throwNextToken();  // var
		string type = getTagValue();
		string name ="";
		string kind = "var";
		int indexOfArg;
		do{
			if(indexOf(checkNextToken() , ",") != -1)
			{
				throwNextToken();  // ,
			}
		    name = getTagValue();
			ft.define(name,type,kind);
			//ft.printTable();
		}while(indexOf(checkNextToken() , ",") != -1);
		
		
		throwNextToken();  // ;
		throwNextToken();  // varDec
	}


	string subroutineBody(symboleTable ft , symboleTable st)
	{
		string output  = "";
		throwNextToken(); // {
		do{
			if(indexOf(checkNextToken() , "varDec") != -1)
			{
				throwNextToken();  // <varDec>
                varDec();
			}
	
		}while(indexOf(checkNextToken() , "var") != -1);

        throwNextToken();  // <statements>
		stat = new Statements(st,ft);
		output = output~""~stat.statements();
		if(indexOf(checkNextToken() , "}") != -1)
		{
			throwNextToken();  // }

		}

		throwNextToken();  // </subroutineBody>

		return output;
	}







}

