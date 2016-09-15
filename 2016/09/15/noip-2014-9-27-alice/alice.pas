uses math;
const z=500009;
type int=longint;
var
	h,f:array[0..1500010] of int64;
	c,next:array[0..1500010] of int;
	head:array[0..z] of int;
	g:array[0..41] of int64;
	i,j,k,n,m,sz,cnt,mn:int;lb,h0,f0,ans:int64;

function lsh(a,b:int64):int64;
begin lsh:=int64(a) shl int64(b) end;

procedure insert(h0,f0:int64;cnt:int);
var i:int;
begin
	i:=h0 mod z;
	inc(sz);h[sz]:=h0;f[sz]:=f0;c[sz]:=cnt;
	next[sz]:=head[i];head[i]:=sz;
end;

function query(h0:int64):int;
var i:int;
begin
	i:=h0 mod z;i:=head[i];
	while i<>0 do begin
		if h0=h[i] then exit(i);
		i:=next[i];
	end;
	query:=-1;
end;

procedure print(ans:int64);
begin
	while ans<>0 do begin
		lb:=ans and (-ans);
		write(round(ln(lb)/ln(2))+1,' ');
		dec(ans,lb);
	end;
end;

procedure dfs(v,x:int);
var i:int;
begin
	if (x=0) and (v=k+1) then begin insert(h0,f0,cnt);exit end;
	if (x=1) and (v=n+1) then begin
		i:=query(h0);
		if (i<>-1) and (c[i]+cnt<mn) then begin
			mn:=c[i]+cnt;
			ans:=f[i] or f0;
		end;
		exit;
	end;
	h0:=h0 xor g[v];f0:=f0 or lsh(1,v-1);inc(cnt);
	dfs(v+1,x);
	h0:=h0 xor g[v];f0:=f0-lsh(1,v-1);dec(cnt);
	dfs(v+1,x);
end;

begin {main}
	assign(input,'alice.in');reset(input);
	assign(output,'alice.out');rewrite(output);
	read(n,m);h0:=0;
	for i:=1 to n do begin
		read(j);inc(h0,lsh(1,i-1)*j);
	end;
	for i:=1 to n do g[i]:=lsh(1,i-1);
	for i:=1 to m do begin
		read(j,k);
		inc(g[j],lsh(1,k-1));
		inc(g[k],lsh(1,j-1));
	end;
	k:=n shr 1;f0:=0;cnt:=0;sz:=0;
	dfs(1,0);
	h0:=lsh(1,n)-1;f0:=0;cnt:=0;mn:=maxlongint;
	dfs(k+1,1);
	
	writeln(mn);print(ans);
	close(input);close(output);
end.
