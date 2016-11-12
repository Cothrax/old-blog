type int=longint;
var 
	n,i:int;
	a:array[0..100010] of int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

begin
	assign(output,'road.in');rewrite(output);
	n:=100000;randomize;
	for i:=1 to n do a[i]:=i;
	for i:=1 to n do swap(a[random(n)+1],a[random(n)+1]);
	writeln(n);
	for i:=1 to n do write(a[i],' ');writeln;
	for i:=1 to n do swap(a[random(n)+1],a[random(n)+1]);
	for i:=1 to n do write(a[i],' ');writeln;
	close(output);
end.
