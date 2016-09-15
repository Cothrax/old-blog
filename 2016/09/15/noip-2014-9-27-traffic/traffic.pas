type 
	int=longint;
	edge=record f,t,next:int end;
	arr=array[0..300010] of int;
var
	g:array[0..2000010] of edge;
	l,r,u,d,x,y,head,q:arr;
	n,m,i,j,f,t,a,b:int;

procedure add(f,t:int);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].f:=f;g[m].t:=t;
	g[m].next:=head[f];head[f]:=m;
end;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

function com(a,b,s:int):boolean;
begin com:=((s=0) and (a<b)) or ((s=1) and (a>b)) end;

procedure qsort(var a:arr;l,r,s:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=y[a[random(r-l)+l]];
	repeat
		while com(y[a[i]],x,s) do inc(i);
		while com(x,y[a[j]],s) do dec(j);
		if i<=j then begin
			swap(a[i],a[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(a,i,r,s);
	if l<j then qsort(a,l,j,s);
end;

procedure init(var d:arr);
var i,v,u,h,t:int;
begin
	fillchar(d,sizeof(d),0);
	h:=1;t:=1;
	for i:=1 to l[0] do begin 
		q[t]:=l[i];inc(t);d[l[i]]:=1;
	end;
	while h<>t do begin
		v:=q[h];inc(h);i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if d[u]=0 then begin
				d[u]:=1;
				q[t]:=u;inc(t);
			end;
			i:=g[i].next;
		end;
	end;
end;

procedure bfs(var d:arr);
var j,i,v,u,h,t:int;
begin
	fillchar(d,sizeof(d),255);
	for j:=1 to r[0] do begin
		if d[r[j]]<>-1 then continue;
		h:=1;t:=2;q[h]:=r[j];d[r[j]]:=j;
		while h<>t do begin
			v:=q[h];inc(h);i:=head[v];
			while i<>0 do begin
				u:=g[i].t;
				if d[u]=-1 then begin
					d[u]:=j;
					q[t]:=u;inc(t);
				end;
				i:=g[i].next;
			end;
		end;
	end;
end;

begin
	assign(input,'traffic.in');reset(input);
	assign(output,'traffic.out');rewrite(output);
	read(n,m,a,b);
	for i:=1 to n do read(x[i],y[i]);
	for i:=1 to m do begin
		read(f,t,j);
		add(f,t);if j=2 then add(t,f);
	end;
	for i:=1 to n do
		if x[i]=0 then begin inc(l[0]);l[l[0]]:=i end;
	qsort(l,1,l[0],1);
	init();
	for i:=1 to n do
		if (x[i]=a) and (d[i]=1) then begin
			inc(r[0]);r[r[0]]:=i;
		end;
	m:=head[0];
	fillchar(head,sizeof(head),0);
	for i:=1 to m do add(g[i].t,g[i].f);
	qsort(r,1,r[0],0);bfs(d);
	qsort(r,1,r[0],1);bfs(u);
	for i:=1 to l[0] do
		if u[l[i]]=-1 then writeln(0)
		else writeln(r[0]-u[l[i]]+2-d[l[i]]);
	close(input);close(output);
end.
	
{
12 13 7 9
0 1
0 3
2 2
5 2
7 1
7 4
7 6
7 7
3 5
0 5 
0 9
3 9
1 3 2
3 2 1
3 4 1
4 5 1
5 6 1
9 3 1
9 4 1
9 7 1 
9 12 2
10 9 1
11 12 1
12 8 1
12 10 1
}
	
