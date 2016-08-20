uses math;
type int=longint;
var 
    n,a,b,l,r,mid,ans,i:int;
    f:array[0..500010] of int;

function check(x:int):boolean;
var i,cnt:int;
begin
    cnt:=0;
    for i:=1 to n do
        if x*a<f[i] then 
            inc(cnt,ceil((f[i]-x*a)/b));
    check:=cnt<=x;
end;

begin
    assign(input,'dry.in');reset(input);
    assign(output,'dry.out');rewrite(output);
    read(n,a,b);
    l:=0;r:=0;
    for i:=1 to n do begin
        read(f[i]);
        r:=max(f[i],r);
    end;
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check(mid) then begin ans:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
    write(ans);
    close(input);close(output);
end.
