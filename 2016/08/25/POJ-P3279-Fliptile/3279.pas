type int=longint;
const d:array[0..4,0..1] of int=
	((0,0),(0,1),(1,0),(-1,0),(0,-1));
var 
	n,m,j,k,x,ans,cnt:int;i:int;
	mat,tmp,opt,cur:array[0..16,0..16] of int;

function min(a,b:int):int;
begin if a<b then min:=a else min:=b end;

procedure flip(x,y:int);
var i:int;p:^int;
begin
	inc(cnt);inc(cur[x,y]);
	for i:=0 to 4 do begin
		p:=@mat[x+d[i,0],y+d[i,1]];
		p^:=1-p^;
	end;
end;

begin
	read(n,m);
	for i:=1 to n do
		for j:=1 to m do read(mat[i,j]);
	
	tmp:=mat;ans:=maxlongint;
	for i:=0 to 1 shl m-1 do begin
		j:=i;cnt:=0;
		fillchar(cur,sizeof(cur),0);
		while j<>0 do begin
			x:=j and (-j);
			flip(1,round(ln(x)/ln(2))+1);
			dec(j,x);
		end;
		for j:=2 to n do
			for k:=1 to m do
				if mat[j-1,k]=1 then flip(j,k);
		
		for j:=1 to m do
			if mat[n,j]=1 then begin 
				cnt:=maxlongint;
				break; 
			end;
		if cnt<ans then begin ans:=cnt;opt:=cur end;
		mat:=tmp;
	end; 
	
	if ans=maxlongint then write('IMPOSSIBLE')
	else 
		for i:=1 to n do begin
			for j:=1 to m do write(opt[i,j],' ');
			writeln;
		end;
end.
