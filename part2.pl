%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define a predicate queens(N, Q)where N is the number of rows and columns of the chessboard, 
% and Q is a list N numbers such that the ith number represents the position of the queen in column i.
%
% queens(n, X) where n is given and your program should output the solutions for X.
% queens(n, l) where n and l are given and your program should output true or false.
%
% Reference: https://www.youtube.com/watch?v=Ph95IHmRp5M&t=237s
%			 https://www.youtube.com/watch?v=l_tbL9RjFdo
%
queens(N, Queens) :-							% Main function
	length(Queens, N),							% Fill Queens with N number of items, since our resulting list will be N long.
	put_queen(Queens, N).						% Find a place to put the queen in the column
		
put_queen([],_).								% Base case; no Queens remaning to place. All Done.
put_queen([Queen1|Queens],N) :-					% Main case; find a space to put the current queen that does conflict with previous columns
	put_queen(Queens, N), 						% Recursively find place for Tail's Head
	between(1, N, Queen1),						% Choose a space between 1 and N to but the current Queen (that hasn't already been taken)
	queen_ok(Queen1,Queens, 1).					% Check that the space does not have any conflicting queens in rows or diagonals

queen_ok(_,[],_).								% Base case; No more queens to check conflictions with
queen_ok(Queen1,[Queen2|Queens], DiagDist) :-	% Main case; Queen to be checked, Queens list to check against, Diagonal distance to not conflict diagonally. 
	Queen1 =\= Queen2, 							% If Queen 1 and Queen2 have same numerical value, they are in the same row. This is not allowed.
	Queen2 =\= Queen1 + DiagDist,				% Check for positive diagonal conflicts. 
	Queen2 =\= Queen1 - DiagDist,				% Check for negative diagonal conflicts.
	NewDiagDist = DiagDist + 1,					% We added a queen, so the possible diagonal conflict-distance will increase.
	queen_ok(Queen1,Queens,NewDiagDist).		% Check the remaining Queens in Queens list (remove head since we just checked that one)