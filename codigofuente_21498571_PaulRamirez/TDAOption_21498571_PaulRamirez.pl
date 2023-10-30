
/*
 TDA Option
 especificación

 option(code,message,ChatbotCodeLink,InitialFlowCodeLink,Keyword,Option)
 option
 optionGetId
 optionGetMsg
 optionGetChatbotcodelink
 optionGetInitialflowcodelink
 optionGetKeyword

 implementacion

 representacion
 code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (Lista de strings) X Option (Option)
*/

% Constructor:

/*
 Predicado: option(C,M,CCL,IFCL,K,O)
 Dominios:
	C, CCL, IFCL: Int
	M: string
	K: lista de 0 o más strings
	O: Option
 Metas: option
 Clausulas:  */

option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keyword,
       [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keyword]).

% Selectores:

/*
 Predicado: optionGetId(O,C)
 Dominios:
	C: Int
	O: Option
 Metas: optionGetId
 Clausulas:  */

optionGetId([Id|_], Id).

/*
 Predicado: optionGetMsg(O,M)
 Dominios:
	M: string
	O: Option
 Metas: optionGetMsg
 Clausulas:  */

optionGetMsg([_, Message|_], Message).

/*
 Predicado: optionGetChatbotcodelink(O,CCL)
 Dominios:
	CCL: Int
	O: Option
 Metas: optionGetChatbocodelink
 Clausulas:  */

optionGetChatbotcodelink([_, _, Chatbocodelink|_],Chatbocodelink).

/*
 Predicado: optionGetInitialflowcodelink(O,IFCL)
 Dominios:
	IFCL: Int
	O: Option
 Metas: optionGetInitialflowcodelink
 Clausulas:  */

optionGetInitialflowcodelink([_, _, _, Initialflowcodelink|_], Initialflowcodelink).

/*
 Predicado: optionGetKeyword(O,K)
 Dominios:
	K: lista de strings
	O: Option
 Metas: optionGetKeyword
 Clausulas:  */

optionGetKeyword([_, _, _, _, Keyword|_], Keyword).
