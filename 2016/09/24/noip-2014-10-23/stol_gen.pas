type int=longint;
var n,m,i,j:int;
begin
	assign(output,'stol.in');rewrite(output);
	randomize;
	n:=random(200)+1;m:=random(200)+1;
	writeln(n,' ',m);
	for i:=1 to n do begin
		for j:=1 to m do
			if random(3)=1 then write('X') else write('.');
		writeln;
	end;
end.
