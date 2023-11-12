
% Mi Script con ejemplos de cada RF

% ejemplos option:

% se crean con mas de una keyword
option(1, "1) perro", 1, 1, ["perro", "can", "perrito"], Option1),
option(2, "2) gato", 1, 2, ["gato", "felino", "gatito", "michi"], Option2),
% se crean options que mandan al inicio de la conversacion
option(1, "1) calculo", 0, 0, ["calculo"], Option4),
option(2, "2) algebra", 0, 0, ["algebra"], Option5),
option(3, "3) fisica", 0, 0, ["fisica"], Option6),
option(1, "1) grande", 0, 0, ["grande"], Option7),
option(2, "2) chico", 0, 0, ["chico"], Option8),
option(1, "1) corto", 0, 0, ["corto"], Option9),
option(2, "2) largo", 0, 0, ["largo"], Option10),
option(1, "1) Adoptar", 1, 0, ["adoptar"], Option11),
option(2, "2) Estudiar", 2, 0, ["estudiar"], Option12),

% ejemplos flow:

% flow con 2 options
flow(0, "¿Que te gustaria adoptar?", [Option1, Option2], Flow0),
% si se descomenta flow1 da false por option de id repetido
% flow(0, "¿Que quieres estudiar?", [Option4, Option4, Option5], flow1),
flow(0, "¿Que ramo quieres estudiar?", [Option4, Option5, Option6], Flow2),
flow(1, "¿Que tamaño?", [Option7], Flow3),
% se crea flow sin options
flow(0, "¿Que te gustaria hacer?", [], Flow4),
flow(2, "¿Que tan largo el pelo?", [Option9, Option10], Flow5),

% ejemplos flowAddOption:

% se agregan options nuevos
flowAddOption(Flow3 , Option8, Flow6),
flowAddOption(Flow4, Option11, Flow7),
flowAddOption(Flow7, Option12, Flow8),
% flowAddOption(Flow8, Option12, Flow9),
% si se descomenta flow9 da false por id repetido


% ejemplos chatbot:

% chatbot sin flows
chatbot(0, "inicial", "Bienvenido", 0, [], Chatbot0),
% chatbot con 2 flows
chatbot(1, "Adoptar", "¿que quieres adoptar?", 0, [Flow0, Flow6], Chatbot1),
% chatbot(2, "Estudiar", "¿que ramo?", 0, [Flow2, Flow2], Chatbot2),
% si se descomenta da false por flow con id repetido
chatbot(2, "Estudiar", "¿que quieres estudiar?", 0, [Flow2], Chatbot2),

% ejemplos chatbotAddFlow:

% se añade un flow
chatbotAddFlow(Chatbot0, Flow8, Chatbot3),
chatbotAddFlow(Chatbot1, Flow5, Chatbot4),
% chatbotAddFlow(chatbot4, Flow5, chatbot5),
% si se descomenta da false por agregar flow con id repetido

% ejemplos system:

% system sin chatbots
system("chatbots ejemplo", 0, [], System1),
system("chatbots ejemplo", 0, [Chatbot3], System3),
% si se descomenta da false system2 por chatbot con id repetido
% system("chatbots ejemplo", 0, [Chatbot3,Chatbot3], System2),

% ejemplos systemAddChatbot:

% se agrega un chatbot
systemAddChatbot(System3, Chatbot1, System4),
% si se descomenta system5 da false por id repetido
% systemAddChatbot(System4, Chatbot0, System5),
% agrega el segundo chatbot
systemAddChatbot(System4, Chatbot2, System6),

% ejemplos systemAddUser:

% se agrega un usuario
systemAddUser(System6, "usuario0", System7),
% si se descomenta system8 da false por usuario ya existente
% systemAddUser(System7, "usuario0", System8),
systemAddUser(System7, "usuario1", System9),

% ejemplos systemLogin:
% si se descomenta system10 da false porque no esta registrado
% systemLogin(System9, "usuario8", System10),
% se inicia sesion
systemLogin(System9, "usuario0", System11),
% si se descomenta system12 da false porque ya hay sesion abierta
% systemLogin(System11, "usuario1", System12),

% ejemplos systemLogout:

% se hace logout del usuario0
systemLogout(System11, System13),
% si se descomentan dan false porque no hay usuarios logeados
% systemLogout(System13, System14),
% systemLogout(System13, System15),

% ejemplos systemTalkRec:

% si se descomenta system16 da false porque no hay usuarios logeados
% systemTalkRec(System13, "hola", System16),
% inicia historial del usuario0
systemTalkRec(System11, "hola", System17),
% se linkea al chatbot 1 flow 0
systemTalkRec(System17, "1", System18),
% se linkea al chatbot 1 flow 1
systemTalkRec(System18, "1", System19),

% ejemplos systemSynthesis

% se encuentra el historial del usuario0
systemSynthesis(System19, "usuario0", String0),
% se encuentra el historial del usuario 1 pero esta vacio porque no ha
% usado systemTalkRec
systemSynthesis(System19, "usuario1", String1).
% si se descomenta String8 da false porque no tiene historial
% systemSynthesis(System19, "usuario8", String8).


% Script de Pruebas Enunciado
option(1, "1) Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "Flujo Principal Chatbot0\nBienvenido\n¿Qué te gustaría hacer?", [OP1], F10),
flowAddOption(F10, OP2, F11),
% flowAddOption(F10, OP1, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
%Chatbot1
option(1, "1) New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2) París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3) Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4) Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),
%Opciones segundo flujo Chatbot1
option(1, "1) Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2) Museos", 1, 2, ["Museo"], OP8),
option(3, "3) Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4) Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1) Solo", 1, 3, ["Solo"], OP11),
option(2, "2) En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3) En familia", 1, 3, ["Familia"], OP13),
option(4, "4) Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5) En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),
%Chatbot2
option(1, "1) Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2) Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3) Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddChatbot(S0, CB1, S01),
systemAddChatbot(S01, CB2, S02),
systemAddUser(S02, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10),
systemTalkRec(S10, "hola", S11),
systemTalkRec(S11, "1", S12),
systemTalkRec(S12, "1", S13),
systemTalkRec(S13, "Museo", S14),
systemTalkRec(S14, "1", S15),
systemTalkRec(S15, "3", S16),
systemTalkRec(S16, "5", S17),
systemSynthesis(S17, "user2", Str1),
write(Str1).
