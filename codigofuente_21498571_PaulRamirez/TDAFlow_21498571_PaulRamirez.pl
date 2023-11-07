:- include('TDAOption_21498571_PaulRamirez.pl').
 /*
 TDA Flow
 especificación

 flow(Id, NameMsg, Option)
 flow
 flowGetId
 flowGetNameMsg
 flowGetOption
 flowAddOption

 implementacion

 representacion
 id (int) X name-msg (String)  X Option  (Lista de options)
*/


/*
 Predicado: flowOptionIdCheck(Option, ListaOptionsOld,ListaOptionsNew)
 Dominios:
	ListaOptionsOld, ListaOptionsNew: lista de options
        Option: option
 Metas: flowOptionIdCheck
 Clausulas:
*/
% Hechos
flowOptionIdCheck(_, [], []).
% Reglas
flowOptionIdCheck(Option, [Actual|Told], Tnew) :-
    optionGetId(Option, Id), optionGetId(Actual, Idactual),
    Id = Idactual, flowOptionIdCheck(Option, Told, Tnew).
flowOptionIdCheck(Option, [Actual|Told], [Actual|Tnew]) :-
    flowOptionIdCheck(Option, Told, Tnew).

/*
 Predicado: flowRemoveDup(ListaOptionsOld,ListaOptionsNew)
 Dominios:
	ListaOptionsOld, ListaOptionsNew: lista de options
 Metas:
     principal: flowRemoveDup
     secundaria flowOptionIdCheck
 Clausulas:
*/
% Hechos
flowRemoveDup([], []).
% Reglas
flowRemoveDup([O],[O]).
flowRemoveDup([O|Told], [O|Tnew]) :-
    flowOptionIdCheck(O, Told, T), flowRemoveDup(T, Tnew).

% Constructor:

/*
 Predicado: flow(Id, Name-msg, Option, Flow)
 Dominios:
    Id: Int
    Name-msg: string
    Option: lista de options
    Flow: flow
 Metas:
    principal: flow
    secundaria: flowRemoveDup
 Clausulas:  */

flow(Id, NameMsg, Option, [Id, NameMsg, Optionsnodup]) :-
    flowRemoveDup(Option, Optionsnodup).

% Selectores:
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
 Predicado: flowAddNoDup(Options, Option, Optionsnodup)
 Dominios:
    Options, Optionsnodup: lista de options
    Option: option
 Metas: flowAddNoDup
 Clausulas:  */
flowAddNoDup([], Option, [Option]).
flowAddNoDup([Optionactual|Options], Option, [Optionactual|Optionsnodup]) :-
    optionGetId(Optionactual, Idactual),
    optionGetId(Option, Id),
    dif(Idactual,Id), flowAddNoDup(Options, Option, Optionsnodup).
flowAddNoDup(Options, _, Options).

% Modificador:
/*
 Predicado: flowAddOption(Flow, Option, Flownew)
 Dominios:
    Flow, Flownew: flow
    Option: option
 Metas:
     prinicpal: flowAddOption
     secundaria: flowAddNoDup
 Clausulas:  */
flowAddOption(Flow , Option, Flownew) :-
    flowGetId(Flow, Id), flowGetNameMsg(Flow, NameMsg),
    flowGetOption(Flow, Options),
    flowAddNoDup(Options, Option, Optionsnodup),
    flow(Id, NameMsg, Optionsnodup, Flownew).
flowAddOption(Flow, _, Flow).
