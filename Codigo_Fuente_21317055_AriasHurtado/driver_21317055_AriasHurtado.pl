:-module(driver_21317055_AriasHurtado,[driver/4, isDriver/1, isDrivers/1]).



driver(IdDriver, NameDriver, TrainMaker, Driver):-
    integer(IdDriver),
    string(NameDriver),
    string(TrainMaker),
    Driver = [IdDriver, NameDriver, TrainMaker].


isDriver([IdDriver, NameDriver, TrainMaker]):-
    driver(IdDriver, NameDriver, TrainMaker, _).


isDrivers([]).
isDrivers([H|T]):-
    isDriver(H),
    isDrivers(T).


/*

driver( 0, "name0", "CAF", D0).
driver( 1, "Oliver Atom", "ALSTOM", D1).

*/
