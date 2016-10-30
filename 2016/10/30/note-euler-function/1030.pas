{
uses math;
type int=longint;
function phi(n:int):int;
var i:int;
begin
	phi:=n;
	for i:=2 to ceil(sqrt(n)) do
		if n mod i=0 then begin
			phi:=phi div i*(i-1);
			while n mod i=0 do n:=n div i;
		end;
	if n>1 then phi:=phi div n*(n-1);
end;

var i:int;
begin
	for i:=1 to 20 do writeln(i,' ',phi(i));
end.
}
type int=longint;
var phi:array[0..1010] of int;i:int;
	
procedure euler(n:int);
var 
	i,j,k:int;
	f:array[0..1010] of boolean; //素数标记
	p:array[0..1010] of int; //素数表，规模为k
begin
	fillchar(f,sizeof(f),false);
	phi[1]:=1;k:=0;
	for i:=2 to n do begin
		if not f[i] then 
			begin inc(k);p[k]:=i;phi[i]:=i-1 end;
		j:=1;//write(i,'> ');
		while i*p[j]<=n do begin
			f[i*p[j]]:=true;//write(i*p[j],' ');
			if i mod p[j]=0 then begin
				phi[i*p[j]]:=phi[i]*p[j];break
			end else
				phi[i*p[j]]:=phi[i]*(p[j]-1);
			inc(j);
		end;//writeln;
	end;
end;

begin
	euler(50);
	//for i:=1 to 50 do writeln(i,' ',phi[i]);
end.

