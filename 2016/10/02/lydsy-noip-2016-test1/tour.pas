uses math;
type 
	int=longint;
	edge=record t,next:int end;
var 
	g:array[0..2250010] of edge;
	mat:array[0..1510,0..1510] of char;
	head:array[0..1510] of int;
	f:array[0..1510,0..4] of int64;
	cnt:array[0..1 shl 20] of int;
	b:array[0..1510,0..80] of int;
	n,sz,i,j,v,u:int;ans:int64;
	
procedure add(f,t:int);
begin
	inc(sz);g[sz].t:=t;
	g[sz].next:=head[f];head[f]:=sz;
end;

function tri():int64;
var i,j,k,p,t,x:int;
begin
	t:=20;p:=floor((n-1)/t)+1;
	for i:=1 to 1 shl t do
		cnt[i]:=cnt[i and (i-1)]+1;
	for i:=1 to n do
		for j:=0 to p-1 do
			for k:=0 to t-1 do
				if mat[i,j*t+k+1]='1' then
					b[i,j]:=b[i,j] or (1 shl k);
	tri:=0;
	for i:=1 to n do
		for j:=1 to n do
			if mat[i,j]='1' then
				for k:=0 to p-1 do begin
					x:=b[i,k] and b[j,k];
					inc(tri,int64(cnt[x]));	
				end;
end;

begin
	assign(input,'tour.in');reset(input);
	assign(output,'tour.out');rewrite(output);
	readln(n);sz:=0;
	for i:=1 to n do f[i,1]:=2;
	for i:=1 to n do begin
		for j:=1 to n do begin
			read(mat[i,j]);
			if mat[i,j]='1' then begin
				add(i,j);inc(f[i,2]);
			end;
		end;
		readln;
	end;
	for j:=3 to 4 do
		for v:=1 to n do begin
			i:=head[v];
			while i<>0 do begin
				u:=g[i].t;
				inc(f[v,j],f[u,j-1]-f[v,j-2]+1);
				i:=g[i].next;
			end;
		end;
	ans:=0;
	for i:=1 to n do inc(ans,f[i,4]);
	write(ans-tri());
	close(input);close(output);
end.
