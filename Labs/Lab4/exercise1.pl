% --------
% book( Title, Authors, Publisher, Year, CallNumber )
% --------
book(
  'The craft of Prolog',
  'R. A. O''Keefe',
  'MIT Press',
  1990,
  'QA 76.73 .P76 O38 1990'
).
book(
  'Programming in Prolog',
  'W. F. Clocksin, C. S. Mellish',
  'Springer',
  2003,
  'QA 76.73 .P76 C57 2003'
).
book(
  'Prolog for programmers',
  'F. Kluzniak, S. Szpakowicz',
  'Academic Press',
  1985,
  'QA 76.73 .P76 K58 1985'
).
book(
  'Prolog programming for artificial intelligence',
  'I. Bratko',
  'Addison-Wesley',
  2001,
  'Q 336 .B74 2001'
).
book(
  'To Kill a Mockingbird',
  'H. Lee',
  'J. B. Lippincott & Co.',
  1960,
  'Q 336 .B74 2005'
).
book(
  'Art of War',
  'S. Tzu',
  'Springer',
  500,
  'Q 336 .B74 0918'
).
book(
  'Tester Book',
  'I. Bratko',
  'Springer',
  2021,
  'Q 336 .B74 8901'
).

% --------
% reader( CardNumber, Name )
% --------

reader( 1234567, 'James Brown' ).
reader( 2345678, 'Jacques Brun' ).
reader( 3456789, 'Giacomo Bruno' ).

% --------
% checkedOut( CardNumber, CallNumber )
% --------

checkedOut( 1234567, 'QA 76.73 .P76 C57 2003' ).
checkedOut( 3456789, 'Q 336 .B74 2001' ).
checkedOut( 1234567, 'Q 336 .B74 2005' ).
checkedOut( 1234567, 'Q 336 .B74 0918' ).
checkedOut( 1234567, 'Q 336 .B74 8901' ).

% Find books published by Springer
publishedBySpringer(Book) :- book(Book, _, Publisher, _, _), Publisher = 'Springer'.

% Find books published after 1990
publishedAfter1990(Book) :- book(Book, _, _, Date, _), Date > 1990.

% Find all books checked out by James Brown
checkedOutByJames(Book) :- checkedOut(CardNum, CallNum), book(Book,_,_,_,CallNum),reader(CardNum, Name), Name = 'James Brown'.