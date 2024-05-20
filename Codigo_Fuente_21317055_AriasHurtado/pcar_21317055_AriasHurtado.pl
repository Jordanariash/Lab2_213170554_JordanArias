:-module(pcar_21317055_AriasHurtado, [pcarType/1, pcar/5, isPcar/1]).



pcarType(TypePcar) :-
    member(TypePcar, ["tr","ct"]).

pcar(IdPcar, Capacity, Model, TypePcar, Pcar):-
   integer(IdPcar),
   integer(Capacity),
   Capacity > 0,
   string(Model),
   pcarType(TypePcar),
   Pcar = [IdPcar, Capacity, Model, TypePcar].


isPcar([IdPcar, Capacity, Model, TypePcar]):-
    pcar(IdPcar, Capacity, Model, TypePcar,_).


/*
pcar( 0, 90, "NS-74", ct, PC0),
pcar( 1, 100, "NS-74", tr, PC1),
pcar( 2, 150, "NS-74", tr, PC2),
pcar( 3, 90, "NS-74", ct, PC3),
pcar( 4, 100, "AS-2014", ct, PC4),
pcar( 5, 100, "AS-2014", ct, PC5),
pcar( 6, 100, "AS-2016", ct, PC6),
*/
