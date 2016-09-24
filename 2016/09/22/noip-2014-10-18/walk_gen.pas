type int=longint;
var n,m,i:int;
begin
	assign(output,'walk.in');rewrite(output);
	randomize;
	n:=random(100000);m:=random(100000);
	writeln(n,' ',m);
	for i:=1 to n do writeln(random(n)+1);
	for i:=1 to m do writeln(random(n)+1,' ',random(100000000000000000));
	close(output);
end.
