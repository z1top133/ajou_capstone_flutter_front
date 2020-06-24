import 'package:flutter/material.dart';

List mbti_result = [
  {
    "mbti": "ISTJ",
    "keyword": "세상의 소금형",
    "comment": "한번 시작한 일은 끝까지 해내는 사람들",
    "hit_it_off":"ESFP,ESTP",
    "color": Colors.blue,
  },
  {
    "mbti": "ISFJ",
    "keyword": "임금 뒷편의 권력형",
    "comment": "성실하고 온화하며 협조를 잘하는 사람들",
    "hit_it_off":"ESFP,ESTP",
    "color": Colors.blue,
  },
  {
    "mbti": "INFJ",
    "keyword": "예언자형",
    "comment": "사람과 관련된 뛰어난 통찰력을 가지고 있는 사람들",
    "hit_it_off":"ENFP,ENTP",
    "color": Colors.green,
  },
  {
    "mbti": "INTJ",
    "keyword": "과학자형",
    "comment": "전체적인 부분을 조합하여 비전을 제시하는 사람들",
    "hit_it_off":"ENFP,ENTP",
    "color": Colors.purple,
  },
  {
    "mbti": "ISTP",
    "keyword": "백과사전형",
    "comment": "논리적이고 뛰어난 상황 적응력을 가지고 있는 사람들",
    "hit_it_off":"ESFJ,ESTJ",
    "color": Colors.yellow
  },
  {
    "mbti": "ISFP",
    "keyword": "성인군자형",
    "comment": "따뜻한 감성을 가지고 있는 겸손한 사람들",
    "hit_it_off":"ESFJ,ESTJ",
    "color": Colors.yellow
  },
  {
    "mbti": "INFP",
    "keyword": "잔다르크형",
    "comment": "이상적인 세상을 만들어 가는 사람들",
    "hit_it_off":"ENFJ,ENTJ",
    "color": Colors.green
  },
  {
    "mbti": "INTP",
    "keyword": "아이디어 뱅크형",
    "comment": "비평적인 고나점을 가지고 있는 뛰어난 전략가들",
    "hit_it_off":"ENTJ,ESTJ",
    "color": Colors.purple,
  },
  {
    "mbti": "ESTP",
    "keyword": "완좋은 활동가형",
    "comment": "친구, 운동, 음식 등 다양한 활동을 선호하는 사람들",
    "hit_it_off":"ISFJ,ISTJ",
    "color": Colors.yellow
  },
  {
    "mbti": "ESFP",
    "keyword": "사교적인 유형",
    "comment": "분위기를 고조시키는 우호적 사람들",
    "hit_it_off":"ISFJ,ISTJ",
    "color": Colors.yellow
  },
  {
    "mbti": "ENFP",
    "keyword": "스파크형",
    "comment": "열정적으로 새로운 관계를 만드는 사람들",
    "hit_it_off":"INFJ,INTJ",
    "color": Colors.green
  },
  {
    "mbti": "ENTP",
    "keyword": "발명가형",
    "comment": "풍부한 상상력을 가지고 새로운 것에 도전하는 사람들",
    "hit_it_off":"INFJ,INTJ",
    "color": Colors.purple,
  },
  {
    "mbti": "ESTJ",
    "keyword": "사업가형",
    "comment": "사무적, 실용적, 현실적으로 일을 많이하는 사람들",
    "hit_it_off":"INFP,INTP",
    "color": Colors.blue,
  },
  {
    "mbti": "ESFJ",
    "keyword": "친선도모형",
    "comment": "친절과 현실감을 바탕으로 타인에게 봉사하는 사람들",
    "hit_it_off":"ISFP,ISTP",
    "color": Colors.blue,
  },
  {
    "mbti": "ENFJ",
    "keyword": "언변능숙형",
    "comment": "타인의 성장을 도모하고 협동하는 사람들",
    "hit_it_off":"INFP,ISFP",
    "color": Colors.green
  },
  {
    "mbti": "ENTJ",
    "keyword": "지도자형",
    "comment": "비전을 가지고 사람들을 활력적으로 이끌어가는 사람들",
    "hit_it_off":"INFP,INTP",
    "color": Colors.purple,
  },
];

Map<String, dynamic> mbti_color = {
  'ENTJ': Colors.purple,
  'ENFJ': Colors.green,
  'ESFJ': Colors.blue,
  'ESTJ': Colors.blue,
  'ENTP': Colors.purple, 
  'ENFP': Colors.green,
  'ESFP': Colors.yellow,
  'ESTP': Colors.yellow,
  'INTP': Colors.purple,
  'INFP': Colors.green,
  'ISFP': Colors.yellow,
  'ISTP': Colors.yellow,
  'INTJ': Colors.purple,
  'INFJ': Colors.green,
  'ISFJ': Colors.blue,
  'ISTJ': Colors.blue,
  'x': Colors.black
};