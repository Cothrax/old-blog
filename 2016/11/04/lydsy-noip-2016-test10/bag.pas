uses math;
type int=longint;
var 
	n,m,mn,mx,up,lim,i:int;
	v:array[0..55] of int;
	f:array[0..35,0..300010] of int64;

procedure solv1();
var 
	f:array[0..35,0..300010] of boolean;
	i,j,k:int;w:int64;
begin
	fillchar(f,sizeof(f),false);
	f[0,0]:=true;mx:=mx*n;
	for i:=1 to n do
		for j:=1 to lim do
			for k:=v[i] to mx do
				f[j,k]:=f[j,k] or f[j-1,k-v[i]];
	for i:=1 to m do begin
		read(w);
		if (w<=mx) and f[lim,w] then writeln('Yes') 
		else writeln('No');
	end;
end;

procedure solv2();
var 
	q:array[0..10010] of int;
	inq:array[0..10010] of boolean;
	i,j,k:int;w:int64;
	
	procedure spfa(x:int64);
	var i,v,u,h,t:int;
	begin
		h:=0;t:=mn;
		for i:=0 to mn-1 do q[i]:=i;
		fillchar(inq,sizeof(inq),true);
		while h<>t do begin
			u:=q[h];v:=(u+x)mod mn;
			if f[j,v]>f[j,u]+x then begin
				f[j,v]:=f[j,u]+x;
				if not inq[v] then begin
					q[t]:=v;inq[v]:=true;
					inc(t);if t>10010 then t:=0;
				end;
			end;
			inq[u]:=false;inc(h);if h>10010 then h:=0;
		end;
	end;

begin
	fillchar(f,sizeof(f),31);
	f[0,0]:=0;
	for i:=1 to n do begin
		if v[i]>=up then for j:=1 to lim do for k:=0 to mn-1 do
			f[j,k]:=min(f[j,k],f[j-1,((k-v[i])mod mn+mn)mod mn]+v[i])
		else for j:=0 to lim do spfa(v[i]);
	end;
	for k:=0 to mn-1 do
		for j:=0 to lim-1 do f[lim,k]:=min(f[lim,k],f[j,k]);
	for i:=1 to m do begin
		read(w);
		if f[lim,w mod mn]<=w then writeln('Yes')
		else writeln('No');
	end;
end;

begin
	assign(input,'bag_sample3.in');reset(input);
	assign(output,'bag.out');rewrite(output);
	read(n,m);mn:=maxlongint;
	for i:=1 to n do begin 
		read(v[i]);mn:=min(mn,v[i]);mx:=max(mx,v[i]) 
	end;
	read(up,lim);
	if mn>=up then solv1() else solv2();
	close(input);close(output);
end.
