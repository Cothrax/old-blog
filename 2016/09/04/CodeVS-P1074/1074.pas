type int=longint;
var 
	n,k,i,a,b,c,ans:int;
	par,d:array[0..50010] of int;

function find(x:int):int;
var old:int;
begin
	if par[x]=x then exit(x)
	else begin
		old:=par[x];
		par[x]:=find(par[x]);
		d[x]:=(d[x]+d[old]) mod 3;
		find:=par[x];
	end;
end;

procedure union(x,y,f:int);
var px,py:int;
begin
	px:=find(x);py:=find(y);
	par[px]:=py;
	d[px]:=(d[y]-f-d[x]+3) mod 3;
end;

function same(x,y:int):boolean;
begin same:=find(x)=find(y) end;

begin
	read(n,k);
	for i:=1 to n do begin
		par[i]:=i;
		d[i]:=0;
	end;
	ans:=0;
	for i:=1 to k do begin
		read(a,b,c);
		if (b>n) or (c>n) then inc(ans)
		else if (a=2) and (b=c) then inc(ans)
		else if same(b,c) then begin
			if (a=1) and (d[b]<>d[c]) then inc(ans);
			if (a=2) and ((d[c]-d[b]+3) mod 3<>1) then inc(ans);
		end else union(b,c,a-1);
	end;
	write(ans);
end.
