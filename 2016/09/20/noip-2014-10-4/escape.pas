uses math;
type int=longint;
const d:array[0..3,0..1] of int=((1,0),(0,1),(-1,0),(0,-1));
var
	mp,dist:array[0..1010,0..1010] of int;
	q:array[0..1000010,0..1] of int;
	k,n,m,i,h,t,
	x,y,sx,sy,tx,ty,nx,ny,
	l,r,mid,ans,mn:int;

function check(x0:int):boolean;
begin
	if mp[sx,sy]<x0 then exit(false);
	fillchar(dist,sizeof(dist),255);
	h:=0;t:=1;q[h,0]:=sx;q[h,1]:=sy;dist[sx,sy]:=0;
	while h<>t do begin
		x:=q[h,0];y:=q[h,1];inc(h);
		for i:=0 to 3 do begin
			nx:=x+d[i,0];ny:=y+d[i,1];
			if (min(nx,ny)<0) or (nx>=n) or (ny>=m) then continue;
			if dist[nx,ny]<>-1 then continue;
			if mp[nx,ny]<x0 then continue;
			dist[nx,ny]:=dist[x,y]+1;
			q[t,0]:=nx;q[t,1]:=ny;inc(t);
		end;
	end;
	check:=dist[tx,ty]<>-1;
end;

begin
	assign(input,'escape.in');reset(input);
	assign(output,'escape.out');rewrite(output);
	fillchar(mp,sizeof(mp),255);
	read(k,n,m,sx,sy,tx,ty);
	h:=0;t:=0;
	for i:=1 to k do begin
		read(x,y);
		q[t,0]:=x;q[t,1]:=y;inc(t);
		mp[x,y]:=0;
	end;
	
	while h<>t do begin
		x:=q[h,0];y:=q[h,1];inc(h);
		for i:=0 to 3 do begin
			nx:=x+d[i,0];ny:=y+d[i,1];
			if (min(nx,ny)<0) or (nx>=n) or (ny>=m) then continue;
			if mp[nx,ny]<>-1 then continue;
			mp[nx,ny]:=mp[x,y]+1;
			q[t,0]:=nx;q[t,1]:=ny;inc(t);
		end;
	end;
	l:=0;r:=n+m+2;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if check(mid) then begin 
			ans:=mid;mn:=dist[tx,ty];l:=mid+1; 
		end else r:=mid-1;
	end;
	write(ans,' ',mn);
	close(input);close(output);
end.
