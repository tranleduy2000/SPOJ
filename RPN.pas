var
        expr: string;
        n, top, pos, topRes: integer;
        stack: array[1..1000] of string;
        consume: array[1..1000] of string;

function next: string;
var
        res: string;
begin
        res := '';
        if expr[pos] in ['0'..'9'] then
        begin
                while expr[pos] in ['0'..'9'] do
                begin
                        res := res + expr[pos];
                        inc(pos);
                end;
                exit(res);
        end
        else
        begin
                res := expr[pos];
                inc(pos);
                exit(res);
        end;
end;

function precedence(opt: string): integer;
begin
        case opt[1] of
          '(': exit(0);
          '+', '-': exit(1);
          '*', '/': exit(2);
        end;
end;

procedure popHigher(opt: string);
begin
        while (top > 0) and (precedence(stack[top]) >= precedence(opt)) do
        begin
                inc(topRes);
                consume[topRes] := stack[top];
                dec(top);
        end;
end;

procedure toRpn;
var
        token: string;
begin
        pos := 1;
        topRes := 0;
        top := 0;
        while pos <= length(expr) do
        begin
            token := next;
            if token[1] in ['+', '-', '*', '/'] then
            begin
                popHigher(token);
                inc(top);
                stack[top] := token;
            end else
            if token[1] in ['(', ')'] then
            begin
                if token[1] = '(' then
                begin
                        inc(top);
                        stack[top] := token;
                end
                else
                begin
                        while stack[top] <> '(' do
                        begin
                                inc(topRes);
                                consume[topRes] := stack[top];
                                dec(top);
                        end;
                        dec(top); // '(' token
                end;
            end else
            begin
                inc(topRes);
                consume[topRes] := token;
            end;
        end;
        while top > 0 do
        begin
                inc(topRes);
                consume[topRes] := stack[top];
                dec(top);
        end;
end;

function isOpt(token: string):boolean;
begin
        if token[1] in ['+', '-', '*','/'] then exit(true) else exit(false);
end;

procedure evaluate;
var
        num1, num2: real;
        pos, e: longint;
        stack: array[1..1000] of real;
begin
        pos := 1;
        top := 0;
        for pos := 1 to topRes do
        begin
                if isOpt(consume[pos]) then
                begin
                        num1 := stack[top-1];
                        num2 := stack[top];
                        top := top - 2;
                        case consume[pos] of
                         '+': num1 := num1 + num2;
                         '-': num1 := num1 - num2;
                         '*': num1 := num1 * num2;
                         '/': num1 := num1 / num2;
                        end;
                        inc(top);
                        stack[top] := num1;
                end else
                begin
                        inc(top);
                        val(consume[pos], num1, e);
                        stack[top] := num1;
                end;
        end;
        writeln(stack[1]);
end;

begin
        readln(expr);
 //      expr := '1/2+3';
        toRpn();
        evaluate();
        readln;
end.