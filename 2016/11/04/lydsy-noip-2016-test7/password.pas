type int=longint;node=record w,nxt:int end;
var
	n,m,sz,i,j,u,v:int;
	lnk:array[0..100010] of node;
	x,y:array[0..100010] of int;
	a,b,ptr,par,w:array[0..30] of int;

procedure insert(i,x:int);
begin
	inc(sz);lnk[sz].w:=x;
	lnk[sz].nxt:=ptr[i];ptr[i]:=sz;
end;

function find(x:int):int;
begin
	if par[x]=x then find:=x
	else begin
		find:=find(par[x]);
		inc(w[x],w[par[x]]);
		par[x]:=find;
	end;
end;

procedure union(x,y,k:int);
var px,py:int;
begin
	px:=find(x);py:=find(y);
	if px=py then exit;
	w[px]:=-w[x]+k+w[y];par[px]:=py;
end;

procedure dfs(x:int);
begin
	if par[x]=x then a[x]:=0
	else begin
		if a[par[x]]=-1 then dfs(par[x]);
		a[x]:=(a[par[x]]+w[x])mod m;
	end;
end;

begin
	assign(input,'password.in');reset(input);
	assign(output,'password.out');rewrite(output);
	read(n,m);
	for i:=0 to n-1 do read(x[i]);
	for i:=0 to n-1 do begin read(y[i]);insert(y[i],i) end;
	for i:=0 to m-1 do begin par[i]:=i;w[i]:=0 end;
	for j:=0 to m-1 do begin
		i:=ptr[j];u:=lnk[i].w;i:=lnk[i].nxt;
		while i<>0 do begin
			v:=lnk[i].w;
			union((x[u]+u)mod m,(x[v]+v)mod m,
				((v div m-u div m)mod m+m)mod m);
			u:=v;i:=lnk[i].nxt;
		end;
	end;
	fillchar(a,sizeof(a),255);
	for i:=0 to m-1 do if a[i]=-1 then dfs(i);
	for i:=0 to n-1 do b[(a[(x[i]+i)mod m]+i div m)mod m]:=y[i];
	for i:=0 to m-1 do write(a[i],' ');writeln;
	for i:=0 to m-1 do write(b[i],' ');
	close(input);close(output);
end.
