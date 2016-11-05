type 
	int=longint;qw=qword;
	bit=array[0..25] of qw;
const mx:qw=1 shl 16-1;
var
	cnt:array[0..65536] of int;
	deg:array[0..1510] of int;
	g:array[0..1510,0..1510] of char;
	f:array[0..1510] of bit;
	i,j,n,m:int;ans:int64;

function _cnt(x:qword):int;
begin 
	_cnt:=cnt[x and mx]+cnt[(x shr 16)and mx]+
		cnt[(x shr 32)and mx]+cnt[(x shr 48)and mx];
end;

procedure _set(var x:bit;i:int);
begin x[i shr 6]:=x[i shr 6]or (qw(1) shl (i and 63)) end;

function inter(var x,y:bit):int;
var i:int;
begin
	inter:=0;
	for i:=0 to m do inc(inter,_cnt(x[i] and y[i]));
end;

begin
	assign(input,'tour.in');reset(input);
	assign(output,'tour.out');rewrite(output);
	readln(n);m:=(n-1) shr 6;
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
