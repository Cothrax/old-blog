type int=longint;
var n,i:int;
begin
	assign(output,'mouse.in');rewrite(output);
	randomize;
	n:=random(1000)+1;
	writeln(n);
	for i:=1 to n do write(random(1000)+1,' ');writeln;
	for i:=1 to n do write(random(1000)+1,' ');writeln;
	close(output);
end.
