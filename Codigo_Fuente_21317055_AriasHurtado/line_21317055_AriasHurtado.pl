:-module(line_21317055_AriasHurtado,[line/5, isLineStructure/1, lineLength/4, calcLenghtLine/2, auxCalcLenghtLine/3, calcDistanceLine/2, auxCalcDistanceLine/3,calcCostLine/2,auxCalcCostLine/3, getFirstStation/2, getLastStation/2, auxGetFirstStation/2, auxGetLastStation/2, compareStations/2,isCircular/1,isLinear/1,isValid/1,connected/1,auxConnected/1,findStart/3, lineAddSection/3, isLine/1, isLines/1]).

:-use_module(section_21317055_AriasHurtado).

/*
 * -Predicados:
 *
 * line(IdLine,NameLine,RailType,Sections,Line)
 * isLineStructure([IdLine,NameLine,RailType,Sections])
 * lineLength(Line,LenghtLine,DistanceLine,CostLine)
 * calcLenghtLine(Line, Resultado)
 * auxCalcLenghtLine(List, Contador, Resultado)
 * calcDistanceLine(Line,DistanceLine)
 * auxCalcDistanceLine(List,Acumulador, Resultado)
 * calcCostLine(Line,CostLine)
 * auxCalcCostLine(List, Acumulador, Resultado)
 * getFirstStation(Line, FirstStation)
 * auxGetFirstStation(List, FirstStation)
 * getLastStation(Line,LastStation)
 * auxGetLastStation(List, LastStation)
 * compareStations(Station1,Station2)
 * isCircular(Line)
 * isLinear(Line)
 * isValid(Line)
 * connected(Line)
 *
 * -Metas:
 *
 * Principales:
 * line,lineLength
 *
 * Secundarias:
 * isLineStructure, calcLenghtLine, auxCalcLenghtLine, calcDistanceLine,
 * auxCalcDistanceLine, calcCostLine, auxCalcCostLine, getFirstStation,
 * auxGetFirstStation,

 */





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






% line (line) X station1-name (String) X station2-name (String) X path
% (List Section) X distance (Number) X cost (Number)


lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost):-
    findPath(Line, Station1Name, Station2Name, Path),
    auxCalcDistanceLine(Path,0, Distance),
    auxCalcCostLine(Path, 0, Cost).



findStart([_,_,_,Sections], Station1Name, NewSections):-
    auxFindStart(Sections, Station1Name, NewSections).

%caso base, es la primera estacion de la primera seccion
auxFindStart([[[IdStation,Station1Name|A]|B]|T], Station1Name, [[[IdStation,Station1Name|A]|B]|T]):-
    writeln("entro a caso base").

%sino recursividad
auxFindStart([_|T], Station1Name, NewSections):-
     auxFindStart(T, Station1Name, NewSections).










%inicializar
findFinal(Sections, Station2Name, Path):-
    auxFindFinal(Sections, Station2Name,[],Path).

%caso base
auxFindFinal([[A,[IdStation,Station2Name|B]|C]|_], Station2Name, Recorrido, Path):-
    append(Recorrido, [[A,[IdStation,Station2Name|B]|C]], Path).


auxFindFinal([H|T],Station2Name,Recorrido, Path):-
    append(Recorrido, [H], NewRecorrido),
    auxFindFinal(T,Station2Name,NewRecorrido, Path).


findPath(Line, Station1Name, Station2Name, Path):-
    findStart(Line, Station1Name, Sections),
    findFinal(Sections, Station2Name, Path).

findPath(Line, Station2Name, Station1Name, Path):-
    findStart(Line, Station1Name, Sections),
    findFinal(Sections, Station2Name, Path).




getFirstStation([_,_,_,Sections], FirstStation):-
    auxGetFirstStation(Sections, FirstStation).

auxGetFirstStation([[FirstStation|_]|_], FirstStation).



getLastStation([_,_,_,Sections],LastStation):-
    auxGetLastStation(Sections, LastStation).

auxGetLastStation([[_,LastStation|_]], LastStation).

auxGetLastStation([_|T], LastStation):-
    auxGetLastStation(T,LastStation).




compareStations([Id1|_],[Id1|_]).


isCircular(Line):-
    getFirstStation(Line, FirstStation),
    getLastStation(Line, LastStation),
    compareStations(FirstStation, LastStation).



isLinear(Line):-
    getFirstStation(Line, FirstStation),
    FirstStation = [_,_,"t",_],
    getLastStation(Line, LastStation),
    LastStation = [_,_,"t",_].


isValid(Line):-
    isCircular(Line);
    isLinear(Line).



connected([_,_,_,Sections]):-
    auxConnected(Sections).

%sin ninguna seccion
auxConnected([]).
%con 1 seccion
auxConnected([_]).
%con mas de 2
auxConnected([[_,St1|_],[St1,St2|_]|T]):-
    auxConnected([[_,St2|_]|T]).




%caso base, linea vacia
lineAddSection([IdLine,NameLine,RailType,[]],Section,[IdLine,NameLine,RailType,[Section]]).


% si no, añadirla al final
lineAddSection([IdLine,NameLine,RailType,[H|T]], Section, [IdLine,NameLine,RailType,[H|TAux]]):-
    lineAddSection([IdLine,NameLine,RailType,T], Section, [IdLine,NameLine,RailType,TAux]).




isLine(Line):-
    isLineStructure(Line),
    connected(Line),
    isValid(Line).


isLines([]).
isLines([H|T]):-
    isLine(H),
    isLines(T).


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
lineSectionLength(L0, "USACH", "ULA" , Path, Distance, Cost).
*/
