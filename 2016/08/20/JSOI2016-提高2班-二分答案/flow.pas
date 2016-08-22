uses math;
type int=longint;
const inf=1000000000;
var 
    n,m,d,i,l,r,mid,ans:int;
    w,s:array[0..15010] of int;
    f:array[0..15010,0..1] of int;


function check(x:int):boolean;
var i,j:int;
begin
    filldword(f,sizeof(f) div 4,inf);
    f[0,0]:=0;
    for i:=1 to n div 2 do
        for j:=i-1 downto max(i-d,0) do
            if max(s[2*j+i-j]-s[2*j],s[2*i]-s[2*j+i-j])<=x then begin
                f[i,0]:=min(f[i,0],f[j,1]+1);
                f[i,1]:=min(f[i,1],f[j,0]+1);
            end;
    check:=f[n div 2,(m-1) and 1]<m;
end;

begin
    assign(input,'flow.in');reset(input);
    assign(output,'flow.out');rewrite(output);
    read(n,m,d);
    if odd(n) or (n<2*m-2) then begin write('BAD');halt end;
    l:=0;r:=0;s[0]:=0;
    for i:=1 to n do begin
        read(w[i]);
        inc(r,w[i]);
        s[i]:=s[i-1]+w[i];
    end;
    
    ans:=-1;
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check(mid) then begin ans:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
    if ans=-1 then write('BAD') else write(ans);
    close(input);close(output);
end.
