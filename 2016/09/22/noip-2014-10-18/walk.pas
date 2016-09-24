type int=longint;
const mx=60;
var
	f:array[0..100010,0..mx] of int;
	bin:array[0..mx] of int64;
	n,m,t,i,j:int;k:int64;

begin
	assign(input,'walk.in');reset(input);
	assign(output,'walk.out');rewrite(output);
	read(n,m);
	for i:=1 to n do read(f[i,0]);
	bin[0]:=1;
	for i:=1 to mx do bin[i]:=bin[i-1]*int64(2);
	for j:=1 to mx do
		for i:=1 to n do
			f[i,j]:=f[f[i,j-1],j-1];
	for i:=1 to m do begin
		read(t,k);
		for j:=mx downto 0 do
			if bin[j]<=k then begin
				dec(k,bin[j]);t:=f[t,j];
			end;
		writeln(t);
	end;
	close(input);close(output);
end.

