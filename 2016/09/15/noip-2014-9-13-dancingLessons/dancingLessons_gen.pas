type int=longint;
var 
	n,i:int;

begin
	assign(output,'dancingLessons.in');rewrite(output);
	randomize;
	n:=random(100000)+1;writeln(n);
	for i:=1 to n do 
		if random(2)=1 then write('B') else write('G');writeln;
	for i:=1 to n do write(random(100000)+1,' ');writeln;
	close(output);
end.
