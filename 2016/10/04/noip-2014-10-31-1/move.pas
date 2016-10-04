type 
	int=longint;
	edge=record v,w,next:int end;
const inf=1000000000;
var
	g:array[0..2200010] of edge;
	head,l,d:array[0..110010] of int;
	h:array[0..110010,0..1] of int;
	n,m,k,sz,hs,u,v,w,s,t,i,j:int;

procedure add(u,v,w:int);
begin
	inc(sz);g[sz].v:=v;g[sz].w:=w;
	g[sz].next:=head[u];head[u]:=sz;
end;

procedure swap(i,j:int);
var tmp:int;
begin
	l[h[i,1]]:=j;l[h[j,1]]:=i;
	tmp:=h[i,0];h[i,0]:=h[j,0];h[j,0]:=tmp;
	tmp:=h[i,1];h[i,1]:=h[j,1];h[j,1]:=tmp;
end;

procedure hfy(i:int);
var l,r,s:int;
begin
	l:=i shl 1;r:=l or 1;
	if (l<=hs) and (h[l,0]<h[i,0]) then s:=l else s:=i;
	if (r<=hs) and (h[r,0]<h[s,0]) then s:=r;
	if i<>s then begin
		swap(i,s);hfy(s);
	end;
end;

procedure ext();
begin
	swap(1,hs);dec(hs);hfy(1);
end;

procedure red(i,k:int);
begin
	h[i,0]:=k;
	while (i>1) and (h[i,0]<h[i shr 1,0]) do begin
		swap(i,i shr 1);i:=i shr 1;
	end;
end;

procedure ins(x,k:int);
begin
	inc(hs);l[x]:=hs;
	h[hs,1]:=x;h[hs,0]:=inf;red(hs,k);
end;

procedure dij();
var i,u,v:int;
begin
	hs:=0;
	for i:=1 to n*(k+1) do
		if i=s then ins(i,0) else ins(i,inf);
	while hs>0 do begin
		u:=h[1,1];d[u]:=h[1,0];ext;
		//writeln('>',u,' ',d[u]);
		i:=head[u];
		while i<>0 do begin
			v:=g[i].v;
			if h[l[v],0]>d[u]+g[i].w then 
				red(l[v],d[u]+g[i].w);
			i:=g[i].next;
		end;
	end;
end;

begin
	assign(input,'move.in');reset(input);
	assign(output,'move.out');rewrite(output);
	read(n,m,k,s,t);inc(s);inc(t);
	for i:=1 to m do begin
		read(u,v,w);inc(u);inc(v);
		add(u,v,w);add(v,u,w);
		for j:=1 to k do begin
			add(u+j*n,v+j*n,w);add(u+(j-1)*n,v+j*n,0);
			add(v+j*n,u+j*n,w);add(v+(j-1)*n,u+j*n,0);
		end;
	end;
	dij();
	write(d[t+k*n]);
	close(input);close(output);
end.
