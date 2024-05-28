:-use_module(station_21317055_AriasHurtado).
:-use_module(section_21317055_AriasHurtado).
:-use_module(line_21317055_AriasHurtado).
:-use_module(pcar_21317055_AriasHurtado).
:-use_module(train_21317055_AriasHurtado).
:-use_module(driver_21317055_AriasHurtado).
:-use_module(subway_21317055_AriasHurtado).

/*
 * -Predicados:
 *
 * station(IdStation,NameStation,Type,StopTime,Station)
 * section(Point1,Point2,Distance,Cost,Section)
 * line(IdLine,NameLine,RailType,Sections,Line)
 * lineAddSection(Line,Section,LineOut)
 * isLine(Line)
 * lineLength(Line,LenghtLine,DistanceLine,CostLine)
 * lineSectionLength(Line, Station1Name, Station2Name, Path, Distance,Cost)
 * pcar(Pcar)
 * train(IdTrain, Maker, RailType, Speed, Pcars, Train)
 * isTrain(Train)
 * trainAddCar(Train, Pcar, Position, TrainOut)
 * trainRemoveCar(Train, Position, Train)
 * trainCapacity(Train, Capacity)
 * driver(IdDriver, NameDriver, TrainMaker, Driver)
 * subway(IdSubway, NameSubway, Subway)
 * subwayAddTrain(SubwayIn, Trains, SubwayOut)
 * subwayAddLine(SubwayIn, Lines, SubwayOut)
 * subwayAddDriver(SubwayIn, Drivers, SubwayOut)
 *
 * -Metas:
 *
 * Principales:
 * station, section, line, lineAddSection, isLine, lineLength,
 * lineSectionLength, pcar, train, isTrain, trainAddCar,
 * trainRemoveCar, trainCapacity, driver, subway, subwayAddTrain,
 * subwayAddLine, subwayAddDriver
 *
 *
 *
 *
 *
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


% Dominio: IdPcar (int) X Capacity (positive integer) X Model (string) X
% TypeCar (pcarTyoe) X PCar(pcar)
%
% Descripcion: Constructor de un vagon con un id, capacidad, modelo
% y tipo de vagon

 pcar(IdPcar, Capacity, Model, TypePcar, Pcar):-
   integer(IdPcar),
   integer(Capacity),
   Capacity > 0,
   string(Model),
   pcarType(TypePcar),
   Pcar = [IdPcar, Capacity, Model, TypePcar].


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


%Dominio: IdSubway(int) X NameSubway(string) X Subway(subway)
%
%Descripcion: crea una estacion de metro vacia

subway(IdSubway, NameSubway, Subway):-
    integer(IdSubway),
    string(NameSubway),
    Subway = [IdSubway, NameSubway].












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


% Dominio: Train(train)
%
% Descripcion: verifica si el tren posee la estructura adecuada y cumple
% con empezar y terminar con vagones terminales

isTrain([IdTrain, Maker, RailType, Speed, Pcars]):-
    train(IdTrain, Maker, RailType, Speed, Pcars,_).








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



% Dominio: Train(train) X Capacity(Number)
%
% Descripcion: encapsula e inicializa al predicado auxiliar que calcula
% la capacidad del tren

trainCapacity( [_, _, _, _, Pcars], TrainCapacity):-
    auxTrainCapacity(Pcars,0, TrainCapacity).




