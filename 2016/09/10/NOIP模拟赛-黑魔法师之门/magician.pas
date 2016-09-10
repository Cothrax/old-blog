type int=longint;
const z=1000000009;
var 
	par:array[0..200010] of int;
	n,m,i,ans,x,y:int;
	
function find(x:int):int;
begin
	if par[x]=x then find:=x
	else begin par[x]:=find(par[x]);find:=par[x] end;
end;

procedure union(x,y:int);
begin x:=find(x);y:=find(y);par[x]:=y end;

function same(x,y:int):boolean;
begin same:=find(x)=find(y) end;

begin
	assign(input,'magician.in');reset(input);
	assign(output,'magician.out');rewrite(output);
	read(n,m);
	for i:=1 to n do par[i]:=i;
	ans:=0;
	for i:=1 to m do begin
		read(x,y);
		if same(x,y) then ans:=(ans*2+1) mod z else union(x,y);
		writeln(ans); 
	end;
	close(input);close(output);
end.
