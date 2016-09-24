type int=longint;
const mx=40000;
var 
	hash:array[0..40010] of boolean;
	a:array[0..40010] of int;
	n,m,i,j:int;


begin
	assign(output,'tree.in');rewrite(output);
	randomize;
	n:=random(mx)+1;
	for i:=1 to n do begin
		j:=random(mx)+1;
		while hash[j] do j:=random(mx)+1;
		hash[j]:=true;
		a[i]:=j;
	end;
	writeln(n);writeln(a[1],' ',-1);
	for i:=2 to n do 
		writeln(a[i],' ',a[random(i-1)+1]);
	m:=random(mx)+1;writeln(m);
	for i:=1 to m do
		writeln(a[random(n)+1],' ',a[random(n)+1]);
	close(output);
end.
