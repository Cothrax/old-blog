uses math;
type int=longint;
var
	l,r:array[-10..30] of boolean;
	ans,n,m:int;

procedure dfs(x,y,k:int);
begin
	if y=m+1 then begin y:=1;inc(x) end;
	if x=n+1 then begin 
		ans:=max(ans,k);exit 
	end;
	dfs(x,y+1,k);
	if r[x+y] and l[y-x] then begin
		r[x+y]:=false;l[y-x]:=false;
		dfs(x,y+1,k+1);
		r[x+y]:=true;l[y-x]:=true;
	end;
end;

begin
	//read(n,m);
	for n:=1 to 9 do begin
		for m:=1 to 9 do begin
			fillchar(l,sizeof(l),true);
			fillchar(r,sizeof(r),true);
			ans:=0;
			dfs(1,1,0);
			write(ans:3);		
		end;
		writeln;
	end;
end.
