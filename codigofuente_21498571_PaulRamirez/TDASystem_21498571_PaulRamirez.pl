:- include('TDAChatbot_21498571_PaulRamirez.pl').
:- include('TDAChatHistory_21498571_PaulRamirez.pl').
:- include('TDAUser_21498571_PaulRamirez.pl').

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
% Reglas
systemRemoveDup([C],[C]).
systemRemoveDup([C|Told], [C|Tnew]) :-
    chatbotGetId(C,Id), maplist(chatbotGetId, Told, Idlist), not(member(Id, Idlist)),
    systemRemoveDup(Told,Tnew).

systemRemoveDup([C|Told], Tnew) :-
    chatbotGetId(C,Id), maplist(chatbotGetId, Told, Idlist), member(Id, Idlist),
    systemRemoveDup(Told,Tnew).


% Constructor:
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

system(Name, InitialChatbotCodeLink, Chatbots, [Name, InitialChatbotCodeLink, Chatbotsnodup, [[], ""], []]) :-
       systemRemoveDup(Chatbots, Chatbotsnodup).

% Selectores:

/*
 Predicado: systemGetName(S, N)
 Dominios:
        S: system
        N: string
 Metas: systemGetName
 Clausulas:
*/
systemGetName([Name|_], Name).

/*
 Predicado: systemGetInitialChatbotid(S, I)
 Dominios:
        S: system
        I: Int
 Metas: systemGetInitialChatbotid
 Clausulas:
*/
systemGetInitialChatbotId([_, InitialChatbotCodeLink|_], InitialChatbotCodeLink).

/*
 Predicado: systemGetChatbots(S, C)
 Dominios:
        S: system
        C: lista de chatbots
 Metas: systemGetChatbots
 Clausulas:
*/
systemGetChatbots([_, _, Chatbots|_], Chatbots).

/*
 Predicado: systemGetFourth(S, F)
 Dominios:
        S: system
        F: lista con una lista de chatHistorys y una lista con un user
 Metas: systemGetFourth
 Clausulas:
*/
systemGetFourth([_, _, _, Fourth|_], Fourth).

/*
 Predicado: systemGetChatHistorylist(S, CH)
 Dominios:
        S: system
        CH: lista de chatHistorys
 Metas: systemGetChatHistorylist
 Clausulas:
*/
systemGetChatHistorylist(System, ChatHistorylist) :-
    systemGetFourth(System, [ChatHistorylist|_]).

/*
 Predicado: systemGetUserlist(S, Ul)
 Dominios:
        S: system
        Ul: lista de users
 Metas: systemGetUserlist
 Clausulas:
*/
systemGetUserlist(ChatHistorylist, Userlist) :-
    maplist(chatHistoryGetUser, ChatHistorylist, Userlist).

/*
 Predicado: systemGetLoggeduser(S, U)
 Dominios:
        S: system
        U: user
 Metas: systemGetLoggeduser
 Clausulas:
*/
systemGetLoggeduser(System, User) :-
    systemGetFourth(System, [_, User]).

/*
 Predicado: systemGetActual(S, A)
 Dominios:
        S: system
        A: lista con 2 enteros y un string
 Metas: systemGetActual
 Clausulas:
*/

systemGetActual([_,_,_,_,Actual], Actual).

% Modificadores:
/*
 Predicado: systemAddChatbot(System, Chatbot, Systemnew)
 Dominios:
        System, Systemnew: system
        Chatbot: chatbot
 Metas:
     principal: systemAddChatbot
     secundaria: systemRemoveDup
 Clausulas:
*/
systemAddChatbot([Name, InitialChatbotCodeLink, Chatbots|T], Chatbot,
                 [Name, InitialChatbotCodeLink, Chatbotsnodup|T]) :-
    systemRemoveDup([Chatbot|Chatbots], Chatbotsnodup).

/*
 Predicado: systemAddUser(System, User, Systemnew)
 Dominios:
        System, Systemnew: system
        User: string
 Metas: systemAddUser
 Clausulas:
*/
systemAddUser([Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylist, Loggeduser]|T],
              User,
              [Name, InitialChatbotCodeLink, Chatbots, [[UserCH|ChatHistorylist], Loggeduser]|T]) :-
              user(User, NewUser), systemGetUserlist(ChatHistorylist, Userlist),
              not(member(NewUser, Userlist)), chatHistory(NewUser, "", UserCH).
systemAddUser(System,_,System).
