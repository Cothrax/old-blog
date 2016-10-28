uses math;
type 
	int=longint;
	edge=record v,next:int end;
	e1=record u,v,next:int end;
var 
	g:array[0..800010] of edge;
	e:array[0..400010] of e1;
	head,flag,ans:array[0..400010] of int;
	stk:array[0..800010] of int;
	ptr:array[0..1000010] of int;
	sz,k,mx,n,i,j,l,u,v,w,idx,len,t:int;

procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].next:=head[u];head[u]:=sz;
end;
procedure _add(u,v,w:int);
begin
	inc(k);e[k].u:=u;e[k].v:=v;
	e[k].next:=ptr[w];ptr[w]:=k;
end;

function dfs(u:int):int;
var v,i,tmp:int;
begin
	flag[u]:=idx;i:=head[u];dfs:=0;
	while i<>0 do begin
		v:=g[i].v;
		if flag[v]<idx then begin
			tmp:=dfs(v);
			len:=max(len,dfs+tmp+1);
			dfs:=max(dfs,tmp+1);
		end;
		i:=g[i].next;
	end;
end;

begin
	assign(input,'ex_walk3.in');reset(input);
	assign(output,'walk.out');rewrite(output);
	read(n);k:=0;mx:=0;
	for i:=1 to n-1 do begin
		read(u,v,w);_add(u,v,w);mx:=max(mx,w);
	end;
	idx:=0;len:=0;
	for i:=1 to mx do begin
		sz:=0;inc(idx);l:=i;t:=0;
		while l<=mx do begin
			j:=ptr[l];inc(l,i);
			while j<>0 do begin
				add(e[j].u,e[j].v);add(e[j].v,e[j].u);
				inc(t,2);stk[t-1]:=e[j].u;stk[t]:=e[j].v;
				j:=e[j].next;
			end;
		end;
		len:=0;
		for j:=1 to t do if flag[stk[j]]<idx then dfs(stk[j]);
		for j:=1 to t do head[stk[j]]:=0;
		ans[len]:=i;
	end;
	for i:=n-1 downto 1 do
		ans[i]:=max(ans[i],ans[i+1]);
	for i:=1 to n do writeln(ans[i]);
	close(input);close(output);
end.
