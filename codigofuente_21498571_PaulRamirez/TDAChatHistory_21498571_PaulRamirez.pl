 /*
 TDA ChatHistory
 especificación

 ChatHistory(User, String)
 chatHistory
 chatHistoryGetUser
 chatHistoryGetRegister

 implementacion

 representacion
 User (user) X register (string)
*/

% Constructor:

/*
 Predicado: chatHistory(User, Register, ChatHistory)
 Dominios:
	User: user
        Register: string
        ChatHistory: chatHistory
 Metas: chatHistory
 Clausulas:
*/
chatHistory(User, Register, [User, Register]).

% Selectores:

/*
 Predicado: chatHistoryGetUser(ChatHistory, User)
 Dominios:
	User: user
        ChatHistory: chatHistory
 Metas: chatHistoryGetUser
 Clausulas:
*/
chatHistoryGetUser([User,_], User).

/*
 Predicado: chatHistoryGetRegister(ChatHistory, Register)
 Dominios:
        Register: string
        ChatHistory: chatHistory
 Metas: chatHistoryGetRegister
 Clausulas:
*/
chatHistoryGetRegister([_, Register], Register).

