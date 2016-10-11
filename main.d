import std.stdio;
import std.file;
import std.string;
import std.algorithm;

extern (C) int getch();
extern (C) int kbhit();

int parse_dir()
{
	string list[];

	string root="c";
	string src="g:\\mp3";
	string pattern="*.mp3";
	string outfolder="b:\\";

	auto dFiles = dirEntries(src,pattern,SpanMode.depth);
	foreach(d; dFiles){
		string tmp;
		tmp=d.name;
		tmp=root~tmp[1..tmp.length];
		list~=tmp;
		writeln(tmp);
	}
	File file;
	string ofname=outfolder~"out.txt";
	file=File(ofname,"wb");
	sort!("toUpper(a) < toUpper(b)", SwapStrategy.stable)(list);
	foreach(s;list){
		file.write(s~"\r\n");
	}
	writeln("output file:"~ofname);
	file.close;
	return 0;
}

int main(string[] argv)
{
	try
		parse_dir();
	catch (Exception e) 
		writeln("error:"~e.msg);
	writeln("done");
	//getch();
    return 0;
}
