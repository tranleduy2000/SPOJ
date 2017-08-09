uses crt;
var     s, tmp: string;
        a: array['a'..'z'] of char;
        b: array['a'..'z'] of char;
        c: char;
        n, i: integer;
begin
        clrscr;
        tmp := '';
        for c := 'a' to 'z' do tmp := tmp + c;
        readln(n);
        for i := 1 to length(tmp) do
        begin
                if i + n <= length(tmp) then a[tmp[i]] := tmp[i+n]
                else a[tmp[i]] := tmp[(i + n) mod length(tmp)]; //abc
                if i - n > 0 then b[tmp[i]] := tmp[i-n]
                else b[tmp[i]] := tmp[length(tmp) + (i - n)];
        end;

        //result
        readln(s);
        for i := 1  to length(s) do write(a[s[i]]); writeln;
        readln(s);
        for i :=1 to length(s) do write(b[s[i]]); writeln;
        readln;
end.