uses math;
type int=longint;
var 
	n,m,d,i,j,k,v,r,amt:int;ans:int64;b:boolean;
	a:array[0..10,0..10] of int;

function mv(x,y,dx,dy:int):boolean;
var lx,ly:int;flg:boolean;
begin
	lx:=x-dx;ly:=y-dy;mv:=false;flg:=true;
	while (min(x,y)>0)and(max(x,y)<=n) do begin
		if a[x,y]>0 then begin
			if flg and (a[x,y]=a[lx,ly]) then begin
				a[lx,ly]:=a[lx,ly]*2;inc(ans,a[lx,ly]);
				a[x,y]:=0;
				inc(r);mv:=true;flg:=false;
			end else begin
				inc(lx,dx);inc(ly,dy);
				a[lx,ly]:=a[x,y];flg:=true;
				if (lx<>x)or(ly<>y) then begin
					a[x,y]:=0;mv:=true;
				end;
			end;
		end;
		inc(x,dx);inc(y,dy);
	end;
	b:=b or mv;
end;

procedure add(k,v:int);
var i,j,cnt:int;
begin
	cnt:=0;dec(r);
	for i:=1 to n do
		for j:=1 to n do
			if a[i,j]=0 then begin
				inc(cnt);
				if cnt=k then begin a[i,j]:=v;exit end;
			end;
end;

begin
	assign(input,'game.in');reset(input);
	assign(output,'game.out');rewrite(output);
	read(n,m);r:=n*n-2;ans:=0;amt:=m;
	read(i,j,k);a[i,j]:=k;
	read(i,j,k);a[i,j]:=k;
	for i:=1 to m do begin
		read(d,k,v);b:=false;
		case d of 
			0:for j:=1 to n do mv(1,j,1,0);
			1:for j:=1 to n do mv(n,j,-1,0);
			2:for j:=1 to n do mv(j,1,0,1);
			3:for j:=1 to n do mv(j,n,0,-1);
		end;
		if (r=0) or not b then begin amt:=i-1;break end;
		k:=1+k mod r;add(k,v);
	end;
	writeln(amt);write(ans);
	close(input);close(output);
end.
