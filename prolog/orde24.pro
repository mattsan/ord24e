% $ gprolog --consult-file orde24.pro --query-goal "main"

seq(_, Value, 0, Result) :-
  reverse(Value, Result),
  !.
seq(Base, Init, Count, Result) :-
  Count > 0,
  inc(Init, Base, Next),
  Count1 is Count - 1,
  seq(Base, Next, Count1, Result).

inc(nil, _, nil) :- !.
inc([1], 2, nil) :- !.
inc([N], Base, [2,1]) :-
  N + 1 =:= Base,
  !.
inc([Base1|DS], Base, nil) :-
  Base1 is Base - 1,
  inc(DS, Base1, nil);
  inc(DS, Base1, [Base|_]),
  !.
inc([Base1|DS], Base, [V1, V|VS]) :-
  Base1 is Base - 1,
  inc(DS, Base1, [V|VS]),
  V1 is V + 1,
  !.
inc([D|DS], _, [D1|DS]) :-
  D1 is D + 1.

num_char(Num, Char) :- Num < 10, Char is Num + 0'0, !.
num_char(Num, Char) :- Char is Num + 0'a - 10.

solve(Input, Result) :-
  append(B_, [0',|C_], Input),
  number_codes(Base, B_),
  number_codes(Count, C_),
  seq(Base, [0], Count, Seq),
  findall(C, (member(N, Seq), num_char(N, C)), Result),
  !.
solve(_, "-").

judge(Input, Expected, Expected) :-
  format("~s passed~n", [Input]).
judge(Input, Expected, Actual) :-
  format("~s failed: expected: ~s, actual: ~s~n", [Input, Expected, Actual]).

test(Input, Expected) :-
  solve(Input, Actual),
  judge(Input, Expected, Actual),
  !.

main :-
  test("16,333", "38e"),
  test("2,100", "-"),
  test("2,1", "1"),
  test("2,2", "-"),
  test("11,8", "8"),
  test("14,9", "9"),
  test("11,12", "13"),
  test("7,16", "34"),
  test("20,16", "g"),
  test("2,17", "-"),
  test("8,26", "56"),
  test("16,51", "3c"),
  test("3,77", "-"),
  test("2,100", "-"),
  test("9,110", "1347"),
  test("22,127", "78"),
  test("24,142", "79"),
  test("30,158", "5s"),
  test("20,213", "139"),
  test("6,216", "-"),
  test("9,244", "235678"),
  test("13,253", "57c"),
  test("19,265", "19c"),
  test("24,314", "13k"),
  test("16,333", "38e"),
  test("32,353", "eo"),
  test("25,490", "1dg"),
  test("26,498", "1bd"),
  test("10,500", "2456789"),
  test("10,543", "-"),
  test("3,897", "-"),
  test("11,1000", "1345789a"),
  test("9,1307", "-"),
  test("9,1412", "-"),
  test("26,1678", "79e"),
  test("8,1942", "-"),
  test("12,1950", "234589ab"),
  test("2,2245", "-"),
  test("18,2670", "5ace"),
  test("5,3013", "-"),
  test("5,3048", "-"),
  test("14,3099", "157acd"),
  test("27,3440", "13hm"),
  test("13,3698", "235689ab"),
  test("36,5592", "dqs"),
  test("10,9505", "-"),
  test("27,9833", "49ej"),
  test("16,10000", "123467e"),
  test("24,14090", "14bfk"),
  test("29,15270", "5mnq"),
  test("17,20000", "23458cg"),
  test("36,20000", "37bc"),
  test("25,24346", "256bk"),
  test("21,27815", "146adi"),
  test("25,28030", "2aflm"),
  test("25,34448", "3cefi"),
  test("36,44811", "abpu"),
  halt.
