type int=longint;
const inf=maxlongint shr 2;
var
	a,l,r:array[0..200010] of int;
	g:array[0..200010] of char;
	ans:array[0..200010,0..1] of int;
	i,j,n,x,y,d,cnt:int;

begin
	assign(input,'dancingLessons.in');reset(input);
	assign(output,'dancingLessons.ans');rewrite(output);
	readln(n);
	for i:=1 to n do read(g[i]);readln;
	for i:=1 to n do begin
		read(a[i]);
		l[i]:=i-1;r[i]:=i+1;
	end;
	l[1]:=n+1;r[n+1]:=1;r[n]:=0;
	cnt:=0;
	while true do begin
		d:=inf;
		j:=r[n+1];i:=r[j];
		while i<>0 do begin
			if (g[j]<>g[i]) and (abs(a[i]-a[j])<d) then begin
				x:=j;y:=i;d:=abs(a[i]-a[j]);
			end;
			j:=i;i:=r[i];
		end;
		if d=inf then break;
		inc(cnt);ans[cnt,0]:=x;ans[cnt,1]:=y;
		r[l[x]]:=r[y];l[r[y]]:=l[x];
	end;
	writeln(cnt);
	for i:=1 to cnt do writeln(ans[i,0],' ',ans[i,1]);
	close(input);close(output);
end.
