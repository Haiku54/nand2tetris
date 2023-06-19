import  std.file, std.string, std.stdio,std.algorithm, std.path,std.conv,std.typecons : No;
import std.algorithm.comparison : equal;
import std.conv : to;
import std.path;
import std.uni : lineSep, paraSep;
enum KIND {STATIC, FIELD, ARG, VAR, NONE}

class rowInTable {

	int index;
	string type;
	KIND kind;
	
	this()
	{
		 index =0;
		 type = "";
		 kind = KIND.NONE;
	
	}
	this(int Index , string Type, KIND Kind)
	{
		type = Type;
		kind = Kind;
		index = Index;

	}
	void printRow()
	{
		write("\t\t",index,"                 "~""~type~""~"       ",kind);

	}


} 


class symboleTable{

	int rowIndex;
	rowInTable[string] table;
	int staticNum;
    int fieldNum ;
    int argNum;
    int varNum;
	string nameOfClass= "";
	//string type_of_class="";
	int indexIf = 0;
	int indexWhile = 0;
    
	this(string name_Of_Class)
	{
		rowIndex=0;
		staticNum = 0;
		fieldNum = 0;
		argNum = 0;
		varNum = 0;
		nameOfClass= name_Of_Class;
		indexIf = 0;
		indexWhile = 0;

	
	}

	//this(string name_Of_Class,string type)
	//{
	//    rowIndex=0;
	//    staticNum = 0;
	//    fieldNum = 0;
	//    argNum = 0;
	//    varNum = 0;
	//    nameOfClass= name_Of_Class;
	//    type_of_class = type;
	//    indexIf = 0;
	//    indexWhile = 0;
	//
	//}

	void startSubroutine() {
        
			argNum = 0;
			varNum = 0;
			indexIf = 0;
			indexWhile = 0;
			rowIndex=0;
			staticNum = 0;
			fieldNum = 0;
			table = null;
    }
	//void startSubroutine_ft() {
	//
	//    argNum = 1;
	//    varNum = 0;
	//    indexIf = 0;
	//    indexWhile = 0;
	//    rowIndex=0;
	//    staticNum = 0;
	//    fieldNum = 0;
	//}

	void define(string name, string type, string kind){

		if(kind=="static")
		{

			rowInTable row = new rowInTable();
			row.type=type;
			row.kind = KIND.STATIC;
			row.index = staticNum;
			table[name]=row;
			++staticNum;		
		}
		else if(kind=="field")
		{
			rowInTable row = new rowInTable();
			row.type=type;
			row.kind = KIND.FIELD;
			row.index = fieldNum;
			table[name]=row;
			++fieldNum;	
		}
		else if(kind == "var")
		{
			rowInTable row = new rowInTable();
			row.type=type;
			row.kind = KIND.VAR;
			row.index = varNum;
			table[name]=row;
			varNum++;	
		}

		else if(kind=="arg")
		{

			rowInTable row = new rowInTable();
			row.type=type;
			row.kind = KIND.ARG;
			row.index = argNum;
			table[name]=row;
			++argNum;	
		}

		else assert(0);

	}


	KIND kindOf(string name){

		string [] keys = table.keys;
		for(int i=0 ; i<keys.length ; i++ )
			if(keys[i]==name)
				return table[name].kind;
		return KIND.NONE;

	}

	string typeOf(string name){
		string [] keys = table.keys;
		for(int i=0 ; i<keys.length ; i++ )
			if(keys[i]==name)
				return table[name].type;
		return "";
	}

	int indexOf(string name){
		string [] keys = table.keys;
		for(int i=0 ; i<keys.length ; i++ )
			if(keys[i]==name)
				return table[name].index;
		return -1;
	}


	void updateStaticNum() {
		staticNum++;
    }

	int getStaticNum()
	{
		return staticNum;
	}




	void updateFieldNum() {
		fieldNum++;
    }

	int getFieldNum()
	{
		return fieldNum;
	}



	void updateArgNum() {
		argNum++;
    }

	int getArgNum()
	{
		return argNum;
	}




	void updateVarNum() {
		varNum++;
    }

	int getVarNum()
	{
		return varNum;
	}


	string  getClassName() {
        return nameOfClass;
    }

	void setClassName(string name_Of_Class) {
         nameOfClass = name_Of_Class;
    }

	//void setClassType(string type) {  // new
	//    type_of_class = type;
	//}
	//
	//string getClassType() {  //new
	//    return type_of_class ;
	//}

	int getVarCount(KIND k){
		string s= to!string(k);
		switch (s)
		{
			case "STATIC":		
				return staticNum;
				break;
			case "FIELD":
				return fieldNum;
				break;
			case "ARG":	      
				return argNum;
				break;
			case "VAR":		  
				return varNum;
				break;
			default:
				return -1;
				break;
		}
	}


	//void setRow(rowInTable row) {
	//    table[rowIndex++] = row;
	//}


	void printTable(){
		
		writeln("\n\t      ========================================================");
		writeln("\t\tindex","\t||\ttype","\t||\tkind","\t||\tname");
		writeln("\t      ========================================================");
		
		string [] keys = table.keys;
		for(int i=0 ; i<keys.length ; i++ )
		{
			table[keys[i]].printRow();
			write("\t\t"~""~keys[i]~""~"\n");
		}

			




	}



}