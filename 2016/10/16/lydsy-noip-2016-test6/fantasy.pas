{$R-}
uses math;
type int=longint;qw=qword;dw=dword;
const z0:qw=20000116;
var 
	T,i:int;l,r,x:qw;ans,k,cnt:dw;
	nxt:array[0..1100] of dw;
	f:array[0..60] of dw;

begin
	//assign(input,'fantasy.in');reset(input);
	//assign(output,'fantasy.out');rewrite(output);
	read(T);
	repeat
		read(k,l,r);
		fillchar(f,sizeof(f),0);
		x:=l;i:=0;cnt:=0;
		while x>0 do begin
			f[i]:=x mod k;x:=x div k;cnt:=cnt+f[i];i:=i+1;
		end;
		for i:=0 to k-2 do nxt[i]:=i+1;nxt[k-1]:=0;
		cnt:=cnt mod k;
		ans:=qw(cnt)*trunc((sqr(l mod z0)+l+804)/233);
		if l=r then exit;x:=l+1;
		repeat
			f[0]:=f[0]+1;cnt:=nxt[cnt];i:=0;
			while f[i]=k do begin
				f[i+1]:=f[i+1]+1;f[i]:=0;i:=i+1;
				cnt:=nxt[cnt];
			end;
			ans:=qw(ans)+qw(cnt)*trunc((sqr(x mod z0)+x+804)/233);
			x:=x+1;
		until x=r+1;
		writeln(ans);
		dec(T);
	until T=0;
	//close(input);close(output);
end.
