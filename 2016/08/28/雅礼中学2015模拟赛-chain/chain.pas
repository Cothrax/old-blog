const z:qword=32416190071;
type 
	int=longint;
	edge=record t,w,next:int end;
var 
	n,i,j,f0,t0,w0,r,h,t,v,u,cnt,sz:int;
	g:array[0..2000010] of edge;
	head,q,ind,w:array[0..2000010] of int;
	f:array[0..2000010] of qword;

procedure add(f,t,w:int);
begin
	inc(sz);
	g[sz].t:=t;g[sz].w:=w;
	g[sz].next:=head[f];head[f]:=sz;
end;

begin
	assign(input,'chain.in');reset(input);
	assign(output,'chain.out');rewrite(output);
	read(n);sz:=0;
	for i:=1 to n-1 do begin
		read(f0,t0,w0);
		add(f0,t0,w0);inc(ind[t0]);
	end;
	for i:=1 to n do read(w[i]);
	for i:=1 to n do
		if ind[i]=0 then begin r:=i;break end;
	h:=1;t:=2;q[h]:=r;cnt:=0;
	while h<>t do begin
		v:=q[h];inc(h);
		i:=head[v];
		if i=0 then inc(cnt);
		while i<>0 do begin
			u:=g[i].t;
			q[t]:=u;inc(t);
			i:=g[i].next;
		end;
	end;
	for i:=t-1 downto 1 do begin
		v:=q[i];
		f[v]:=w[v];
		j:=head[v];
		while j<>0 do begin
			u:=g[j].t;
			inc(f[v],f[u]*g[j].w);
			if f[v]>=z then f[v]:=f[v] mod z;
			j:=g[j].next;
		end;
	end;
	writeln(cnt);write(f[r]);
	close(input);close(output);
end.
