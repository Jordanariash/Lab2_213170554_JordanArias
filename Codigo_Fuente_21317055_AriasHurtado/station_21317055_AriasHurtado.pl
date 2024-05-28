:-module(station_21317055_AriasHurtado,[stationType/1, station/5, isStation/1]).



/*
 * -Predicados:
 *
 * stationType(Type)
 * station(IdStation,NameStation,Type,StopTime,Station)
 * isStation(List)
 *
 *
 * -Metas:
 *
 * Principales:
 * station
 *
 * Secundarias:
 * stationType, isStation
*/



% Predicados Constructores


% Dominio: IdStation (int) X NameStation (String) X type (stationType) X
% StopTime (positive integer) X Station(Station)
%
% Descripcion: Constructor de una estacion con un id, nombre, tipo y
% tiempo de parada

station(IdStation,NameStation,Type,StopTime,Station):-
    integer(IdStation),
    string(NameStation),
    stationType(Type),
    integer(StopTime),
    StopTime>0,
    Station=[IdStation,NameStation,Type,StopTime].



% Predicados Pertenencia

% Dominio: IdStation (int) X NameStation (String) X type (stationType) X
% StopTime (positive integer)
%
% Descripcion: Verifica que la estacion contenga la estructura y
% elementos necesarios para que sea una estacion

isStation([IdStation, NameStation,Type, StopTime]):-
    station(IdStation,NameStation,Type,StopTime,_).



% Otros Predicados

% Dominio: Type(String)
%
% Descripcion: Verifica que la estacion sea de recorrido, mantenimiento,
% combinacion o terminal

stationType(Type):-
    member(Type, ["r", "m", "c", "t"]).


