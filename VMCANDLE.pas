var
	left, right, mid, res, k: qword;
begin
	readln(k);
	left := 1;
	right := round(1e18+1);
	while left <= right do
	begin
		mid := (left + right) div 2;
		if mid - trunc(sqrt(mid)) >= k then
		begin
			res := mid;
			right := mid - 1;
		end else left := mid + 1;
	end;
	write(res);
end.
		
