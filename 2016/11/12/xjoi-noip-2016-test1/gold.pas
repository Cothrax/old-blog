uses math;
type int=longint;node=record w,nxt:int end;
const eps=0.000001;inf:double=100000000000;
var 
	lnk:array[0..100010] of node;
	head,tail:array[0..100010] of int;
	n,m,sz,i,j,x:int;l,r,mid,ans:double;

procedure insert(i,x:int);
begin
	inc(sz);lnk[sz].w:=x;
	if head[i]=0 then begin head[i]:=sz;tail[i]:=sz end
	else begin lnk[tail[i]].nxt:=sz;tail[i]:=sz end;
end;

function jud(x:double):boolean;
var sum,cur,ans:double;i,j:int;
begin
	sum:=0;
	for i:=1 to n do begin
		j:=head[i];cur:=0;ans:=-inf;
		while j<>0 do begin
			cur:=cur+int64(lnk[j].w)-x;
			ans:=max(ans,cur);
			j:=lnk[j].nxt;
		end;
		sum:=sum+ans;
	end;
	jud:=sum>=0;
end;

begin
	//assign(input,'gold.in');reset(input);
	//assign(output,'gold.out');rewrite(output);
	read(n,m);sz:=0;
	l:=0;r:=0;
	for i:=1 to n do
		for j:=1 to m do begin
			read(x);insert(i,x);r:=r+x;
		end;
	while r-l>eps do begin
		mid:=(l+r)/2;
		if jud(mid) then begin ans:=mid;l:=mid end
		else r:=mid;
	end;
	write(ans:0:4);
	//close(input);close(output);
end.
