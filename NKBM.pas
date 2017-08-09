const
	maxn = 1000;
var
	x, y, m: integer;
	mx, my, trace: array[1..maxn] of integer;
	c: array[1..maxn, 1..maxn] of boolean;

procedure enter;
var
	f: text;
	u,v,i: integer;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, x, y, m);
	fillchar(c, sizeof(c), false);
	for i := 1 to m do
	begin
		readln(f, u, v);
		c[u, v] := true;
	end;
	close(f);
	fillchar(mx, sizeof(mx), 0);
	fillchar(my, sizeof(my), 0);
end;

function findPath: integer;
var
	queue: array[1..maxn] of longint;
	u,v, f,r : longint;
begin
	f := 1; r := 0;
	fillchar(trace, sizeof(trace), 0);
	for u := 1 to x do
		if mx[u] = 0 then
		begin
			inc(r);
			queue[r] := u;
		end;
	repeat
		u := queue[f]; inc(f);
		for v := 1 to y do
			if (trace[v] = 0) and c[u, v] then
			begin
				trace[v] := u;
				if mY[v] = 0 then exit(v);
				inc(r); queue[r] := mY[v];
			end;
	until f > r;
	exit(0);
end;

procedure enlarge(v: integer);
var
	u,  next: integer;
begin
	repeat
		u := trace[v];
		next := mX[u];
		mX[u] := v;
		mY[v] := u;
		v := next;
	until v = 0;
end;

procedure solve;
var
	f: integer;
begin
	repeat
		f := findPath;
	        if f <> 0 then enlarge(f);
	until f = 0;
end;

procedure print;
var
	u, res: integer;
begin
	res := 0;
	for u := 1 to x do if mx[u] <> 0 then inc(res);
	writeln(res);
end;

begin
	enter;
	solve;
	print;
end.
