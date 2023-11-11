:-include('TDASystem_21498571_PaulRamirez.pl').


/*
 Predicado: systemTalkRec(System, Message, Systemnew)
 Dominios:
        System, Systemnew: system
        Message: string
 Metas:
     principal: systemTalkRec
     secundarias: systemUpdateHistory
 Clausulas:
*/

systemTalkRec([Name, ICCL, Chatbots, [ChatHistorylist, Loggeduser], []],
              Message,
              [Name, ICCL, Chatbots, [ChatHistorylistnew, Loggeduser], [ICCL, IdF, Message]]) :-
    dif(Loggeduser, ""),
    systemSearchChatbot(Chatbots, ICCL, Chatbot),
    chatbotGetStartFlowId(Chatbot, IdF),
    systemRegisterAppendString([Name, ICCL, Chatbots, [ChatHistorylistnew, Loggeduser], [ICCL, IdF, _]],
                               Message, ICCL, IdF, String),
    systemUpdateHistory(ChatHistorylist, String, Loggeduser, ChatHistorylistnew).
systemTalkRec([Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylist, Loggeduser], [IdC, IdF, _]],
              Message,
              [Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylistnew, Loggeduser], [CCL, FCL, Message]]) :-
    dif(Loggeduser, ""),
    systemSearchChatbot(Chatbots, IdC, Chatbot),
    chatbotSearchFlow(Chatbot, IdF, Flow),
    flowSearchOption(Flow, Message, Option),
    optionGetChatbotcodelink(Option, CCL),
    optionGetInitialflowcodelink(Option, FCL),
    systemRegisterAppendString([Name, InitialChatbotCodeLink, Chatbots, [ChatHistorylistnew, Loggeduser], [IdC, IdF, _]],
                               Message, CCL, FCL, String),
    systemUpdateHistory(ChatHistorylist, String, Loggeduser, ChatHistorylistnew).


