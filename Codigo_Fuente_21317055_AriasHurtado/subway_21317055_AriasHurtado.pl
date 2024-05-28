:-module(subway_21317055_AriasHurtado, [subway/3, subwayAddTrain/3, subwayAddLine/3, subwayAddDriver/3]).
:-use_module(train_21317055_AriasHurtado).
:-use_module(line_21317055_AriasHurtado).
:-use_module(driver_21317055_AriasHurtado).



/*
 * -Predicados:
 * subway(IdSubway, NameSubway, Subway)
 * subwayAddTrain(SubwayIn, Trains, SubwayOut)
 * subwayAddLine(SubwayIn, Lines, SubwayOut)
 * subwayAddDriver(SubwayIn, Drivers, SubwayOut)
 *
 * -Metas:
 *
 * Principales:
 * subway, subwayAddTrain, subwayAddLine, subwayAddDriver

 *
 * Secundarias:
 *
*/


% Predicados contructores

%Dominio: IdSubway(int) X NameSubway(string) X Subway(subway)
%
%Descripcion: crea una estacion de metro vacia

subway(IdSubway, NameSubway, Subway):-
    integer(IdSubway),
    string(NameSubway),
    Subway = [IdSubway, NameSubway].

% Predicados Modificadores


%Dominio: SubwayIn(subway) X List (trains) X SubwayOut(subway)
%
%Descripcion: Añade una lista de trenes a un subway

subwayAddTrain(SubwayIn, Trains, SubwayOut):-
    isTrains(Trains),
    append(SubwayIn,[Trains],SubwayOut).



%Dominio: SubwayIn(subway) X List (Lines) X SubwayOut(subway)
%
%Descripcion: Añade una lista de lineas a un subway

subwayAddLine(SubwayIn, Lines, SubwayOut):-
    isLines(Lines),
    append(SubwayIn, [Lines], SubwayOut).


%Dominio: SubwayIn(subway) X List(drivers) X SubwayOut(subway)
%
%Descripcion: Añade una lista de conductores a un subway
subwayAddDriver(SubwayIn, Drivers, SubwayOut):-
    isDrivers(Drivers),
    append(SubwayIn, [Drivers], SubwayOut).
