:-module(subway_21317055_AriasHurtado, [subway/3, isTrains/1, subwayAddTrain/3, isLines/1, subwayAddLine/3, isDrivers/1, subwayAddDriver/3,subwayToString/2]).
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


subwayToString([], _).
subwayToString([H|T], SubwayStr):-
    writeln(H),
    subwayToString(T,SubwayStr).


/*
station( 1, "USACH", "c", 30, ST1),
station( 2, "Estación Central", "c", 45, ST2),
station( 3, "ULA", "r", 45, ST3),
station( 4, "San Pablo", "t", 40, ST4).
station( 5, "Los Dominicos", "t", 60, ST5).

section(ST1, ST2, 2, 50, S0),
section( ST2, ST3, 2.5, 55, S1),

line( 0, "Línea 0", "UIC 60 ASCE", [S0,S1], L0),

pcar( 0, 90, "NS-74", ct, PC0),
pcar( 1, 100, "NS-74", tr, PC1),
pcar( 2, 150, "NS-74", tr, PC2),
pcar( 3, 90, "NS-74", ct, PC3),

pcar( 0, 90, "NS-74", "ct", PC0),
pcar( 1, 100, "NS-74", "tr", PC1),
pcar( 2, 150, "NS-74", "tr", PC2),
pcar( 3, 90, "NS-74", "ct", PC3),

train( 1, "CAF", "UIC 60 ASCE", 70, [PC1, PC0, PC3, PC2], T1),

driver( 0, "name0", "CAF", D0).



subway( 0, "Metro Santiago", S0),

subwayAddTrain( Sw0, [T1], Sw1),

subwayAddLine( Sw1, [L0], Sw2),

subwayAddDriver( Sw2, [D0], Sw3),

*/
