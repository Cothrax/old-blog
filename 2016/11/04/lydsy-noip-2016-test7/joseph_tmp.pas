uses math;
type int=longint;
var 
	n,m,k,i,j:int;
	f:array[0..1000000] of int;

begin
	assign(input,'joseph.in');reset(input);
	assign(output,'joseph.out');rewrite(output);
	read(n,m);
	i:=1;
	while i<=n do k:=k*m;
	write((n-i div m) div (m-1)*m);
	close(input);close(output);
end.
