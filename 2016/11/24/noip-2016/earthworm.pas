uses math;
type int=longint;ll=int64;
var
	q:array[0..2,0..7500010] of ll;
	h,t:array[0..2] of int;
	n,m,t0,i:int;u,v,q0,dt,tmp,x,y:ll;p:double;

function ext():ll;
var i,j:int;
begin
	j:=-1;
	for i:=0 to 2 do
		if (h[i]<=t[i])and((j=-1)
			or(q[j,h[j]]<q[i,h[i]])) then j:=i;
	ext:=q[j,h[j]];inc(h[j]);//writeln(j,'::',ext);
end;

procedure qsort(l,r:int);
var i,j:int;x,tmp:ll;
begin
	i:=l;j:=r;x:=q[0,random(r-l)+l];
	repeat
		while q[0,i]>x do inc(i);
		while q[0,j]<x do dec(j);
		if i<=j then begin
			tmp:=q[0,i];q[0,i]:=q[0,j];q[0,j]:=tmp;
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

begin
	//assign(input,'earthworm.in');reset(input);
	//assign(output,'earthworm.out');rewrite(output);
	read(n,m,q0,u,v,t0);p:=u/v;
	for i:=1 to n do read(q[0,i]);
	qsort(1,n);
	//for i:=1 to n do write(q[0,i],' ');writeln;
	h[0]:=1;h[1]:=1;h[2]:=1;t[0]:=n;dt:=0;
	for i:=1 to m do begin
		tmp:=ext()+dt;x:=trunc(tmp*u/v);y:=tmp-x;inc(dt,q0);
		//writeln(tmp,' ',x,' ',y,'>>',dt);
		inc(t[1]);inc(t[2]);q[1,t[1]]:=x-dt;q[2,t[2]]:=y-dt;
		if i mod t0=0 then write(tmp,' ');
	end;
	writeln;
	for i:=1 to n+m do begin
		tmp:=ext()+dt;
		if i mod t0=0 then write(tmp,' ');
	end;
	//close(input);close(output);
end.
