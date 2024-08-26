import 'package:flutter/material.dart';
import 'package:gesture_reaction/widgets/message_item.dart';
import 'package:gesture_reaction/widgets/options_item.dart';

List<MessageItem> conversation = [
  MessageItem(1, 1, "Hola, ¿cómo estás?"),
  MessageItem(2, 2, "¡Hola! Estoy bien, gracias. ¿Y tú?"),
  MessageItem(1, 3, "Bien también. Oye, ¿tienes planes para el fin de semana?"),
  MessageItem(2, 4, "Aún no he planeado nada. ¿Por qué?"),
  MessageItem(1, 5, "Estaba pensando en organizar una pequeña reunión en mi casa. ¿Te interesa?"),
  MessageItem(2, 6, "¡Suena genial! ¿Qué día estás pensando?"),
  MessageItem(1, 7, "Estaba pensando en el sábado por la tarde, ¿te parece bien?"),
  MessageItem(2, 8, "Sábado por la tarde me viene perfecto. ¿A qué hora?"),
  MessageItem(1, 9, "¿Qué tal a partir de las 6?"),
  MessageItem(2, 10, "Perfecto, ahí estaré. ¿Necesitas que lleve algo?"),
  MessageItem(1, 11, "Si puedes traer algunas bebidas, sería genial. Yo me encargo de la comida."),
  MessageItem(2, 12, "Claro, no hay problema. ¿Quién más va a venir?"),
  MessageItem(1, 13, "He invitado a un par de amigos del trabajo. Seremos unos 6 en total."),
  MessageItem(2, 14, "Genial, será divertido. ¿Tienes algo planeado o solo será una reunión casual?"),
  MessageItem(1, 15, "Pensaba en algunos juegos de mesa y tal vez karaoke. ¿Qué opinas?"),
  MessageItem(2, 16, "¡Me encanta la idea! Hace tiempo que no juego juegos de mesa."),
  MessageItem(1, 17, "¡Excelente! Entonces está todo listo. Nos vemos el sábado."),
  MessageItem(2, 18, "Perfecto. Gracias por organizar esto. ¡Estoy emocionado!"),
  MessageItem(1, 19, "Yo también estoy emocionado. Será una gran noche."),
  MessageItem(2, 20, "Sin duda. ¡Hasta el sábado entonces!")
];


List<OptionItem> options = [
  OptionItem('Start', Icons.start),
  OptionItem('Reply', Icons.arrow_outward_rounded),
  OptionItem('Forward', Icons.forward),
  OptionItem('Copy', Icons.copy),
  OptionItem('Pin', Icons.push_pin_outlined),
  OptionItem('Report', Icons.report_gmailerrorred),
];