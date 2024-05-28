:-module(train_21317055_AriasHurtado, [validTrain/1, validTrainBody/2, train/6, trainAddCar/4, trainRemoveCar/3, isTrain/1, trainCapacity/2, auxTrainCapacity/3,isTrains/1]).
:- use_module(pcar_21317055_AriasHurtado).


/*
 * -Predicados:
 * train(IdTrain, Maker, RailType, Speed, Pcars, Train)
 * isTrain(Train)
 * isTrains(List)
 * trainAddCar(Train, Pcar, Position, TrainOut)
 * trainRemoveCar(Train, Position, Train)
 * validTrain(List)
 * validTrainBody(Modelo,List)
 * trainCapacity(Train, Capacity)
 * auxTrainCapacity(List, Acumulador ,TrainCapacity)
 *
 * -Metas:
 *
 * Principales:
 * train, isTrain, trainAddCar, trainRemoveCar, trainCapacity
 *
 *
 * Secundarias:
 * isTrains, validTrain, validTrainBody, auxTrainCapacity
 *
*/

% Predicados contructores


% Dominio: IdTrain(int) X Maker(string) X RailType(string) X Speed
% (positive number) X Pcars (PCars) X Train(Train)
%
% Descripcion: Permite crear un tren, con un id, su manufactoradora, el
% tipo de riel, velocidad, la lista de vagones, la cual debe comenzar y
% terminar con vagones del tipo terminal

train(IdTrain, Maker, RailType, Speed, Pcars, Train):-
    integer(IdTrain),
    string(Maker),
    string(RailType),
    number(Speed),
    Speed > 0,
    isPcars(Pcars),
    validTrain(Pcars),
    Train = [IdTrain, Maker, RailType, Speed, Pcars].



% Predicados Pertenencia


% Dominio: Train(train)
%
% Descripcion: verifica si el tren posee la estructura adecuada y cumple
% con empezar y terminar con vagones terminales

isTrain([IdTrain, Maker, RailType, Speed, Pcars]):-
    train(IdTrain, Maker, RailType, Speed, Pcars,_).


% Dominio: List(Trains)
%
% Descripcion: verifica si una lista contiene unicamente trenes validos

isTrains([]).
isTrains([H|T]):-
    isTrain(H),
    isTrains(T).



% Predicados Modificadores


% Dominio: Train(train) X Pcar(pcar) X Position (positive-integer U
% {0}) X TrainOut(train)
%
% Descripcion: añade el tren en base a una posicion indicada, usando
% como caso base, la posicion 0, para añadir el vagon al inicio del
% tren recursivamente


trainAddCar([IdTrain, Maker, RailType, Speed,Pcars], Pcar, 0, [IdTrain, Maker, RailType, Speed,[Pcar|Pcars]]).
trainAddCar([IdTrain, Maker, RailType, Speed,[H|T]], Pcar, Position, [IdTrain, Maker, RailType, Speed,[H|TAux]]):-
    integer(Position),
    Position > 0,
    AuxPosition is Position - 1,
    trainAddCar([IdTrain, Maker, RailType, Speed,T], Pcar, AuxPosition, [IdTrain, Maker, RailType, Speed,TAux]).



% Dominio: Train (train) X Position (positive-integer U {0}) X Train
%
% Descripcion: Permite eliminar un vagon de un tren indicando su
% posicion dentro del mismo

trainRemoveCar([IdTrain, Maker, RailType, Speed,[_|T]], 0,[IdTrain, Maker, RailType, Speed,T]).
trainRemoveCar([IdTrain, Maker, RailType, Speed,[H|T]], Position, [IdTrain, Maker, RailType, Speed,[H|TAux]]):-
    integer(Position),
    Position>0,
    AuxPosition is Position - 1,
    trainRemoveCar([IdTrain, Maker, RailType, Speed,T], AuxPosition, [IdTrain, Maker, RailType, Speed,TAux]).



% Otros Predicados


% Dominio: Train(train)
%
% Descripcion: predicado que verifica si un tren posee la estructura
% valida de comenzar y terminar con vagones de terminal del mismo
% modelo, ademas de verificar si los vagones intermedios son validos

validTrain([]).
validTrain([[_, _, _,"tr"]]).
validTrain([[_, _, Modelo,"tr"],[_, _, Modelo,"tr"]]).
validTrain([[_, _, Modelo,"tr"]|T]):-
    validTrainBody(Modelo, T).

% Dominio: Modulo(String) X List(pcars)
%
% Descripcion: verifica recursivamente que todos los vagones del tren
% sean del tipo central, ademas del mismo modelo entre si y los
% terminales

validTrainBody(Modelo,[[_, _, Modelo,"tr"]]).
validTrainBody(Modelo,[[_ ,_ , Modelo,"ct"]|T]):-
    validTrainBody(Modelo, T).

% Dominio: Train(train) X Capacity(Number)
%
% Descripcion: encapsula e inicializa al predicado auxiliar que calcula
% la capacidad del tren

trainCapacity( [_, _, _, _, Pcars], TrainCapacity):-
    auxTrainCapacity(Pcars,0, TrainCapacity).

% Dominio: List(pcars) X Acumulador(int) X TrainCapacity(int)
%
% Descripcion: calcula la capacidad maxima de pasajeros del tren de
% manera recursiva

auxTrainCapacity([], Acumulador, Acumulador).
auxTrainCapacity([[_, Capacity, _, _]|T], Acumulador, TrainCapacity):-
    AuxAcumulador is Acumulador + Capacity,
    auxTrainCapacity(T, AuxAcumulador, TrainCapacity).








