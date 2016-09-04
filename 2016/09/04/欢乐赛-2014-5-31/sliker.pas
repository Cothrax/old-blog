uses math;
type 
	int=longint;
	arr=array[0..51,0..51] of int;
const 
	dir:array[0..3,0..1] of int=((0,1),(1,0),(0,-1),(-1,0));
	inf=100000000;
var
	map:array[0..51,0..51] of char;
	s:array[0..2510,0..1] of int;
	n,m,k,i,j,sx,sy,tx,ty:int;
	f,d:arr;

procedure bfs(sx,sy:int;var d:arr;b:boolean);
var 
	h,t,i,nx,ny,x,y:int;
	q:array[0..2510,0..1] of int;
	used:array[0..51,0..51] of boolean;
begin
	fillchar(used,sizeof(used),false);
	h:=0;t:=1;
	q[h,0]:=sx;q[h,1]:=sy;
	d[sx,sy]:=0;used[sx,sy]:=true;
	while h<>t do begin
		x:=q[h,0];y:=q[h,1];
		for i:=0 to 3 do begin
			nx:=q[h,0]+dir[i,0];ny:=q[h,1]+dir[i,1];
			if (nx<1) or(nx>n) or (ny<1) or (ny>m) then continue;
			if used[nx,ny] or (map[nx,ny]='X') then continue;
			if not b and (map[nx,ny]='D') then continue;
			used[nx,ny]:=true;
			d[nx,ny]:=min(d[nx,ny],d[x,y]+1);
			if b and (d[nx,ny]>=f[nx,ny]) then continue;
			q[t,0]:=nx;q[t,1]:=ny;inc(t);
		end;
		inc(h);
	end;
end;

procedure print(a:arr);
var i,j:int;
begin
	for i:=1 to n do begin
		for j:=1 to m do
			if a[i,j]=inf then write(-1:3) else write(a[i,j]:3);
		writeln
	end;writeln;
end;

begin
	assign(input,'sliker.in');reset(input);
	assign(output,'sliker.out');rewrite(output);
	readln(n,m);k:=0;
	for i:=1 to n do
		for j:=1 to m do begin
			read(map[i,j]);
			case map[i,j] of 
				'S':begin sx:=i;sy:=j end;
				'D':begin tx:=i;ty:=j end;
				'*':begin inc(k);s[k,0]:=i;s[k,1]:=j end;
			end;
			if j=m then readln;
		end;
	filldword(f,sizeof(f) div 4,inf);
	for i:=1 to k do bfs(s[i,0],s[i,1],f,false);
	//print(f);
	filldword(d,sizeof(d) div 4,inf);
	bfs(sx,sy,d,true);
	//print(d);
	if d[tx,ty]<>inf then write(d[tx,ty])
	else write('ORZ hzwer!!!');
	close(input);close(output);
end.
