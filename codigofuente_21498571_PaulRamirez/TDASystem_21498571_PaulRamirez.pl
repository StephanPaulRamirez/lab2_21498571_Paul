:- include('TDAChatbot_21498571_PaulRamirez.pl').
 /*
 TDA System
 especificación

 System(Name, InitialChatbotCodeLink, Chatbots)
 system
 systemGetName
 systemGetInitialChatbotId
 systemGetChatbots
 systemGetFourth
 systemGetChatHistorylist
 systemGetUserlist
 systemGetLoggeduser
 systemGetActual
 systemAddChatbot
 systemAddUser
 systemLogin
 SystemLogout

 implementacion

 representacion
 Name (String) X InitialChatbotCodeLink (Int) X Chatbots (lista de chatbots)
*/


/*
 Predicado: systemRemoveDup(ListaChatbotsOld,ListaChatbotsNew)
 Dominios:
	ListaChatbotsOld, ListaChatbotsNew: lista de Chatbots
 Metas: systemRemoveDup
 Clausulas:
*/

% Hechos
systemRemoveDup([], []).
systemRemoveDup([C],[C]).

% Reglas
systemRemoveDup([C|Told], [C|Tnew]) :-
    chatbotGetId(C,Id), maplist(chatbotGetId, Told, Idlist), not(member(Id, Idlist)),
    systemRemoveDup(Told,Tnew).

systemRemoveDup([C|Told], Tnew) :-
    chatbotGetId(C,Id), maplist(chatbotGetId, Told, Idlist), member(Id, Idlist),
    systemRemoveDup(Told,Tnew).


/*
 Predicado: system(Name, InitialChatbotCodeLink, Chatbots, System)
 Dominios:
       Name: String
       InitialChatbotCodeLink: Int
       Chatbots: Lista de chatbots
       System: system
 Metas:
     principal: system
     secundaria: systemRemoveDup
 Clausulas:
*/

system(Name, InitialChatbotCodeLink, Chatbots, [Name, InitialChatbotCodeLink, Chatbotsnodup, [[], []], []]) :-
       systemRemoveDup(Chatbots, Chatbotsnodup).
