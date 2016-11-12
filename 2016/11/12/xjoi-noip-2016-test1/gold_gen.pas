type int=longint;
var n,m,i,j:int;
begin
	assign(output,'gold.in');rewrite(output);
	randomize;
	n:=1000;m:=100;
	writeln(n,' ',m);
	for i:=1 to n do begin
		for j:=1 to m do write(random(1000000000)+1,' ');
		writeln;
	end;
	close(output);
end.
