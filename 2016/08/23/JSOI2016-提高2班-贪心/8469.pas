uses math;
type int=longint;
var n,ans:int;
	s,d:string;

procedure flip(var s:string;i:int);
begin
	s[i]:=chr(ord('1')+ord('0')-ord(s[i]));
end;

function solve(s,d:string):int;
var i,j:int;
begin
	i:=1;solve:=0;
	while i<=n do begin
		while (s[i]=d[i]) and (i<=n) do inc(i);
		if i<n then begin
			for j:=i to min(i+2,n) do flip(s,j);
			inc(solve);
		end;
		inc(i);
	end;
	for i:=1 to n do
		if s[i]<>d[i] then exit(maxlongint);
end;

begin
	readln(s);readln(d);
	n:=length(s);
	ans:=solve(s,d);
	flip(s,1);flip(s,2);
	ans:=min(ans,solve(s,d)+1);
	if ans=maxlongint then write('impossible') else write(ans);
end.
