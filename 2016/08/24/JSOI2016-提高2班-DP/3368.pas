uses math;
const inf=100000000;
type int=longint;
var n,m,i,j,k,tmp,ans,i0,i1:int;
	d:array[0..510,0..510] of int;
	f:array[0..1,0..510,0..510] of int;

begin
	read(n,m);
	filldword(d,sizeof(d) div 4,inf);
	for i:=1 to m do begin
		read(j,k,tmp);
		d[j,k]:=min(d[j,k],tmp);d[k,j]:=d[j,k];
	end;
	for i:=0 to n do d[i,i]:=0;
	for k:=0 to n do
		for i:=0 to n do
			for j:=0 to n do
				d[i,j]:=min(d[i,j],d[i,k]+d[k,j]);
	
	filldword(f,sizeof(f) div 4,inf);
	f[0,0,0]:=0;
	for i:=0 to n do begin
		i0:=i mod 2;i1:=1-i0;
		filldword(f[i1],sizeof(f[i1]) div 4,inf);
		for j:=0 to i do
			for k:=0 to i do begin
				f[i1,j,k]:=min(f[i1,j,k],f[i0,j,k]+d[i,i+1]);
				f[i1,i,k]:=min(f[i1,i,k],f[i0,j,k]+d[j,i+1]);
				f[i1,j,i]:=min(f[i1,j,i],f[i0,j,k]+d[k,i+1]);
			end;
	end;
	ans:=inf;i0:=n mod 2;
	for i:=0 to n do
		for j:=0 to n do
			ans:=min(ans,f[i0,i,j]+d[0,n]+d[i,0]+d[j,0]);
	write(ans);
end.
