%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_concat(L1, L2, L3): Determine if L3 is the concatination of L1 and L3.
%
% my_concat(l1, l2, X) where l1 and l2 are given and your program should output the solution for X.
% my_concat(l1, l2, l3) where l1, l2 and l3 are given and your program should output true or false.
%
% Examples: my_concat([1, 2, 3], [4], [1, 2, 3, 4]) is true
%			my_concat([1, [2, 3]], [4], [1, 2, 3, 4]) is false.
%			my_concat([1, [2, 3]], [4], [1, [2, 3], 4]) is true.
%
% Reference: https://www.youtube.com/watch?v=syGMNm25mfY
%			 Concepts of Programming Languages, Page 734
%
% How does this function work?
% Ex 1. my_concat([a,b], [c,d], X)
%	  	([a,b], [c,d], [a,X])
%	  	([a], [c,d], [b,X])
%	  	([], [c,d], [c,d])
% 	  	We now know X is [c,d]... coming out of recursion
%	  	([a], [b,c], [b,c,d])
%	  	([a,b], [b,c], [a,b,c,d])

% Ex 2. my_concat([a,b], [c,d], [a,b,c,e])
%	  	([a,b], [c,d], [b,c,e])
%	  	([a], [c,d], [c,e])
%	  	([], [c,d], [c,e]) -> false
%
my_concat([], List, List).								% Base case; only one list, so no concatination needed					
my_concat([Head|List1], List2, [Head|List3]) :-			% Main case; 		
	my_concat(List1, List2, List3).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% element_at(X, N, L): Determine if element X is the Nth item in list L.
%
% element_at(a, N, l) where a and l are given and your program should output the solution for N.
% element_at(X, n, l) where n and l are given and your program should output the solution for X.
% element_at(a, n, l) where a, n and l are given and your program should output true or false.
%
% Examples: element_at(2, 1, [2, 3, 4]) is true.
%           element_at(2, 1, [3, 2, 4]) is false.
%           element_at(2, 1, [[2], 3, 4]) is false.
%           element_at(5, 2, [3, 2, 4]) is false.
%
% You may assume N ≥ 1 and List non-empty.
%
element_at(X, 1, [X|_]).
element_at(X, N, [_|Tail]) :-
	element_at(X, NewN, Tail),
	N is NewN+1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_reverse(L1, L2): L2 is the reverse of L1.
%
% Examples: my_reverse([1,2,3], [3,2,1]) is true.
% 			my_reverse([1,2,3], [2,1,3]) is false.
% 			my_reverse([1,[2,3],4,[5]], [[5],4,[2,3],1]) is true.
% 			my_reverse([1,[2,3],4,[5]], [[5],4,[3,2],1]) is false.
% 			my_reverse([], []) is true.
%
% my_reverse(l, L) where l is given and your program should output the solution for L.
% my_reverse(L, l) where l is given and your program should output the solution for L.
% my_reverse(l1, l2) where l1 and l2 are given and your program should output true or false.
%
% Reference: Concepts of Programming Languages, Page 736
%
my_reverse([],[]).								% Base case; lists are empty so nothing to reverse.
my_reverse([Head | List1], List2) :-			% Main case; Remove head, concatinate it at the end of the running reverse list. Continue recursing with the tail until finished.
	my_reverse(List1, Reverse),					% Find reverse of the tail.
	my_concat(Reverse, [Head], List2).			% Add head to end of Reverse list using my_concat.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_flatten(L1, L2): Given a list L1, its flattened version is L2
%
% Examples: my_flatten([1, 2, 3], [1, 2, 3]) is true.
% 		    my_flatten([1, [2, 3]], [1, 2, 3]) is true.
% 		    my_flatten([1, [2], [3, 4]], [1, 2, 3, 4]) is true.
% 		    my_flatten([1, [2, 3, [4, 5], 6]], [1, 2, 3, 4, 5, 6]) is true.
% 
% my_flatten(l, X) where l is given and your program should output the solution for X.
% my_flatten(l1, l2) where l1 and l2 are given and your program should output true or false.
%
my_flatten([],[]).								% Base case; lists are empty so nothing to flatten, return true
my_flatten(X, [X]) :-							% Base case 2; input is not a list so nothing more to flatten (from recursion), return true.
	not(is_list(X)).
my_flatten([Head | List1], List2) :-			% Main case; Continually pop the head of the list, and flatten both head and tail. Eventually, the heads of the head and tail wont have any lists anymore.
	my_flatten(Head, FlatHead),					% Flatten Head
	my_flatten(List1, FlatTail),				% Flatten Tail
	my_concat(FlatHead, FlatTail, List2).		% Create List-String with flattened head and tail to print with my_concat					


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compress(L1, L2): Given a list L1,L2 is its compressed version by eliminating the duplicates.
%
% Examples: compress([1, 2, 3], [1, 2, 3]) is true.
% 			compress([1, 2, 2], [1, 2]) is true.
%			compress([1, 2, [2]], [1, 2]) is false.
%			compress([1, 2, [3, 4], [5], [5], [3]], [1, 2, [3, 4], [5], [3]]) is true.
%
% compress(l, X) where l is given and your program should output the solution for X.
% compress(l1, l2) where l1 and l2 are given and your program should output true or false.
%
compress([],[]).								% Base case; lists are empty, nothing to compress
compress([Head|List1], List2) :-				% Main case; Head of the current list is a duplicate (with the tail of that same list), recurse with tail
	member(Head, List1),						% Head is already a member. Discard it.
	compress(List1, List2).						% Compress Tail.
compress([Head|List1], [Head|List2]) :-			% If we get here, we are not a head is not a member of the current list
	compress(List1, List2).						% Prepend Head to List2, since it wasn't a member before. Compress Tail of List1