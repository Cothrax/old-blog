type 
	int=longint;
	edge=record u,next:int end;
var 
	g:array[0..100010] of edge;
	head,w,q:array[0..100010] of int;
	inq:array[0..100010] of boolean;
	n,m,i,v,u,sz,h,t:int;

procedure add(v,u:int);
begin
	inc(sz);g[sz].u:=u;
	g[sz].next:=head[v];head[v]:=sz;
end;

begin
	assign(input,'graph.in');reset(input);
	assign(output,'graph.out');rewrite(output);
	read(n,m);sz:=0;
	for i:=1 to m do begin
		read(v,u);add(u,v);
	end;
	h:=1;t:=n+1;
	for i:=1 to n do begin
		w[i]:=i;q[i]:=n-i+1;
	end;
	fillchar(inq,sizeof(inq),true);
	while h<>t do begin
		v:=q[h];inq[v]:=false;//writeln(v);
		inc(h);if h>100010 then h:=0;
		i:=head[v];
		while i<>0 do begin
			u:=g[i].u;
			if w[u]<w[v] then begin
				w[u]:=w[v];//writeln(v,'->',u);
				if not inq[u] then begin
					q[t]:=u;inq[u]:=true;
					inc(t);if t>100010 then t:=0;
				end;
			end;
			i:=g[i].next;
		end;
	end;
	for i:=1 to n do write(w[i],' ');
	close(input);close(output);
end.
