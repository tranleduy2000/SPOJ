const
	maxn = 200;
var
	c: array[1..maxn, 1..maxn] of integer;
	mX, mY, trace: array[1..maxn] of integer;
	n, mid, left, right: integer;
	
procedure enter;
var
	f: text;
	u, v: integer;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, n);
	for u := 1 to n do
		for v := 1 to n do
			read(f, c[u, v]);
	close(f);
end;

function findPath: integer;
var
	queue: array[1..maxn] of integer;
	f, r, u, v: longint;
begin
	fillchar(trace, sizeof(trace), 0);	
	f := 1; r := 0;
	for u := 1 to n do 
		if mX[u] = 0 then
		begin
			inc(r);
			queue[r] := u;
		end;

	while f <= r do
	begin
		u := queue[f]; inc(f);
		for v := 1 to n do
			if (trace[v] = 0) and (c[u, v] <= mid) then
			begin
				trace[v] := u;
				if mY[v] = 0 then exit(v);
				inc(r); queue[r] := mY[v];
			end
	end;
	exit(0);
end;

procedure enlarge(f: integer);
var
	u, next: integer;
begin
	repeat
		u := trace[f];
		next := mX[u];
		mY[f] := u;
		mX[u] := f;
		f := next;
	until f = 0;
end;

function hasPair: boolean;
var
	finish, i: integer;
begin
	fillchar(mx, sizeof(mx), 0);
	fillchar(my, sizeof(my), 0);
	repeat
		finish := findPath;
		if finish <> 0 then enlarge(finish);
	until finish = 0;
	for i := 1 to n do if mX[i] = 0 then exit(false);
	exit(true);
end;
procedure solve;
begin
	left := 0; right := maxint;
	while left < right do 
	begin
		mid := (left + right) div 2;
		if hasPair then right := mid
		else left := mid + 1;
	end;
	writeln(left);
end;

begin
	enter;
	solve;
end.
