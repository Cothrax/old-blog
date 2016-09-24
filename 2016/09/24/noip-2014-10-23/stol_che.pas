uses math;
type int=longint;
var 
	a:array[0..410,0..410] of char;
	n,m,i,j,k,t,ans:int;

function jud(u,d,l,r:int):boolean;
var i,j:int;
begin
	for i:=u to d do
		for j:=l to r do
			if a[i,j]='X' then exit(false);
	jud:=true;
end;

begin
	assign(input,'stol.in');reset(input);
	assign(output,'stol.ans');rewrite(output);
	readln(n,m);
	for i:=1 to n do begin
		for j:=1 to m do read(a[i,j]);
		readln;
	end;
	ans:=0;
	for i:=1 to n do
		for j:=1 to m do
			for t:=i to n do	
				for k:=j to m do
					if jud(i,t,j,k) then
						ans:=max(ans,(t-i+1+k-j+1)*2);
	write(ans-1);
	close(input);close(output);
end.
