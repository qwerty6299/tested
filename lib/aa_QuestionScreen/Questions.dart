import 'package:flutter/material.dart';

class Question {
  final String question;
  final int id,answer;
  final List<String> options;

  Question({required this.question,required this.id,required this.answer,required this.options});

 static const List sample_data=[
   {
     "id":1,
     'question': 'Q1. Who created Flutter?',
     "options":['Facebook','Adobe','Google','Google'],
     "answer_index":3
   },
   {
     "id":2,
     'question': 'Q2. Who is the best company?',
     "options":['Facebook','Adobe','Google','Google'],
     "answer_index":1
   },
   {
     "id":3,
     'question': 'Q3. Which app is been used the most?',
     "options":['Facebook','Adobe','Google','Google'],
     "answer_index":2
   },
   {
     "id":4,
     'question': 'Q4. Who created React JS?',
     "options":['Facebook','Adobe','Google','Google'],
     "answer_index":1
   },

];
}