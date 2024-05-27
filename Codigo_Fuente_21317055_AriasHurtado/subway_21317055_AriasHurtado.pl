:-module(subway_21317055_AriasHurtado, [subway/3, subwayAddTrain/3, subwayAddLine/3, subwayAddDriver/3,subwayToString/2]).
:-use_module(train_21317055_AriasHurtado).
:-use_module(line_21317055_AriasHurtado).
:-use_module(driver_21317055_AriasHurtado).


subway(IdSubway, NameSubway, Subway):-
    integer(IdSubway),
    string(NameSubway),
    Subway = [IdSubway, NameSubway].




subwayAddTrain(SubwayIn, Trains, SubwayOut):-
    isTrains(Trains),
    append(SubwayIn,[Trains],SubwayOut),
    writeln("llega aqui").




subwayAddLine(SubwayIn, Lines, SubwayOut):-
    %isLines(Lines),
    append(SubwayIn, [Lines], SubwayOut),
    writeln("llega aqui").


subwayAddDriver(SubwayIn, Drivers, SubwayOut):-
    isDrivers(Drivers),
    append(SubwayIn, [Drivers], SubwayOut).


subwayToString([], _).
subwayToString([H|T], SubwayStr):-
    writeln(H),
    subwayToString(T,SubwayStr).


