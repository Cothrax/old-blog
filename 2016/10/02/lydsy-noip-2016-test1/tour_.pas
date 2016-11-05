type 
	int=longint;dw=dword;
	bit=array[0..50] of dw;
const mx=1 shl 16;
var
	cnt:array[0..mx+10] of int64;
	deg:array[0..1510] of int64;
	g:array[0..1510,0..1510] of char;
	f:array[0..1510] of bit;
	i,j,n,m:int;ans:int64;

function _cnt(x:dword):int64;
begin _cnt:=cnt[x shr 16]+cnt[x and (mx-1)] end;

procedure _set(var x:bit;i:int);
begin x[i shr 5]:=x[i shr 5]or dw(1 shl (i and 31)) end;

function inter(var x,y:bit):int64;
var i:int;
begin
	inter:=0;
	for i:=0 to m do inc(inter,_cnt(x[i] and y[i]));
end;

begin
	assign(input,'tour.in');reset(input);
	assign(output,'tour.out');rewrite(output);
	readln(n);m:=(n-1) shr 5;
	for i:=1 to n do begin
		for j:=1 to n do read(g[i,j]);
		readln;
	end;
	for i:=1 to mx do cnt[i]:=cnt[i and(i-1)]+1;
	for i:=1 to n do
		for j:=1 to n do
			if g[i,j]='1' then 
				begin inc(deg[i]);_set(f[i],j) end;
	ans:=0;
	for i:=1 to n do
		for j:=1 to n do
			if g[i,j]='1' then
				inc(ans,(deg[i]-1)*(deg[j]-1)-inter(f[i],f[j]));
	write(ans);
	close(input);close(output);
end.
