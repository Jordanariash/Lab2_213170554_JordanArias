:-module(train_21317055_AriasHurtado, [isPcars/1, validTrain/1, validTrainBody/2, train/6, trainAddCar/4, trainRemoveCar/3, isTrain/1]).
:- use_module(pcar_21317055_AriasHurtado, [isPcar/1]).


%verifica que SOLO reciba pcars
isPcars([]).
isPcars([H|T]):-
    isPcar(H),
    isPcars(T).

%un tren sin pcars es valido
validTrain([]).

%un tren de solo un pcar tipo tr es valido
validTrain([[_, _, _,"tr"]]).

%un tren que empieza y termina con 2 tr del mismo modelo es valido
validTrain([[_, _, Modelo,"tr"],[_, _, Modelo,"tr"]]).

% un tren que parte con pcar tr es valido, si el siguiente tiene el
% mismo modelo
validTrain([[_, _, Modelo,"tr"]|T]):-
    validTrainBody(Modelo, T).

validTrainBody(Modelo,[[_, _, Modelo,"tr"]]).
% revisar que el cuerpo del tren sea tipo ct, y mismo modelo que el
% anterior
validTrainBody(Modelo,[[_ ,_ , Modelo,"ct"]|T]):-
    validTrainBody(Modelo, T).



train(IdTrain, Maker, RailType, Speed, Pcars, Train):-
    integer(IdTrain),
    string(Maker),
    string(RailType),
    number(Speed),
    Speed > 0,
    isPcars(Pcars),
    validTrain(Pcars),
    Train = [IdTrain, Maker, RailType, Speed, Pcars].




trainAddCar([IdTrain, Maker, RailType, Speed,Pcars], Pcar, 0, [IdTrain, Maker, RailType, Speed,[Pcar|Pcars]]).
trainAddCar([IdTrain, Maker, RailType, Speed,[H|T]], Pcar, Position, [IdTrain, Maker, RailType, Speed,[H|TAux]]):-
    integer(Position),
    Position > 0,
    AuxPosition is Position - 1,
    trainAddCar([IdTrain, Maker, RailType, Speed,T], Pcar, AuxPosition, [IdTrain, Maker, RailType, Speed,TAux]).




trainRemoveCar([IdTrain, Maker, RailType, Speed,[_|T]], 0,[IdTrain, Maker, RailType, Speed,T]).
trainRemoveCar([IdTrain, Maker, RailType, Speed,[H|T]], Position, [IdTrain, Maker, RailType, Speed,[H|TAux]]):-
    integer(Position),
    Position>0,
    AuxPosition is Position - 1,
    trainRemoveCar([IdTrain, Maker, RailType, Speed,T], AuxPosition, [IdTrain, Maker, RailType, Speed,TAux]).



isTrain([IdTrain, Maker, RailType, Speed, Pcars]):-
    train(IdTrain, Maker, RailType, Speed, Pcars,_).



/*

pcar( 0, 90, "NS-74", "ct", PC0),
pcar( 1, 100, "NS-74", "tr", PC1),
pcar( 2, 150, "NS-74", "tr", PC2),
pcar( 3, 90, "NS-74", "ct", PC3),

train( 0, "CAF", "UIC 60 ASCE", 60, [ ], T0),
train( 1, "CAF", "UIC 60 ASCE", 70, [PC1, PC0, PC3, PC2], T1),

trainAddCar( T0, PC1, 0, T2).
trainAddCar( T2, PC0, 1, T3).
trainAddCar( T3, PC2, 2, T4).
trainAddCar( T4, PC3, 2, T5).

pcar( 4, 100, "AS-2014", "ct", PC4),
pcar( 5, 100, "AS-2014", "ct", PC5),
pcar( 6, 100, "AS-2016", "ct", PC6),

*/
