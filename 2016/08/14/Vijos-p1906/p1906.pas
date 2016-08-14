uses math;
const z=10007;
type 
    int=longint;
    edge=record t,next:int end;
var 
    n,i,f,t,ans,maxw:int;
    w,head:array[0..200010] of int;
    g:array[0..400010] of edge;

procedure add(f,t:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;
    g[m].next:=head[f];head[f]:=m;
end;

procedure solve(v:int);
var i,u,fir,sec,sqrsum,sum:int;
begin
    fir:=0;sec:=0;sqrsum:=0;sum:=0;
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if w[u]>fir then begin sec:=fir;fir:=w[u] end
        else if w[u]>sec then sec:=w[u];
        sum:=(sum+w[u]) mod z;
        sqrsum:=(sqrsum+sqr(w[u])) mod z;
        i:=g[i].next;
    end;
    if sec<>0 then begin
        maxw:=max(maxw,fir*sec);
        ans:=(ans+sqr(sum)-sqrsum) mod z;
    end;
end;

begin
    read(n);
    for i:=1 to n-1 do begin
        read(f,t);
        add(f,t);add(t,f);
    end;
    for i:=1 to n do read(w[i]);
    ans:=0;maxw:=0;
    for i:=1 to n do solve(i);
    write(maxw,' ',ans);
end.
