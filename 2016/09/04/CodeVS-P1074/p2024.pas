uses math;
var 
	n,k,ans,i,t,a,b:longint;
	par,rank:array[0..150010] of longint;
	
function find(x:longint):longint;
begin
	if par[x]=x then find:=x
	else begin
		par[x]:=find(par[x]);
		find:=par[x];
	end;
end;

procedure unite(x,y:longint);
begin
	if x=y then exit;
	if rank[x]>rank[y] then par[y]:=x
	else begin
		par[x]:=y;
		if rank[x]=rank[y] then inc(rank[y]);
	end;
end;

function same(x,y:longint):boolean;
begin
	same:=(find(x)=find(y));
end;

begin
	read(n,k);
	for i:=1 to 3*n do begin
		par[i]:=i;
		rank[i]:=0;
	end;
	ans:=0;
	for i:=1 to k do begin
		read(t,a,b);
		if (max(a,b)>n) or (min(a,b)<1) then continue;
		if t=1 then begin
			if same(a,b+n) or same(a,b+2*n) then continue;
			unite(a,b);
			unite(a+n,b+n);
			unite(a+2*n,b+2*n);
		end else begin
			if same(a,b) or same(a,b+2*n) then continue;
			unite(a,b+n);
			unite(a+n,b+2*n);
			unite(a+2*n,b);
		end;
		inc(ans);
	end;
	write(k-ans);
end.