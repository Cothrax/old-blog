uses math;
type int=longint;
const 
    inf=1000000000;
    dir:array[1..4,0..1] of int=((-1,0),(1,0),(0,-1),(0,1));
var 
    map:array[0..210,0..210] of char;
    f:array[0..210,0..210] of int;
    q:array[0..100010,0..1] of int;
    n,m,k,i,j,sx,sy,l,r,d,ans:int;

procedure dp(x,y,d,l:int);
var h,t,cnt:int;
begin
    h:=1;t:=0;cnt:=1;
    while (x>0) and (y>0) and (x<=n) and (y<=m) do begin
        if map[x,y]='x' then begin h:=1;t:=0 end;
        while (h<=t) and (q[t,0]<f[x,y]-cnt) do dec(t);
        inc(t);q[t,0]:=f[x,y]-cnt;q[t,1]:=cnt;
        while (h<=t) and (cnt-q[h,1]>l) do inc(h);
        f[x,y]:=q[h,0]+cnt;
        ans:=max(ans,f[x,y]);
        inc(x,dir[d,0]);inc(y,dir[d,1]);inc(cnt);
    end;
end;

begin
    assign(input,'adv1900.in');reset(input);
    assign(output,'adv1900.out');rewrite(output);
    readln(n,m,sx,sy,k);
    for i:=1 to n do begin
        for j:=1 to m do read(map[i,j]);
        readln;
    end;
    filldword(f,sizeof(f) div 4,-inf);
    f[sx,sy]:=0;ans:=0;
    for i:=1 to k do begin
        read(l,r,d);
        if d=1 then for j:=1 to m do dp(n,j,d,r-l+1);
        if d=2 then for j:=1 to m do dp(1,j,d,r-l+1);
        if d=3 then for j:=1 to n do dp(j,m,d,r-l+1);
        if d=4 then for j:=1 to n do dp(j,1,d,r-l+1);
    end;
    write(ans);
    close(input);close(output);
end.
