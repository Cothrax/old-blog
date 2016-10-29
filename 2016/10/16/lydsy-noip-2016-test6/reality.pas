uses math;
const inf=1000000000;
type 
	int=longint;
	edge=record u,v,nxt:int;f:boolean end;
	arr=array[0..1000010] of int;
var
	g:array[0..1500010] of edge;
	head,top,pre,edg,flg,loc,cyc,f1,f2,f3,a,ans:arr;
	sz,n,m,i,j,k,u,v,cnt:int;

procedure add(u,v:int);
begin
	inc(sz);g[sz].u:=u;g[sz].v:=v;g[sz].f:=true;
	g[sz].nxt:=head[u];head[u]:=sz;
end;

function dfs(u:int):boolean;
var i,v,w:int;
begin
	flg[u]:=1;i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if flg[v]=1 then begin
			w:=u;k:=0;
			while w<>v do begin
				inc(k);cyc[k]:=w;loc[w]:=k;
				g[edg[w]].f:=false;
				w:=pre[w];
			end;
			inc(k);cyc[k]:=v;loc[v]:=k;
			edg[v]:=i;g[i].f:=false;
			exit(true);
		end;
		if flg[v]=0 then begin
			pre[v]:=u;edg[v]:=i;
			if dfs(v) then exit(true);
		end;
		i:=g[i].nxt;
	end;
	flg[u]:=2;dfs:=false;
end;

function sort():boolean;
var i,u,v,h,t:int;deg:arr;
begin
	fillchar(deg,sizeof(deg),0);t:=0;
	for i:=1 to sz do
		if g[i].f then inc(deg[g[i].v]);
	for i:=1 to n*2 do
		if deg[i]=0 then
			begin inc(t);top[t]:=i end;
	h:=1;
	while h<=t do begin
		u:=top[h];inc(h);i:=head[u];
		while i<>0 do begin
			if g[i].f then begin
				v:=g[i].v;dec(deg[v]);
				if deg[v]=0 then begin inc(t);top[t]:=v end;
			end;
			i:=g[i].nxt;
		end;
	end;
	sort:=t=n*2;
end;

begin
	assign(input,'ex_reality5.in');reset(input);
	assign(output,'reality.out');rewrite(output);
	read(n,m);
	for i:=1 to n do add(i,i+n);
	for i:=1 to m do begin 
		read(u,v);add(u+n,v);
	end;
	for i:=1 to n*2 do
		if (flg[i]=0) and dfs(i) then break;
	if k=0 then begin
		writeln(n);
		for i:=1 to n do write(i,' ');halt;
	end;
	if not sort() then begin write(0);halt end;
	filldword(f1,sizeof(f1) div 4,inf);
	filldword(f3,sizeof(f3) div 4,inf);
	for i:=1 to n*2 do
		if loc[i]>0 then
		 	begin f1[i]:=loc[i];f2[i]:=loc[i];f3[i]:=loc[i] end;
	for j:=n*2 downto 1 do begin
		u:=top[j];i:=head[u];
		while i<>0 do begin
			v:=g[i].v;
			if g[i].f then begin
				f1[u]:=min(f1[u],f1[v]);
				f2[u]:=max(f2[u],f2[v]);
			end;
			i:=g[i].nxt;
		end;
	end;
	for j:=1 to n*2 do begin
		u:=top[j];i:=head[u];
		while i<>0 do begin
			v:=g[i].v;
			if g[i].f then f3[v]:=min(f3[u],f3[v]);
			i:=g[i].nxt;
		end;
	end;
	for i:=1 to k do begin
		u:=cyc[i];
		if f1[u]<i then begin inc(a[f1[u]]);dec(a[i]) end;
		if f2[u]>i then begin inc(a[1]);dec(a[i]) end;
		if f3[u]<i then inc(a[i]);
	end;
	for i:=2 to k do inc(a[i],a[i-1]);
	for i:=1 to k do
		if (a[i]=0)and(cyc[i]>n) then flg[cyc[i]-n]:=-1;
	cnt:=0;
	for i:=1 to n do
		if flg[i]=-1 then begin inc(cnt);ans[cnt]:=i end;
	writeln(cnt);
	for i:=1 to cnt do write(ans[i],' ');
end.
