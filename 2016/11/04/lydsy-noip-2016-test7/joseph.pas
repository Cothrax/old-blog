uses math;
type int=longint;
var 
	n,m,k,i,j:int;
	f:array[0..1000000] of int;

begin
	assign(input,'joseph.in');reset(input);
	assign(output,'joseph.out');rewrite(output);
	read(n,m);
	k:=(n-1) div (m-1);
	f[0]:=1;
	for i:=0 to k-1 do
		f[i+1]:=f[i]mod(i*(m-1)+1)+m;
	write(f[k]);
end.
