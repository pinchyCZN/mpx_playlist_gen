import std.stdio;
import std.file;
import std.string;
import std.algorithm;
import std.getopt;

extern (C) int getch();
extern (C) int kbhit();

int parse_dir(string src,string pattern,string root)
{
	string list[];

	auto dFiles = dirEntries(src,pattern,SpanMode.depth);
	foreach(d; dFiles){
		string tmp;
		int rlen;
		tmp=d.name;
		rlen=root.length;
		tmp=root~tmp[rlen..tmp.length];
		list~=tmp;
	}
	sort!("toUpper(a) < toUpper(b)", SwapStrategy.stable)(list);
	foreach(s;list){
		writeln(s);
	}
	return 0;
}

int main(string[] argv)
{
	if(argv.length<=1){
		writeln("--src c:\\stuff\\foo --pattern *.{mp3,ogg} --prefix c");
		return 0;
	}
	try{
		string src,pattern,prefix;
		auto opt=getopt(
			argv,
			"src",&src,
			"pattern",&pattern,
			"prefix",&prefix,
		);
		parse_dir(src,pattern,prefix);
	}
	catch (Exception e){
		writeln("error:"~e.msg);
	}
    return 0;
}
