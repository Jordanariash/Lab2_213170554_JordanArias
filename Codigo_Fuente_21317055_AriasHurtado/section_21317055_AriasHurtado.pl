:-module(section_21317055_AriasHurtado,[section/5, isSection/1, isSections/1]).
:- use_module(station_21317055_AriasHurtado).


/*
 * -Predicados:
 *
 * section(Point1,Point2,Distance,Cost,Section)
 * isSection([Point1,Point2,Distance,Cost])
 * isSections(List)
 *
 * -Metas:
 *
 * Principales:
 * section
 *
 * Secundarias:
 * isSection, isSections
*/



%Predicados contructores


% Dominio: Point1 (station) X Point2 (station) X Distance
% (positive-number) X Xost (positive-number U {0}) X Section(Section)
%
% Descripcion: Constructor de una seccion, de 2 estaciones validas, con
% una distancia y costo asociado

section(Point1,Point2,Distance,Cost,Section):-
    isStation(Point1),
    isStation(Point2),
    number(Distance),
    Distance>0,
    number(Cost),
    Cost>0,
    Section=[Point1,Point2,Distance,Cost].





%Predicados Pertenencia

% Dominio: Point1 (station) X Point2 (station) X Distance
% (positive-number) X Xost (positive-number U {0})
%
% Descripcion: Verifica que la seccion contenga la estructura y
% elementos necesarios para que sea una seccion


isSection([Point1,Point2,Distance,Cost]):-
    section(Point1,Point2,Distance,Cost,_).




% Dominio: List
% Descripcion: Verifica que una Lista contenga unicamente secciones

isSections([]).
isSections([H|T]):-
    isSection(H),
    isSections(T).

