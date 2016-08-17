type int=longint;
var
    a1,a0,ans,orig,p,t,c,i,n,m:int; 
    s,op:string;

begin
    assign(input,'sleep.in');reset(input);
    assign(output,'sleep.out');rewrite(output);

    readln(n,m);
    a0:=0;a1:=not 0;
    for i:=1 to n do begin
        readln(s);
        p:=pos(' ',s);
        op:=copy(s,1,p-1);
        val(copy(s,p+1,length(s)-p),t,c);
        
        if op='XOR' then begin a0:=a0 xor t;a1:=a1 xor t end
        else if op='OR' then begin a0:=a0 or t;a1:=a1 or t end
        else begin a0:=a0 and t;a1:=a1 and t end;
    end;

    ans:=0; //最终伤害
    orig:=0; //原始伤害
    for i:=30 downto 0 do 
        if ((a0 shr i) and 1)=1 then
            ans:=ans or (1 shl i)
        else if (((a1 shr i) and 1)=1) and 
                ((orig or (1 shl i))<=m) then begin
            ans:=ans or (1 shl i);
            orig:=orig or (1 shl i);
        end;
    write(ans);

    close(input);close(output);
end.

