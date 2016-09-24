uses math;
type int=longint;
var
	tmp,cnt:array[-1000010..1000010] of int;
	n,k,i,j,mn,mx,p:int;ans:int64;

begin
	assign(input,'jkl.in');reset(input);
	assign(output,'jkl.out');rewrite(output);
	read(n,k);
	mn:=maxlongint;mx:=0;
	for i:=1 to n do begin
		read(j);inc(cnt[j]);
		mn:=min(j,mn);mx:=max(j,mx);
	end;
	tmp:=cnt;ans:=0;
	for i:=1 to k do begin
		while cnt[mx]=0 do dec(mx);
		inc(ans,mx);dec(cnt[mx]);inc(cnt[mx-1]);
	end;
	write(ans,' ');
	p:=mn;i:=k;ans:=0;
	while i>0 do begin
		while (tmp[p]=0) do inc(p);
		//p+p-1+p-2+...1
		dec(tmp[p]);j:=min(i,p);dec(i,j);
		inc(ans,(p+(p-j+1))*j div 2);
	end;
	write(ans);
	close(input);close(output);
end.
