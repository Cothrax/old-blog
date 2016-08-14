uses math;
type int=longint;
var 
    h,s:array[0..100010] of int;
    i,n,t:int;

function cal(sym:int):int;
var i:int;
begin
    {
        sym=1 下一个数大
        sym=-1 下一个数小
    }
    t:=1;s[t]:=h[1];
    for i:=2 to n do begin
        if ((sym>0) and (h[i]>s[t])) or
           ((sym<0) and (h[i]<s[t])) then begin
            inc(t);
            sym:=-sym;
        end;
        s[t]:=h[i];
    end;
    cal:=t;
end;

begin
    read(n);
    for i:=1 to n do read(h[i]);
    write(max(cal(1),cal(-1)));
end.
