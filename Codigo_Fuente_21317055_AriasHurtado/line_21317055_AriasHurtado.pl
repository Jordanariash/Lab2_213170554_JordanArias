:-module(line_21317055_AriasHurtado,[stationType/1, station/5, isStation/1, section/5, isSection/1, isSections/1, line/5, isLineStructure/1, lineLength/4, calcLenghtLine/2, auxCalcLenghtLine/3, calcDistanceLine/2, auxCalcDistanceLine/3,calcCostLine/2,auxCalcCostLine/3, validStart/1]).



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



validStart([_,_,_,[]]).
validStart([_,_,_,[[H|_]|_]]):-
    H = [_,_,"t",_].

conected([_,_,_,[]]).
conected([_,_,_,Sections]):-
    isSections(Sections).


/*
station( 1, "USACH", "c", 30, ST1),
station( 2, "Estaci�n Central", "c", 45, ST2),
station( 3, "ULA", "r", 45, ST3),
station( 4, "San Pablo", "t", 40, ST4),
station( 5, "Los Dominicos", "t", 60, ST5),
section(ST4, ST1, 2, 50, S0),
section( ST1, ST5, 2.5, 55, S1),
line( 0, "L�nea 0", "UIC 60 ASCE", [S0,S1], L0),
validStart(L0).


section(ST1, ST2, 2, 50, S0),
section( ST2, ST3, 2.5, 55, S1),


lineLength(L0,LenghtLine,DistanceLine,CostLine).
*/
