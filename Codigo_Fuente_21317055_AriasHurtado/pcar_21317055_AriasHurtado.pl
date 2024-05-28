:-module(pcar_21317055_AriasHurtado, [pcarType/1, pcar/5, isPcar/1, isPcars/1]).


/*
 * -Predicados:
 * pcar(IdPcar, Capacity, Model, TypePcar, Pcar)
 * isPcar(Pcar)
 * isPcars(List)
 * pcarType(TypePcar)
 *
 * -Metas:
 *
 * Principales:
 * pcar
 *
 * Secundarias:
 * pcarType, isPcar, isPcars
 *
*/

% Predicados contructores


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


% Predicados Pertenencia


% Dominio: Pcar(pcar)
%
% Descripcion: verifica que un pcar tenga la estructura de un pcar

isPcar([IdPcar, Capacity, Model, TypePcar]):-
    pcar(IdPcar, Capacity, Model, TypePcar,_).


% Dominio: List(pcars)
%
% Descripcion: verifica que una lista contenga unicamente pcars validos
% de manera recursiva

isPcars([]).
isPcars([H|T]):-
    isPcar(H),
    isPcars(T).


% Otros Predicados


% Dominio: Typecar(String)
%
% Descripcion: verifica que los tipos de vagon validos sean de terminal
% o central

pcarType(TypePcar) :-
    member(TypePcar, ["tr","ct"]).





