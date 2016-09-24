uses math;
type int=longint;
const inf=100000000;
var 
	a,b,w,f:array[0..50010] of int;
	n,i,j,len:int;

function bin(x:int):int;
var l,r,mid:int;
begin
	bin:=0;;l:=1;r:=len;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if f[mid]<x then begin bin:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
end;

begin
	assign(input,'formation.in');reset(input);
	assign(output,'formation.out');rewrite(output);
	read(n);
	for i:=1 to n do read(a[i]);
	for i:=1 to n do begin read(j);b[j]:=i end;
	for i:=1 to n do w[i]:=b[a[i]];
	filldword(f,sizeof(f) div 4,inf);
	f[0]:=0;len:=0;
	for i:=1 to n do begin
		j:=bin(w[i])+1;
		f[j]:=min(f[j],w[i]);
		len:=max(len,j);
	end;
	write(len);
	close(input);close(output);
end.
