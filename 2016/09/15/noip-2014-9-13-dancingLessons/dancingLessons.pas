uses math;
const inf=maxlongint shr 2;
type 
	int=longint;
	nh=record l,r,d:int end;
	nl=record l,r:int end;
var 
	hp:array[0..200010] of nh;
	lk:array[0..200010] of nl;
	lh,a:array[0..200010] of int;
	g:array[0..200010] of char;
	ans:array[0..100010,0..1] of int;
	n,i,sh,cnt,l1,r1,l2,r2:int;

procedure swap(i,j:int);
var tmp:nh;
begin
	if hp[i].d<>inf then lh[hp[i].l]:=j;
	if hp[j].d<>inf then lh[hp[j].l]:=i;
	tmp:=hp[i];hp[i]:=hp[j];hp[j]:=tmp;
end;
function com(p,c:int):boolean;
begin
	com:=(hp[p].d<hp[c].d) or 
		((hp[p].d=hp[c].d) and (hp[p].l<hp[c].l));
end;
procedure heapify(i:int);
var l,r,s:int;
begin
	l:=i shl 1;r:=l or 1;
	if (l<=sh) and com(l,i) then s:=l else s:=i;
	if (r<=sh) and com(r,s) then s:=r;
	if s<>i then begin swap(s,i);heapify(s) end;
end;
procedure extract();
begin swap(1,sh);dec(sh);heapify(1) end;
procedure delete(x:int);
var i:int;
begin i:=lh[x];hp[i].d:=inf;heapify(i) end;
procedure insert(x,y:int);
var i:int;
begin
	inc(sh);lh[x]:=sh;
	hp[sh].l:=x;hp[sh].r:=y;
	hp[sh].d:=abs(a[x]-a[y]);
	i:=sh;
	while (i>1) and com(i,i shr 1) do begin
		swap(i,i shr 1);i:=i shr 1;
	end;
end;

begin
	assign(input,'dancingLessons.in');reset(input);
	assign(output,'dancingLessons.out');rewrite(output);
	readln(n);sh:=0;
	for i:=1 to n do read(g[i]);readln;
	for i:=1 to n do begin
		read(a[i]);
		lk[i].l:=i-1;lk[i].r:=i+1;
	end;
	lk[n].r:=0;lk[0].r:=1;lk[0].l:=n;
	for i:=2 to n do
		if g[i]<>g[i-1] then insert(i-1,i);
	cnt:=0;
	while (hp[1].d<>inf) and (sh<>0) do begin
		inc(cnt);
		l1:=hp[1].l;r1:=hp[1].r;extract;
		l2:=lk[l1].l;r2:=lk[r1].r;
		if (l2<>0) and (g[l1]<>g[l2]) then delete(l2);
		if (r2<>0) and (g[r1]<>g[r2]) then delete(r1);
		if (min(l2,r2)<>0) and (g[l2]<>g[r2]) then
			insert(l2,r2);
		ans[cnt,0]:=l1;ans[cnt,1]:=r1;
		lk[l2].r:=r2;lk[r2].l:=l2;
	end;
	writeln(cnt);
	for i:=1 to cnt do writeln(ans[i,0],' ',ans[i,1]);
	close(input);close(output);
end.
