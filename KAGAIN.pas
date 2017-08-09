var
        n: longint;
        a, l, r: array[1..30000] of longint;

procedure leftright;
var     i, j, k, max: longint;
begin
        for i := 1 to n do
        begin
                l[i] := i;
                k := i-1;
                while (k > 0) and (a[k] >= a[i]) do
                begin
                        l[i] := l[k];
                        k := l[k] - 1;
                end;
        end;
        for i := n downto 1 do
        begin
                r[i] := i;
                k := i + 1;
                while (k <= n) and (a[k] >= a[i]) do
                begin
                        r[i] := r[k];
                        k := r[k] + 1;
                end;
        end;
        max := 0;
        for i := 1 to n do
        begin
                if max < (a[i] * (r[i] - l[i] + 1)) then
                begin
                        max := a[i] * (r[i] - l[i] + 1);
                        j := i;
                end;
        end;
        writeln(max,' ',  l[j], ' ', r[j]);
end;

procedure process;
var     f: text;
        i, t: longint;
begin
        assign(f, 'file.inp');
        reset(f);
        readln(f, t);
        while t > 0 do
        begin
                readln(f, n);
                for i := 1 to n do read(f, a[i]);
                leftright;
                dec(t);
        end;
        close(f);
end;

begin
        process;
        readln;
end.
