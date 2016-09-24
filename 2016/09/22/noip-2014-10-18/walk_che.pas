type int=longint;
var 
	next:array[0..100010] of int;
	n,m,t,i,j:int;k:int64;

begin
	assign(input,'walk.in');reset(input);
	assign(output,'walk.ans');rewrite(output);
	read(n,m);
	for i:=1 to n do read(next[i]);
	for i:=1 to m do begin
		read(t,k);
		for j:=1 to k do t:=next[t];
		writeln(t);
	end;
	close(input);close(output);
end.
