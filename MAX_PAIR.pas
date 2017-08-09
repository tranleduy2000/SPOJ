const
	maxn = 100;
	maxC = 10000;
var
	c: array[1..maxn, 1..maxn] of integer;
	mX, mY, trace, fx, fy: array[1..maxn] of integer;
	n, m, finish, start: integer;
procedure enter;
var
	f: text;
	u, v: integer;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, n, m);
	for u := 1 to n do
		for v := 1 to m do c[u, v] := maxC;
	while not seekeof(f) do
	begin
		read(f, u, v);
		read(f, c[u, v]);
	end;
	close(f);
end;

procedure init;
begin
	fillchar(mx, sizeof(mx), 0);
	fillchar(my, sizeof(my), 0);
end;

function getC(x, y: integer): integer;
begin 
	getC := c[x, y] - fx[x] - fy[y];
end;

procedure findPath;
var
	queue: array[1..maxn] of integer;
	f, r, x, y: integer;
begin
	f := 1; r := 1; 
	queue[1] := start;
	fillchar(trace, sizeof(trace), 0);
	repeat
		x := queue[f]; 
		inc(f);
		for y := 1 to m do
			if (trace[y] = 0) and (getC(x, y) = 0) then
			begin
				trace[y] := x;
				if mY[y] = 0 then 
				begin
					finish := y;
					exit;
				end;
				inc(r);
				queue[r] := mY[y];
			end;
	until f > r;
end;

procedure enlarge();
var
	x, next: integer;
begin
	writeln('enlarge ', start, ' -> ', finish);
	repeat
		x := trace[finish];
		writeln('enl ', finish , ' -> ', x);
		next := mX[finish];
		mY[finish] := x;
		mX[x] := finish;
		finish := next;
	until finish = 0;
end;

procedure subXaddY;
var
	vX, vY: set of byte;
	x, y, minC: integer;
begin
	vX := [start];
	vY := [];
	for y := 1 to m do 
		if trace[y] <> 0 then
		begin
			writeln('inc ', y, ' ', trace[y]);
			include(vY, y);
			include(vX, mY[y]);
		end;
	for x in vX do write(x, ' '); writeln;
		
	//find delta
	minC := maxC;
	for x in vX do
		for y := 1 to m do
			if not (y in vY) and (getC(x, y) < minC) then
				minC := getC(x, y);
	for x in vX do fx[x] := fx[x] + minC;
	for y in vY do fy[y] := fy[y] - minC;
	writeln('minC ', minC);
end;

procedure solve;
var
	x: integer;
begin
	init;
	for x := 1 to n do
	begin	
		start := x;
		finish := 0;
		repeat
			findPath;
			writeln(start, ' -> ', finish);
			if finish = 0 then subXaddY;
		until finish <> 0;
		enlarge;
	end;
end;
	
procedure print;
var
	x: integer;
begin
	for x := 1 to n do 
		if (mX[x] <> 0) and (c[x, mX[x]] < maxC) then 
			writeln(x, ' ', mX[x]);
end;

begin
	enter;
	solve;
	print;
end.
