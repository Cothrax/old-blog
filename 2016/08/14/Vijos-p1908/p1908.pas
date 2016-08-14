uses math;
type int=longint;
var 
    n,d,x,y,mx,my,i,j,tmp,ans,cnt:int;
    a:array[-21..200,-21..200] of int;

function solve(x,y:int):int;
var i,j:int;
begin
    solve:=0;
    for i:=x-d to x+d do
        for j:=y-d to y+d do 
            inc(solve,a[i,j]);
end;

begin
    read(d,n);
    mx:=0;my:=0;
    fillchar(a,sizeof(a),0);
    for i:=1 to n do begin
        read(x,y);read(a[x,y]);
        mx:=max(x,mx);my:=max(y,my);
    end;
    inc(mx,d);inc(my,d);
    ans:=0;cnt:=0;
    for i:=0 to min(mx,128) do
        for j:=0 to min(my,128) do begin
            tmp:=solve(i,j);
            if tmp>ans then begin ans:=tmp;cnt:=1 end
            else if ans=tmp then inc(cnt);
        end;
    write(cnt,' ',ans);
end.
