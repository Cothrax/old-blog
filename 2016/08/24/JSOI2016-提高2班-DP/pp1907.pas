uses math;
type int=longint;
const inf=1000000000;
var
	n,m,k,i,i1,i0,j,cnt,ans:int;
	x,y,lb,ub:array[0..10010] of int;
	flag:array[0..10010] of boolean;b:boolean;
	f:array[0..1,0..1010] of int;

begin
	read(n,m,k);
	for i:=1 to n do begin
		read(x[i],y[i]);
		lb[i]:=0;ub[i]:=m+1;
	end;
	fillchar(flag,sizeof(flag),false);
	for i:=1 to k do begin
		read(j);read(lb[j],ub[j]);
		flag[j]:=true;
	end;
	
	filldword(f[0],sizeof(f[0]) div 4,inf);
	for i:=1 to m do f[0,i]:=0;
	cnt:=0;
	for i:=1 to n do begin
		i1:=i mod 2;i0:=1-i1;
		filldword(f[i1],sizeof(f[i1]) div 4,inf);
		for j:=1+x[i] to m do //完全背包（上升）
			f[i1,j]:=min(f[i1,j],min(f[i1,j-x[i]],f[i0,j-x[i]])+1);
		for j:=0 to x[i] do //特判顶点
			f[i1,m]:=min(f[i1,m],min(f[i0,m-j],f[i1,m-j])+1);
		for j:=1 to m-y[i] do //01背包（下落）
			f[i1,j]:=min(f[i1,j],f[i0,j+y[i]]);
		//不可达的点标记为inf
		for j:=1 to lb[i] do f[i1,j]:=inf;
		for j:=ub[i] to m do f[i1,j]:=inf;
		//判无解，和cnt更新
		b:=false;
		for j:=1 to m do
			if f[i1,j]<>inf then begin b:=true;break end;
		if not b then break
		else if flag[i] then inc(cnt);
	end;
	if b then begin
		ans:=inf;i1:=n mod 2;
		for i:=1 to m do ans:=min(ans,f[i1,i]);
		writeln(1);write(ans);
	end else begin
		writeln(0);write(cnt);
	end;
end.
