:-module(driver_21317055_AriasHurtado,[driver/4, isDriver/1, isDrivers/1]).

/*
 * -Predicados:
 *  driver(IdDriver, NameDriver, TrainMaker, Driver)
 *  isDriver(Driver)
 *  isDrivers(List)
 * -Metas:
 *
 * Principales:
 * driver
 *
 * Secundarias:
 * isDriver, isDrivers
 *
*/

% Predicados contructores


% Dominio: IdDriver(int) X NameDriver(string) X TrainMaker(string) X
% Driver(driver)
%
% Descripcion: Predicado que permite crear un conductor cuya
% habilitación de conducción depende del fabricante de tren

driver(IdDriver, NameDriver, TrainMaker, Driver):-
    integer(IdDriver),
    string(NameDriver),
    string(TrainMaker),
    Driver = [IdDriver, NameDriver, TrainMaker].



% Predicados Pertenencia

% Dominio: Driver(driver)
%
% Descripcion: verifica que un conductor tenga la estructura correcta

isDriver([IdDriver, NameDriver, TrainMaker]):-
    driver(IdDriver, NameDriver, TrainMaker, _).

% Dominio: List(drivers)
%
% Descripcion: verifica que una lista sea unicamente de conductores
% validos

isDrivers([]).
isDrivers([H|T]):-
    isDriver(H),
    isDrivers(T).
