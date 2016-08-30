type 
	int=longint;
	edge=record f,t,next:int;c:char end;
var 
	g:array[0..100010] of edge;
	head,cnt,l,r:array[0..100010] of int;
	q:array[0..100010,0..1] of int;
	ans:array[0..100010] of char;
	n,m,k,i,j,sz:int;c,x:char;s:ansistring;

procedure add(f,t:int;c:char);
begin
	inc(sz);
	g[sz].f:=f;g[sz].t:=t;g[sz].c:=c;
	g[sz].next:=head[f];head[f]:=sz;
end;

procedure dfs(v:int);
var i,u:int;
begin
	for i:=l[v] to r[v] do ans[i]:=s[q[i,1]];
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if g[i].c<>'.' then s:=s+g[i].c;
		dfs(u);
		if g[i].c<>'.' then delete(s,length(s),1);
		i:=g[i].next;
	end;
end;

begin
	assign(input,'type.in');reset(input);
	assign(output,'type.out');rewrite(output);
	readln(n);
	m:=0;sz:=0;k:=0;
	fillchar(head,sizeof(head),0);
	fillchar(q,sizeof(q),0);
	for i:=1 to n do begin
		read(c);read(x);
		case c of
			'Q':begin 
				inc(k);q[k,0]:=m;readln(q[k,1]) end;
			'T':begin readln(x);inc(m);add(m-1,m,x) end;
			'U':begin readln(j);inc(m);add(m-j-1,m,'.') end;
		end;
	end;
	fillchar(cnt,sizeof(cnt),0);
	for i:=1 to k do inc(cnt[q[i,0]]);
	r[0]:=0;l[0]:=1;
	for i:=1 to m do begin
		l[i]:=r[i-1]+1;
		r[i]:=l[i]+cnt[i]-1;
	end;
	dfs(0);
	for i:=1 to k do writeln(ans[i]);
	close(input);close(output);
end.
