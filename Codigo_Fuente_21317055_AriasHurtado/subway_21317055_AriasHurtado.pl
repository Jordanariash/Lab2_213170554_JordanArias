:-module(subway_21317055_AriasHurtado, [subway/3, isTrains/1, subwayAddTrain/3, isLines/1, subwayAddLine/3, isDrivers/1, subwayAddDriver/3]).
:-use_module(train_21317055_AriasHurtado,[ isTrain/1, train/6]).
:-use_module(line_21317055_AriasHurtado,[line/5, isLine/1]).
:-use_module(driver_21317055_AriasHurtado,[driver/4, isDriver/1]).


subway(IdSubway, NameSubway, Subway):-
    integer(IdSubway),
    string(NameSubway),
    Subway = [IdSubway, NameSubway].


isTrains([]).
isTrains([H|T]):-
    isTrain(H),
    isTrains(T).


subwayAddTrain(SubwayIn, Trains, SubwayOut):-
    isTrains(Trains),
    SubwayOut = [SubwayIn, Trains].

isLines([]).
isLines([H|T]):-
    isLine(H),
    isLines(T).


subwayAddLine(SubwayIn, Lines, SubwayOut):-
    isLines(Lines),
    SubwayOut = [SubwayIn, Lines].

isDrivers([]).
isDrivers([H|T]):-
    isDriver(H),
    isDrivers(T).


subwayAddDriver(SubwayIn, Drivers, SubwayOut):-
    isDrivers(Drivers),
    SubwayOut = [SubwayIn, Drivers].



/*
subway( 0, "Metro Santiago", S0),

subwayAddTrain( Sw0, [T1], Sw1),
subwayAddTrain( Sw1, [T2, T3, T4], Sw2).

subwayAddLine( Sw5, [L5], Sw6).
subwayAddLine( Sw6, [L6, L7], Sw7).

subwayAddDriver( Sw7, [D0], Sw8).
subwayAddDriver( Sw8, [D1, D2, D3], Sw9).

*/
