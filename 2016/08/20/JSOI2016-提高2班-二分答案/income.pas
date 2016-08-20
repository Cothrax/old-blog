type int=longint;
var 
    n,m,i,l,r,mid,ans:int;
    a:array[0..100010] of int;

function check(x:int):boolean;
var i,sum,cnt:int;
begin
    sum:=0;cnt:=0;
    for i:=1 to n do
        if a[i]>x then exit(false)
        else if sum+a[i]>x then begin
            inc(cnt);sum:=a[i]
        end else
            inc(sum,a[i]);
    check:=(cnt+1)<=m;
end;

begin
    assign(input,'income.in');reset(input);
    assign(output,'income.out');rewrite(output);
    read(n,m);
    l:=0;r:=0;
    for i:=1 to n do begin
        read(a[i]);
        inc(r,a[i]);
    end;
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check(mid) then begin ans:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
    write(ans);
    close(input);close(output);
end.
