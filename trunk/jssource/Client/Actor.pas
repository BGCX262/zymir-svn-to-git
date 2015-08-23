//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit Actor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grobal2, DxDraws, CliUtil, magiceff, Wil, ClFunc, SDK;

const
   MAXACTORSOUND = 3;
   CMMX     = 150;
   CMMY     = 200;

   HUMANFRAME = 600;
   MONFRAME  = 280;
   EXPMONFRAME = 360;
   SCULMONFRAME = 440;
   ZOMBIFRAME = 430;
   MERCHANTFRAME = 60;
   MAXSAY = 5;
//   MON1_FRAME =
//   MON2_FRAME =

   RUN_MINHEALTH = 10;
   DEFSPELLFRAME = 10;
   FIREHIT_READYFRAME = 6;  //堪拳搬 矫傈 橇贰烙
   MAGBUBBLEBASE = 3890;    //魔法盾效果图位置
   MAGBUBBLESTRUCKBASE = 3900; //被攻击时魔法盾效果图位置
   MAXWPEFFECTFRAME = 5;
   WPEFFECTBASE = 3750;
   EFFECTBASE = 0;
   
type
  TActionInfo = packed record
    start   :Word;//0x14              // 矫累 橇贰烙
    frame   :Word;//0x16              // 橇贰烙 肮荐
    skip    :Word;//0x18
    ftime   :Word;//0x1A              // 橇贰烙 肮荐
    usetick :Word;//0x1C              // 荤侩平, 捞悼 悼累俊父 荤侩凳
  end;
  pTActionInfo = ^TActionInfo;
  TMoveHMShow = packed record
    nMoveHpList    :array[0..6] of Integer;
    nMoveHpCount   :Byte;
    nMoveHpEnd     :Integer;
    boMoveHpShow   :Boolean;
    dwMoveHpTick   :LongWord;
  end;
  pTMoveHMShow= ^TMoveHMShow;
  THumanAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActRun:        TActionInfo;   //8
    ActRushLeft:   TActionInfo;
    ActRushRight:  TActionInfo;
    ActWarMode:    TActionInfo;   //1
    ActHit:        TActionInfo;   //6
    ActHeavyHit:   TActionInfo;   //6
    ActBigHit:     TActionInfo;   //6
    ActFireHitReady: TActionInfo; //6
    ActSpell:      TActionInfo;   //6
    ActSitdown:    TActionInfo;   //1
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
  end;
  pTHumanAction = ^THumanAction;
  TMonsterAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActAttack:     TActionInfo;   //6 0x14 - 0x1C
    ActCritical:   TActionInfo;   //6 0x20 -
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
    ActDeath:      TActionInfo;
  end;
  pTMonsterAction = ^TMonsterAction;
const
   HA: THumanAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 90;   usetick: 2);
        ActRun:    (start: 128;    frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActRushLeft: (start: 128;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActRushRight:(start: 131;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActWarMode:(start: 192;    frame: 1;  skip: 0;  ftime: 200;  usetick: 0);
        //ActHit:    (start: 200;    frame: 5;  skip: 3;  ftime: 140;  usetick: 0);
        ActHit:    (start: 200;    frame: 6;  skip: 2;  ftime: 85;   usetick: 0);
        ActHeavyHit:(start: 264;   frame: 6;  skip: 2;  ftime: 90;   usetick: 0);
        ActBigHit: (start: 328;    frame: 8;  skip: 0;  ftime: 70;   usetick: 0);
        ActFireHitReady: (start: 192; frame: 6;  skip: 4;  ftime: 70;   usetick: 0);
        ActSpell:  (start: 392;    frame: 6;  skip: 2;  ftime: 60;   usetick: 0);
        ActSitdown:(start: 456;    frame: 2;  skip: 0;  ftime: 300;  usetick: 0);
        ActStruck: (start: 472;    frame: 3;  skip: 5;  ftime: 70;  usetick: 0);
        ActDie:    (start: 536;    frame: 4;  skip: 4;  ftime: 120;  usetick: 0)
      );
  MA9: TMonsterAction = (//4C03D4
    ActStand:(Start:0;  frame:1;  skip:7;  ftime:200;  usetick:0);
    ActWalk:(Start:64;  frame:6;  skip:2;  ftime:120;  usetick:3);
    ActAttack:(Start:64;  frame:6;  skip:2;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:64;  frame:6;  skip:2;  ftime:100;  usetick:0);
    ActDie:(Start:0;  frame:1;  skip:7;  ftime:140;  usetick:0);
    ActDeath:(Start:0;  frame:1;  skip:7;  ftime:0;  usetick:0);
    );
   MA10: TMonsterAction = (  //(8Frame) 带刀卫士
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 4;  skip: 4;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA11: TMonsterAction = (  //荤娇(10Frame楼府)
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 120;  usetick: 3);
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA12: TMonsterAction = (  //版厚捍, 锭府绰 加档 狐福促.
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 6;  skip: 2;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 150;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA13: TMonsterAction = (  //侥牢檬
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 10;     frame: 8;  skip: 2;  ftime: 160;  usetick: 0); //殿厘...
        ActAttack: (start: 30;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 110;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 130;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 20;     frame: 9;  skip: 0;  ftime: 150;  usetick: 0); //见澜..
      );
   MA14: TMonsterAction = (  //秦榜 坷付
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 100;  usetick: 0); //归榜牢版快(家券)
      );
   MA15: TMonsterAction = (  //档尝带瘤绰 坷付
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 1;      frame: 1;  skip: 0;  ftime: 100;  usetick: 0);
      );
   MA16: TMonsterAction = (  //啊胶筋绰 备单扁
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 4;  skip: 6;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 1;  skip: 0;  ftime: 160;  usetick: 0);
      );
   MA17: TMonsterAction = (  //官迭波府绰 各
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 60;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA19: TMonsterAction = (  //快搁蓖 (磷绰芭 弧府磷澜)
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA20: TMonsterAction = (  //磷菌促 混酒唱绰 粱厚)
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 170;  usetick: 0); //促矫 混酒唱扁
      );
   MA21: TMonsterAction = (  //国笼
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0); //
        ActAttack: (start: 10;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //国 惯荤
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 20;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 30;     frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0); //
      );
   MA22: TMonsterAction = (  //籍惑阁胶磐(堪家措厘,堪家厘焙)
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0); //
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 6;  skip: 4;  ftime: 170;  usetick: 0); //籍惑踌澜
      );
   MA23: TMonsterAction = (  //林付空
        ActStand:  (start: 20;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 100;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 180;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0); //
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 260;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 280;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 20; skip: 0;  ftime: 100;  usetick: 0); //籍惑踌澜
      );
   MA24: TMonsterAction = (  //傈哎, 傍拜 2啊瘤
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start:240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 420;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
      {
   MA25: TMonsterAction = (  //瘤匙空
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 70;     frame: 10; skip: 0;  ftime: 200;  usetick: 3); //殿厘
        ActAttack: (start: 20;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //流立傍拜
        ActCritical:(start: 10;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //刀魔傍拜(盔芭府)
        ActStruck: (start: 50;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 60;     frame: 10; skip: 0;  ftime: 200;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 140;  usetick: 0); //
      );
      }
  MA25: TMonsterAction = (//4C080C
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:70;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:20;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:50;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:60;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:80;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );

   MA26: TMonsterAction = (  //己巩,
        ActStand:  (start: 0;      frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 160;  usetick: 0); //殿厘...
        ActAttack: (start: 56;     frame: 6;  skip: 2;  ftime: 500;  usetick: 0); //凯扁
        ActCritical:(start: 64;    frame: 6;  skip: 2;  ftime: 500;  usetick: 0); //摧扁
        ActStruck: (start: 0;      frame: 4;  skip: 4;  ftime: 100;  usetick: 0);
        ActDie:    (start: 24;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 150;  usetick: 0); //见澜..
      );
   MA27: TMonsterAction = (  //己寒
        ActStand:  (start: 0;     frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;     frame: 0;  skip: 0;  ftime: 160;  usetick: 0); //殿厘...
        ActAttack: (start: 0;     frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActCritical:(start: 0;    frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActStruck: (start: 0;     frame: 0;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 0;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;     frame: 0;  skip: 0;  ftime: 150;  usetick: 0); //见澜..
      );
   MA28: TMonsterAction = (  //脚荐 (函脚 傈)
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start:  0;     frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0); //殿厘..
      );
   MA29: TMonsterAction = (  //脚荐 (函脚 饶)
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0); //殿厘..
      );
  MA30: TMonsterAction = (//4C0974
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:20;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:30;  frame:20;  skip:0;  ftime:150;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );
  MA31: TMonsterAction = (//4C09BC
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:0;  frame:2;  skip:8;  ftime:100;  usetick:0);
    ActDie:(Start:20;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );

  MA32: TMonsterAction = (//4C0A04
    ActStand:(Start:0;  frame:1;  skip:9;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:0;  frame:2;  skip:8;  ftime:100;  usetick:0);
    ActDie:(Start:80;  frame:10;  skip:0;  ftime:80;  usetick:0);
    ActDeath:(Start:80;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );

  MA33: TMonsterAction = (//4C0A4C
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:340;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:260;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:260;  frame:10;  skip:0;  ftime:200;  usetick:0);
    );

  MA34: TMonsterAction = (//4C0A94
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:320;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:400;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:420;  frame:20;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:420;  frame:20;  skip:0;  ftime:200;  usetick:0);
    );

  MA35: TMonsterAction = (//4C0ADC
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );

  MA36: TMonsterAction = (//4C0B24
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:20;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );

  MA37: TMonsterAction = (//4C0B6C
    ActStand:(Start:30;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:4;  skip:6;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );

  MA38: TMonsterAction = (//4C0BB4
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:80;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );

  MA39: TMonsterAction = (//4C0BFC
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:300;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:20;  frame:2;  skip:0;  ftime:150;  usetick:0);
    ActDie:(Start:30;  frame:10;  skip:0;  ftime:80;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );

  MA40: TMonsterAction = (//4C0C44
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:250;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:210;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:110;  usetick:0);
    ActCritical:(Start:580;  frame:20;  skip:0;  ftime:135;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:120;  usetick:0);
    ActDie:(Start:260;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActDeath:(Start:260;  frame:20;  skip:0;  ftime:130;  usetick:0);
    );

  MA41: TMonsterAction = (//4C0C8C
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );

  MA42: TMonsterAction = (//4C0CD4
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:10;  frame:8;  skip:2;  ftime:160;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:30;  frame:10;  skip:0;  ftime:120;  usetick:0);
    ActDeath:(Start:30;  frame:10;  skip:0;  ftime:150;  usetick:0);
    );

  MA43: TMonsterAction = (//4C0D1C
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActCritical:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:150;  usetick:0);
    ActDie:(Start:260;  frame:10;  skip:0;  ftime:120;  usetick:0);
    ActDeath:(Start:340;  frame:10;  skip:0;  ftime:100;  usetick:0);
    );

  MA44: TMonsterAction = (//4C0D64
    ActStand:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActWalk:(Start:10;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActAttack:(Start:20;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:40;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActStruck:(Start:40;  frame:2;  skip:8;  ftime:150;  usetick:0);
    ActDie:(Start:30;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );

  MA45: TMonsterAction = (//4C0DAC
    ActStand:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActAttack:(Start:10;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActCritical:(Start:10;  frame:10;  skip:0;  ftime:100;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    ActDie:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    ActDeath:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    );

  MA46: TMonsterAction = (//4C0DF4
    ActStand:(Start:0;  frame:20;  skip:0;  ftime:100;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA47: TMonsterAction = (//4C0A4C 嗜血教主
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:260;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:524;  frame:6;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:524;  frame:6;  skip:0;  ftime:200;  usetick:0);
    );
  MA48: TMonsterAction = (//4C0D1C
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActAttack:(Start:160;  frame:4;  skip:6;  ftime:160;  usetick:0);
    ActCritical:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:150;  usetick:0);
    ActDie:(Start:260;  frame:10;  skip:0;  ftime:120;  usetick:0);
    ActDeath:(Start:340;  frame:10;  skip:0;  ftime:100;  usetick:0);
    );
  MA49: TMonsterAction = (//4C0C8C
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:10;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
   MA50: TMonsterAction = (//4C0ADC
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:350;  frame:80;  skip:0;  ftime:120;  usetick:0);
    ActAttack:(Start:30;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
   WORDER: Array[0..1, 0..599] of byte = (  //1: 漠捞 菊栏肺,  0: 漠捞 第肺
      (       //巢磊
      //沥瘤
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //叭扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //顿扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war葛靛
      0,1,1,1,0,0,0,0,
      //傍拜
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //傍拜 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //傍拜3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //付过
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //澵扁
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //嘎扁
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //静矾咙
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      ),

      (
      //沥瘤
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //叭扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //顿扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war葛靛
      1,1,1,1,0,0,0,0,
      //傍拜
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //傍拜 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //傍拜3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //付过
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //澵扁
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //嘎扁
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //静矾咙
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      )
   );

   EffDir : array[0..7] of byte = (0, 0, 1, 1, 1, 1, 1, 0);


type
   TActor = class//Size 0x240
     m_nRecogId                :Integer;    //角色标识 0x4
     m_nCurrX                  :Integer;    //当前所在地图座标X 0x08
     m_nCurrY                  :Integer;    //当前所在地图座标Y 0x0A
     m_btDir                   :Byte;       //当前站立方向 0x0C
     m_btSex                   :Byte;       //性别 0x0D
     m_btRace                  :Byte;       //0x0E
     m_btHair                  :Byte;       //头发类型 0x0F
     m_btDress                 :Byte;       //衣服类型 0x10
     m_btWeapon                :Byte;       //武器类型
     m_btHorse                 :Byte;       //马类型
     m_btEffect                :Byte;       //天使类型
     m_btJob                   :Byte;       //职业 0:武士  1:法师  2:道士
//     m_Helmet                  :Byte;
     m_wAppearance             :Word;       //0x14
     m_btDeathState            :Byte;
     m_nFeature                :Integer;    //0x18
     m_nFeatureEx              :Integer;    //0x18
     m_nState                  :Integer;    //0x1C
     m_boDeath                 :Boolean;    //0x20
     m_boSkeleton              :Boolean;    //0x21
     m_boDelActor              :Boolean;    //0x22
     m_dwDelTick               :LongWord;
     m_boDelActionAfterFinished:Boolean;   //0x23
     m_Abil                    :TAbility;   //0x30
     m_boIsShop                :Boolean;
     m_sShopMsg                :String[16];
     m_nUserCorpsIdx           :Integer;
     m_nHelmet                 :Byte;
     m_nIconIdx                :Array[0..4] of Word;
     m_sGroupMsg               :String;
     m_sDescUserName           :String;     //人物名称，后缀
     m_sUserName               :String;     //0x28
     m_nNameColor              :Integer;    //0x2C
     m_nGold                   :Integer;    //金币数量0x58
     m_nGameGold               :Integer;    //游戏币数量
     m_nGamePoint              :Integer;    //游戏点数量
     m_nGameDiamond            :Integer;    //金刚石数量
     m_nGameGird               :Integer;    //灵符数量
     m_nGloryPoint             :Integer;    //荣誉值
     m_nHitSpeed2              :ShortInt;   //攻击速度 0: 扁夯, (-)蠢覆 (+)狐抚

    m_WineRec:TWineRec;//酒量值相关

    m_MedicineRec:TMedicineRec;//药力值相在

    m_SKILL84Rec:TSKILL84Rec;//酒气护体相关

    m_bLiquorProgress:Byte;//酒量提升进度值
    m_SKILL83Rec:TSKILL83Rec; //先天元力相关

     m_boVisible               :Boolean;    //0x5D
     m_boHoldPlace             :Boolean;    //0x5E
     m_nShowY                  :Integer;

     m_SayingArr               :array[0..MAXSAY-1] of String;
     m_SayWidthsArr            :array[0..MAXSAY-1] of Integer;
     m_dwSayTime               :LongWord;
     m_nSayX                   :Integer;
     m_nSayY                   :Integer;
     m_nSayLineCount           :Integer;

     m_boChangeEff             :Boolean;

     m_nShiftX                 :Integer;    //0x98
     m_nShiftY                 :Integer;    //0x9C
     //m_nCopX                   :Integer;
     //m_nCopY                   :Integer;

     m_nPx                     :Integer;  //0xA0
     m_nHpx                    :Integer;  //0xA4
     m_nWpx                    :Integer;  //0xA8
     m_nSpx                    :Integer;  //0xAC
     m_nHsx                    :Integer;
     m_nHelmetX                :Integer;

     m_nPy                     :Integer;
     m_nHpy                    :Integer;
     m_nWpy                    :Integer;
     m_nSpy                    :Integer;  //0xB0 0xB4 0xB8 0xBC
     m_nHsy                    :Integer;
     m_nHelmetY                :Integer;

     m_nRx                     :Integer;
     m_nRy                     :Integer;//0xC0 0xC4
     m_nDownDrawLevel          :Integer;    //0xC8
     m_nTargetX                :Integer;
     m_nTargetY                :Integer; //0xCC 0xD0
     m_nTargetRecog            :Integer;      //0xD4
     m_nHiterCode              :Integer;        //0xD8
     m_nMagicNum               :Integer;         //0xDC
     m_nCurrentEvent           :Integer; //辑滚狼 捞亥飘 酒捞叼
     m_boDigFragment           :Boolean;  //捞锅 邦豹捞 龙捞 某脸绰瘤..
     m_boThrow                 :Boolean;

     m_nBodyOffset             :Integer;     //0x0E8   //0x0D0
     m_nHairOffset             :Integer;     //0x0EC
     m_nHumWinOffset           :Integer;   //0x0F0
     m_nWeaponOffset           :Integer;   //0x0F4
//     m_nCutEffectNumber        :Integer;
//     m_nCutEndEffectNumber     :Integer;
     m_boUseMagic              :Boolean;    //0x0F8   //0xE0
     m_boHitEffect             :Boolean;   //0x0F9    //0xE1
//     m_boCutEffect             :Boolean;
//     m_nCutDir                 :Byte;
//     m_nCutX                   :Integer;
//     m_nCutY                   :Integer;
     m_boUseEffect             :Boolean;   //0x0FA    //0xE2
     m_nHitEffectNumber        :Integer;              //0xE4
//     m_nCutEffectNumberEx      :Integer;
     m_dwWaitMagicRequest      :LongWord;
     m_nWaitForRecogId         :Integer;  //磊脚捞 荤扼瘤搁 WaitFor狼 actor甫 visible 矫挪促.
     m_nWaitForFeature         :Integer;
     m_nWaitForStatus          :Integer;
     m_dwCutMagicTick          :LongWord;
     m_dwCutFrameTimetime      :LongWord;


     m_nCurEffFrame            :Integer;       //0x110
     m_nSpellFrame             :Integer;        //0x114
     m_CurMagic                :TUseMagicInfo;    //0x118  //m_CurMagic.EffectNumber 0x110

   //  m_nCorpsIdx               :Integer;
   //  m_boCorpsEffFrame         :Integer;
 //    m_boCorpsEffEnd           :Integer;
//     m_boCorpsShow             :Boolean;
 //    m_dwCorpsShowTick         :LongWord;

     m_nMoveHpList             :TList;
    { m_nMoveHpList             :array[0..6] of Integer;
     m_nMoveHpCount            :Byte;
     m_nMoveHpEnd              :Integer;
     m_boMoveHpShow            :Boolean;
     m_dwMoveHpTick            :LongWord;}

     {m_nMoveMpList             :array[0..6] of Integer;
     m_nMoveMpCount            :Byte;
     m_nMoveMpEnd              :Integer;
     m_boMoveMpShow            :Boolean;
     m_dwMoveMpTick            :LongWord; }
      //GlimmingMode: Boolean;
      //CurGlimmer: integer;
      //MaxGlimmer: integer;
      //GlimmerTime: longword;
     m_nGenAniCount            :Integer;                   //0x124
     m_boOpenHealth            :Boolean;        //0x140
     m_noInstanceOpenHealth    :Boolean;//0x141
     m_dwOpenHealthStart       :LongWord;
     m_dwOpenHealthTime        :LongWord;//Integer;jacky

      //SRc: TRect;  //Screen Rect 拳搁狼 角力谅钎(付快胶 扁霖)
     m_BodySurface             :TDirectDrawSurface;    //0x14C   //0x134
     m_BodyHorse               :TDirectDrawSurface;
     m_BodyHelmet              :TDirectDrawSurface;

     m_boGrouped               :Boolean;    //0x150 是否组队
     m_nCurrentAction          :Integer;    //0x154         //0x13C
     m_boReverseFrame          :Boolean;    //0x158
     m_boWarMode               :Boolean;    //0x159
     m_dwWarModeTime           :LongWord;   //0x15C
     m_nChrLight               :Integer;    //0x160
     m_nMagLight               :Integer;    //0x164
     m_nRushDir                :Integer;  //0, 1  //0x168
     m_nXxI                    :Integer; //0x16C
     m_boLockEndFrame          :Boolean;     //0x170
     m_dwLastStruckTime        :LongWord;  //0x174
     m_dwSendQueryUserNameTime :LongWord;    //0x178
     m_dwDeleteTime            :LongWord;//0x17C

      //荤款靛 瓤苞
     m_nMagicStruckSound       :Integer;  //0x180 被魔法攻击弯腰发出的声音
     m_boRunSound              :Boolean;  //0x184 跑步发出的声音
     m_nFootStepSound          :Integer;  //CM_WALK, CM_RUN //0x188  走步声
     m_nStruckSound            :Integer;  //SM_STRUCK         //0x18C  弯腰声音
     m_nStruckWeaponSound      :Integer;                //0x190  被指定武器攻击弯腰声音

     m_nAppearSound            :Integer;  //殿厘家府 0    //0x194
     m_nNormalSound            :Integer;  //老馆家府 1    //0x198
     m_nAttackSound            :Integer;  //         2    //0x19C
     m_nWeaponSound            :Integer; //          3    //0x1A0
     m_nScreamSound            :Integer;  //         4    //0x1A4
     m_nDieSound               :Integer;     //磷阑锭   5 SM_DEATHNOW //0x1A8
     m_nDie2Sound              :Integer;                    //0x1AC

     m_nMagicStartSound        :Integer;     //0x1B0
     m_nMagicFireSound         :Integer;      //0x1B4
     m_nMagicExplosionSound    :Integer; //0x1B8
     m_Action                  :pTMonsterAction;
   private
     function GetMessage(ChrMsg:pTChrMsg):Boolean;
   protected
     m_nStartFrame             :Integer;      //0x1BC        //0x1A8
     m_nEndFrame               :Integer;        //0x1C0      //0x1AC
     m_nCurrentFrame           :Integer;    //0x1C4          //0x1B0
     m_nEffectStart            :Integer;     //0x1C8         //0x1B4
     m_nEffectFrame            :Integer;     //0x1CC         //0x1B8
     m_nEffectEnd              :Integer;       //0x1D0       //0x1BC
     m_dwEffectStartTime       :LongWord;//0x1D4             //0x1C0
     m_dwEffectFrameTime       :LongWord;//0x1D8             //0x1C4
     m_dwFrameTime             :LongWord;      //0x1DC       //0x1C8
     m_dwStartTime             :LongWord;      //0x1E0       //0x1CC
     m_nMaxTick                :Integer;         //0x1E4
     m_nCurTick                :Integer;         //0x1E8
     m_nMoveStep               :Integer;        //0x1EC
     m_boMsgMuch               :Boolean;            //0x1F0
     m_dwStruckFrameTime       :LongWord;   //0x1F4
     m_nCurrentDefFrame        :Integer;    //0x1F8          //0x1E4
     m_dwDefFrameTime          :LongWord;      //0x1FC       //0x1E8
     m_nDefFrameCount          :Integer;      //0x200        //0x1EC
     m_nSkipTick               :Integer;           //0x204
     m_dwSmoothMoveTime        :LongWord;    //0x208
     m_dwGenAnicountTime       :LongWord;   //0x20C
     m_dwLoadSurfaceTime       :LongWord;   //0x210  //0x200

     m_nOldx                   :Integer;
     m_nOldy                   :Integer;
     m_nOldDir                 :Integer; //0x214 0x218 0x21C
     m_nActBeforeX             :Integer;
     m_nActBeforeY             :Integer;  //0x220 0x224
     m_nWpord                  :Integer;                   //0x228

      procedure CalcActorFrame; dynamic;
      procedure DefaultMotion; dynamic;
      function  GetDefaultFrame (wmode: Boolean): integer; dynamic;
      procedure DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
      procedure DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
   public
      m_MsgList: TGList;       //list of PTChrMsg 0x22C  //0x21C
      RealActionMsg: TChrMsg; //FrmMain    0x230

      constructor Create; dynamic;
      destructor Destroy; override;
      procedure  SendMsg (wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
      procedure  UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
      procedure  CleanUserMsgs;
      procedure  ProcMsg;
      procedure  ProcHurryMsg;
      function   IsIdle: Boolean;
      function   ActionFinished: Boolean;
      function   CanWalk: Integer;
      function   CanRun: Integer;
      function   Strucked: Boolean;
      procedure  Shift (dir, step, cur, max: integer);
      procedure  ReadyAction (msg: TChrMsg);
      function   CharWidth: Integer;
      function   CharHeight: Integer;
      function   CheckSelect (dx, dy: integer): Boolean;
      procedure  CleanCharMapSetting (x, y: integer);
      procedure  Say (str: string);
      procedure  SetSound; dynamic;
      procedure  Run; dynamic;
      procedure  RunSound; dynamic;
      procedure  RunActSound (frame: integer); dynamic;
      procedure  RunFrameAction (frame: integer); dynamic;  //橇贰烙付促 刀漂窍霸 秦具且老
      procedure  ActionEnded; dynamic;
      function   Move (step: integer): Boolean;
      procedure  MoveFail;
      function   CanCancelAction: Boolean;
      procedure  CancelAction;
      procedure  FeatureChanged; dynamic;
      function   Light: integer; dynamic;
      procedure  LoadSurface; dynamic;
      function   GetDrawEffectValue: TColorEffect;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); dynamic;
      procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); dynamic;
   end;

   TNpcActor = class (TActor)  //NPC类
   private
     m_nEffX      :Integer; //0x240
     m_nEffY      :Integer; //0x244
     m_bo248      :Boolean; //0x248
     m_dwUseEffectTick    :LongWord; //0x24C
     m_EffSurface       :TDirectDrawSurface; //0x250
   public
     constructor Create; override; //创建NPC事件
     procedure  Run; override;   //运行
     procedure  CalcActorFrame; override; //获取当前动做榛
     function   GetDefaultFrame (wmode: Boolean): integer; override;  //获取默认动作
     procedure  LoadSurface; override;  //读入纹理
     procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;//画NPC身体
     procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override; //画NPC效果
   end;

   THumActor = class (TActor)//Size: 0x27C Address: 0x00475BB8
   private
     m_HairSurface         :TDirectDrawSurface; //0x250  //0x240
     m_WeaponSurface       :TDirectDrawSurface; //0x254  //0x244
     m_HumWinSurface       :TDirectDrawSurface; //0x258  //0x248
     m_boWeaponEffect      :Boolean;            //0x25C  //0x24C
     m_nCurWeaponEffect    :Integer;            //0x260  //0x250
     m_nCurBubbleStruck    :Integer;            //0x264  //0x254
     m_dwWeaponpEffectTime :LongWord;           //0x268
     m_boHideWeapon        :Boolean;            //0x26C
     m_nFrame              :Integer;
     m_dwFrameTick         :LongWord;
     m_dwFrameTime         :LongWord;
     m_bo2D0               :Boolean;
   protected
      procedure CalcActorFrame; override;
      procedure DefaultMotion; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure  Run; override;
      procedure  RunFrameAction (frame: integer); override;
      function   Light: integer; override;
      procedure  LoadSurface; override;
      procedure  DoWeaponBreakEffect;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;

   function GetRaceByPM (race: integer;Appr:word): PTMonsterAction;
   //function aGetMonImg2 (appr: integer): TWMImages;
   function GetOffset (appr: integer): integer;
   function GetNpcOffset(nAppr:Integer):Integer;


implementation

uses
   ClMain, SoundUtil, clEvent, MShare,WShare;


function GetRaceByPM (race: integer;Appr:word): pTMonsterAction;
begin
Try //程序自动增加
   Result := nil;
   {
   case race of
      10,24:      Result := @MA10;
      11:      Result := @MA11;
      12:      Result := @MA12;
      13:      Result := @MA13;
      14, 17, 18, 23:  Result := @MA14;
      15, 22:  Result := @MA15;
      16:      Result := @MA16;
      30, 31:  Result := @MA17;
      19, 20, 21, 40, 45, 52, 53:  Result := @MA19;
      41, 42:  Result := @MA20;
      43:      Result := @MA21;
      47:      Result := @MA22;
      48, 49:  Result := @MA23;
      32:      Result := @MA24;  //傈哎, 傍拜捞 2啊瘤 规侥
//      33:      Result := @MA25;
      54:      Result := @MA28;
      55:      Result := @MA29;
      98:      Result := @MA27;
      99:      Result := @MA26;
      50:      Result := @MA50;
      33:      Result := @MA51;
      34:      Result := @MA52;
   end;
   }

  case Race of
    9{01}: Result:=@MA9; //475D70
    10{02}: Result:=@MA10; //475D7C
    11{03}: Result:=@MA11; //475D88
    12{04}: Result:=@MA12; //475D94
    13{05}: Result:=@MA14; //475DA0
    14{06}: Result:=@MA14; //475DAC
    15{07}: Result:=@MA15; //475DB8
    16{08}: Result:=@MA16; //475DC4
    17{06}: Result:=@MA14; //475DAC
    18{06}: Result:=@MA14; //475DAC
    19{0A}: Result:=@MA19; //475DDC
    20{0A}: Result:=@MA19; //475DDC
    21{0A}: Result:=@MA19; //475DDC
    22{07}: Result:=@MA15; //475DB8
    23{06}: Result:=@MA14; //475DAC
    24{04}: Result:=@MA12; //475D94
    30{09}: Result:=@MA17; //475DD0
    31{09}: Result:=@MA17; //475DD0
    32{0F}: Result:=@MA24; //475E18
    33{10}: Result:=@MA25; //475E24
    34{11}: Result:=@MA30; //475E30  赤月恶魔
    35{12}: Result:=@MA31; //475E3C
    36{13}: Result:=@MA32; //475E48
    37{0A}: Result:=@MA19; //475DDC
    40{0A}: Result:=@MA19; //475DDC
    41{0B}: Result:=@MA20; //475DE8
    42{0B}: Result:=@MA20; //475DE8
    43{0C}: Result:=@MA21; //475DF4
    45{0A}: Result:=@MA19; //475DDC
    47{0D}: Result:=@MA22; //475E00
    48{0E}: Result:=@MA23; //475E0C
    49{0E}: Result:=@MA23; //475E0C
    50{27}: begin//NPC
      case Appr of //外观值
        23{01}: Result:=@MA36; //475F77
        24{02}: Result:=@MA37; //475F80
        25{02}: Result:=@MA37; //475F80
        26{00}: Result:=@MA35; //475F9B
        27{02}: Result:=@MA37; //475F80
        28{00}: Result:=@MA35; //475F9B
        29{00}: Result:=@MA35; //475F9B
        30{00}: Result:=@MA35; //475F9B
        31{00}: Result:=@MA35; //475F9B
        32{02}: Result:=@MA37; //475F80
        33{00}: Result:=@MA35; //475F9B
        34{00}: Result:=@MA35; //475F9B
        35{03}: Result:=@MA41; //475F89
        36{03}: Result:=@MA41; //475F89
        37{03}: Result:=@MA41; //475F89
        38{03}: Result:=@MA41; //475F89
        39{03}: Result:=@MA41; //475F89
        40{03}: Result:=@MA41; //475F89
        41{03}: Result:=@MA41; //475F89
        42{04}: Result:=@MA46; //475F92
        43{04}: Result:=@MA46; //475F92
        44{04}: Result:=@MA46; //475F92
        45{04}: Result:=@MA46; //475F92
        46{04}: Result:=@MA46; //475F92
        47{04}: Result:=@MA46; //475F92
        48{03}: Result:=@MA41; //4777B3
        49{03}: Result:=@MA41; //4777B3
        50{03}: Result:=@MA41; //4777B3
        51{00}: Result:=@MA35; //4777C5
        52{03}: Result:=@MA41; //4777B3
        53{03}: Result:=@MA41; //4777B3
        71{03}: Result:=@MA50; //4777B3
        72..74: Result:=@MA49; //4777B3
        76: Result:=@MA35
        else Result:=@MA35;
      end;
    end;

    52{0A}: Result:=@MA19; //475DDC
    53{0A}: Result:=@MA19; //475DDC
    54{14}: Result:=@MA28; //475E54
    55{15}: Result:=@MA29; //475E60
    60{16}: Result:=@MA33; //475E6C
    //60{16}: Result:=@MA43; //475E6C
    61{16}: Result:=@MA33; //475E6C
    62{16}: Result:=@MA33; //475E6C
    63{17}: Result:=@MA34; //475E78
    64{18}: Result:=@MA19; //475E84
    65{18}: Result:=@MA19; //475E84
    66{18}: Result:=@MA19; //475E84
    67{18}: Result:=@MA19; //475E84
    68{18}: Result:=@MA19; //475E84
    69{18}: Result:=@MA19; //475E84
    70{19}: Result:=@MA33; //475E90
    71{19}: Result:=@MA33; //475E90
    72{19}: Result:=@MA33; //475E90
    73{1A}: Result:=@MA19; //475E9C
    74{1B}: Result:=@MA19; //475EA8
    75{1C}: Result:=@MA39; //475EB4
    76{1D}: Result:=@MA38; //475EC0
    77{1E}: Result:=@MA39; //475ECC
    78{1F}: Result:=@MA40; //475ED8
    79{20}: Result:=@MA19; //475EE4
    80{21}: Result:=@MA42; //475EF0
    81{22}: Result:=@MA43; //475EFC
    83{23}: Result:=@MA44; //475F08
    84{24}: Result:=@MA45; //475F14
    85{24}: Result:=@MA45; //475F14
    86{24}: Result:=@MA45; //475F14
    87{24}: Result:=@MA45; //475F14
    88{24}: Result:=@MA45; //475F14
    89{24}: Result:=@MA45; //475F14
    90{11}: Result:=@MA30; //475E30
    98{25}: Result:=@MA27; //475F20
    99{26}: Result:=@MA26; //475F29
    100{16}: Result:=@MA48; //475E6C
  end

Except //程序自动增加
  DebugOutStr('[Exception] UnActor.GetRaceByPM'); //程序自动增加
End; //程序自动增加
end;
{$REGION '没用的'}
{function aGetMonImg2 (appr: integer): TWMImages;
var
  WMImage:TWMImages;
begin
   Result := FrmMain.WMonImg;
   case (appr div 10) of
      0: Result := FrmMain.WMonImg;
      1: Result := FrmMain.WMon2Img;
      2: Result := FrmMain.WMon3Img;
      3: Result := FrmMain.WMon4Img;
      4: Result := FrmMain.WMon5Img;
      5: Result := FrmMain.WMon6Img;
      6: Result := FrmMain.WMon7Img;
      7: Result := FrmMain.WMon8Img;
      8: Result := FrmMain.WMon9Img;
      9: Result := FrmMain.WMon10Img;
      10: Result := FrmMain.WMon11Img;
      11: Result := FrmMain.WMon12Img;
      12: Result := FrmMain.WMon13Img;
      13: Result := FrmMain.WMon14Img;
      14: Result := FrmMain.WMon15Img;
      15: Result := FrmMain.WMon16Img;
      16: Result := FrmMain.WMon17Img;
      17: Result := FrmMain.WMon18Img;
      18: Result := FrmMain.WMon19Img;
      19: Result := FrmMain.WMon20Img;
      20: Result := FrmMain.WMon21Img;
      21: Result := FrmMain.WMon22Img;
      22: Result := FrmMain.WMon23Img;

      49: Result := FrmMain.WMon50Img;
      50: Result := FrmMain.WMon51Img;
      51: Result := FrmMain.WMon52Img;
      52: Result := FrmMain.WMon53Img;
      53: Result := FrmMain.WMon54Img;
      80: Result := g_WDragonImages;
      90: Result := g_WEffectImages;
   end;
   {
   if (appr >= 1000) and FrmMain.GetMonImg(appr,WMImage) then begin
     Result:=WMImage;
   end;
   }
//end;  }
{$ENDREGION}
function GetOffset (appr: integer): integer;
var
   nrace, npos: integer;
begin
Try //程序自动增加
   Result := 0;
   //if (appr >= 1000) then exit;
   nrace := appr div 10;
   npos := appr mod 10;
   case nrace of
      0:    Result := npos * 280;  //8橇贰烙
      1:    Result := npos * 230;
      2,3,7..12:    Result := npos * 360;  //10橇贰烙 扁夯
      4:    begin
               Result := npos * 360;        //
               if npos = 1 then Result := 600;  //厚阜盔面
            end;
      5:    Result := npos * 430;   //
      6:    Result := npos * 440;   //
//      13:   Result := npos * 360;
      13: case npos of
            0: Result:= 0;
            1: Result:= 360;
            2: Result:= 440;
            3: Result:= 550;
            else Result:= npos * 360;
          end;
      14:   Result := npos * 360;
      15:   Result := npos * 360;
      16:   Result := npos * 360;
      17:   case npos of
               2 : Result := 1280;
               else Result := npos * 350;
            end;
      18:   case npos of
               0: Result := 0;   //己巩
               1: Result := 520;
               2: Result := 950;
               4: Result := 1574;
               5: Result := 1934;
               6: Result := 2294;
               7: Result := 2654;
               8: Result := 3014;
            end;
      19:   case npos of
               0: Result := 0;   //己巩
               1: Result := 370;
               2: Result := 810;
               3: Result := 1250;
               4: Result := 1630;
               5: Result := 2010;
               6: Result := 2390;
            end;
      20:   case npos of
               0: Result := 0;   //己巩
               1: Result := 360;
               2: Result := 720;
               3: Result := 1080;
               4: Result := 1440;
               5: Result := 1800;
               6: Result := 2350;
               7: Result := 3060;
            end;
      21:   case npos of
               0: Result := 0;   //己巩
               1: Result := 460;
               2: Result := 820;
               3: Result := 1180;
               4: Result := 1540;
               5: Result := 1900;
//               6: Result := 2260;
               6: Result := 2440;
               7: Result := 2570;
               8: Result := 2700;
            end;
      22:   case npos of
               0: Result := 0;
               1: Result := 430;
               2: Result := 1290;
               3: Result := 1810;
               //4: Result := 1810;
               //5: Result := 1810;
               else Result := npos * 360;
               {6: Result := 2440;
               7: Result := 2570;
               8: Result := 2700; }
            end;
      23:   case npos of
                0: Result:=0;   //340
                1: Result:=680;  //1020
                2: Result:=1180;
                3: Result:=1770;
                4: Result:=2610;
                5: Result:=2950;
                6: Result:=3290;
                7: Result:=3750;
                8: Result:=4460;
                9: Result:=4810;
            end;
      24:  case npos of
                0: Result:=0;   //340
                1: Result:=510;  //1020
                else Result := npos * 350;
            end;
      //49,50,51,52,53: Result := npos * 360;
      80:   case npos of
               0: Result := 0;   //己巩
               1: Result := 80;
               2: Result := 300;
               3: Result := 301;
               4: Result := 302;
               5: Result := 320;
               6: Result := 321;
               7: Result := 322;
               8: Result := 321;
            end;
      90:   case npos of
               0: Result := 80;   //己巩
               1: Result := 168;
               2: Result := 184;
               3: Result := 200;
            end;
      else Result:= npos * 360;
   end;

Except //程序自动增加
  DebugOutStr('[Exception] UnActor.GetOffset'); //程序自动增加
End; //程序自动增加
end;

//npc图片设置

function GetNpcOffset(nAppr:Integer):Integer;
begin
Try //程序自动增加
  Result:=0;
  case nAppr of
    
    {0..34: Result:=nAppr * 60;
    35: Result:=2040;
    36: Result:=2100;
    37..42: Result:=(nAppr - 37) * 60 + 2160;
    43: Result:=2520;
    44: Result:=2580;
    45: Result:=2640;
    46: Result:=2700;
    47: Result:=2760;
    48: Result:=2820;
    49: Result:=2880;
    50: Result:=2940;
    51: Result:=2960; }


    0..22: Result:=nAppr * 60;
    23: Result:=1380;
    24,25: Result:=(nAppr - 24) * 60 + 1470;
    27,32: Result:=(nAppr - 26) * 60 + 1620 - 30;
    26,28,29,30,31,33..41: Result:=(nAppr - 26) * 60 + 1620;
    42,43: Result:=2580;
    44..47: Result:=2640;
    48..50: Result:=(nAppr - 48) * 60 + 2700;
    51: Result:=2880;
    52: Result:=2960;         //雪人
    53: Result:=3020;
    55: Result:=3060;
    56: Result:=3120;
    57: Result:=3180;
    58: Result:=3240;
    59: Result:=3300;
    60: Result:=3360;
    61: Result:=3420;
    62: Result:=3480;
    63: Result:=3540;
    64: Result:=3600;
    65: Result:=3660;
    66: Result:=3720;
    67: Result:=3750;
    68: Result:=3780;
    69: Result:=3810;
    70: Result:=3840;
    71: Result:=3900;
    72: Result:=3960;
    73: Result:=3980;
    74: Result:=4000;
    75: Result:=4030;
    76: Result:=4120;  //前年暖玉NPC




    {69: Result:=3770;
    70: Result:=3780;
    71: Result:=3790;
    72: Result:=3800;
    73: Result:=3810;
    74: Result:=3820;
    75: Result:=3830;}
  end;
Except //程序自动增加
  DebugOutStr('[Exception] UnActor.GetNpcOffset'); //程序自动增加
End; //程序自动增加
end;


constructor TActor.Create;
begin
Try //程序自动增加
  inherited Create;
  FillChar(m_Abil,Sizeof(TAbility), 0);
  FillChar(m_nIconIdx,SizeOf(m_nIconIdx),0);
  //FillChar(m_Action,SizeOf(m_Action),0);
  m_nMoveHpList       := TList.Create;

  m_MsgList           := TGList.Create;
  m_nRecogId          := 0;
  m_BodySurface       := nil;
  m_BodyHorse         := Nil;
  m_BodyHelmet        := Nil;
  m_nGold             := 0;

  m_WineRec.WineValue:= 0;//酒量值
  m_WineRec.Alcoho:= 0;//饮酒量

  m_MedicineRec.MedicineLevel:= 0;//药力等级
  m_MedicineRec.MedicineValue:= 0;//当前药力值
  m_MedicineRec.MaxMedicineValue:=0;//当前等级药力值升级值

  m_SKILL84Rec.SKILL84Level:= 0;//酒气护体等级
  m_SKILL84Rec.SKILL84Exp:= 0;//酒气护体经验
  m_SKILL84Rec.MaxSKILL84Exp:=0;//当前等级酒气护体升级经验

  m_bLiquorProgress:=0; //酒量提升进度值
  m_SKILL83Rec.skill83Level:=0;//先天元力等级
  m_SKILL83Rec.skill83Abil:=0;
  m_SKILL83Rec.MaxWineValue:=0;//当前等级先天元力的最大酒量
  m_boVisible         := TRUE;
  m_boHoldPlace       := TRUE;
  m_dwDelTick         := 0;
  m_boChangeEff       := False;
  m_boIsShop          := False;
  m_sShopMsg          := '';
//  m_Helmet            := 0;
  m_nUserCorpsIdx     := 0;
  m_nHelmet           := 0;

   //泅犁 柳青吝牢 悼累, 辆丰夌绢档 啊瘤绊 乐澜
   //悼累狼 m_nCurrentFrame捞 m_nEndFrame阑 逞菌栏搁 悼累捞 肯丰等巴栏肺 航
  m_nCurrentAction    := 0;
  m_boReverseFrame    := FALSE;
  m_nShiftX           := 0;
  m_nShiftY           := 0;
  m_nDownDrawLevel    := 0;
  m_nCurrentFrame     := -1;
  m_nEffectFrame      := -1;
  RealActionMsg.Ident := 0;
  m_sUserName         := '';
  m_nNameColor        := clWhite;
  m_dwSendQueryUserNameTime  := 0; //GetTickCount;
  m_boWarMode                := FALSE;
  m_dwWarModeTime            := 0;    //War mode
  m_boDeath                  := FALSE;
  m_boSkeleton               := FALSE;
  m_boDelActor               := FALSE;
  m_boDelActionAfterFinished := FALSE;

  m_nChrLight                := 0;
  m_nMagLight                := 0;
  m_boLockEndFrame           := FALSE;
  m_dwSmoothMoveTime         := 0; //GetTickCount;
  m_dwGenAnicountTime        := 0;
  m_dwDefFrameTime           := 0;
  m_dwLoadSurfaceTime        := GetTickCount;
  m_boGrouped                := FALSE;
  m_boOpenHealth             := FALSE;
  m_noInstanceOpenHealth     := FALSE;
  m_CurMagic.ServerMagicCode := 0;
  //CurMagic.MagicSerial := 0;

  m_nSpellFrame              := DEFSPELLFRAME;

  m_nNormalSound             := -1;
  m_nFootStepSound           := -1; //绝澜  //林牢傍牢版快, CM_WALK, CM_RUN
  m_nAttackSound             := -1;
  m_nWeaponSound             := -1;
  m_nStruckSound             := s_struck_body_longstick;  //嘎阑锭 唱绰 家府    SM_STRUCK
  m_nStruckWeaponSound       := -1;
  m_nScreamSound             := -1;
  m_nDieSound                := -1;    //绝澜    //磷阑锭 唱绰 家府    SM_DEATHNOW
  m_nDie2Sound               := -1;

 { m_nCorpsIdx                :=-1;
  m_boCorpsEffFrame          :=-1;
  m_boCorpsEffEnd            :=-1;
  m_boCorpsShow              :=False;
  m_dwCorpsShowTick          :=GetTickCount;}
Except //程序自动增加
  DebugOutStr('[Exception] TActor.Create'); //程序自动增加
End; //程序自动增加
end;

destructor TActor.Destroy;
var
  I: Integer;
  Msg:pTChrMsg;
begin
Try //程序自动增加
  for I := 0 to m_MsgList.Count - 1 do begin
    Msg:=m_MsgList.Items[I];
    Dispose(Msg);
  end;
  m_MsgList.Free;
  for I:=0 to m_nMoveHpList.Count-1 do begin
    Dispose(pTMoveHMShow(m_nMoveHpList.Items[I]));
  end;
  m_nMoveHpList.Free;
  inherited Destroy;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.Destroy'); //程序自动增加
End; //程序自动增加
end;
procedure  TActor.SendMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
var
  Msg:pTChrMsg;
begin
Try //程序自动增加
  New(Msg);
  Msg.ident   := wIdent;
  Msg.x       := nX;
  Msg.y       := nY;
  Msg.dir     := ndir;
  Msg.feature := nFeature;
  Msg.state   := nState;
  Msg.saying  := sStr;
  Msg.Sound   := nSound;
  m_MsgList.Lock;
  try
    m_MsgList.Add(Msg);
  finally
    m_MsgList.UnLock;
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.SendMsg'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
var
  I: integer;
  Msg:pTChrMsg;
begin
Try //程序自动增加
  m_MsgList.Lock;
  try
    I:= 0;
    while TRUE do begin
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I];
      if ((Self = g_MySelf) and (Msg.Ident >= 3000) and (Msg.Ident <= 3099)) or (Msg.Ident = wIdent) then begin
        Dispose(Msg);
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendMsg (wIdent,nX,nY,nDir,nFeature,nState,sStr,nSound);
Except //程序自动增加
  DebugOutStr('[Exception] TActor.UpdateMsg'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.CleanUserMsgs;
var
  I:Integer;
  Msg:pTChrMsg;
begin
Try //程序自动增加
  m_MsgList.Lock;
  try
    I:= 0;
    while TRUE do begin
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I];
      if (Msg.Ident >= 3000) and //努扼捞攫飘俊辑 焊辰 皋技瘤绰
         (Msg.Ident <= 3099) then begin
        Dispose(Msg);
        m_MsgList.Delete (I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CleanUserMsgs'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.CalcActorFrame;
var
  haircount: integer;
begin
Try //程序自动增加
  m_boUseMagic    := FALSE;
  m_nCurrentFrame := -1;

  m_nBodyOffset   := GetOffset (m_wAppearance);
  m_Action := GetRaceByPM(m_btRace,m_wAppearance);
  if m_Action = nil then exit;

   case m_nCurrentAction of
      SM_TURN:
         begin
            m_nStartFrame := m_Action.ActStand.start + m_btDir * (m_Action.ActStand.frame + m_Action.ActStand.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStand.frame - 1;
            m_dwFrameTime := m_Action.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := m_Action.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK, SM_RUSH, SM_RUSHKUNG, SM_BACKSTEP:
         begin
            m_nStartFrame := m_Action.ActWalk.start + m_btDir * (m_Action.ActWalk.frame + m_Action.ActWalk.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActWalk.frame - 1;
            m_dwFrameTime := m_Action.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := m_Action.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            if m_nCurrentAction = SM_BACKSTEP then
               Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
            else
               Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      {SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
            m_dwFrameTime := pm.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := pm.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
         end;}
      SM_HIT:
         begin
            m_nStartFrame := m_Action.ActAttack.start + m_btDir * (m_Action.ActAttack.frame + m_Action.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActAttack.frame - 1;
            m_dwFrameTime := m_Action.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            m_nStartFrame := m_Action.ActStruck.start + m_btDir * (m_Action.ActStruck.frame + m_Action.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_DEATH:
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_nStartFrame := m_nEndFrame; //
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_SKELETON:
         begin
            m_nStartFrame := m_Action.ActDeath.start + m_btDir;
            m_nEndFrame := m_nStartFrame + m_Action.ActDeath.frame - 1;
            m_dwFrameTime := m_Action.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_SPELL:
         begin
            m_nStartFrame := m_Action.ActAttack.start + m_btDir * (m_Action.ActAttack.frame + m_Action.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActAttack.frame - 1;
            m_dwFrameTime := m_Action.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            m_nCurEffFrame := 0;
            m_boUseMagic := TRUE;
            m_nMagLight := 2;
            m_nSpellFrame := 10;
            if  m_CurMagic.EffectNumber=100 then  m_nSpellFrame := 5;
            m_dwWaitMagicRequest := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CalcActorFrame'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.ReadyAction (msg: TChrMsg);
var
   n: integer;
   UseMagic: PTUseMagicInfo;
begin
Try //程序自动增加
   m_nActBeforeX := m_nCurrX;
   m_nActBeforeY := m_nCurrY;

   if msg.Ident = SM_ALIVE then begin
      m_boDeath := FALSE;
      m_boSkeleton := FALSE;
   end;
   if (not m_boDeath) and (msg.Ident<>SM_MAGICFIRE) and (msg.Ident<>SM_MAGICFIRE_FAIL) then begin
      case msg.Ident of
         SM_TURN, SM_WALK, SM_BACKSTEP, SM_RUSH, SM_RUSHKUNG, SM_RUN, SM_HORSERUN, SM_DIGUP, SM_ALIVE:
            begin
               m_nFeature := msg.feature;
               m_nState := msg.state;

               //某腐磐狼 何啊利牢 惑怕 钎矫
               if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := TRUE
               else m_boOpenHealth := FALSE;

            end;
      end;
      if msg.ident = SM_LIGHTING then
         n := 0;
      if g_MySelf = self then begin
         if (msg.Ident = CM_WALK) then
            if not PlayScene.CanWalk (msg.x, msg.y) then
               exit;  //捞悼 阂啊
         if (msg.Ident = CM_RUN) then
            if not PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
               exit; //捞悼 阂啊
         if (msg.Ident = CM_HORSERUN) then
            if not PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
               exit; //捞悼 阂啊

         //msg
         case msg.Ident of
            CM_TURN,
            CM_WALK,
            CM_SITDOWN,
            CM_RUN,
            CM_HIT,
            CM_HEAVYHIT,
            CM_BIGHIT,
            CM_POWERHIT,
            CM_LONGHIT,
            CM_WIDEHIT:
               begin
                  if (msg.Ident-3000) in [SM_HIT..SM_WIDEHIT] then begin
                    if (g_WgInfo.boAttackEffect) then begin
                      if g_WgInfo.boAttackEffectCls then msg.Ident:=CM_FIREHIT
                      else msg.Ident:=CM_WIDEHIT;
                    end else
                    //战士打开内挂的刀刀刺杀后打不出攻杀
                    {if (g_WgInfo.boCanLongHit) and
                       (g_MyMagic[12]<>NIl) and
                       (g_boCanLongHit) then begin
                      msg.Ident:=CM_LONGHIT;
                    end; }
                    if (g_WgInfo.boCanWideHit) and
                       (g_MyMagic[25]<>nil) and
                       (g_boCanWideHitCount>0) and
                       (g_MySelf.m_Abil.MP >= 3) then begin
                      msg.Ident:=CM_WIDEHIT;
                    end;
                    if (g_WgInfo.boCanCrsHit) and
                       (g_MyMagic[40]<>nil) and
                       (g_boCanWideHitCount>1) and
                       (g_MySelf.m_Abil.MP >= 3) then begin
                      msg.Ident:=CM_CRSHIT;
                    end;
                  end;
                  RealActionMsg := msg;
                  if msg.Ident=CM_FIREHIT then msg.Ident :=SM_FIREHIT
                  else if msg.Ident=CM_CRSHIT then msg.Ident :=SM_CRSHIT
                  else msg.Ident := msg.Ident - 3000;
               end;
            CM_HORSERUN: begin
              RealActionMsg:=msg;
              msg.Ident:=SM_HORSERUN;
            end;
            CM_THROW: begin
              if m_nFeature <> 0 then begin
                m_nTargetX := TActor(msg.feature).m_nCurrX;
                m_nTargetY := TActor(msg.feature).m_nCurrY;
                m_nTargetRecog := TActor(msg.feature).m_nRecogId;
              end;
              RealActionMsg := msg;
              msg.Ident := SM_THROW;
            end;
            CM_FIREHIT: begin
              RealActionMsg := msg;
              msg.Ident := SM_FIREHIT;
            end;
            CM_CRSHIT: begin
              RealActionMsg := msg;
              msg.Ident := SM_CRSHIT;
            end;
            CM_TWINHIT: begin
              RealActionMsg := msg;
              msg.Ident := SM_TWINHIT;
            end;
            CM_LONGSWORD1: begin
              RealActionMsg := msg;
              msg.Ident := SM_LONGSWORD1;
            end;
            CM_LONGSWORD2: begin
              RealActionMsg := msg;
              msg.Ident := SM_LONGSWORD2;
            end;
            CM_LONGFIRESWORD: begin
              RealActionMsg := msg;
              msg.Ident := SM_LONGFIREHIT;
            end;
            CM_3037: begin
              RealActionMsg := msg;
              msg.Ident := SM_41;
            end;
            CM_SPELL: begin
                  RealActionMsg := msg;
                  UseMagic := PTUseMagicInfo (msg.feature);
                  RealActionMsg.Dir := UseMagic.MagicSerial;
                  msg.Ident := msg.Ident - 3000;  //SM_?? 栏肺 函券 窃
            end;
         end;

         m_nOldx := m_nCurrX;
         m_nOldy := m_nCurrY;
         m_nOldDir := m_btDir;
      end;
      case msg.Ident of
         SM_STRUCK:
            begin
               //Abil.HP := msg.x; {HP}
               //Abil.MaxHP := msg.y; {maxHP}
               //msg.dir {damage}
               //饭骇捞 臭栏搁 嘎绰 矫埃捞 陋促.
               m_nMagicStruckSound := msg.x; //1捞惑, 付过瓤苞
               n := Round (200 - m_Abil.Level * 5);
               if n > 80 then m_dwStruckFrameTime := n
               else m_dwStruckFrameTime := 80;
               m_dwLastStruckTime := GetTickCount;
            end;
         SM_SPELL:
            begin
               m_btDir := msg.dir;
               //msg.x  :targetx
               //msg.y  :targety
               UseMagic := PTUseMagicInfo (msg.feature);
               if UseMagic <> nil then begin
                  m_CurMagic := UseMagic^;
                  m_CurMagic.ServerMagicCode := -1; //FIRE 措扁
                  //CurMagic.MagicSerial := 0;
                  m_CurMagic.TargX := msg.x;
                  m_CurMagic.TargY := msg.y;
                  Dispose (UseMagic);
                  //DScreen.AddSysMsg ('SM_SPELL  ');
               end;

            end;
         else begin
               if (msg.X<>0) and (msg.Y <> 0) then begin
                 m_nCurrX := msg.x;
                 m_nCurrY := msg.y;
                 m_btDir := msg.dir;
               end;
            end;
      end;

      m_nCurrentAction := msg.Ident;
      CalcActorFrame;
      //DScreen.AddSysMsg (IntToStr(msg.Ident) + ' ' + IntToStr(XX) + ' ' + IntToStr(YY) + ' : ' + IntToStr(msg.x) + ' ' + IntToStr(msg.y));
   end else begin
      if msg.Ident = SM_SKELETON then begin
         m_nCurrentAction := msg.Ident;
         CalcActorFrame;
         m_boSkeleton := TRUE;
      end;
   end;
   if (msg.Ident = SM_DEATH) or (msg.Ident = SM_NOWDEATH) then begin
      m_boDeath := TRUE;
      PlayScene.ActorDied (self);
   end;

   RunSound;

Except //程序自动增加
  DebugOutStr('[Exception] TActor.ReadyAction'); //程序自动增加
End; //程序自动增加
end;


function TActor.GetMessage(ChrMsg:pTChrMsg): Boolean;
var
  Msg:pTChrMsg;
begin
Try //程序自动增加
  Result:=False;
  m_MsgList.Lock;
  try
    if m_MsgList.Count > 0 then begin
      Msg:=m_MsgList.Items[0];
      ChrMsg.Ident:=Msg.Ident;
      ChrMsg.X:=Msg.X;
      ChrMsg.Y:=Msg.Y;
      ChrMsg.Dir:=Msg.Dir;
      ChrMsg.State:=Msg.State;
      ChrMsg.feature:=Msg.feature;
      ChrMsg.saying:=Msg.saying;
      ChrMsg.Sound:=Msg.Sound;
      Dispose(Msg);
      m_MsgList.Delete(0);
      Result:=True;
    end;
  finally
    m_MsgList.UnLock;
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.GetMessage'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.ProcMsg;
var
  Msg:TChrMsg;
  Meff:TMagicEff;
  Idx:integer;
begin
Try //程序自动增加
   while (m_nCurrentAction = 0) and GetMessage(@Msg) do begin
      case Msg.ident of
         SM_STRUCK: begin
           m_nHiterCode := msg.Sound;
           ReadyAction (msg);
         end;
         SM_DEATH,  //27
         SM_NOWDEATH,
         SM_SKELETON,
         SM_ALIVE,
         SM_ACTION_MIN..SM_ACTION_MAX,  //26
         SM_ACTION2_MIN..SM_ACTION2_MAX,//35   2293    293
         3000..3099: ReadyAction (msg);
         SM_SPACEMOVE_HIDE: begin
           meff := TScrollHideEffect.Create (250, 10, m_nCurrX, m_nCurrY, self);
           PlayScene.m_EffectList.Add (meff);
           PlaySound (s_spacemove_out);
         end;
         SM_SPACEMOVE_HIDE2: begin
           meff := TScrollHideEffect.Create (1590, 10, m_nCurrX, m_nCurrY, self);
           PlayScene.m_EffectList.Add (meff);
           PlaySound (s_spacemove_out);
         end;
         SM_SPACEMOVE_SHOW: begin
           meff := TCharEffect.Create (260, 10, self);
           PlayScene.m_EffectList.Add (meff);
           msg.ident := SM_TURN;
           ReadyAction (msg);
           PlaySound (s_spacemove_in);
         end;
         SM_SPACEMOVE_SHOW2: begin
           meff := TCharEffect.Create (1600, 10, self);
           PlayScene.m_EffectList.Add (meff);
           msg.ident := SM_TURN;
           ReadyAction (msg);
           PlaySound (s_spacemove_in);
         end;
         SM_896: begin
            meff :=TNormalDrawEffect.Create(msg.X,msg.Y,g_WEffectImages,810,10,120,True);
            PlayScene.m_EffectList.Add(meff);
            PlaySoundEx(bmg_HeroLogout);
         end;
         SM_SKILL53:
         begin
              meff := TCorpsDrawEffect.Create(Self,g_WMagic2Images,1090,10,120,True);
              PlayScene.m_EffectList.Add(meff);
         end;
         SM_DRINK,SM_HeroDRINK: //唱酒动画
         begin
           meff := TCorpsDrawEffect.Create(Self,g_WMain2Images,630,10,120,True);
             PlayScene.m_EffectList.Add(meff);
           // PlaySoundEx(bmg_HeroLogout);
         end;
         SM_DRUNK,SM_HeroDRUNK : //喝醉酒消息
         begin
            meff := TCorpsDrawEffect.Create(Self,g_WMain2Images,650,20,320,True);
            PlayScene.m_EffectList.Add(meff);
           // PlaySoundEx(bmg_HeroLogout);
         end;
         SM_ADDLiquor,SM_HeroADDLiquor: //酒量提升消息
         begin
            meff := TCorpsDrawEffect.Create(Self,g_WMain2Images,640,10,120,True);
            PlayScene.m_EffectList.Add(meff);
           // PlaySoundEx(bmg_HeroLogout);
         end;
         SM_897: begin
            meff :=TNormalDrawEffect.Create(msg.X,msg.Y,g_WEffectImages,800,10,120,True);
            PlayScene.m_EffectList.Add(meff);
            PlaySoundEx(bmg_HeroLogin);
         end;
         SM_SHOWEFFECT:begin
            idx:=msg.X-75;
            case msg.X of
              Effect_76: begin
                if g_WMagic3Images <> nil then begin
                meff := TCorpsDrawEffect.Create(Self,g_WMagic3Images,20,10,120,True);
                PlayScene.m_EffectList.Add(meff);
                end;
              end;
              Effect_77: begin
                if g_WMagic3Images <> nil then begin
                meff := TCorpsDrawEffect.Create(Self,g_WMagic3Images,40,10,120,True);
                PlayScene.m_EffectList.Add(meff);
                end;
              end;
              Effect_78..Effect_84: begin
                meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic3Images,idx*20,20,120,True);
                PlayScene.m_EffectList.Add(meff);
                PlaySoundEx(bmg_newysound);
              end;
              Effect_85: begin
                if g_WMain2Images <> nil then begin
                  meff := TCorpsDrawEffect.Create(Self,g_WMain2Images,110,15,120,True);
                  PlayScene.m_EffectList.Add(meff);
                  PlaySoundEx(bmg_powerup);
                end;
              end;
              Effect_86: begin
                if g_WMain2Images <> nil then begin
                  meff := TCorpsDrawEffect.Create(Self,g_WMain2Images,30,25,120,True);
                  PlayScene.m_EffectList.Add(meff);
                  PlaySoundEx(bmg_powerup);
                end;
              end;
              Effect_87: begin
                if g_WMagic5Images <> nil then begin
                  meff := TCorpsDrawEffect.Create(Self,g_WMagic5Images,790,10,120,True);
                  PlayScene.m_EffectList.Add(meff);
                  PlaySoundEx(bmg_heroshield);
                end;
              end;
              Effect_88: begin
                if g_WMagic5Images <> nil then begin
                  meff := TCorpsDrawEffect.Create(Self,g_WMagic6Images,480,10,120,True);
                  PlayScene.m_EffectList.Add(meff);
                  PlaySoundEx(bmg_heroshield);
                end;
              end;
              Effect_89: begin
                if g_WMagic5Images <> nil then begin
                  meff := TCorpsDrawEffect.Create(Self,g_WMagic6Images,470,5,120,True);
                  PlayScene.m_EffectList.Add(meff);
                  PlaySoundEx(bmg_heroshield);
                end;
              end;
              Effect_100: begin  //站在泉水上领泉水动画
                if g_WMain2Images <> nil then begin
                  meff := TCorpsDrawEffect.Create(Self,g_WMain2Images,670,20,120,True);
                  PlayScene.m_EffectList.Add(meff);
               //   PlaySound(s_click_drug);
                end;
              end;
              Effect_THUNDER: begin
                if g_WDragonImages <> nil then begin
                  meff :=TNormalDrawEffect.Create(Msg.Y,Msg.Dir,g_WDragonImages,420,10,80,True);
                  PlayScene.m_EffectList.Add(meff);
                  PlaySoundEx(bmg_skill_11);
                end;
              end;
              Effect_LAVA: begin
                if g_WDragonImages <> nil then begin
                  meff :=TNormalDrawEffect.Create(Msg.Y,Msg.Dir,g_WDragonImages,470,10,80,True);
                  PlayScene.m_EffectList.Add(meff);
                  PlaySoundEx(bmg_LAVA);
                end;
              end;
              else begin
                if g_WMagic3Images <> nil then begin
                meff := TCorpsDrawEffect.Create(Self,g_WMagic3Images,0,14,120,True);
                PlayScene.m_EffectList.Add(meff);
                end;
              end;
            end;
            //m_boCorpsEffFrame         :=0;
        end;
         else
            begin
               ReadyAction (msg); //Damian
            end;
      end;
   end;

Except //程序自动增加
  DebugOutStr('[Exception] TActor.ProcMsg'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.ProcHurryMsg; //弧府 贸府秦具 登绰 皋技瘤 贸府窃..
var
   n: integer;
   msg: TChrMsg;
   fin: Boolean;
begin
Try //程序自动增加
   n := 0;
   while TRUE do begin
      if m_MsgList.Count <= n then break;
      msg := PTChrMsg (m_MsgList.Items[n])^;
      fin := FALSE;
      case msg.Ident of
         SM_MAGICFIRE:
            if m_CurMagic.ServerMagicCode <> 0 then begin
               m_CurMagic.ServerMagicCode := 111;
               m_CurMagic.Target := msg.x;
               if msg.y in [0..MAXMAGICTYPE-1] then
                  m_CurMagic.EffectType := TMagicType(msg.y); //EffectType
               m_CurMagic.EffectNumber := msg.dir; //Effect
               m_CurMagic.TargX := msg.feature;
               m_CurMagic.TargY := msg.state;
               m_CurMagic.Recusion2 := TRUE;
               fin := TRUE;
            end;
         SM_MAGICFIRE_FAIL: begin
            if m_CurMagic.ServerMagicCode <> 0 then begin
               m_CurMagic.ServerMagicCode := 0;
               fin := TRUE;
            end;
         end;
      end;
      if fin then begin
         Dispose (PTChrMsg (m_MsgList.Items[n]));
         m_MsgList.Delete (n);
      end else
         Inc (n);
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.ProcHurryMsg'); //程序自动增加
End; //程序自动增加
end;

function  TActor.IsIdle: Boolean;
begin
Try //程序自动增加
   if (m_nCurrentAction = 0) and (m_MsgList.Count = 0) then
      Result := TRUE
   else Result := FALSE;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.IsIdle:'); //程序自动增加
End; //程序自动增加
end;

function  TActor.ActionFinished: Boolean;
begin
Try //程序自动增加
   if (m_nCurrentAction = 0) or (m_nCurrentFrame >= m_nEndFrame) then
      Result := TRUE
   else Result := FALSE;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.ActionFinished:'); //程序自动增加
End; //程序自动增加
end;

function  TActor.CanWalk: Integer;
begin
Try //程序自动增加
   //掘绢 嘎篮 促澜俊 吧阑 荐 绝促. or 付过 掉贰捞
   if {(GetTickCount - LastStruckTime < 1300) or}(GetTickCount - g_dwLatestSpellTick < g_dwMagicPKDelayTime) then
      Result := -1   //掉饭捞
   else
      Result := 1;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CanWalk:'); //程序自动增加
End; //程序自动增加
end;

function  TActor.CanRun: Integer;
begin
Try //程序自动增加
   Result := 1;
   //检查人物的HP值是否低于指定值，低于指定值将不允许跑
   if m_Abil.HP < RUN_MINHEALTH then begin
      Result := -1;
   end else
   //检查人物是否被攻击，如果被攻击将不允许跑，取消检测将可以跑步逃跑
//   if (GetTickCount - LastStruckTime < 3*1000) or (GetTickCount - LatestSpellTime < MagicPKDelayTime) then
//      Result := -2;

Except //程序自动增加
  DebugOutStr('[Exception] TActor.CanRun:'); //程序自动增加
End; //程序自动增加
end;

function  TActor.Strucked: Boolean;
var
   i: integer;
begin
Try //程序自动增加
   Result := FALSE;
   for i:=0 to m_MsgList.Count-1 do begin
      if PTChrMsg (m_MsgList[i]).Ident = SM_STRUCK then begin
         Result := TRUE;
         break;
      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.Strucked:'); //程序自动增加
End; //程序自动增加
end;


//dir : 规氢
//step : 捞悼 沫
//cur : 泅犁 胶跑
//max : 弥措 胶跑
procedure TActor.Shift (dir, step, cur, max: integer);
var
   unx, uny, ss, v: integer;
begin
Try //程序自动增加
   unx := UNITX * step;
   uny := UNITY * step;
   if cur > max then cur := max;
   m_nRx := m_nCurrX;
   m_nRy := m_nCurrY;
   ss := Round((max-cur-1) / max) * step;
   case dir of
      DR_UP: begin
        ss := Round((max-cur) / max) * step;
        m_nShiftX := 0;
        m_nRy := m_nCurrY + ss;
        if ss = step then m_nShiftY := -Round(uny / max * cur)
        else m_nShiftY := Round(uny / max * (max-cur));
      end;
      DR_UPRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            m_nRx := m_nCurrX - ss;
            m_nRy := m_nCurrY + ss;
            if ss = step then begin
               m_nShiftX:=  Round(unx / max * cur);
               m_nShiftY:= -Round(uny / max * cur);
            end else begin
               m_nShiftX:= -Round(unx / max * (max-cur));
               m_nShiftY:=  Round(uny / max * (max-cur));
            end;
         end;
      DR_RIGHT:
         begin
            ss := Round((max-cur) / max) * step;
            m_nRx := m_nCurrX - ss;
            if ss = step then m_nShiftX := Round(unx / max * cur)
            else m_nShiftX := -Round(unx / max * (max-cur));
            m_nShiftY := 0;
         end;
      DR_DOWNRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nRx := m_nCurrX - ss;
            m_nRy := m_nCurrY - ss;
            if ss = step then begin
               m_nShiftX:= Round(unx / max * cur);
               m_nShiftY:= Round(uny / max * cur);
            end else begin
               m_nShiftX:= -Round(unx / max * (max-cur));
               m_nShiftY:= -Round(uny / max * (max-cur));
            end;
         end;
      DR_DOWN:
         begin
            if max >= 6 then v := 1
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nShiftX := 0;
            m_nRy := m_nCurrY - ss;
            if ss = step then m_nShiftY := Round(uny / max * cur)
            else m_nShiftY := -Round(uny / max * (max-cur));
         end;
      DR_DOWNLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nRx := m_nCurrX + ss;
            m_nRy := m_nCurrY - ss;
            if ss = step then begin
               m_nShiftX := -Round(unx / max * cur);
               m_nShiftY :=  Round(uny / max * cur);
            end else begin
               m_nShiftX :=  Round(unx / max * (max-cur));
               m_nShiftY := -Round(uny / max * (max-cur));
            end;
         end;
      DR_LEFT:
         begin
            ss := Round((max-cur) / max) * step;
            m_nRx := m_nCurrX + ss;
            if ss = step then m_nShiftX := -Round(unx / max * cur)
            else m_nShiftX := Round(unx / max * (max-cur));
            m_nShiftY := 0;
         end;
      DR_UPLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            m_nRx := m_nCurrX + ss;
            m_nRy := m_nCurrY + ss;
            if ss = step then begin
               m_nShiftX := -Round(unx / max * cur);
               m_nShiftY := -Round(uny / max * cur);
            end else begin
               m_nShiftX := Round(unx / max * (max-cur));
               m_nShiftY := Round(uny / max * (max-cur));
            end;
         end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.Shift'); //程序自动增加
End; //程序自动增加
end;

procedure  TActor.FeatureChanged;
var
   haircount: integer;
begin
Try //程序自动增加
   case m_btRace of
      //human
      0: begin
         m_btHair   := HAIRfeature (m_nFeature);         //函版等促.
         m_btDress  := DRESSfeature (m_nFeature);
         m_btWeapon := WEAPONfeature (m_nFeature);

         m_btHorse  := Horsefeature(m_nFeatureEx);
         m_btEffect := Effectfeature(m_nFeatureEx);
         m_nBodyOffset := HUMANFRAME * m_btDress; //巢磊0, 咯磊1

         m_nHairOffset := HUMANFRAME * m_btHair;

         m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);

        if m_nRecogId=g_HeronRecogId then g_HerobtHair:=m_btHair;
        if m_btEffect <> 0 then begin
          if m_btEffect = 50 then m_nHumWinOffset:=352
          else m_nHumWinOffset:=(m_btEffect - 1) * HUMANFRAME;
        end;
      end;
      50: ;  //npc
      else begin
         m_wAppearance := APPRfeature (m_nFeature);
         m_nBodyOffset := GetOffset (m_wAppearance);
         //BodyOffset := MONFRAME * (Appearance mod 10);
      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.FeatureChanged'); //程序自动增加
End; //程序自动增加
end;

function   TActor.Light: integer;
begin
Try //程序自动增加
   Result := m_nChrLight;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.Light:'); //程序自动增加
End; //程序自动增加
end;

procedure  TActor.LoadSurface;
var
   mimg: TWMImages;
begin
Try //程序自动增加
   mimg := GetMonImg (m_wAppearance);
   if mimg <> nil then begin
      if (not m_boReverseFrame) then
         m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame, m_nPx, m_nPy)
      else
         m_BodySurface := mimg.GetCachedImage (
                            GetOffset (m_wAppearance) + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame),
                            m_nPx, m_nPy);
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.LoadSurface'); //程序自动增加
End; //程序自动增加
end;

function  TActor.CharWidth: Integer;
begin
Try //程序自动增加
   if m_BodySurface <> nil then
      Result := m_BodySurface.Width
   else Result := 48;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CharWidth:'); //程序自动增加
End; //程序自动增加
end;

function  TActor.CharHeight: Integer;
begin
Try //程序自动增加
   if m_BodySurface <> nil then
      Result := m_BodySurface.Height
   else Result := 70;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CharHeight:'); //程序自动增加
End; //程序自动增加
end;

function  TActor.CheckSelect (dx, dy: integer): Boolean;
var
  c:Integer;
begin
Try //程序自动增加
  Result := FALSE;
  if m_BodySurface <> nil then begin
    c := m_BodySurface.Pixels[dx, dy];
    if (c <> 0) and
       ((m_BodySurface.Pixels[dx-1, dy] <> 0) and
       (m_BodySurface.Pixels[dx+1, dy] <> 0) and
       (m_BodySurface.Pixels[dx, dy-1] <> 0) and
       (m_BodySurface.Pixels[dx, dy+1] <> 0)) then
     Result := TRUE;
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CheckSelect'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
begin
Try //程序自动增加
   if m_nState and $00800000 <> 0 then begin
      blend := TRUE;  //隐身
   end;
   if not Blend then begin
      if ceff = ceNone then begin
         if source <> nil then
            dsurface.Draw (ddx, ddy, source.ClientRect, source, TRUE);
      end else begin
         if source <> nil then begin
            g_ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
            DrawEffect (0, 0, source.Width, source.Height, g_ImgMixSurface, ceff);
            dsurface.Draw (ddx, ddy, source.ClientRect, g_ImgMixSurface, TRUE);
         end;
      end;
   end else begin
      if ceff = ceNone then begin
         if source <> nil then
            DrawBlend (dsurface, ddx, ddy, source, 0);
      end else begin
         if source <> nil then begin
            g_ImgMixSurface.Fill(0);
            g_ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
            DrawEffect (0, 0, source.Width, source.Height, g_ImgMixSurface, ceff);
            DrawBlend (dsurface, ddx, ddy, g_ImgMixSurface, 0);
         end;
      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.DrawEffSurface'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
begin
Try //程序自动增加
   //荤侩救窃..(堪拳搬) 弊贰侨 坷幅...
   (*if BoNextTimeFireHit and WarMode and GlimmingMode then begin
      if GetTickCount - GlimmerTime > 200 then begin
         GlimmerTime := GetTickCount;
         Inc (CurGlimmer);
         if CurGlimmer >= MaxGlimmer then CurGlimmer := 0;
      end;
      idx := GetEffectBase (5-1{堪拳搬馆娄烙}, 1) + Dir*10 + CurGlimmer;
      d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface, ddx + ax, ddy + ay, d, 1);
                          //dx + ax + ShiftX,
                          //dy + ay + ShiftY,
                          //d, 1);
   end;*)
Except //程序自动增加
  DebugOutStr('[Exception] TActor.DrawWeaponGlimmer'); //程序自动增加
End; //程序自动增加
end;
//人物显示颜色，中毒
function TActor.GetDrawEffectValue: TColorEffect;
var
   ceff: TColorEffect;
begin
Try //程序自动增加
   ceff := ceNone;
   if (g_FocusCret = self) or (g_MagicTarget = self) then begin
      ceff := ceBright;
   end;
   if m_nState and $80000000 <> 0 then begin
      ceff := ceGreen;
   end;
   if m_nState and $40000000 <> 0 then begin
      ceff := ceRed;
   end;
   if m_nState and $20000000 <> 0 then begin
      ceff := ceBlue;
   end;
   if m_nState and $10000000 <> 0 then begin
      ceff := ceYellow;
   end;
   if m_nState and $08000000 <> 0 then begin
      ceff := ceFuchsia;
   end;
   if m_nState and $04000000 <> 0 then begin
      ceff := ceGrayScale;  //麻痹效果
   end;
   Result := ceff;
   //if self=g_MySelf then
   //DScreen.AddChatBoardString (IntToStr(Integer(Result)),0,255);
   if (m_boChangeEff) and
      (g_WgInfo.boCropsChangeColor) and
      (g_WgInfo.nCropsColorEff in [1..9]) then
    Result:=TColorEffect(g_WgInfo.nCropsColorEff);
Except //程序自动增加
  DebugOutStr('[Exception] TActor.GetDrawEffectValue:'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
   I:Integer;
   II:integer;
   MoveShow:pTMoveHMShow;
begin
Try //程序自动增加
   d:=nil;//jacky
   //Dscreen.AddSysMsg ('TActor '+m_sUserName);
   if not (m_btDir in [0..7]) then exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurface殿捞 loadsurface甫 促矫 何福瘤 臼酒 皋葛府啊 橇府登绰 巴阑 阜澜
   end;

   ceff := GetDrawEffectValue;

   if m_BodySurface <> nil then begin
      DrawEffSurface (dsurface,
                      m_BodySurface,
                      dx + m_nPx + m_nShiftX,
                      dy + m_nPy + m_nShiftY,
                      blend,
                      ceff);
   end;

   if m_boUseMagic {and (EffDir[Dir] = 1)} and (m_CurMagic.EffectNumber > 0) then
      if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
         GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx);
         //Dscreen.AddSysMsg (inttoStr(m_CurMagic.EffectNumber));
         idx := idx + m_nCurEffFrame;
         if wimg <> nil then
            d := wimg.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
      end;

Except //程序自动增加
  DebugOutStr('[Exception] TActor.DrawChr'); //程序自动增加
End; //程序自动增加
end;

procedure  TActor.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
Try //程序自动增加
Except //程序自动增加
  DebugOutStr('[Exception] TActor.DrawEff'); //程序自动增加
End; //程序自动增加
end;


function  TActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
Try //程序自动增加
   Result:=0;//Jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   if m_boDeath then begin
      if m_boSkeleton then
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.GetDefaultFrame'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.DefaultMotion;   //悼累 绝澜,  扁夯 磊技..
begin
Try //程序自动增加
   m_boReverseFrame := FALSE;
   if m_boWarMode then begin
      if (GetTickCount - m_dwWarModeTime > 4*1000) then //and not BoNextTimeFireHit then
         m_boWarMode := FALSE;
   end;
   m_nCurrentFrame := GetDefaultFrame (m_boWarMode);
   Shift (m_btDir, 0, 1, 1);
Except //程序自动增加
  DebugOutStr('[Exception] TActor.DefaultMotion'); //程序自动增加
End; //程序自动增加
end;

//人物动作声音(脚步声、武器攻击声)
procedure TActor.SetSound;
var
   cx, cy, bidx, wunit, attackweapon: integer;
   hiter: TActor;
begin
Try //程序自动增加
   if m_btRace = 0 then begin
      if (self = g_MySelf) and
         ((m_nCurrentAction=SM_WALK) or
          (m_nCurrentAction=SM_BACKSTEP) or
          (m_nCurrentAction=SM_RUN) or
          (m_nCurrentAction=SM_HORSERUN) or
          (m_nCurrentAction=SM_RUSH) or
          (m_nCurrentAction=SM_RUSHKUNG)
         )
      then begin
         cx := g_MySelf.m_nCurrX - Map.m_nBlockLeft;
         cy := g_MySelf.m_nCurrY - Map.m_nBlockTop;
         cx := cx div 2 * 2;
         cy := cy div 2 * 2;
         bidx := Map.m_MArr[cx, cy].wBkImg and $7FFF;
         wunit := Map.m_MArr[cx, cy].btArea;
         bidx := wunit * 10000 + bidx - 1;
         case bidx of
            //陋篮 钱
            330..349, 450..454, 550..554, 750..754,
            950..954, 1250..1254, 1400..1424, 1455..1474,
            1500..1524, 1550..1574:
               m_nFootStepSound := s_walk_lawn_l;

            //吝埃钱

            //变 钱
            250..254, 1005..1009, 1050..1054, 1060..1064, 1450..1454,
            1650..1654:
               m_nFootStepSound := s_walk_rough_l;

            //倒 辨
            //措府籍 官蹿
            605..609, 650..654, 660..664, 2000..2049,
            3025..3049, 2400..2424, 4625..4649, 4675..4678:
               m_nFootStepSound := s_walk_stone_l;

            //悼奔救
            1825..1924, 2150..2174, 3075..3099, 3325..3349,
            3375..3399:
               m_nFootStepSound := s_walk_cave_l;

            //唱公官蹿
           3230, 3231, 3246, 3277:
               m_nFootStepSound := s_walk_wood_l;

           //带傈..
           3780..3799:
               m_nFootStepSound := s_walk_wood_l;

           3825..4434:
               if (bidx-3825) mod 25 = 0 then m_nFootStepSound := s_walk_wood_l
               else m_nFootStepSound := s_walk_ground_l;


            //笼救(家府 喊风 救巢)
             2075..2099, 2125..2149:
               m_nFootStepSound := s_walk_room_l;

            //俺匡
            1800..1824:
               m_nFootStepSound := s_walk_water_l;

            else
               m_nFootStepSound := s_walk_ground_l;
         end;
         //泵傈郴何
         if (bidx >= 825) and (bidx <= 1349) then begin
            if ((bidx-825) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_stone_l;
         end;
         //悼奔郴何
         if (bidx >= 1375) and (bidx <= 1799) then begin
            if ((bidx-1375) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_cave_l;
         end;
         case bidx of
            1385, 1386, 1391, 1392:
               m_nFootStepSound := s_walk_wood_l;
         end;

         bidx := Map.m_MArr[cx, cy].wMidImg and $7FFF;
         bidx := bidx - 1;
         case bidx of
            0..115:
               m_nFootStepSound := s_walk_ground_l;
            120..124:
               m_nFootStepSound := s_walk_lawn_l;
         end;

         bidx := Map.m_MArr[cx, cy].wFrImg and $7FFF;
         bidx := bidx - 1;
         case bidx of
            //寒倒辨
            221..289, 583..658, 1183..1206, 7163..7295,
            7404..7414:
               m_nFootStepSound := s_walk_stone_l;
            //唱公付风
            3125..3267, {3319..3345, 3376..3433,} 3757..3948,
            6030..6999:
               m_nFootStepSound := s_walk_wood_l;
            //规官蹿
            3316..3589:
               m_nFootStepSound := s_walk_room_l;
         end;
         if (m_nCurrentAction = SM_RUN) or (m_nCurrentAction = SM_HORSERUN) then
            m_nFootStepSound := m_nFootStepSound + 2;

      end;

      if m_btSex = 0 then begin //巢磊
         m_nScreamSound := s_man_struck;
         m_nDieSound := s_man_die;
      end else begin //咯磊
         m_nScreamSound := s_wom_struck;
         m_nDieSound := s_wom_die;
      end;

      case m_nCurrentAction of
         SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT, SM_CRSHIT, SM_TWINHIT,SM_LONGSWORD1,SM_LONGSWORD2,SM_FIREHIT2,SM_LONGFIREHIT:
            begin
               case (m_btWeapon div 2) of
                  6, 20:  m_nWeaponSound := s_hit_short;
                  1:  m_nWeaponSound := s_hit_wooden;
                  2, 13, 9, 5, 14, 22:  m_nWeaponSound := s_hit_sword;
                  4, 17, 10, 15, 16, 23:  m_nWeaponSound := s_hit_do;
                  3, 7, 11:  m_nWeaponSound := s_hit_axe;
                  24:  m_nWeaponSound := s_hit_club;
                  8, 12, 18, 21:  m_nWeaponSound := s_hit_long;
                  else m_nWeaponSound := s_hit_fist;
               end;
            end;
         SM_STRUCK:
            begin
               if m_nMagicStruckSound >= 1 then begin  //付过栏肺 嘎澜
                  //strucksound := s_struck_magic;  //烙矫..
               end else begin
                  hiter := PlayScene.FindActor (m_nHiterCode);
                  attackweapon := 0;
                  if hiter <> nil then begin //锭赴仇捞 公均栏肺 锭啡绰瘤 八荤
                     attackweapon := hiter.m_btWeapon div 2;
                     if hiter.m_btRace = 0 then
                        case (m_btDress div 2) of
                           3: //癌渴
                              case attackweapon of
                                 6:  m_nStruckSound := s_struck_armor_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_armor_sword;
                                 3,7,11: m_nStruckSound := s_struck_armor_axe;
                                 8,12,18: m_nStruckSound := s_struck_armor_longstick;
                                 else m_nStruckSound := s_struck_armor_fist;
                              end;
                           else //老馆
                              case attackweapon of
                                 6: m_nStruckSound := s_struck_body_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_body_sword;
                                 3,7,11: m_nStruckSound := s_struck_body_axe;
                                 8,12,18: m_nStruckSound := s_struck_body_longstick;
                                 else m_nStruckSound := s_struck_body_fist;
                              end;
                        end;
                  end;
               end;
            end;
      end;

      //付过 家府
      if m_boUseMagic and (m_CurMagic.MagicSerial > 0) then begin
         //Dscreen.AddSysMsg (IntToStr(Integer(0))+'  '+IntToStr(m_CurMagic.MagicSerial));
         if m_CurMagic.MagicSerial = 37 then begin
           m_nMagicStartSound := 10110;
           m_nMagicFireSound := 10111;
           m_nMagicExplosionSound := 10112;
         end else
         if m_CurMagic.MagicSerial = 41 then begin //080605修改狮子吼声音
           m_nMagicStartSound := 10430;
           m_nMagicFireSound := 10431;
           m_nMagicExplosionSound := 10432;
        end else
         if m_CurMagic.MagicSerial = 48 then begin //080605修改气功波声音
           m_nMagicStartSound := 10370;
           m_nMagicFireSound := 10371;
           m_nMagicExplosionSound := 10372;
         end else
         if m_CurMagic.MagicSerial = 50 then begin //080605修改无极真气声音
           m_nMagicStartSound := 10360;
           m_nMagicFireSound := 10361;
           m_nMagicExplosionSound := 10362;
         end else
         if m_CurMagic.MagicSerial = 53 then begin //080819修改噬血术声音
           m_nMagicStartSound := 10480;
           m_nMagicFireSound := 0;
           m_nMagicExplosionSound := 0;
         end else
         if m_CurMagic.MagicSerial = 80 then begin //道力盾
           m_nMagicStartSound := 10310;
           m_nMagicFireSound := 10311;
           m_nMagicExplosionSound := 10312;
         end else begin
           m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10;
           m_nMagicFireSound := 10000 + m_CurMagic.MagicSerial * 10 + 1;
           m_nMagicExplosionSound := 10000 + m_CurMagic.MagicSerial * 10 + 2;
         end;
      end;

   end else begin
      if m_nCurrentAction = SM_STRUCK then begin
         if m_nMagicStruckSound >= 1 then begin  //付过栏肺 嘎澜
            //strucksound := s_struck_magic;  //烙矫..
         end else begin
            hiter := PlayScene.FindActor (m_nHiterCode);
            if hiter <> nil then begin  //锭赴仇捞 公均栏肺 锭啡绰瘤 八荤
               attackweapon := hiter.m_btWeapon div 2;
               case attackweapon of
                  6: m_nStruckSound := s_struck_body_sword;
                  1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_body_sword;
                  3,11: m_nStruckSound := s_struck_body_axe;
                  8,12,18: m_nStruckSound := s_struck_body_longstick;
                  else m_nStruckSound := s_struck_body_fist;
               end;
            end;
         end;
      end;

      if m_btRace = 50 then begin
      end else begin
         m_nAppearSound := 200 + (m_wAppearance) * 10;
         m_nNormalSound := 200 + (m_wAppearance) * 10 + 1;
         m_nAttackSound := 200 + (m_wAppearance) * 10 + 2;  //快况撅
         m_nWeaponSound := 200 + (m_wAppearance) * 10 + 3;  //茸(公扁戎滴冯)
         m_nScreamSound := 200 + (m_wAppearance) * 10 + 4;
         m_nDieSound := 200 + (m_wAppearance) * 10 + 5;
         m_nDie2Sound := 200 + (m_wAppearance) * 10 + 6;
      end;
   end;

   if m_btRace = 100 then begin
      if m_boUseMagic and (m_CurMagic.MagicSerial > 0) then begin
         m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10;
         m_nMagicFireSound := 10000 + m_CurMagic.MagicSerial * 10 + 1;
         m_nMagicExplosionSound := 10000 + m_CurMagic.MagicSerial * 10 + 2;
      end;
   end;

   //漠 嘎绰 家府
   if m_nCurrentAction = SM_STRUCK then begin
      hiter := PlayScene.FindActor (m_nHiterCode);
      attackweapon := 0;
      if hiter <> nil then begin  //锭赴仇捞 公均栏肺 锭啡绰瘤 八荤
         attackweapon := hiter.m_btWeapon div 2;
         if hiter.m_btRace = 0 then
            case (attackweapon div 2) of
               6, 20:  m_nStruckWeaponSound := s_struck_short;
               1:  m_nStruckWeaponSound := s_struck_wooden;
               2, 13, 9, 5, 14, 22:  m_nStruckWeaponSound := s_struck_sword;
               4, 17, 10, 15, 16, 23:  m_nStruckWeaponSound := s_struck_do;
               3, 7, 11:  m_nStruckWeaponSound := s_struck_axe;
               24:  m_nStruckWeaponSound := s_struck_club;
               8, 12, 18, 21:  m_nStruckWeaponSound := s_struck_wooden; //long;
               //else struckweaponsound := s_struck_fist;
            end;
      end;
   end;

Except //程序自动增加
  DebugOutStr('[Exception] TActor.SetSound'); //程序自动增加
End; //程序自动增加
end;

procedure  TActor.RunSound;
begin
Try //程序自动增加
   m_boRunSound := TRUE;
   SetSound;
   case m_nCurrentAction of
      SM_STRUCK:
         begin
            if (m_nStruckWeaponSound >= 0) then PlaySound (m_nStruckWeaponSound);
            if (m_nStruckSound >= 0) then PlaySound (m_nStruckSound);
            if (m_nScreamSound >= 0) then PlaySound (m_nScreamSound);
         end;
      SM_NOWDEATH:
         begin
            if (m_nDieSound >= 0) then begin
              PlaySound (m_nDieSound);
//              if Self.m_btRace = RC_USERHUMAN then
              //if Self = g_MySelf then
                //PlayBGM(bmg_gameover);
            end;
         end;
      SM_THROW, SM_HIT, SM_FLYAXE, SM_LIGHTING, SM_DIGDOWN{巩摧塞}:
         begin
            if m_nAttackSound >= 0 then PlaySound (m_nAttackSound);
         end;
      SM_ALIVE, SM_DIGUP{殿厘,巩凯覆}:
         begin
            PlaySound (m_nAppearSound);
            SilenceSound;
         end;
      SM_SPELL:
         begin
            if m_CurMagic.MagicSerial = 74 then begin
              PlaySoundEx (bmg_SKILL_74_0);
            end else
            if ((m_CurMagic.MagicSerial = 57) or (m_CurMagic.MagicSerial = 81)) then begin
              PlaySoundEx(bmg_SKILL_48_0); //四级魔法盾
            end else
            if m_CurMagic.MagicSerial = 84 then begin
              PlaySoundEx (bmg_heroshield);
            end else
            if m_CurMagic.MagicSerial = 75 then begin
              PlaySoundEx (bmg_heroshield);
            end else PlaySound (m_nMagicStartSound);
         end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.RunSound'); //程序自动增加
End; //程序自动增加
end;

procedure  TActor.RunActSound (frame: integer);
begin
Try //程序自动增加
   if m_boRunSound then begin
      if m_btRace = 0 then begin
         case m_nCurrentAction of
            SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_POWERHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  if m_btSex = 0 then PlaySound (s_yedo_man)
                  else PlaySound (s_yedo_woman);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_LONGHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_longhit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_WIDEHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_widehit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_FIREHIT,SM_FIREHIT2:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_CRSHIT:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit); //Damian
                  m_boRunSound := FALSE; //茄锅父 家府晨
              end;
            SM_TWINHIT:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit_ready); //Damian
                  m_boRunSound := FALSE; //茄锅父 家府晨
              end;
            SM_LONGSWORD1:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySoundEx (bmg_longswordhit); //Damian
                  m_boRunSound := FALSE; //茄锅父 家府晨
              end;
            SM_LONGSWORD2:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySoundEx (bmg_longswordhit); //Damian
                  m_boRunSound := FALSE; //茄锅父 家府晨
              end;
            SM_LONGFIREHIT:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  if (m_btSex=0) then PlaySoundEx (bmg_LONGFIREHITMan)
                  else PlaySoundEx (bmg_LONGFIREHITwoMan); //Damian
                  m_boRunSound := FALSE; //茄锅父 家府晨
              end;
            SM_60:
              if frame = 2 then begin
                PlaySound (m_nWeaponSound);
                PlaySound(s_phz);
                m_boRunSound := FALSE;
              end;
         end;
      end else begin
         if m_btRace = 50 then begin
         end else begin
          //(** 货 荤款靛
            if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_TURN) then begin
               if (frame = 1) and (Random(8) = 1) then begin
                  PlaySound (m_nNormalSound);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            end;
            if m_nCurrentAction = SM_HIT then begin
               if (frame = 3) and (m_nAttackSound >= 0) then begin
                  PlaySound (m_nWeaponSound);
                  m_boRunSound := FALSE;
               end;
            end;
            case m_wAppearance of
               80: //包冠零
                  begin
                     if m_nCurrentAction = SM_NOWDEATH then begin
                        if (frame = 2) then begin
                           PlaySound (m_nDie2Sound);
                           m_boRunSound := FALSE; //茄锅父 家府晨
                        end;
                     end;
                  end;
            end;
         end; //*)

      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.RunActSound'); //程序自动增加
End; //程序自动增加
end;

procedure  TActor.RunFrameAction (frame: integer);
begin
Try //程序自动增加
Except //程序自动增加
  DebugOutStr('[Exception] TActor.RunFrameAction'); //程序自动增加
End; //程序自动增加
end;

procedure  TActor.ActionEnded;
begin
Try //程序自动增加
Except //程序自动增加
  DebugOutStr('[Exception] TActor.ActionEnded'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.Run;
   function MagicTimeOut: Boolean;
   begin
      if self = g_MySelf then begin
         Result := GetTickCount - m_dwWaitMagicRequest > 3000;
      end else
         Result := GetTickCount - m_dwWaitMagicRequest > 2000;
      if Result then
         m_CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   bofly: Boolean;
begin
Try //程序自动增加
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      (m_nCurrentAction = SM_HORSERUN) or

      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then exit;

   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;

   //荤款靛 瓤苞
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;

      if (self <> g_MySelf) and (m_boUseMagic) then begin
         m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
      end else begin
         if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
         else m_dwFrameTimetime := m_dwFrameTime;
      end;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            if m_boUseMagic then begin
               if (m_nCurEffFrame = m_nSpellFrame-2) or (MagicTimeOut) then begin
                  if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin
                     Inc (m_nCurrentFrame);
                     Inc(m_nCurEffFrame);
                     m_dwStartTime := GetTickCount;
                  end;
               end else begin
                  if m_nCurrentFrame < m_nEndFrame - 1 then Inc (m_nCurrentFrame);
                  Inc (m_nCurEffFrame);
                  m_dwStartTime := GetTickCount;
               end;
            end else begin
               Inc (m_nCurrentFrame);
               m_dwStartTime := GetTickCount;
            end;

         end else begin
            if m_boDelActionAfterFinished then begin
               m_boDelActor := TRUE;
            end;
            if self = g_MySelf then begin
               if FrmMain.ServerAcceptNextAction then begin
                  ActionEnded;
                  m_nCurrentAction := 0;
                  m_boUseMagic := FALSE;
               end;
            end else begin
               ActionEnded;
               m_nCurrentAction := 0;
               m_boUseMagic := FALSE;
            end;
         end;
         if m_boUseMagic then begin
            if m_nCurEffFrame = m_nSpellFrame-1 then begin
               if m_CurMagic.ServerMagicCode > 0 then begin
                  with m_CurMagic do
                     PlayScene.NewMagic (self,
                                      ServerMagicCode,
                                      EffectNumber, //Effect
                                      m_nCurrX,
                                      m_nCurrY,
                                      TargX,
                                      TargY,
                                      Target,
                                      EffectType, //EffectType
                                      Recusion2,
                                      AniTime,
                                      bofly);
                  //Dscreen.AddSysMsg (IntToStr(Integer(bofly))+'  '+IntToStr(m_CurMagic.ServerMagicCode));
                  if bofly then begin
                      PlaySound (m_nMagicFireSound);

                  end else begin
                      PlaySound (m_nMagicExplosionSound);
                  end;
               end;
               //LatestSpellTime := GetTickCount;
               m_CurMagic.ServerMagicCode := 0;
            end;
         end;
      end;
      if m_wAppearance in [0, 1, 43] then m_nCurrentDefFrame := -10
      else m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
   end else begin
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;

Except //程序自动增加
  DebugOutStr('[Exception] TActor.Run'); //程序自动增加
End; //程序自动增加
end;

function  TActor.Move (step: integer): Boolean;
var
   prv, curstep, maxstep: integer;
   fastmove, normmove: Boolean;
begin
Try //程序自动增加
   Result := FALSE;
   fastmove := FALSE;
   normmove := FALSE;
   if (m_nCurrentAction = SM_BACKSTEP) then //or (CurrentAction = SM_RUSH) or (CurrentAction = SM_RUSHKUNG) then
      fastmove := TRUE;
   if (m_nCurrentAction = SM_RUSH) or (m_nCurrentAction = SM_RUSHKUNG) then
      normmove := TRUE;
   if (self = g_MySelf) and (not fastmove) and (not normmove) then begin
      g_boMoveSlow := FALSE;
      g_boAttackSlow := FALSE;
      g_nMoveSlowLevel := 0;
      if (not g_WgInfo.boMoveSlow) or (Not g_ClientWgInfo.boMoveSlow) then begin
        if m_Abil.Weight > m_Abil.MaxWeight then begin
           g_nMoveSlowLevel := m_Abil.Weight div m_Abil.MaxWeight;
           g_boMoveSlow := TRUE;
        end;
        if m_Abil.WearWeight > m_Abil.MaxWearWeight then begin
           g_nMoveSlowLevel := g_nMoveSlowLevel + m_Abil.WearWeight div m_Abil.MaxWearWeight;
           g_boMoveSlow := TRUE;
        end;
        if m_Abil.HandWeight > m_Abil.MaxHandWeight then begin
           g_boAttackSlow := TRUE;
        end;
      end;
      if g_boMoveSlow and (m_nSkipTick < g_nMoveSlowLevel) then begin
         Inc (m_nSkipTick);
         exit;
      end else begin
         m_nSkipTick := 0;
      end;

      if (m_nCurrentAction = SM_WALK) or
         (m_nCurrentAction = SM_BACKSTEP) or
         (m_nCurrentAction = SM_RUN) or
         (m_nCurrentAction = SM_HORSERUN) or
         (m_nCurrentAction = SM_RUSH) or
         (m_nCurrentAction = SM_RUSHKUNG)
      then begin
         case (m_nCurrentFrame - m_nStartFrame) of
            1: PlaySound (m_nFootStepSound);
            4: PlaySound (m_nFootStepSound + 1);
         end;
      end;
   end;

   Result := FALSE;
   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;
   prv := m_nCurrentFrame;
   //叭扁 顿扁
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_RUN) or
      (m_nCurrentAction = SM_HORSERUN) or
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then begin
         m_nCurrentFrame := m_nStartFrame - 1;
      end;
      if m_nCurrentFrame < m_nEndFrame then begin
         Inc (m_nCurrentFrame);
         if m_boMsgMuch and not normmove then //or fastmove then
            if m_nCurrentFrame < m_nEndFrame then
               Inc (m_nCurrentFrame);

         //何靛反霸 捞悼窍霸 窍妨绊
         curstep := m_nCurrentFrame-m_nStartFrame + 1;
         maxstep := m_nEndFrame-m_nStartFrame + 1;
         Shift (m_btDir, m_nMoveStep, curstep, maxstep);
      end;
      if m_nCurrentFrame >= m_nEndFrame then begin
         if self = g_MySelf then begin
            if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;     //辑滚狼 脚龋甫 罐栏搁 促澜 悼累
               m_boLockEndFrame := TRUE;   //辑滚狼脚龋啊 绝绢辑 付瘤阜橇贰烙俊辑 肛勉
               m_dwSmoothMoveTime := GetTickCount;
            end;
         end else begin
            m_nCurrentAction := 0; //悼累 肯丰
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      if m_nCurrentAction = SM_RUSH then begin
         if self = g_MySelf then begin
            g_dwDizzyDelayStart := GetTickCount;
            g_dwDizzyDelayTime := 300; //掉饭捞
         end;
      end;
      if m_nCurrentAction = SM_RUSHKUNG then begin
         if m_nCurrentFrame >= m_nEndFrame - 3 then begin
            m_nCurrX := m_nActBeforeX;
            m_nCurrY := m_nActBeforeY;
            m_nRx := m_nCurrX;
            m_nRy := m_nCurrY;
            m_nCurrentAction := 0;
            m_boLockEndFrame := TRUE;
            //m_dwSmoothMoveTime := GetTickCount;
         end;
      end;
      Result := TRUE;
   end;
   //缔吧澜龙
   if (m_nCurrentAction = SM_BACKSTEP) then begin
      if (m_nCurrentFrame > m_nEndFrame) or (m_nCurrentFrame < m_nStartFrame) then begin
         m_nCurrentFrame := m_nEndFrame + 1;
      end;
      if m_nCurrentFrame > m_nStartFrame then begin
         Dec (m_nCurrentFrame);
         if m_boMsgMuch or fastmove then
            if m_nCurrentFrame > m_nStartFrame then Dec (m_nCurrentFrame);

         //何靛反霸 捞悼窍霸 窍妨绊
         curstep := m_nEndFrame - m_nCurrentFrame + 1;
         maxstep := m_nEndFrame - m_nStartFrame + 1;
         Shift (GetBack(m_btDir), m_nMoveStep, curstep, maxstep);
      end;
      if m_nCurrentFrame <= m_nStartFrame then begin
         if self = g_MySelf then begin
            //if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;
               m_boLockEndFrame := TRUE;
               m_dwSmoothMoveTime := GetTickCount;


               g_dwDizzyDelayStart := GetTickCount;
               g_dwDizzyDelayTime := 1000;
            //end;
         end else begin
            m_nCurrentAction := 0;
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      Result := TRUE;
   end;
   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.Move'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.MoveFail;
begin
Try //程序自动增加
   m_nCurrentAction := 0; //悼累 肯丰
   m_boLockEndFrame := TRUE;
   g_MySelf.m_nCurrX := m_nOldx;
   g_MySelf.m_nCurrY := m_nOldy;
   g_MySelf.m_btDir := m_nOldDir;
   CleanUserMsgs;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.MoveFail'); //程序自动增加
End; //程序自动增加
end;

function  TActor.CanCancelAction: Boolean;
begin
Try //程序自动增加
   Result := FALSE;
   if m_nCurrentAction = SM_HIT then
      if not m_boUseEffect then
         Result := TRUE;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CanCancelAction:'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.CancelAction;
begin
Try //程序自动增加
   m_nCurrentAction := 0; //悼累 肯丰
   m_boLockEndFrame := TRUE;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CancelAction'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.CleanCharMapSetting (x, y: integer);
begin
Try //程序自动增加
   g_MySelf.m_nCurrX := x;
   g_MySelf.m_nCurrY := y;
   g_MySelf.m_nRx := x;
   g_MySelf.m_nRy := y;
   m_nOldx := x;
   m_nOldy := y;
   m_nCurrentAction := 0;
   m_nCurrentFrame := -1;
   CleanUserMsgs;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.CleanCharMapSetting'); //程序自动增加
End; //程序自动增加
end;

procedure TActor.Say (str: string);
var
   i, len, aline, n: integer;
   dline, temp: string;
   loop: Boolean;
const
   MAXWIDTH = 150;
begin
Try //程序自动增加
   m_dwSayTime := GetTickCount;
   m_nSayLineCount := 0;

   n := 0;
   loop := TRUE;
   while loop do begin
      temp := '';
      i := 1;
      len := Length (str);
      while TRUE do begin
         if i > len then begin
            loop := FALSE;
            break;
         end;
         if byte (str[i]) >= 128 then begin
            temp := temp + str[i];
            Inc (i);
            if i <= len then temp := temp + str[i]
            else begin
               loop := FALSE;
               break;
            end;
         end else
            temp := temp + str[i];

         aline := FrmMain.Canvas.TextWidth (temp);
         if aline > MAXWIDTH then begin
            m_SayingArr[n] := temp;
            m_SayWidthsArr[n] := aline;
            Inc (m_nSayLineCount);
            Inc (n);
            if n >= MAXSAY then begin
               loop := FALSE;
               break;
            end;
            str := Copy (str, i+1, Len-i);
            temp := '';
            break;
         end;
         Inc (i);
      end;
      if temp <> '' then begin
         if n < MAXWIDTH then begin
            m_SayingArr[n] := temp;
            m_SayWidthsArr[n] := FrmMain.Canvas.TextWidth (temp);
            Inc (m_nSayLineCount);
         end;
      end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] TActor.Say'); //程序自动增加
End; //程序自动增加
end;


{============================== NPCActor =============================}
procedure TNpcActor.CalcActorFrame;
var
  Pm:pTMonsterAction;
  HairCount:Integer;
begin
Try //程序自动增加
  m_boUseMagic    :=False;
  m_nCurrentFrame :=-1;
  m_nBodyOffset   :=GetNpcOffset(m_wAppearance);
   {
   if m_btRace = 50 then //NPC
      m_nBodyOffset := MERCHANTFRAME * m_wAppearance;
   }
  Pm:=GetRaceByPM(m_btRace,m_wAppearance);
  if pm = nil then exit;
  m_btDir := m_btDir mod 3;  //规氢篮 0, 1, 2 观俊 绝澜..
  case m_nCurrentAction of
    SM_TURN: begin
      m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
      m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
      m_dwFrameTime := pm.ActStand.ftime;
      m_dwStartTime := GetTickCount;
      m_nDefFrameCount := pm.ActStand.frame;
      Shift (m_btDir, 0, 0, 1);
      if ((m_wAppearance = 33) or (m_wAppearance = 34))and not m_boUseEffect then begin
        m_boUseEffect:=True;
        m_nEffectStart:=30;
        m_nEffectFrame:=m_nEffectStart;
        m_nEffectEnd:=m_nEffectStart+9;
        m_dwEffectStartTime:=GetTickCount();
        m_dwEffectFrameTime:=300;
      end else
      if m_wAppearance in [42..47] then begin
        m_nStartFrame:=20;
        m_nEndFrame:=10;
        m_boUseEffect:=True;
        m_nEffectStart:=0;
        m_nEffectFrame:=0;
        m_nEffectEnd:=19;
        m_dwEffectStartTime:=GetTickCount();
        m_dwEffectFrameTime:=100;
      end else
      if m_wAppearance = 51 then begin
        m_boUseEffect:=True;
        m_nEffectStart:=60;
        m_nEffectFrame:=m_nEffectStart;
        m_nEffectEnd:=m_nEffectStart + 7;
        m_dwEffectStartTime:=GetTickCount();
        m_dwEffectFrameTime:=500;
      end else
      if m_wAppearance = 52 then begin
        m_boUseEffect:=True;
        m_nEffectStart:=60;
        m_nEffectFrame:=m_nEffectStart;
        m_nEffectEnd:=m_nEffectStart + 11;
        m_dwEffectStartTime:=GetTickCount();
        m_dwEffectFrameTime:=500;
      end;
    end;
    SM_HIT: begin
      case m_wAppearance of
        33,34,52: begin
          m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
        end;
        else begin
          m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
          m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
          m_dwFrameTime := pm.ActAttack.ftime;
          m_dwStartTime := GetTickCount;
          if m_wAppearance = 51 then begin
            m_boUseEffect:=True;
            m_nEffectStart:=60;
            m_nEffectFrame:=m_nEffectStart;
            m_nEffectEnd:=m_nEffectStart + 7;
            m_dwEffectStartTime:=GetTickCount();
            m_dwEffectFrameTime:=500;
          end else
          if m_wAppearance = 52 then begin
            m_boUseEffect:=True;
            m_nEffectStart:=60;
            m_nEffectFrame:=m_nEffectStart;
            m_nEffectEnd:=m_nEffectStart + 11;
            m_dwEffectStartTime:=GetTickCount();
            m_dwEffectFrameTime:=500;
          end;
        end;
      end;
    end;

  //酒馆老板娘走动
  SM_WALK:begin
      case m_wAppearance of
      71:
       begin
          m_nStartFrame := pm.ActWalk.start + m_btDir;
          m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - m_btDir-1;
          m_dwFrameTime := pm.ActWalk.ftime;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActWalk.frame;
          m_bo248:=True;
          m_boUseEffect:=True;
          m_nEffectStart:=431+m_btDir;
          m_nEffectFrame:=m_nEffectStart;
          m_nEffectEnd:=m_nEffectStart+pm.ActWalk.frame-m_btDir-1;
          m_dwEffectStartTime:=GetTickCount();
          m_dwEffectFrameTime:=pm.ActWalk.ftime;
       end;
      end;
    end;

    SM_DIGUP: begin
      
      if m_wAppearance = 52 then begin
        m_bo248:=True;
        m_dwUseEffectTick:=GetTickCount + 23000;
        Randomize;
        PlaySound(Random(7) + 146);
        m_boUseEffect:=True;
        m_nEffectStart:=60;
        m_nEffectFrame:=m_nEffectStart;
        m_nEffectEnd:=m_nEffectStart + 11;
        m_dwEffectStartTime:=GetTickCount();
        m_dwEffectFrameTime:=120;
      end;

    end;
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TNpcActor.CalcActorFrame'); //程序自动增加
End; //程序自动增加
end;

constructor TNpcActor.Create; //0x0047C42C
begin
Try //程序自动增加
  inherited;
  m_EffSurface:=nil;
  m_boHitEffect:=False;
//  m_boCutEffect:=False;
  m_bo248:=False;
Except //程序自动增加
  DebugOutStr('[Exception] TNpcActor.Create'); //程序自动增加
End; //程序自动增加
end;

procedure TNpcActor.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer;
  blend, boFlag: Boolean);
var
  ceff: TColorEffect;
begin
Try //程序自动增加
  m_btDir := m_btDir mod 3;
  if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
    m_dwLoadSurfaceTime := GetTickCount;
    LoadSurface;
  end;
  ceff := GetDrawEffectValue;
  if m_BodySurface <> nil then begin
    if m_wAppearance = 51 then begin
      DrawEffSurface (dsurface,
                      m_BodySurface,
                      dx + m_nPx + m_nShiftX,
                      dy + m_nPy + m_nShiftY,
                      True,
                      ceff);
    end else begin
      DrawEffSurface (dsurface,
                      m_BodySurface,
                      dx + m_nPx + m_nShiftX,
                      dy + m_nPy + m_nShiftY,
                      blend,
                      ceff);
    end;
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TNpcActor.DrawChr'); //程序自动增加
End; //程序自动增加
end;

procedure TNpcActor.DrawEff(dsurface: TDirectDrawSurface; dx, dy: integer);
begin
Try //程序自动增加
//  inherited;
  if m_boUseEffect and (m_EffSurface <> nil) then begin
    DrawBlend (dsurface,
               dx + m_nEffX + m_nShiftX,
               dy + m_nEffY + m_nShiftY,
               m_EffSurface,
               1);
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TNpcActor.DrawEff'); //程序自动增加
End; //程序自动增加
end;

function  TNpcActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
Try //程序自动增加
   Result:=0;//Jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   m_btDir := m_btDir mod 3;  //规氢篮 0, 1, 2 观俊 绝澜..

   if m_nCurrentDefFrame < 0 then cf := 0
   else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
   else cf := m_nCurrentDefFrame;
   Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
Except //程序自动增加
  DebugOutStr('[Exception] TNpcActor.GetDefaultFrame'); //程序自动增加
End; //程序自动增加
end;

procedure TNpcActor.LoadSurface;
var
  WMImage:TWMImages;
begin
Try //程序自动增加
{
  case m_btRace of
    50: begin //Npc
      m_BodySurface:=FrmMain.WNpcImg.GetCachedImage (m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);
      if m_nBodyOffset >= 1000 then begin
        if FrmMain.GetNpcImg(m_wAppearance,WMImage) then begin
          m_BodySurface:=WMImage.GetCachedImage (m_nCurrentFrame, m_nPx, m_nPy);
        end;
      end;
    end;
  end;
}
  if m_btRace = 50 then begin
    m_BodySurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);
  end;
  m_EffSurface:=nil;
  if m_wAppearance in [42..47] then
    m_BodySurface:=nil;
  if m_wAppearance in [60,67..69] then m_boUseEffect:=True;
  if m_boUseEffect then begin
    if m_wAppearance in [33..34] then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 42 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 71;
      m_nEffY:=m_nEffY + 5;
    end else if m_wAppearance = 43 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 71;
      m_nEffY:=m_nEffY + 37;
    end else if m_wAppearance = 44 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 7;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 45 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 6;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 46 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 7;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 47 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 8;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 51 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 71 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset +  m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 52 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance in [67..69] then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nCurrentFrame + 4, m_nEffX, m_nEffY);
    end else if m_wAppearance = 60 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nCurrentFrame + 180, m_nEffX, m_nEffY);
    end;
  end;

Except //程序自动增加
  DebugOutStr('[Exception] TNpcActor.LoadSurface'); //程序自动增加
End; //程序自动增加
end;


procedure TNpcActor.Run;
var
  nEffectFrame:Integer;
  dwEffectFrameTime:LongWord;
begin
Try //程序自动增加
  inherited Run;
  nEffectFrame:=m_nEffectFrame;
  if m_boUseEffect then begin
    if m_boUseMagic then begin
      dwEffectFrameTime:=Round(m_dwEffectFrameTime / 3);
    end else dwEffectFrameTime:=m_dwEffectFrameTime;

    if GetTickCount - m_dwEffectStartTime > dwEffectFrameTime then begin
      m_dwEffectStartTime:=GetTickCount();
      if m_nEffectFrame < m_nEffectEnd then begin
        Inc(m_nEffectFrame);
       if (m_wAppearance=71) and (m_nCurrentAction=SM_WALK)
        // and  (m_nEffectFrame<>m_nCurrentFrame+80)
          then
           m_nEffectFrame:=m_nCurrentFrame+80; //解决白光和走动不同步
      end else begin
        if m_bo248 then begin
          if GetTickCount > m_dwUseEffectTick then begin
            m_boUseEffect:=False;
            m_bo248:=False;
            m_dwUseEffectTick:=GetTickCount();
          end;
          m_nEffectFrame:=m_nEffectStart;
        end else m_nEffectFrame:=m_nEffectStart;
        m_dwEffectStartTime:=GetTickCount();
      end;
    end;
  end;
  if nEffectFrame <> m_nEffectFrame then begin
    m_dwLoadSurfaceTime:=GetTickCount();
    LoadSurface();
  end;
Except //程序自动增加
  DebugOutStr('[Exception] TNpcActor.Run'); //程序自动增加
End; //程序自动增加
end;


{============================== HUMActor =============================}

//            荤恩

{-------------------------------}


constructor THumActor.Create;
begin
Try //程序自动增加
   inherited Create;
   m_HairSurface := nil;
   m_WeaponSurface := nil;
   m_HumWinSurface:=nil;
   m_boWeaponEffect := FALSE;
   m_dwFrameTime:=150;
   m_dwFrameTick:=GetTickCount();
   m_nFrame:=0;
   m_nHumWinOffset:=0;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.Create'); //程序自动增加
End; //程序自动增加
end;

destructor THumActor.Destroy;
begin
Try //程序自动增加
  inherited Destroy;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.Destroy'); //程序自动增加
End; //程序自动增加
end;

procedure THumActor.CalcActorFrame;
var
  haircount: integer;
  TempHair : Integer;
  Meff:TMagicEff;
begin
Try //程序自动增加
  m_boUseMagic := FALSE;
  m_boHitEffect := FALSE;
  m_nCurrentFrame := -1;
   //human
  m_btHair   := HAIRfeature (m_nFeature);         //函版等促.
  m_btDress  := DRESSfeature (m_nFeature);
  m_btWeapon := WEAPONfeature (m_nFeature);
  m_btHorse  :=Horsefeature(m_nFeatureEx);
  m_btEffect :=Effectfeature(m_nFeatureEx);
  m_nBodyOffset := HUMANFRAME * (m_btDress); //m_btSex; //巢磊0, 咯磊1

  m_nHairOffset := HUMANFRAME * m_btHair;

  m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);

  if m_nRecogId=g_HeronRecogId then g_HerobtHair:=m_btHair;
  if (m_btEffect = 50) then begin
    m_nHumWinOffset:=352;
  end else
  if m_btEffect <> 0 then
     m_nHumWinOffset:=(m_btEffect - 1) * HUMANFRAME;
   case m_nCurrentAction of
      SM_TURN:
         begin
            m_nStartFrame := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip);
            m_nEndFrame := m_nStartFrame + HA.ActStand.frame - 1;
            m_dwFrameTime := HA.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := HA.ActStand.frame;
            Shift (m_btDir, 0, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      SM_WALK,
      SM_BACKSTEP:
         begin
            m_nStartFrame := HA.ActWalk.start + m_btDir * (HA.ActWalk.frame + HA.ActWalk.skip);
            m_nEndFrame := m_nStartFrame + HA.ActWalk.frame - 1;
            m_dwFrameTime := HA.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActWalk.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            m_nMoveStep := 1;
            if m_nCurrentAction = SM_BACKSTEP then
               Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
            else
               Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      SM_RUSH:
         begin
            if m_nRushDir = 0 then begin
               m_nRushDir := 1;
               m_nStartFrame := HA.ActRushLeft.start + m_btDir * (HA.ActRushLeft.frame + HA.ActRushLeft.skip);
               m_nEndFrame := m_nStartFrame + HA.ActRushLeft.frame - 1;
               m_dwFrameTime := HA.ActRushLeft.ftime;
               m_dwStartTime := GetTickCount;
               m_nMaxTick := HA.ActRushLeft.UseTick;
               m_nCurTick := 0;
               m_nMoveStep := 1;
               Shift (m_btDir, 1, 0, m_nEndFrame-m_nStartFrame+1);
            end else begin
               m_nRushDir := 0;
               m_nStartFrame := HA.ActRushRight.start + m_btDir * (HA.ActRushRight.frame + HA.ActRushRight.skip);
               m_nEndFrame := m_nStartFrame + HA.ActRushRight.frame - 1;
               m_dwFrameTime := HA.ActRushRight.ftime;
               m_dwStartTime := GetTickCount;
               m_nMaxTick := HA.ActRushRight.UseTick;
               m_nCurTick := 0;
               m_nMoveStep := 1;
               Shift (m_btDir, 1, 0, m_nEndFrame-m_nStartFrame+1);
            end;
         end;
      SM_RUSHKUNG:
         begin
            m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
            m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
            m_dwFrameTime := HA.ActRun.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActRun.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      {SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
            m_dwFrameTime := pm.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := pm.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
         end;  }
      SM_SITDOWN:
         begin
            m_nStartFrame := HA.ActSitdown.start + m_btDir * (HA.ActSitdown.frame + HA.ActSitdown.skip);
            m_nEndFrame := m_nStartFrame + HA.ActSitdown.frame - 1;
            m_dwFrameTime := HA.ActSitdown.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_RUN:
         begin
            m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
            m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
            m_dwFrameTime := HA.ActRun.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActRun.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            if m_nCurrentAction = SM_RUN then m_nMoveStep := 2
            else m_nMoveStep := 1;

            //m_nMoveStep := 2;
            Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      SM_HORSERUN: begin
            m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
            m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
            m_dwFrameTime := HA.ActRun.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActRun.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            if m_nCurrentAction = SM_HORSERUN then m_nMoveStep := 3
            else m_nMoveStep := 1;

            //m_nMoveStep := 2;
            Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
      end;
      SM_THROW:
         begin
            m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
            m_dwFrameTime := HA.ActHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            m_boThrow := TRUE;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_HIT, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT,SM_FIREHIT2, SM_CRSHIT, SM_TWINHIT,SM_61,SM_62,SM_60,SM_LONGSWORD1,SM_LONGSWORD2,SM_LONGFIREHIT:
         begin
            m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
            m_dwFrameTime := HA.ActHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            if (m_nCurrentAction = SM_POWERHIT) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 1;
            end;
            if (m_nCurrentAction = SM_LONGHIT) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 2;
            end;
            if (m_nCurrentAction = SM_WIDEHIT) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 3;
            end;
            if (m_nCurrentAction = SM_FIREHIT) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 4;
            end;
            if (m_nCurrentAction = SM_FIREHIT2) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 14;
            end;
            if (m_nCurrentAction = SM_CRSHIT) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 6;
            end;
            if (m_nCurrentAction = SM_TWINHIT) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := -1;
               meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic2Images,m_btDir*20+740,18,85,True);
               PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_60) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := -1;
               meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic4Images,m_btDir*20+10,18,85,True);
               PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_61) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 10;
            end;
            if (m_nCurrentAction = SM_62) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 11;
            end;
            if (m_nCurrentAction = SM_LONGSWORD1) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 12;
               meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic5Images,m_btDir*10+550,10,85,True);
               PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_LONGSWORD2) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 13;
               meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic5Images,m_btDir*10+710,10,85,True);
               PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_LONGFIREHIT) then begin
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 15;
            end;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_HEAVYHIT:
         begin
            m_nStartFrame := HA.ActHeavyHit.start + m_btDir * (HA.ActHeavyHit.frame + HA.ActHeavyHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHeavyHit.frame - 1;
            m_dwFrameTime := HA.ActHeavyHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_BIGHIT:
         begin
            m_nStartFrame := HA.ActBigHit.start + m_btDir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActBigHit.frame - 1;
            m_dwFrameTime := HA.ActBigHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_SPELL:
         begin
            m_nStartFrame := HA.ActSpell.start + m_btDir * (HA.ActSpell.frame + HA.ActSpell.skip);
            m_nEndFrame := m_nStartFrame + HA.ActSpell.frame - 1;
            m_dwFrameTime := HA.ActSpell.ftime;
            m_dwStartTime := GetTickCount;
            m_nCurEffFrame := 0;
            m_boUseMagic := TRUE;
            case m_CurMagic.EffectNumber of
               22: begin //火墙
                     m_nMagLight := 4;
                     m_nSpellFrame := 10;
                  end;
               26: begin //心灵启示
                     m_nMagLight := 2;
                     m_nSpellFrame := 20;
                     m_dwFrameTime := m_dwFrameTime div 2;
                  end;
               35: begin //
                     m_nMagLight := 2;
                     m_nSpellFrame := 15;
               end;
               43: begin //狮子吼
                     m_nMagLight := 2;
                     m_nSpellFrame := 20;
                  end;
               else begin //
                  m_nMagLight := 2;
                  m_nSpellFrame := DEFSPELLFRAME;
               end;
            end;
            m_dwWaitMagicRequest := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      (*SM_READYFIREHIT:
         begin
            startframe := HA.ActFireHitReady.start + Dir * (HA.ActFireHitReady.frame + HA.ActFireHitReady.skip);
            m_nEndFrame := startframe + HA.ActFireHitReady.frame - 1;
            m_dwFrameTime := HA.ActFireHitReady.ftime;
            m_dwStartTime := GetTickCount;

            BoHitEffect := TRUE;
            HitEffectNumber := 4;
            MagLight := 2;

            CurGlimmer := 0;
            MaxGlimmer := 6;

            WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end; *)
      SM_STRUCK:
         begin
            m_nStartFrame := HA.ActStruck.start + m_btDir * (HA.ActStruck.frame + HA.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + HA.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //HA.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);

            m_dwGenAnicountTime := GetTickCount;
            m_nCurBubbleStruck := 0;
         end;
      SM_NOWDEATH:
         begin
            m_nStartFrame := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip);
            m_nEndFrame := m_nStartFrame + HA.ActDie.frame - 1;
            m_dwFrameTime := HA.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.CalcActorFrame'); //程序自动增加
End; //程序自动增加
end;

procedure THumActor.DefaultMotion;
begin
Try //程序自动增加
   inherited DefaultMotion;
   if (m_btEffect = 50) then begin
     if (m_nCurrentFrame <= 536) then begin
       if (GetTickCount - m_dwFrameTick) > 100 then begin
         if m_nFrame < 19 then Inc(m_nFrame)
         else begin
           if not m_bo2D0 then m_bo2D0:=True
           else m_bo2D0:=False;
           m_nFrame:=0;
         end;
         m_dwFrameTick:=GetTickCount();
       end;
       m_HumWinSurface:=g_WEffectImages.GetCachedImage (m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
     end;
   end else
   if (m_btEffect <> 0) then begin
   if m_nCurrentFrame < 64 then begin
     if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
       if m_nFrame < 7 then Inc(m_nFrame)
       else m_nFrame:=0;
       m_dwFrameTick:=GetTickCount();
     end;
     m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset+ (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
   end else begin
     m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
   end;
   end;
   if m_btHorse<>0 then begin
    m_HumWinSurface:= Nil;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.DefaultMotion'); //程序自动增加
End; //程序自动增加
end;

function  THumActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
Try //程序自动增加
   //GlimmingMode := FALSE;
   //dr := Dress div 2;            //HUMANFRAME * (dr)
   if m_boDeath then
      Result := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip) + (HA.ActDie.frame - 1)
   else
   if wmode then begin
      //GlimmingMode := TRUE;
      Result := HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
   end else begin
      m_nDefFrameCount := HA.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= HA.ActStand.frame then cf := 0 //HA.ActStand.frame-1
      else cf := m_nCurrentDefFrame;
      Result := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip) + cf;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.GetDefaultFrame'); //程序自动增加
End; //程序自动增加
end;

procedure  THumActor.RunFrameAction (frame: integer);
var
   meff: TMapEffect;
   event: TClEvent;
   mfly: TFlyingAxe;
begin
Try //程序自动增加
   m_boHideWeapon := FALSE;
   if m_nCurrentAction = SM_HEAVYHIT then begin
      if (frame = 5) and (m_boDigFragment) then begin
         m_boDigFragment := FALSE;
         meff := TMapEffect.Create (8 * m_btDir, 3, m_nCurrX, m_nCurrY);
         meff.ImgLib := g_WEffectImages;
         meff.NextFrameTime := 80;
         PlaySound (s_strike_stone);
         //PlaySound (s_drop_stonepiece);
         PlayScene.m_EffectList.Add (meff);
         event := EventMan.GetEvent (m_nCurrX, m_nCurrY, ET_PILESTONES);
         if event <> nil then
            event.m_nEventParam := event.m_nEventParam + 1;
      end;
   end;
   if m_nCurrentAction = SM_THROW then begin
      if (frame = 3) and (m_boThrow) then begin
         m_boThrow := FALSE;
         mfly := TFlyingAxe (PlayScene.NewFlyObject (self,
                          m_nCurrX,
                          m_nCurrY,
                          m_nTargetX,
                          m_nTargetY,
                          m_nTargetRecog,
                          mtFlyAxe));
         if mfly <> nil then begin
            TFlyingAxe(mfly).ReadyFrame := 40;
            mfly.ImgLib := GetMonEx(3-1);
            mfly.FlyImageBase := FLYOMAAXEBASE;
         end;

      end;
      if frame >= 3 then
         m_boHideWeapon := TRUE;
   end;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.RunFrameAction'); //程序自动增加
End; //程序自动增加
end;

procedure  THumActor.DoWeaponBreakEffect;
begin
Try //程序自动增加
   m_boWeaponEffect := TRUE;
   m_nCurWeaponEffect := 0;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.DoWeaponBreakEffect'); //程序自动增加
End; //程序自动增加
end;

procedure  THumActor.Run;
   function MagicTimeOut: Boolean;
   begin
      if self = g_MySelf then begin
         Result := GetTickCount - m_dwWaitMagicRequest > 3000;
      end else
         Result := GetTickCount - m_dwWaitMagicRequest > 2000;
      if Result then
         m_CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   bofly: Boolean;
begin
Try //程序自动增加
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //林贱狼阜 殿... 局聪皋捞记 瓤苞
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
      Inc (m_nCurBubbleStruck);
   end;
   if m_boWeaponEffect then begin  //公扁 氢惑/何辑咙 瓤苞
      if GetTickCount - m_dwWeaponpEffectTime > 120 then begin
         m_dwWeaponpEffectTime := GetTickCount;
         Inc (m_nCurWeaponEffect);
         if m_nCurWeaponEffect >= MAXWPEFFECTFRAME then
            m_boWeaponEffect := FALSE;
      end;
   end;
  { if m_boCorpsShow then begin
      if (GetTickCount - m_dwCorpsShowTick) > 120 then begin
        m_dwCorpsShowTick:=GetTickCount;
        Inc(m_boCorpsEffFrame);
        if m_boCorpsEffFrame >= m_boCorpsEffEnd then
           m_boCorpsShow:=False;
      end;
   end; }

   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      (m_nCurrentAction = SM_HORSERUN) or
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then exit;

   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;

   //荤款靛 瓤苞
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   {if m_boCutEffect then begin
      if (GetTickCount - m_dwCutMagicTick) > (m_dwCutFrameTimetime) then begin
        if m_nCutEffectNumber < m_nCutEndEffectNumber then begin
          Inc(m_nCutEffectNumber);
          m_dwCutMagicTick := GetTickCount;
        end else begin
          m_boCutEffect:=False;
        end;
      end;
   end;  }
   {if m_boCutEffect then begin
         if (GetTickCount - m_dwCutMagicTick) > (m_dwFrameTimetime) then begin
           if self = g_MySelf then
           Dscreen.AddSysMsg (format('%d-%d',[m_nCurrentFrame,m_nEndFrame]));
           if m_nCurrentFrame < m_nEndFrame then begin
               Inc(m_nCutEffectNumber);
               if Odd(m_nCutEffectNumber) then Inc(m_nCurrentFrame);
               m_dwCutMagicTick := GetTickCount;
           end else begin
              if self = g_MySelf then begin
                 if FrmMain.ServerAcceptNextAction then begin
                    m_nCurrentAction := 0;
                    m_boUseMagic := FALSE;
                 end;
              end else begin
                 m_nCurrentAction := 0; //悼累 肯丰
                 m_boUseMagic := FALSE;
              end;
              m_boCutEffect := FALSE;
           end;
         end;
      end else }
   if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then begin
         m_nCurrentFrame := m_nStartFrame;
      end;

      if (self <> g_MySelf) and (m_boUseMagic) then begin
         m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
      end else begin
         if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
         else m_dwFrameTimetime := m_dwFrameTime;
      end;
      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            if m_boUseMagic then begin
               if (m_nCurEffFrame = m_nSpellFrame-2) or (MagicTimeOut) then begin
                  if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin
                     Inc (m_nCurrentFrame);
                     Inc(m_nCurEffFrame);
                     m_dwStartTime := GetTickCount;
                  end;
               end else begin
                  if m_nCurrentFrame < m_nEndFrame - 1 then Inc (m_nCurrentFrame);
                  Inc (m_nCurEffFrame);
                  m_dwStartTime := GetTickCount;
               end;
            end else begin
               Inc (m_nCurrentFrame);
               m_dwStartTime := GetTickCount;
            end;

         end else begin
            if self = g_MySelf then begin
               if FrmMain.ServerAcceptNextAction then begin
                  m_nCurrentAction := 0;
                  m_boUseMagic := FALSE;
               end;
            end else begin
               m_nCurrentAction := 0; //悼累 肯丰
               m_boUseMagic := FALSE;
            end;
            m_boHitEffect := FALSE;
         end;
         if m_boUseMagic then begin
            if m_nCurEffFrame = m_nSpellFrame - 1 then begin //付过 惯荤 矫痢
               //付过 惯荤
               if m_CurMagic.ServerMagicCode > 0 then begin
                  with m_CurMagic do begin
                     PlayScene.NewMagic (self,
                                      ServerMagicCode,
                                      EffectNumber,
                                      m_nCurrX,
                                      m_nCurrY,
                                      TargX,
                                      TargY,
                                      Target,
                                      EffectType,
                                      Recusion2,
                                      AniTime,
                                      bofly);
                     //DScreen.AddSysMsg (IntToStr(Integer(bofly))+ '/'+IntToStr(m_CurMagic.EffectNumber));
                  end;
                  if bofly then begin
                    PlaySound (m_nMagicFireSound)
                  end else begin
                    PlaySound (m_nMagicExplosionSound);
                  end;
               end;
               if self = g_MySelf then
                  g_dwLatestSpellTick := GetTickCount;
               m_CurMagic.ServerMagicCode := 0;
            end;
         end;

      end;
      if m_btRace = 0 then m_nCurrentDefFrame := 0
      else m_nCurrentDefFrame := -10;
      m_dwDefFrameTime := GetTickCount;
   end else begin
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;

Except //程序自动增加
  DebugOutStr('[Exception] THumActor.Run'); //程序自动增加
End; //程序自动增加
end;

function   THumActor.Light: integer;
var
   l: integer;
begin
Try //程序自动增加
   l := m_nChrLight;
   if l < m_nMagLight then begin
      if m_boUseMagic or m_boHitEffect then
         l := m_nMagLight;
   end;
   Result := l;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.Light:'); //程序自动增加
End; //程序自动增加
end;

procedure  THumActor.LoadSurface;
begin
Try //程序自动增加

  if m_btHorse<>0 then begin
    m_BodySurface := FrmMain.GetWHorseHumImg(m_btDress,m_btSex ,m_nCurrentFrame, m_nPx, m_nPy);
    m_BodyHorse   := FrmMain.GetWHorseImg(m_btHorse,m_nCurrentFrame, m_nHsx, m_nHsy);
    m_HairSurface := g_HorseHairImages.GetCachedImage (m_nHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy);
    Dec(m_nHpy,4);
    m_HumWinSurface:= Nil;
    m_WeaponSurface:= NIl;
    m_BodyHelmet:=nil;
  end else begin
     m_BodyHorse:=Nil;
     m_BodySurface := FrmMain.GetWHumImg(m_btDress,m_btSex ,m_nCurrentFrame, m_nPx, m_nPy);
     if m_BodySurface = nil then
       m_BodySurface := FrmMain.GetWHumImg(0,m_btSex ,m_nCurrentFrame, m_nPx, m_nPy);

     if m_nHairOffset >= 0 then
        m_HairSurface := g_WHairImgImages.GetCachedImage (m_nHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy)
     else m_HairSurface := nil;
     if (m_btEffect = 50) then begin
       if (m_nCurrentFrame <= 536) then begin
         if (GetTickCount - m_dwFrameTick) > 100 then begin
           if m_nFrame < 19 then Inc(m_nFrame)
           else begin
             if not m_bo2D0 then m_bo2D0:=True
             else m_bo2D0:=False;
             m_nFrame:=0;
           end;
           m_dwFrameTick:=GetTickCount();
         end;
         m_HumWinSurface:=g_WEffectImages.GetCachedImage (m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
       end;
     end else
     if (m_btEffect <> 0) then begin
     if m_nCurrentFrame < 64 then begin
       if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
         if m_nFrame < 7 then Inc(m_nFrame)
         else m_nFrame:=0;
         m_dwFrameTick:=GetTickCount();
       end;
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset+ (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
     end else begin
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
     end;
     end;

     m_WeaponSurface:=FrmMain.GetWWeaponImg(m_btWeapon,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy);
     if m_WeaponSurface = nil then
       m_WeaponSurface:=FrmMain.GetWWeaponImg(0,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy);

     if m_nHelmet > 0 then
      m_BodyHelmet:=g_WHelmetImages.GetCachedImage((HUMANFRAME*(m_nHelmet-1)) + m_nCurrentFrame,m_nHelmetx,m_nHelmety)
     else m_BodyHelmet:=nil;
  end;
Except //程序自动增加
  DebugOutStr('[Exception] THumActor.LoadSurface'); //程序自动增加
End; //程序自动增加
end;

procedure  THumActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   idx, ax, ay,nx,ny: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
   I,nLeng:integer;
   II:Integer;
   
begin
Try //程序自动增加
   d:=nil;//Jacky
   if not (m_btDir in [0..7]) then exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurface loadsurface
   end;

   ceff := GetDrawEffectValue;


   if m_btRace = 0 then begin
      if (m_nCurrentFrame >= 0) and (m_nCurrentFrame <= 599) then
         m_nWpord := WORDER[m_btSex, m_nCurrentFrame];

//      if Dress in [1..4] then begin
//      if Dress in [18..21] then begin
      if m_btEffect <> 0 then begin
        if g_MySelf = Self then begin
          //if blend then begin //080611修正隐身术看到不翅膀
            if blend and ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
               (m_HumWinSurface <> nil) and not boFlag then begin
               DrawBlend (dsurface,
                          dx + m_nSpx + m_nShiftX,
                          dy + m_nSpy + m_nShiftY,
                          m_HumWinSurface,
                          1);
            end else begin//0x0047CED1
              if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
                 (m_HumWinSurface <> nil) and boFlag then begin
                 DrawBlend (dsurface,
                           dx + m_nSpx + m_nShiftX,
                           dy + m_nSpy + m_nShiftY,
                           m_HumWinSurface,
                           1);
              end;
            end;
         // end;//0x0047D03F
        end else begin;//0x0047CF4D
          if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and
             blend and ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
             (m_HumWinSurface <> nil) and not boFlag then begin
             DrawBlend (dsurface,
                        dx + m_nSpx + m_nShiftX,
                        dy + m_nSpy + m_nShiftY,
                        m_HumWinSurface,
                        1);
          end else begin;//0x0047CFD4
            if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and
               (m_HumWinSurface <> nil) and boFlag then begin
               DrawBlend (dsurface,
                          dx + m_nSpx + m_nShiftX,
                          dy + m_nSpy + m_nShiftY,
                          m_HumWinSurface,
                          1);
            end;//0x0047D03F
          end;
        end;
      end;//0x0047D03F

      if (m_nWpord = 0) and (not blend) and (m_btWeapon >= 2) and (m_WeaponSurface <> nil) and (not m_boHideWeapon) then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);  //漠篮 祸捞 救函窃
         DrawWeaponGlimmer (dsurface, dx + m_nShiftX, dy + m_nShiftY);
         //dsurface.Draw (dx + wpx + ShiftX, dy + wpy + ShiftY, WeaponSurface.ClientRect, WeaponSurface, TRUE);
      end;
      //个烹 弊府绊
      if m_BodyHorse <> Nil then
         DrawEffSurface (dsurface, m_BodyHorse, dx + m_nHsx + m_nShiftX, dy + m_nHsy + m_nShiftY, blend, ceff);

      if m_BodySurface <> nil then
         DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      if m_HairSurface <> nil then
         DrawEffSurface (dsurface, m_HairSurface, dx + m_nHpx + m_nShiftX, dy + m_nHpy + m_nShiftY, blend, ceff);
         
      if m_BodyHelmet <> nil then
         DrawEffSurface (dsurface, m_BodyHelmet, dx + m_nHelmetx + m_nShiftX, dy + m_nHelmety + m_nShiftY,blend,ceff);
      //
      if (m_nWpord = 1) and {(not blend) and} (m_btWeapon >= 2) and (m_WeaponSurface <> nil) and (not m_boHideWeapon) then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
         DrawWeaponGlimmer (dsurface, dx + m_nShiftX, dy + m_nShiftY);
         //dsurface.Draw (dx + wpx + ShiftX, dy + wpy + ShiftY, WeaponSurface.ClientRect, WeaponSurface, TRUE);
      end;

//      if Dress in [1..4] then begin
//      if Dress in [18..21] then begin
      if (m_btEffect = 50) then begin
        if (m_HumWinSurface <> nil) then
          DrawBlend (dsurface,
                          dx + m_nSpx + m_nShiftX,
                          dy + m_nSpy + m_nShiftY,
                          m_HumWinSurface,
                          1);
      end else
      if m_btEffect <> 0 then begin
        if g_MySelf = Self then begin
          //if blend then begin //080611修正隐身术看到不翅膀
            if blend and ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6)  or (m_btDir = 2)) and
               (m_HumWinSurface <> nil) and not boFlag then begin
               DrawBlend (dsurface,
                          dx + m_nSpx + m_nShiftX,
                          dy + m_nSpy + m_nShiftY,
                          m_HumWinSurface,
                          1);
            end else begin//0x0047D27F
              if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6)  or (m_btDir = 2)) and
                 (m_HumWinSurface <> nil) and boFlag then begin
                DrawBlend (dsurface,
                          dx + m_nSpx + m_nShiftX,
                          dy + m_nSpy + m_nShiftY,
                          m_HumWinSurface,
                          1);
             end;
           // end;
          end;// gogo 0x0047D41D
        end else begin;//0x0047D30D
          if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and
             ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6)  or (m_btDir = 2)) and
             (m_HumWinSurface <> nil) and not boFlag then begin
               DrawBlend (dsurface,
                          dx + m_nSpx + m_nShiftX,
                          dy + m_nSpy + m_nShiftY,
                          m_HumWinSurface,
                          1);
          end else begin;//0x0047D3A0
            if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6)  or (m_btDir = 2)) and
               (m_HumWinSurface <> nil) and boFlag then begin
               DrawBlend (dsurface,
                          dx + m_nSpx + m_nShiftX,
                          dy + m_nSpy + m_nShiftY,
                          m_HumWinSurface,
                          1);
            end;//0x0047D41D
          end;
        end;
      end;//0x0047D41D

      //显示魔法盾时效果
      if (m_nState and $00100000{STATE_BUBBLEDEFENCEUP} <> 0) or
      (m_nState and $02000000{STATE_BUBBLEDEFENCEUP} <> 0) then begin
         if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
            idx := MAGBUBBLESTRUCKBASE + m_nCurBubbleStruck
           else
            idx := MAGBUBBLEBASE + (m_nGenAniCount mod 3);
         d := g_WMagicImages.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);

       if (m_nState and $02000000{STATE_BUBBLEDEFENCEUP} <> 0) then
         begin
         if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
            idx := 720 + m_nCurBubbleStruck
         else
            idx := 716 + (m_nGenAniCount mod 3);
         d := g_WMagic6Images.GetCachedImage(idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
         end;
      end;
   end;

   //显示魔法效果
   //Dscreen.AddSysMsg (IntToStr(1000));
   if m_boUseMagic {and (EffDir[Dir] = 1)} and (m_CurMagic.EffectNumber > 0) then begin
      //Dscreen.AddSysMsg (IntToStr(Integer(m_CurMagic.ClientType))+'  '+IntToStr(m_CurMagic.EffectNumber));
      if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
         //Dscreen.AddSysMsg (IntToStr(Integer(m_CurMagic.ClientType))+'  '+IntToStr(m_CurMagic.EffectNumber));
         GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx);
         if m_CurMagic.EffectNumber=64 then begin
           if m_CurMagic.ClientType=mtFly then idx:=190
           else idx:=210;

         end;
         idx := idx + m_nCurEffFrame;
         if wimg <> nil then
            d := wimg.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
      end;
   end;

   //显示攻击效果
   if m_boHitEffect and (m_nHitEffectNumber > 0) then begin
      GetEffectBase (m_nHitEffectNumber - 1, 1, wimg, idx);
      if m_nHitEffectNumber=11 then idx := idx + (m_nCurrentFrame-m_nStartFrame)
      else idx := idx + m_btDir*10 + (m_nCurrentFrame-m_nStartFrame);
      if wimg <> nil then
         d := wimg.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                          dx + ax + m_nShiftX,
                          dy + ay + m_nShiftY,
                          d, 1);
   end;

   //显示武器破碎效果
   if m_boWeaponEffect then begin
      idx := WPEFFECTBASE + m_btDir * 10 + m_nCurWeaponEffect;
      d := g_WMagicImages.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                     dx + ax + m_nShiftX,
                     dy + ay + m_nShiftY,
                     d, 1);
   end;

   //显示特殊效果
                 {if m_boCorpsShow and (m_nCorpsIdx in [49..58]) then begin
                    GetEffectBase (m_nCorpsIdx, 0, wimg, idx);
                    idx := idx + m_boCorpsEffFrame;
                    if wimg <> nil then
                       d := wimg.GetCachedImage (idx, ax, ay);
                    if d <> nil then
                       DrawBlend (dsurface,
                                  dx + ax + m_nShiftX,
                                  dy + ay + m_nShiftY,
                                  d, 1);
                 end;   }

Except //程序自动增加
  DebugOutStr('[Exception] THumActor.DrawChr'); //程序自动增加
End; //程序自动增加
end;






end.
