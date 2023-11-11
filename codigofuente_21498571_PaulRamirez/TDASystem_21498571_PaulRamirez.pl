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
 systemSearchChatbot
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


/*
 Predicado: systemSearchChatbot(Chatbots, Id, Chatbot)
 Dominios:
       Chatbots: lista de chatbots
       Id: int
       Chatbot: chatbot
 Metas: systemSearchChatbot
 Clausulas:
*/
systemSearchChatbot([Chatbotactual|_], Id, Chatbotactual) :-
    chatbotGetId(Chatbotactual, Idactual), Idactual = Id.
systemSearchChatbot([_|T], Id, Chatbot) :-
    systemSearchChatbot(T, Id, Chatbot).

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

% Otros:
/*
 Predicado: systemLogin(System, User, Systemnew)
 Dominios:
        System, Systemnew: system
        User: string
 Metas: systemLogin
 Clausulas:
*/
systemLogin([Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylist, ""]|T],
            User, [Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylist, Loggedusernew]|T]) :-
    user(User, Loggedusernew), systemGetUserlist(ChatHistorylist, Userlist),
    member(Loggedusernew, Userlist).

/*
 Predicado: systemLogout(System, Systemnew)
 Dominios:
        System, Systemnew: system
 Metas: systemLogout
 Clausulas:
*/

systemLogout([Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylist, _], _],
             [Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylist, ""], []]).

/*
 Predicado: systemRegisterAppendString(System, Message, CCL, FCL,
 String)
 Dominios:
     System: system
     Message: string
     CCL, FCL: int
 Metas: systemRegisterAppendString
 Clausulas:
*/
systemRegisterAppendString([_, _, Chatbots, [_, Loggeduser]|_],
                           Message, CCL, FCL,
                           String) :-
    systemSearchChatbot(Chatbots, CCL, Chatbot), chatbotGetName(Chatbot, Name),
    chatbotSearchFlow(Chatbot, FCL, Flow), flowGetNameMsg(Flow, NM),
    flowGetOptionsMsg(Flow, OM),
    get_time(Time), string_concat("\n", Time, M0), string_concat(M0, "-", M1),
    string_concat(M1, Loggeduser, M2), string_concat(M2, ": ", M3),
    string_concat(M3, Message, M4), string_concat(M4, "\n", M5),
    string_concat(M5, Time, M6), string_concat(M6, "-", M7),
    string_concat(M7, Name, M8), string_concat(M8, ": ", M9),
    string_concat(M9, NM, M10), string_concat(M10, "\n", M11),
    string_concat(M11, OM, String).

/*
 Predicado: systemUpdateHistory(Chathistorylist, String, User,
 Chathistorylistnew)
 Dominios:
     Chathistorylist, Chathistorylistnew: lista de chathistorys
     String: string
     User: user
 Metas: systemUpdatehistory
 Clausulas:
*/
% Hechos
systemUpdateHistory([], _, _, []).
% Reglas
systemUpdateHistory([CHactual|Told], String, User, [CHactual|Tnew]) :-
    chatHistoryGetUser(CHactual, Useractual), dif(Useractual, User),
    systemUpdateHistory(Told, String, User, Tnew).

systemUpdateHistory([CHactual|Told], String, User, [[User, Registernew]|Tnew]) :-
    chatHistoryGetUser(CHactual, Useractual), Useractual = User,
    chatHistoryGetRegister(CHactual, Register), string_concat(Register, String, Registernew),
    systemUpdateHistory(Told, String, User, Tnew).
