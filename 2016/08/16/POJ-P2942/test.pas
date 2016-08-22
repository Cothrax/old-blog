//uses math;
type int=longint;
var 
    n,m,cc,i,f,t,tim,ans:int;
    g:array[0..1010,0..1010] of boolean;
    ins,kick:array[0..1010] of boolean;
    dfn,low,scc,s,col:array[0..1010] of int;
    

function min(a,b:int):int;
begin if a<b then min:=a else min:=b end;


function paint(v,c:int):boolean;
var i:int;
begin
    col[v]:=c;
    for i:=1 to n do
        if g[v,i] and (scc[i]=cc) then begin
            if (col[i]=c) then exit(false);
            if (col[i]=0) and not paint(i,-c) then exit(false);
        end;
    paint:=true;
end;

procedure solve(v,i:int);
var 
    tmp:array[0..1010] of int;
    cnt,j:int;
begin
    inc(cc);cnt:=0;
    while s[t+1]<>i do begin
        ins[s[t]]:=false;
        inc(cnt);tmp[cnt]:=s[t];
        scc[s[t]]:=cc;
        dec(t);
    end;
    inc(cnt);tmp[cnt]:=v;
    fillchar(col,sizeof(col),0);
    if (cnt>=3) and not paint(v,1) then
        for j:=1 to cnt do kick[tmp[j]]:=false;
end;


procedure tarjan(v,p:int);
var i:int;
begin
    inc(tim);dfn[v]:=tim;low[v]:=tim;
    ins[v]:=true;inc(t);s[t]:=v;
    for i:=1 to n do
        if g[v,i] then begin
            if i=p then continue;
            if dfn[i]=0 then begin
                tarjan(i,v);
                low[v]:=min(low[v],low[i]);
                if low[i]>=dfn[v] then solve(v,i);
            end else if ins[i] then
                low[v]:=min(low[v],dfn[i]);
        end;
end;

begin
    while true do begin
        read(n,m);
        if (n=0) and (m=0) then break;
        
        fillchar(g,sizeof(g),true);
        for i:=1 to m do begin
            read(f,t);
            g[f,t]:=false;g[t,f]:=false;
        end;
        for i:=1 to n do g[i,i]:=false;

        fillchar(kick,sizeof(kick),true);
        fillchar(dfn,sizeof(dfn),0);
        fillchar(scc,sizeof(scc),0);
        fillchar(ins,sizeof(ins),false);
        cc:=0;tim:=0;t:=0;
        for i:=1 to n do if dfn[i]=0 then tarjan(i,0);

        ans:=0;
        for i:=1 to n do if kick[i] then inc(ans);
        writeln(ans);
    end;
end.
