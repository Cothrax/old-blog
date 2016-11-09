uses math;
type int=longint;
var
	f:array[0..210,0..210] of int64;
	a:array[0..210] of int64;
	n,i,j,k:int;ans:double;

begin
	assign(input,'seq.in');reset(input);
	assign(output,'seq.ans');rewrite(output);
	read(n);
	for i:=1 to n do read(a[i]);
	fillchar(f,sizeof(f),192);
	f[0,0]:=0;ans:=0;a[0]:=maxlongint;
	for i:=1 to n do
	for j:=1 to n do
	for k:=i-1 downto 0 do
		if ((a[k]>a[i])xor(j and 1=1)) and (a[k]<>a[i]) then
			f[i,j]:=max(f[i,j],max(f[k,j],f[k,j-1])+a[i])
		else f[i,j]:=max(f[i,j],f[k,j-1]+a[i]);
	for i:=1 to n do
		for j:=1 to n do
			ans:=max(ans,f[i,j]/j);
	write(ans:0:3);
	close(input);close(output);
end.
