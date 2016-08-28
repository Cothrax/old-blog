uses math;
const inf=1000000000;
type 
	int=longint;
	edge=record t,w,next:int end;
var 
	g:array[0..2500010] of edge;
	head,d:array[0..110010] of int;
	n,m,k,s0,t0,f,t,w,i,j,sz:int;

procedure add(f,t,w:int);
var m:int;
begin
	inc(sz);m:=sz;
	g[m].t:=t;g[m].w:=w;
	g[m].next:=head[f];head[f]:=m;
end;

procedure dijkstra(x:int);
var 
	h:array[0..110010,0..1] of int;
	l:array[0..110010] of int;
	i,v,u,sz:int;
	
	procedure swap(i,j:int);
	var tmp:int;
	begin
		l[h[i,0]]:=j;l[h[j,0]]:=i;
		tmp:=h[i,0];h[i,0]:=h[j,0];h[j,0]:=tmp;
		tmp:=h[i,1];h[i,1]:=h[j,1];h[j,1]:=tmp;
	end;
	procedure heapify(i:int);
	var l,r,s:int;
	begin
		l:=i*2;r:=l+1;
		if (l<=sz) and (h[l,1]<h[i,1]) then s:=l else s:=i;
		if (r<=sz) and (h[r,1]<h[s,1]) then s:=r;
		if i<>s then begin
			swap(i,s);
			heapify(s);
		end;
	end;
	procedure extract();
	begin
		swap(1,sz);
		dec(sz);
		heapify(1);
	end;
	procedure reduceto(i,k:int);
	begin
		h[i,1]:=k;
		while (i>1) and (h[i,1]<h[i div 2,1]) do begin
			swap(i,i div 2);
			i:=i div 2;
		end;
	end;
	procedure insert(x,k:int);
	begin
		inc(sz);
		h[sz,0]:=x;h[sz,1]:=inf;l[x]:=sz;
		reduceto(sz,k);
	end;

begin
	sz:=0;
	for i:=0 to (k+1)*n do
		if i=x then insert(i,0) else insert(i,inf);
	while sz>0 do begin
		v:=h[1,0];d[v]:=h[1,1];extract;
		i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if (l[u]<=sz) and (h[l[u],1]>g[i].w+d[v]) then
				reduceto(l[u],g[i].w+d[v]);
			i:=g[i].next;
		end;
	end;
end;

begin
	assign(input,'motor.in');reset(input);
	assign(output,'motor.out');rewrite(output);
	read(n,m,k,s0,t0);sz:=0;
	for i:=1 to m do begin
		read(f,t,w);
		add(f,t,w);add(t,f,w);
		for j:=1 to k do begin
			add(f+j*n,t+j*n,w);
			add(t+j*n,f+j*n,w);
			add(f+(j-1)*n,t+j*n,0);
			add(t+(j-1)*n,f+j*n,0);
		end;
	end;
	dijkstra(s0);
	write(d[t0+k*n]);
	close(input);close(output);
end.
