uses math;
type int=longint;
var 
    f:array[0..500010] of boolean;
    q:array[0..1000010] of int;
    a:array[0..6] of int;
    i,sum,cnt,d:int;

procedure print(i:int;b:boolean);
begin
    writeln('Collection #',cnt,':');
    if b then writeln('Can be divided.') 
    else writeln('Can',chr(39),'t be divided.');
    writeln;
end;

procedure dp(c,a:int);
var h,t,k,i:int;
begin
    if a=0 then exit;
    d:=min(sum,d+c*a);
    for i:=0 to c-1 do begin
        h:=1;t:=0;k:=0;
        while i+k*c<=d do begin
            if f[i+k*c] then begin inc(t);q[t]:=k end;
            while (h<=t) and (k-q[h]>a) do inc(h);
            if (h<=t) then f[i+k*c]:=true;
            inc(k);
        end;
    end;
end;

begin
    cnt:=0;
    while true do begin
        sum:=0;
        for i:=1 to 6 do begin
            read(a[i]);
            inc(sum,a[i]*i);
        end;
        if sum=0 then break;
        inc(cnt);
        if odd(sum) then begin print(cnt,false);continue end;
        fillchar(f,sizeof(f),false);
        f[0]:=true;d:=0;
        for i:=1 to 6 do dp(i,a[i]);
        print(cnt,f[sum div 2]);
    end;
end.
