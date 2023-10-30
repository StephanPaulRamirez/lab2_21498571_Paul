:- include('TDAOption_21498571_PaulRamirez.pl').
 /*
 TDA Flow
 especificación

 flow(Id, NameMsg, Option, Flow)
 flow
 flowGetId
 flowGetNameMsg

 implementacion

 representacion
 id (int) X name-msg (String)  X Option  (Lista de 0 o más opciones) X Flow (Flow)
*/


/*
 Predicado: flowRemoveDup(ListaOptionsOld,ListaOptionsNew)
 Dominios:
	ListaOptionsOld, ListaOptionsNew: lista de options
 Metas: flowRemoveDup
 Clausulas:
*/
% Hechos
flowRemoveDup([], []).
flowRemoveDup([O],[O]).

% Reglas
flowRemoveDup([O|Told], [O|Tnew]) :-
    optionGetId(O,Id), maplist(optionGetId, Told, Idlist), not(member(Id, Idlist)),
    flowRemoveDup(Told,Tnew).

flowRemoveDup([O|Told], Tnew) :-
    optionGetId(O,Id), maplist(optionGetId, Told, Idlist), member(Id, Idlist),
    flowRemoveDup(Told,Tnew).

% Constructor:

/*
 Predicado: flow(Id, name-msg, Option, Flow)
 Dominios:
    Id: Int
    name-msg: string
    Option: lista de options
    Flow: flow
 Metas:
    principal: flow
    secundaria: flowRemoveDup
 Clausulas:  */

flow(Id, NameMsg, Option, [Id, NameMsg, Optionsnodup]) :-
    flowRemoveDup(Option, Optionsnodup).

/*
 Predicado: flowGetId(F, I)
 Dominios:
    I: Int
    F: flow
 Metas: flowGetId
 Clausulas:  */

flowGetId([Id|_], Id).

/*
 Predicado: flowGetNameMsg(F, NM)
 Dominios:
    NM: string
    F: flow
 Metas: flowGetNameMsg
 Clausulas:  */
flowGetNameMsg([_, NameMsg|_], NameMsg).

/*
 Predicado: flowGetOption(F, O)
 Dominios:
    O: lista de options
    F: flow
 Metas: flowGetOption
 Clausulas:  */
flowGetOption([_, _, Option|_], Option).

/*
 Predicado: flowAddOption(O, FO, FN)
 Dominios:
    FO, FN: flow
    O: option
 Metas: flowAddOption
 Clausulas:  */
flowAddOption([Id, NameMsg, Options] , Option, Flownew) :-
    flow(Id, NameMsg, [Option|Options], Flownew).

flowAddOption(Flow, _, Flow).
