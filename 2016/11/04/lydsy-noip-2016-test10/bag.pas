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
	(*
	f[i,j,k] 1..i,cnt<=j,v=k
	f[i,j,k]=f[i-1,j,k] or f[i,j-1,k-v[i]]
	*)
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
	(*
	f[i,j,k]=s 1..i,cnt<=j,min_s(s%mn=k)
	v[i]<=up: f[i,j,k]=min(f[i-1,j,k],f[i,j,(k-v[i])%mn]+v[i])
	v[i]> up: f[i,j,k]=min(f[i-1,j,k],f[i,j-1,(k-v[i])%mn]+v[i])
	
	s -(f[i-1,j,k])-> f[i,j,k]
	f[i,j,k] -(v[i])-> f[i,j,(k+v[i])%mn]
	*)
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

{
3 2
3 22 29
100 0
19
39394684982
}
{
4 4
4 4 5 7
5 1
2
4
28
14
}
{
bug
1. 记得检查输出格式，换行
2. 状态f[i,j,k]的含义是 大物品件数=j时的解，最后要用前缀最小值f[n,0..j,k]
3. up和lim不可混用
4. 数据范围！$w<10^18$
}
