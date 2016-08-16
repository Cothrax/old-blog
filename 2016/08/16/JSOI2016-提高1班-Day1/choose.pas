type int=longint;
var 
    a:array[0..100010] of int;
    n,k,i,l,r,mid,ans:int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(b,e:int);
var i,j,x:int;
begin
    i:=b;j:=e;x:=a[random(e-b)+b];
    repeat
        while a[i]<x do inc(i);
        while a[j]>x do dec(j);
        if i<=j then begin
            swap(a[i],a[j]);
            inc(i);dec(j);
        end;
    until i>j;
    if i<e then qsort(i,e);
    if b<j then qsort(b,j);
end;

function check(x:int):boolean;
var i,last,cnt:int;
begin
    cnt:=1;last:=a[1];
    for i:=2 to n do
        if a[i]-last>=x then begin
            last:=a[i];
            inc(cnt);
        end;
    check:=cnt>=k;
end;

begin
    assign(input,'choose.in');reset(input);
    assign(output,'choose.out');rewrite(output);

    read(n,k);
    for i:=1 to n do read(a[i]);
    qsort(1,n);
    l:=0;r:=a[n]-a[1];
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check(mid) then begin ans:=mid;l:=mid+1 end
        else r:=mid-1;
    end;
    write(ans);

    close(input);close(output);
end.

{
11
19 585 29 1111 5868 3331 272 4441 2251 868 581
}
