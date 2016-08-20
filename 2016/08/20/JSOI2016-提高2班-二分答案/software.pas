uses math;
const inf=100000000;
type int=longint;
var 
    n,m,i,l,r,mid,ans:int;
    f:array[0..101] of int;
    d:array[0..101,0..1] of int;

function check(x:int):boolean;
var i,j,k,maxs:int;
begin
    filldword(f,sizeof(f) div 4,-inf);
    f[0]:=0;
    for i:=1 to n do begin
        maxs:=x div d[i,0];
        for j:=m downto 0 do 
            for k:=0 to min(maxs,j) do
                f[j]:=max(f[j],f[j-k]+(x-k*d[i,0]) div d[i,1]);
    end;
    check:=f[m]>=m;
end;

begin
    assign(input,'software.in');reset(input);
    assign(output,'software.out');rewrite(output);
    read(n,m);
    for i:=1 to n do read(d[i,0],d[i,1]);
    l:=1;r:=inf;
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check(mid) then begin ans:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
    write(ans);
    close(input);close(output);
end.
