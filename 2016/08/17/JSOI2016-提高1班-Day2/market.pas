const big=1;small=-1;
type 
    int=longint;
    heap=array[0..1000010,0..1] of int;

procedure swap(var a,b:int);
var tmp:int;
begin
    tmp:=a;a:=b;b:=tmp;
end;

function com(p,c,s:int):boolean;
begin
    if s=big then com:=p>c else com:=p<c;
end;

procedure heapify(var h:heap;x:int);
var l,r,s:int;
begin
    l:=2*x;r:=2*x+1;
    if (l<=h[0,0]) and com(h[l,0],h[x,0],h[0,1]) then s:=l else s:=x;
    if (r<=h[0,0]) and com(h[r,0],h[s,0],h[0,1]) then s:=r;
    if s<>x then begin
        swap(h[s,0],h[x,0]);
        swap(h[s,1],h[x,1]);
        heapify(h,s);
    end;
end;

procedure extract(var h:heap);
begin
    h[1]:=h[h[0,0]];
    dec(h[0,0]);
    heapify(h,1);
end;

procedure insert(var h:heap;k,v:int);
var i:int;
begin
    inc(h[0,0]);i:=h[0,0];
    h[i,0]:=v;h[i,1]:=k;
    while (i>1) and com(h[i,0],h[i div 2,0],h[0,1]) do begin
        swap(h[i,0],h[i div 2,0]);
        swap(h[i,1],h[i div 2,1]);
        i:=i div 2;
    end;
end;

var 
    hb,hs:heap;
    i,j,n,m,cnt,each,b,s:int;
    ans:int64;
    del:array[0..1000010] of boolean;

begin
    assign(input,'market.in');reset(input);
    assign(output,'market.out');rewrite(output);

    read(n);
    fillchar(del,sizeof(del),false);
    hb[0,0]:=0;hb[0,1]:=big;
    hs[0,0]:=0;hs[0,1]:=small;
    cnt:=0;ans:=0;
    for i:=1 to n do begin
        read(m);
        for j:=1 to m do begin
            inc(cnt);
            read(each);
            insert(hs,cnt,each);
            insert(hb,cnt,each);
        end;
        //writeln(hb[0,0],' ',hs[0,0],' ',ans);
        while del[hb[1,1]] do extract(hb);
        b:=hb[1,0];del[hb[1,1]]:=true;extract(hb);
        while del[hs[1,1]] do extract(hs);
        s:=hs[1,0];del[hs[1,1]]:=true;extract(hs);
        inc(ans,b-s);
    end;
    write(ans);

    close(input);close(output);
end.
