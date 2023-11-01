:- include('TDAFlow_21498571_PaulRamirez.pl').
 /*
 TDA Chatbot
 especificación

 chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows)
 chatbot
 chatbot
 chatbotGetId
 chatbotGetName
 chatbotGetMsg
 chatbotGetStartFlowId
 chatbotGetFlows
 chatbotAddFlow

 implementacion

 representacion
 chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int)  X  flows(lista de flows) X chatbot(chatbot)
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
