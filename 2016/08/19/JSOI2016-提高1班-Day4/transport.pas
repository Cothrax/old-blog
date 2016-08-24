uses math;
const inf=100000000;
type 
	int=longint;
	arr=array[0..110,0..110] of int;
var 
	ds0,ds1,ds2:arr;
	a,b,d,s,t:array[0..1010] of int;
	n,m,s0,t0,f,i,j,x,ans:int;

//flag标记能否经过邮递员x
procedure floyd(var ds:arr;f:int;flag:boolean);
var i,j,k:int;
begin
	filldword(ds,sizeof(ds) div 4,inf);
	for i:=1 to m do begin
		if flag and (i=x) then continue;
		k:=a[i]*min(f,d[i])+b[i]*max(0,f-d[i]);
		ds[s[i],t[i]]:=min(k,ds[s[i],t[i]]);
	end;
	for i:=1 to n do ds[i,i]:=0;
	for k:=1 to n do
		for i:=1 to n do
			for j:=1 to n do
				ds[i,j]:=min(ds[i,k]+ds[k,j],ds[i,j]);
end;

begin
	assign(input,'transport.in');reset(input);
	assign(output,'transport.out');rewrite(output);
	read(n,m,s0,t0,f);
	inc(s0);inc(t0);
	x:=-1;
	for i:=1 to m do begin
		read(s[i],t[i],a[i],b[i],d[i]);
		inc(s[i]);inc(t[i]);
		if a[i]<b[i] then x:=i;
	end;
	
	floyd(ds0,f,false);
	if (x=-1) or (f<=d[x]) then begin
		if ds0[s0,t0]=inf then write('Impossible') 
		else write(ds0[s0,t0]);
		close(input);close(output);halt;
	end;
	
	floyd(ds1,d[x],false);
	floyd(ds2,f-d[x],true);
	ans:=inf;
	for i:=1 to n do
		for j:=1 to n do
			ans:=min(ans,ds0[s0,i]+ds1[i,j]+ds2[i,j]+ds0[j,t0]);
	if ans=inf then write('Impossible') else write(ans);
	close(input);close(output);
end.
