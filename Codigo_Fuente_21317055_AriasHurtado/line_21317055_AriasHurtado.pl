stationType(Type):-
    member(Type, ["r", "m", "c", "t"]).

station(IdStation,NameStation,Type,StopTime,Station):-
    integer(IdStation),
    string(NameStation),
    stationType(Type),
    integer(StopTime),
    StopTime>0,
    Station=[IdStation,NameStation,Type,StopTime].

isStation(Station):-
    station(IdStation,NameStation,Type,StopTime,_).

station( 1, "USACH", "c", 30, ST1).
station( 2, "Estación Central", "c", 45, ST2).
station( 3, "ULA", "r", 45, ST3).








section(Point1,Point2,Distance,Cost,Section):-
    isStation(Point1),
    isStation(Point2),
    number(Distance),
    Distance>0,
    number(Cost),
    Cost>0,
    Section=[Point1,Point2,Distance,Cost].


isSection(Section):-
    section(Point1,Point2,Distance,Cost,_).

section(ST1, ST2, 2, 50, S0).
section( ST1, ST2, 2.5, 55, S1).


isSections([]).
isSections([H|T]):-
    isSection(H),
    isSections(T).







line(IdLine,NameLine,RailType,Sections,Line):-
    integer(IdLine),
    string(NameLine),
    string(RailType),
    isSections(Sections),
    Line = [IdLine,NameLine,RailType,Sections,Line].

isLine(Line):-
    line(IdLine,NameLine,RailType,Sections,_).

line( 0, "Línea 0", "UIC 60 ASCE", [S1,S2,S3], L0).
