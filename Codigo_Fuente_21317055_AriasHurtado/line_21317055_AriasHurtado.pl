:-module(line_21317055_AriasHurtado,[stationType/1, station/5, isStation/1, section/5, isSection/1, isSections/1, line/5, isLineStructure/1, lineLength/4, calcLenghtLine/2, auxCalcLenghtLine/3, calcDistanceLine/2, auxCalcDistanceLine/3,calcCostLine/2,auxCalcCostLine/3, getFirstStation/2, getLastStation/2, auxGetFirstStation/2, auxGetLastStation/2, compare/2,isCircular/1,isLinear/1,isValid/1]).



stationType(Type):-
    member(Type, ["r", "m", "c", "t"]).

station(IdStation,NameStation,Type,StopTime,Station):-
    integer(IdStation),
    string(NameStation),
    stationType(Type),
    integer(StopTime),
    StopTime>0,
    Station=[IdStation,NameStation,Type,StopTime].

isStation([IdStation, NameStation,Type, StopTime]):-
    station(IdStation,NameStation,Type,StopTime,_).







section(Point1,Point2,Distance,Cost,Section):-
    isStation(Point1),
    isStation(Point2),
    number(Distance),
    Distance>0,
    number(Cost),
    Cost>0,
    Section=[Point1,Point2,Distance,Cost].


isSection([Point1,Point2,Distance,Cost]):-
    section(Point1,Point2,Distance,Cost,_).



isSections([]).
isSections([H|T]):-
    isSection(H),
    isSections(T).







line(IdLine,NameLine,RailType,Sections,Line):-
    integer(IdLine),
    string(NameLine),
    string(RailType),
    isSections(Sections),
    Line = [IdLine,NameLine,RailType,Sections].

isLineStructure([IdLine,NameLine,RailType,Sections]):-
    line(IdLine,NameLine,RailType,Sections,_).




lineLength(Line,LenghtLine,DistanceLine,CostLine):-
    calcLenghtLine(Line,LenghtLine),
    calcDistanceLine(Line,DistanceLine),
    calcCostLine(Line,CostLine).



%caso base, la linea esta vacia
calcLenghtLine([_,_,_,[]], 0).
%si no, contiene como minimo una unica estacion
calcLenghtLine([_,_,_,Sections], Resultado):-
    auxCalcLenghtLine(Sections, 1, Resultado).
auxCalcLenghtLine([], Contador, Contador).
auxCalcLenghtLine([_|T],Contador, Resultado):-
    AuxContador is Contador + 1,
    auxCalcLenghtLine(T,AuxContador, Resultado).




auxCalcDistanceLine([], Acumulador, Acumulador).
auxCalcDistanceLine([[_,_,Distance,_]|T],Acumulador, Resultado) :-
    AuxAcumulador is Acumulador+Distance,
    auxCalcDistanceLine(T, AuxAcumulador, Resultado).
calcDistanceLine([_,_,_,Sections],DistanceLine):-
    auxCalcDistanceLine(Sections, 0, DistanceLine).





auxCalcCostLine([], Acumulador, Acumulador).
auxCalcCostLine([[_,_,_,Cost]| T], Acumulador, Resultado) :-
    AuxAcumulador is Acumulador+Cost,
    auxCalcCostLine(T, AuxAcumulador, Resultado).
calcCostLine([_,_,_,Sections],CostLine):-
    auxCalcCostLine(Sections,0,CostLine).




%necesito el get first station, y get last station

getFirstStation([_,_,_,Sections], FirstStation):-
    auxGetFirstStation(Sections, FirstStation).

auxGetFirstStation([[FirstStation|_]|_], FirstStation).




getLastStation([_,_,_,Sections],LastStation):-
    auxGetLastStation(Sections, LastStation),
    writeln(LastStation).




auxGetLastStation([[_,LastStation|_]], LastStation).


auxGetLastStation([_|T], LastStation):-
    auxGetLastStation(T,LastStation).




compare([ID1|_],[ID1|_]).


isCircular([_,_,_,Sections]):-
    getFirstStation(Sections, FirstStation),
    getLastStation(Sections, LastStation),
    compare(FirstStation, LastStation).



isLinear([_,_,_,Sections]):-
    getFirstStation(Sections, FirstStation),
    FirstStation = [_,_,"t",_],
    getLastStation(Sections, LastStation),
    LastStation = [_,_,"t",_].


isValid([_,_,_,Sections]):-
    isCircular(Sections);
    isLinear(Sections).



auxConnected([[_]|[]]).
auxConnected([[_,St1|_],[St1,St2|_]|T]):-
    auxConnected([[_,St2|_]|T]).

connected([_,_,_,Sections]):-
    isValid([_,_,_,Sections]),
    auxConnected(Sections).








/*

station( 4, "San Pablo", "t", 40, ST4),
station( 1, "USACH", "c", 30, ST1),
station( 2, "Estación Central", "c", 45, ST2),
station( 3, "ULA", "r", 45, ST3),
station( 5, "Los Dominicos", "t", 60, ST5),

section(ST4, ST1, 2,   50, S0),
section(ST1, ST2, 2.5, 55, S1),
section(ST2, ST3, 2,   50, S2),
section(ST3, ST5, 2.5, 55, S3),

line( 0, "Línea 0", "UIC 60 ASCE", [S0,S1,S2,S3], L0),

isLinear(L0).

station( 1, "USACH", "c", 30, ST1),
station( 2, "Estación Central", "c", 45, ST2),
station( 3, "ULA", "r", 45, ST3),
station( 4, "San Pablo", "t", 40, ST4),
station( 5, "Los Dominicos", "t", 60, ST5),

section(ST1, ST2, 2, 50, S0),
section(ST2, ST3, 2.5, 55, S1),


lineLength(L0,LenghtLine,DistanceLine,CostLine).
*/







/*
codigo q funciono en algun punto

conected([_,_,_,[]]).
conected([_,_,_,[[A,B,_,_]|T]]):-
    isStation(A),
    isStation(B),
    writeln(A),
    writeln(B),
      conected([_,_,_,T]).


*/
