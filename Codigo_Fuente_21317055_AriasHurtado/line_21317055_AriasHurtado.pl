:-module(line_21317055_AriasHurtado,[line/5, isLineStructure/1, lineLength/4, calcLenghtLine/2, auxCalcLenghtLine/3, calcDistanceLine/2, auxCalcDistanceLine/3,calcCostLine/2,auxCalcCostLine/3, lineSectionLength/6, getFirstStation/2, getLastStation/2, auxGetFirstStation/2, auxGetLastStation/2, compareStations/2,isCircular/1,isLinear/1,isValid/1,connected/1,auxConnected/1,findStart/3, lineAddSection/3, isLine/1, isLines/1, auxFindStart/3, findFinal/3, auxFindFinal/4, findPath/4]).

:-use_module(section_21317055_AriasHurtado).

/*
 * -Predicados:
 *
 * line(IdLine,NameLine,RailType,Sections,Line)
 * lineAddSection(Line,Section,LineOut)
 * isLine(Line)
 * isCircular(Line)
 * isLinear(Line)
 * isLinear(Line)
 * isValid(Line)
 * connected(Line)
 * auxConnected(List)
 * isLines(List)
 * isLineStructure(Line)
 * lineLength(Line,LenghtLine,DistanceLine,CostLine)
 * calcLenghtLine(Line, Lenght)
 * auxCalcLenghtLine(List, Contador, Resultado)
 * calcDistanceLine(Line,DistanceLine)
 * auxCalcDistanceLine(List, Acumulador, Resultado)
 * calcCostLine(Line,CostLine)
 * auxCalcCostLine( List, Acumulador, Resultado)
 * lineSectionLength(Line, Station1Name, Station2Name, Path, Distance,
 * Cost)
 * findStart(Line, Station1Name, NewSections)
 * auxFindStart(List, Station1Name, NewSections)
 * findFinal(List, Station2Name, Path)
 * auxFindFinal(List, Station2Name, Recorrido, Path)
 * findPath(Line, Station1Name, Station2Name, Path)
 * getFirstStation(line,Station)
 * auxGetFirstStation(line,Station)
 * getLastStation(line,Station)
 * auxGetLastStation(line,Station)
 * compareStations(Station1, Station2)
 *
 *
 * -Metas:
 *
 * Principales:
 * line, lineAddSection, isLine, lineLength, lineSectionLength
 *
 * Secundarias:
 * isCircular, isLinear, isLinear, isValid, connected,
 * auxConnected, isLines,isLineStructure, calcLenghtLine,
 * auxCalcLenghtLine, auxCalcDistanceLine, calcCostLine,
 * auxCalcCostLine, findStart, auxFindStart, findPath, getFirstStation,
 * auxGetFirstStation, getLastStation, auxGetLastStation, compareStations
 *
 *
 */



% Predicados Contructores

% Dominio: IdLine (int) X NameLine (string) X RailType (string) X
% sections (List section) X Line
%
% Descripcion: constructor de una linea, con un id, nombre, tipo de
% rieles, y lista de secciones que la compone

line(IdLine,NameLine,RailType,Sections,Line):-
    integer(IdLine),
    string(NameLine),
    string(RailType),
    isSections(Sections),
    Line = [IdLine,NameLine,RailType,Sections].











% Predicados Modificadores


% Dominio: Line (Line) X Section (Section) X LineOut (Line)
%
% Descripcion: Añade una seccion al final de una linea, si la linea no
% tiene ninguna seccion la añade, y si ya tiene, recursivamente guarda
% los elementos en H hasta llegar al caso borde de una linea vacia, y
% verifica que la linea es consistente luego de añadir a la seccion

lineAddSection([IdLine,NameLine,RailType,[]],Section,[IdLine,NameLine,RailType,[Section]]):-
    connected([IdLine,NameLine,RailType,[Section]]).
lineAddSection([IdLine,NameLine,RailType,[H|T]], Section, [IdLine,NameLine,RailType,[H|TAux]]):-
    lineAddSection([IdLine,NameLine,RailType,T], Section, [IdLine,NameLine,RailType,TAux]).















% Predicados Pertenencia

% Dominio: Line (Line)
%
% Descripcion: verifica si la linea contiene lo necesario para ser
% valida, osea poseer la estructura de linea, estar completamente
% conectada, comenzar y terminar con estaciones de tipo terminal
% ("t"), y no repetirse el id de alguna estacion

isLine(Line):-
    isLineStructure(Line),
    connected(Line),
    isValid(Line).



% Dominio: Line (Line)
%
% Descripcion: verifica si una linea es circular, osea que la primera y
% ultima estacion de la linea son la misma

isCircular(Line):-
    getFirstStation(Line, FirstStation),
    getLastStation(Line, LastStation),
    compareStations(FirstStation, LastStation).


% Dominio: Line (Line)
%
% Descripcion: verifica si una linea es lineal, osea empieza y termina
% con estaciones terminales ("t")

isLinear(Line):-
    getFirstStation(Line, FirstStation),
    FirstStation = [_,_,"t",_],
    getLastStation(Line, LastStation),
    LastStation = [_,_,"t",_].


% Dominio: Line (Line)
%
% Descripcion: verifica si una linea es circular o lineal

isValid(Line):-
    isCircular(Line);
    isLinear(Line).


% Dominio: Line (Line)
%
% Descripcion: predicado que encapsula al predicado auxiliar para
% verificar coneccion en la linea

connected([_,_,_,Sections]):-
    auxConnected(Sections).


% Dominio: List (Sections)
%
% Descripcion: predicado auxiliar, con caso base de una lista de sin
% ninguna seccion, o una unica seccion, y si no cae en estos, verifica
% recursivamente que la linea esta conectada, osea la 2da estacion de la
% seccion actual, es la misma que la 1ra estacion de la siguiente
% seccion

auxConnected([]).
auxConnected([_]).
auxConnected([[_,St1|_],[St1,St2|_]|T]):-
    auxConnected([[_,St2|_]|T]).


% Dominio: List (Lines)
%
% Descripcion: verifica que una linea esta compuesta unicamente de
% lineas validas recursivamente

isLines([]).
isLines([H|T]):-
    isLine(H),
    isLines(T).

% Dominio: Line (Line)
%
% Descripcion: verifica que la linea tenga la estructura de linea, osea
% un id, nombre, tipo de riel, y lista de secciones

isLineStructure([IdLine,NameLine,RailType,Sections]):-
    line(IdLine,NameLine,RailType,Sections,_).













% Otros Predicados

% Dominio: Line (line) X Length (int) X Distance (Number) X Dost
% (Number)
%
% Descripcion: Permite determinar el largo total de una
% linea (cantidad de estaciones), la distancia y su costo.

lineLength(Line,LenghtLine,DistanceLine,CostLine):-
    calcLenghtLine(Line,LenghtLine),
    calcDistanceLine(Line,DistanceLine),
    calcCostLine(Line,CostLine).



% Dominio: Line (line) X  LenghtLine(int)
%
% Descripcion: Predicado auxiliar que da el caso base de una linea
% sin secciones, osea 0 estaciones, ademas encapsula e inicializa el
% predicado para calcular la cantidad total de estaciones de la linea

calcLenghtLine([_,_,_,[]], 0).
calcLenghtLine([_,_,_,Sections], Resultado):-
    auxCalcLenghtLine(Sections, 1, Resultado).

% Dominio: List(sections) X  Contador(int) X Resultado(int)
%
% Descripcion: Predicado auxiliar que da el caso base de una linea
% sin estaciones, y calcula la cantidad total de estaciones de la linea
% recursivamente

auxCalcLenghtLine([], Contador, Contador).
auxCalcLenghtLine([_|T],Contador, Resultado):-
    AuxContador is Contador + 1,
    auxCalcLenghtLine(T,AuxContador, Resultado).



% Dominio: Line(line) X  DistanceLine(int)
%
% Descripcion: Predicado auxiliar que encapsula e inicializa el
% predicado para calcular la distancia total de la linea

calcDistanceLine([_,_,_,Sections],DistanceLine):-
    auxCalcDistanceLine(Sections, 0, DistanceLine).


% Dominio: List(sections) X  Acumulador(int) X Resultado(int)
%
% Descripcion: Predicado auxiliar que da el caso base de una linea
% sin secciones, para calcular la distancia total de la linea
% recursivamente

auxCalcDistanceLine([], Acumulador, Acumulador).
auxCalcDistanceLine([[_,_,Distance,_]|T],Acumulador, Resultado) :-
    AuxAcumulador is Acumulador+Distance,
    auxCalcDistanceLine(T, AuxAcumulador, Resultado).




% Dominio: Line(line) X  CostLine(int)
%
% Descripcion: Predicado auxiliar que encapsula e inicializa el
% predicado para calcular el costo total de la linea

calcCostLine([_,_,_,Sections],CostLine):-
    auxCalcCostLine(Sections,0,CostLine).


% Dominio: List(sections) X  Acumulador(int) X Resultado(int)
%
% Descripcion: Predicado auxiliar que da el caso base de una linea
% sin secciones, para calcular la distancia total de la linea
% recursivamente

auxCalcCostLine([], Acumulador, Acumulador).
auxCalcCostLine([[_,_,_,Cost]| T], Acumulador, Resultado) :-
    AuxAcumulador is Acumulador+Cost,
    auxCalcCostLine(T, AuxAcumulador, Resultado).


% Dominio: Line(line) X Station1Name(String) X Station2Name(String)
% X Path(List Sections) X Distance(Number) X Cost(Number)
%
% Descripcion: Predicado que permite determinar el trayecto entre una
% estación de partida y una destino, la distancia de ese trayecto y el
% costo

lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost):-
    findPath(Line, Station1Name, Station2Name, Path),
    auxCalcDistanceLine(Path,0, Distance),
    auxCalcCostLine(Path, 0, Cost).


% Dominio: Line(line) X  Station1Name(String) X NewSections(sections)
%
% Descripcion: Predicado que encapsula la funcion auxiliar para
% encontrar la lista de secciones a partir del nombre de estacion
% ingresada

findStart([_,_,_,Sections], Station1Name, NewSections):-
    auxFindStart(Sections, Station1Name, NewSections).

% Dominio: List(sections) X Station1Name(String) X NewSections(sections)
%auxGetLastStation
% Descripcion: Predicado auxiliar que verifica si la primera estacion de
% la linea es la ingresada, si no recursivamente va recorriendo los
% tramos, hasta llegar al caso base

auxFindStart([[[IdStation,Station1Name|A]|B]|T], Station1Name, [[[IdStation,Station1Name|A]|B]|T]).
auxFindStart([_|T], Station1Name, NewSections):-
     auxFindStart(T, Station1Name, NewSections).


% Dominio: List(sections) X  Station2Name(String) X Path(sections)
%
% Descripcion: Predicado que encapsula la funcion auxiliar para
% encontrar la lista de secciones hasta el nombre de la
% estacion ingresada

findFinal(Sections, Station2Name, Path):-
    auxFindFinal(Sections, Station2Name,[],Path).


% Dominio: List(sections) X Station2Name(String) X NewSections(sections)
%
% Descripcion: Predicado auxiliar que verifica si la segunda estacion
% del primer tramo es la la estacion ingresada, si no recursivamente va
% recorriendo los tramos, añadiendo las estaciones al recorrido, hasta
% llegar al caso base
auxFindFinal([[A,[IdStation,Station2Name|B]|C]|_], Station2Name, Recorrido, Path):-
    append(Recorrido, [[A,[IdStation,Station2Name|B]|C]], Path).
auxFindFinal([H|T],Station2Name,Recorrido, Path):-
    append(Recorrido, [H], NewRecorrido),
    auxFindFinal(T,Station2Name,NewRecorrido, Path).



% Dominio: Line(line) X Station1Name(String) X Station2Name(String) X
% Path(sections)
%
% Descripcion: predicado que calcula el camino entre dos estaciones
% ingresadas, y si no lo encuentra, busca intercambiando de posicion las
% estaciones

findPath(Line, Station1Name, Station2Name, Path):-
    findStart(Line, Station1Name, Sections),
    findFinal(Sections, Station2Name, Path).
findPath(Line, Station2Name, Station1Name, Path):-
    findStart(Line, Station1Name, Sections),
    findFinal(Sections, Station2Name, Path).



% Dominio: Line(line) X FirstStation(Station)
%
% Descripcion: Predicado que encapsula al auxiliar que busca la primera
% estacion de la linea

getFirstStation([_,_,_,Sections], FirstStation):-
    auxGetFirstStation(Sections, FirstStation).


% Dominio: List(Sections) X FirstStation(Station)
%
% Descripcion: Predicado que busca la primera estacion de la linea

auxGetFirstStation([[FirstStation|_]|_], FirstStation).


% Dominio: Line(line) X LastStation(Station)
%
% Descripcion: Predicado que encapsula al auxiliar que busca la ultima
% estacion de la linea

getLastStation([_,_,_,Sections],LastStation):-
    auxGetLastStation(Sections, LastStation).


% Dominio: Line(line) X LastStation(Station)
%
% Descripcion: Predicado que verifica si es la ultima seccion de la
% linea, caso contrario, busca recursivamente
auxGetLastStation([[_,LastStation|_]], LastStation).
auxGetLastStation([_|T], LastStation):-
    auxGetLastStation(T,LastStation).



% Dominio: Station1(station) X Station2(station)
%
% Descripcion: funcion que compara si 2 estaciones son la misma
compareStations([Id1|_],[Id1|_]).
