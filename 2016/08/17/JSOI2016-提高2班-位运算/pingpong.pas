const maxn=100000;
type 
    int=longint;
    arr=array[0..100010] of int;
var 
    l,r,a:arr;
    n,i,sl,sr:int;ans:int64;

function lowbit(x:int):int;
begin lowbit:=x and (-x) end;

procedure add(var a:arr;x,k:int);
begin
    if x=0 then exit;
    while x<=maxn do begin
        inc(a[x],k);
        inc(x,lowbit(x));
    end;
end;

function sum(var a:arr;x:int):int;
begin
    sum:=0;
    while x>0 do begin
        inc(sum,a[x]);
        dec(x,lowbit(x));
    end;    
end;

begin
    assign(input,'pingpong.in');reset(input);
    assign(output,'pingpong.out');rewrite(output);

    read(n);
    for i:=1 to n do begin
        read(a[i]);
        if i<>1 then add(r,a[i],1);
    end;
    ans:=0;
    for i:=1 to n do begin
        sl:=sum(l,a[i]);sr:=sum(r,a[i]);
        inc(ans,sl*(n-i-sr)+(i-1-sl)*sr);
        add(r,a[i+1],-1);add(l,a[i],1);
    end;
    write(ans);

    close(input);close(output);
end.
