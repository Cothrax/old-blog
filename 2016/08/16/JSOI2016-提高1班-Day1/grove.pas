uses math;
type int=integer;
const 
    dir:array[0..7,0..1] of int=
    ((0,1),(0,-1),(1,0),(-1,0),(1,1),(-1,-1),(-1,1),(1,-1));
    inf=5000;    
var 
    n,m,i,j,sx,sy,x,y,nx,ny,h,t,ans:int;
    map:array[0..51,0..51] of char;
    f:array[0..51,0..51] of int;
    q:array[0..2510,0..1] of int;
    
begin
    assign(input,'grove.in');reset(input);
    assign(output,'grove.out');rewrite(output);

    readln(n,m);
    y:=51;
    for i:=1 to n do begin
        for j:=1 to m do begin
            read(map[i,j]);
            if (map[i,j]='X') and (j<y) then begin x:=i;y:=j end;
            if map[i,j]='*' then begin sx:=i;sy:=j end;
        end;
        readln;
    end;
    for j:=1 to y-1 do map[x,j]:='-';
    
    fillword(f,sizeof(f) div 2,inf);
    h:=1;t:=2;
    q[h,0]:=sx;q[h,1]:=sy;
    f[sx,sy]:=0;
    while h<>t do begin
        for i:=0 to 7 do begin
            nx:=q[h,0]+dir[i,0];ny:=q[h,1]+dir[i,1];
            if (nx<1) or (ny<1) or (nx>n) or (ny>m) then continue;
            if f[nx,ny]<>inf then continue;
            if (map[nx,ny]='X') or (map[nx,ny]='-') then continue;

            q[t,0]:=nx;q[t,1]:=ny;f[nx,ny]:=f[q[h,0],q[h,1]]+1;
            inc(t);if t>2510 then t:=0;
        end;
        inc(h);if h>2510 then h:=0;
    end;
    
    ans:=maxint;
    for i:=1 to y do
        for j:=1 to y do
            ans:=min(ans,f[x-1,i]+f[x+1,j]+max(abs(j-i),2));
    write(ans);
    
    close(input);close(output);
end.
