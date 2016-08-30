type int=longint;
var 
	n,k,i,j:int;
	f:array[-1..1010,-1..1010] of int;

begin
	assign(input,'num.in');reset(input);
	assign(output,'num.out');rewrite(output);
	read(n,k);
	f[0,0]:=1;
	for i:=1 to n do
		for j:=0 to i-1 do
			f[i,j]:=(f[i-1,j-1]*(i-j)+f[i-1,j]*(j+1)) mod 2012;
	write(f[n,k]);
	close(input);close(output);
end.
