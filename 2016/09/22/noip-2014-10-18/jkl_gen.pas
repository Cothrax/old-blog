type int=longint;
const z=1000;
var 
	n,i,j,s:int;
	a:array[0..z] of int;

begin
	assign(output,'jkl.in');rewrite(output);
	randomize;
	n:=random(z);s:=0;
	for i:=1 to n do begin
		j:=random(z);
		inc(s,j);a[i]:=j;
	end;
	writeln(n,' ',random(s));
	for i:=1 to n do write(a[i],' ');
	close(output);
end.
