:- include('TDAFlow_21498571_PaulRamirez.pl').
 /*
 TDA Chatbot
 especificación

 chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows)
 chatbot
 chatbotGetId
 chatbotGetName
 chatbotGetMsg
 chatbotGetStartFlowId
 chatbotGetFlows
 chatbotAddFlow

 implementacion

 representacion
 chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int)  X  flows(lista de flows)
*/


/*
 Predicado: chatbotRemoveDup(ListaFlowsOld,ListaFlowsNew)
 Dominios:
	ListaFlowsOld, ListaFlowsNew: lista de flows
 Metas: chatbotRemoveDup
 Clausulas:
*/
% Hechos

chatbotRemoveDup([], []).
chatbotRemoveDup([F],[F]).
% Reglas
chatbotRemoveDup([F|Told], [F|Tnew]) :-
    flowGetId(F,Id), maplist(flowGetId, Told, Idlist), not(member(Id, Idlist)),
    chatbotRemoveDup(Told,Tnew).

chatbotRemoveDup([F|Told], Tnew) :-
    flowGetId(F,Id), maplist(flowGetId, Told, Idlist), member(Id, Idlist),
    chatbotRemoveDup(Told,Tnew).

% Constructor:
/*
 Predicado: chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, Chatbot)
 Dominios:
    ChatbotID, StartFlowId: Int
    Name, WelcomeMessage: String
    Flows: Lista de flows
    Chatbot: Chatbot
 Metas:
    principal: chatbot
    secundaria: chatbotRemoveDup
 Clausulas:
*/
chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, [ChatbotID, Name, WelcomeMessage, StartFlowId, Flowsnodup]) :-
    chatbotRemoveDup(Flows, Flowsnodup).

% Selectores:

/*
 Predicado: chatbotGetId(C,I)
 Dominios:
    C: chatbot
    I: Int
 Metas: chatbotGetId
 Clausulas:
*/
chatbotGetId([Id|_],Id).

/*
 Predicado: chatbotGetName(C,N)
 Dominios:
    C: chatbot
    N: String
 Metas: chatbotGetName
 Clausulas:
*/
chatbotGetName([_, Name|_], Name).

/*
 Predicado: chatbotGetMsg(C,M)
 Dominios:
    C: chatbot
    M: string
 Metas: chatbotGetMsg
 Clausulas:
*/
chatbotGetMsg([_, _, WelcomeMessage|_], WelcomeMessage).

/*
 Predicado: chatbotGetStartFlowId(C,S)
 Dominios:
    C: chatbot
    S: int
 Metas: chatbotGetStartFlowId
 Clausulas:
*/
chatbotGetStartFlowId([_, _, _, StartFlowId|_], StartFlowId).

/*
 Predicado: chatbotGetFlows(C,F)
 Dominios:
    C: chatbot
    F: lista de flows
 Metas: chatbotGetFlows
 Clausulas:
*/
chatbotGetFlows([_, _, _, _, Flows|_], Flows).

/*
 Predicado: chatbotAddNoDup(Flows, Flow, Flowsnodup)
 Dominios:
    Flows, Flowsnodup: lista de flows
    Flow: Flow
 Metas: chatbotAddNoDup
 Clausulas:
*/
% Hechos
chatbotAddNoDup([], Flow, [Flow]).
% Reglas
chatbotAddNoDup([Flowactual|Flows], Flow, [Flowactual|Flowsnodup]) :-
    optionGetId(Flowactual, Idactual),
    optionGetId(Flow, Id),
    dif(Idactual,Id), chatbotAddNoDup(Flows, Flow, Flowsnodup).
chatbotAddNoDup(Flows, _, Flows).

% Modificador:
/*
 Predicado: chatbotAddFlow(Chatbot, Flow, Chatbotnew)
 Dominios:
    Chatbot, Chatbotnew: chatbot
    Flow: Flow
 Metas:
     principal: chatbotAddFlow
     secundarias: chatbotAddNoDup
 Clausulas:
*/
chatbotAddFlow(Chatbot, Flow, Chatbotnew) :-
    chatbotGetId(Chatbot, ChatbotID), chatbotGetName(Chatbot, Name),
    chatbotGetMsg(Chatbot, WelcomeMessage),
    chatbotGetStartFlowId(Chatbot, StartFlowId), chatbotGetFlows(Chatbot, Flows),
    chatbotAddNoDup(Flows, Flow, Flowsnodup),
    chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flowsnodup, Chatbotnew).
chatbotAddFlow(Chatbot, _, Chatbot).
