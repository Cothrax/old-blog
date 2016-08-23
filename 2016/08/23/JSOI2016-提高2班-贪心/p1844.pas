uses math;
var n,i,j,last,ans:longint;
begin
	read(n);
	ans:=0;last:=0;
	for i:=1 to n do begin
		read(j);
		inc(ans,max(0,j-last));
		last:=j;
	end;
	write(ans);
end.
