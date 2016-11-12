uses math;
type int=longint;
var 
	n,i,j,ans:int;
	a,b,f:array[0..100010] of int;

begin
	assign(input,'road.in');reset(input);
	assign(output,'road.ans');rewrite(output);
	read(n);
	for i:=1 to n do begin read(j);a[j]:=i end;
	for i:=1 to n do begin read(j);b[a[j]]:=i end;
	f[0]:=0;ans:=0;b[0]:=maxlongint;
	for i:=1 to n do 
		for j:=i-1 downto 0 do
			if b[j]>b[i] then f[i]:=max(f[i],f[j]+1);
	for i:=1 to n do ans:=max(ans,f[i]);
	write(ans);
	close(input);close(output);
end.
{
5
1 4 5 2 3
3 4 2 1 5
}
