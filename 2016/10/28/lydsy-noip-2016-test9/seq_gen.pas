type int=longint;
var n,i:int;

begin
	assign(output,'seq.in');rewrite(output);
	randomize;
	n:=200;
	writeln(n);
	for i:=1 to n do write(random(maxlongint)+1,' ');
	close(output);
end.
