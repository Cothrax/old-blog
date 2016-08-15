uses math;
var
    g:array[0..201,0..201] of boolean;
    dfn,low,scc,ind,s:array[0..201] of integer;
    ins,used:array[0..201] of boolean;
    n,i,j,t,cc,tim,ans:integer;

procedure tarjan(v:integer);
var i:integer;
begin
    inc(tim);dfn[v]:=tim;low[v]:=tim;
    used[v]:=true;ins[v]:=true;
    inc(t);s[t]:=v;
    for i:=1 to n do
        if g[v,i] then begin
            if not used[i] then begin
                tarjan(i);
                low[v]:=min(low[v],low[i]);
            end else if ins[i] then
                low[v]:=min(low[v],dfn[i]);
        end;
    if dfn[v]=low[v] then begin
        inc(cc);
        while s[t+1]<>v do begin
            scc[s[t]]:=cc;
            ins[s[t]]:=false;
            dec(t);
        end;
    end;
end;

begin
    read(n);
    fillchar(g,sizeof(g),false);
    for i:=1 to n do begin
        read(j);
        while j<>0 do begin
            g[i,j]:=true;
            read(j);
        end;
    end;
    fillchar(ins,sizeof(ins),false);
    fillchar(used,sizeof(used),false);
    fillchar(ind,sizeof(ind),0);
    tim:=0;cc:=0;t:=0;
    for i:=1 to n do
        if not used[i] then tarjan(i);
    for i:=1 to n do
        for j:=1 to n do
            if g[i,j] and (scc[i]<>scc[j]) then 
                inc(ind[scc[j]]);
    ans:=0;
    for i:=1 to cc do
        if ind[i]=0 then inc(ans);
    write(ans);
end.
