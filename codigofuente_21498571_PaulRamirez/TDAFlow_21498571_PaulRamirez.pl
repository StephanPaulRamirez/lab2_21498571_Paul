:- include('TDAOption_21498571_PaulRamirez.pl').
 /*
 TDA Flow
 especificación

 flow(Id, NameMsg, Option)
 flow
 flowGetId
 flowGetNameMsg
 flowGetOption
 flowSearchOption
 flowAddOption
 flowGetOptionsMsg

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
flowOptionIdCheck(Option, [Actual|Told], [Actual|Tnew]) :-
    optionGetId(Option, Id), optionGetId(Actual, Idactual),
    dif(Id,Idactual), flowOptionIdCheck(Option, Told, Tnew).

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
 Predicado: searchOption(Options, Message, Option)
 Dominios:
    Options: lista de options
    Option: option
    Message: string
 Metas: searchOption
 Clausulas:  */
searchOption([Optionactual|_], Message, Optionactual) :-
    optionGetKeyword(Optionactual, Keywords),
    string_lower(Message, Messagemin),
    maplist(string_lower, Keywords, Keywordsmin), (member(Messagemin, Keywordsmin);
    (atom_number(Message, N), optionGetId(Optionactual,Id), Id = N)).
searchOption([_|T], Message, Option) :-
    searchOption(T, Message, Option).

/*
 Predicado: flowSearchOption(Flow, Message, Option)
 Dominios:
    Flow: flow
    Option: option
    Message: string
 Metas: flowSearchOption
 Clausulas:  */
flowSearchOption(Flow, Message, Option) :-
    flowGetOption(Flow, Options),searchOption(Options, Message, Option).


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

/*
 Predicado: optionsGetMsg(Options, Message
 Dominios:
    Message: string
    Options: lista de options
 Metas: optionsGetMsg
 Clausulas:  */
% Hechos
optionsGetMsg([], "").
% Reglas
optionsGetMsg([Option|T], Message) :-
    optionGetMsg(Option, OptionMessage1),
    string_concat(OptionMessage1, "\n", OptionMessage2),
    optionsGetMsg(T, TMessage),
    string_concat(OptionMessage2, TMessage, Message).
/*
 Predicado: flowGetOptionsMsg(Flow, Message)
 Dominios:
    Flow: flow
    Message: string
 Metas: flowGetOptionsMsg
 Clausulas:  */
flowGetOptionsMsg(Flow, Message) :-
    flowGetOption(Flow, Options), optionsGetMsg(Options, Message).





