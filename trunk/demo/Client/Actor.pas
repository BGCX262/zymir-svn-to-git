unit Actor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grobal2, DxDraws, CliUtil, magiceff, Wil, ClFunc;

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
   FIREHIT_READYFRAME = 6;  //��ȭ�� ���� ������
   MAGBUBBLEBASE = 3890;       //ħ��Ч��ͼ��Magic.WIL�еĿ�ʼ����
   MAGBUBBLESTRUCKBASE = 3900; //ħ��Ч��ͼ��Magic.WIL�еĿ�ʼ����
   MAXWPEFFECTFRAME = 5;
   WPEFFECTBASE = 3750;
   EFFECTBASE = 0;


type

   //��������
   TActionInfo = record
      start   : word;              // ��ʼ֡
      frame   : word;              // ֡��
      skip    : word;              // ������֡��
      ftime   : word;              // ÿ֡���ӳ�ʱ�䣨���룩
      usetick : byte;              //
   end;
   PTActionInfo = ^TActionInfo;

   //��ҵĶ�������
   THumanAction = record
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
   PTHumanAction = ^THumanAction;

   TMonsterAction = record
      ActStand:      TActionInfo;   //1
      ActWalk:       TActionInfo;   //8
      ActAttack:     TActionInfo;   //6
      ActCritical:   TActionInfo;   //6
      ActStruck:     TActionInfo;   //3
      ActDie:        TActionInfo;   //4
      ActDeath:      TActionInfo;
   end;
   PTMonsterAction = ^TMonsterAction;

const
   //���ද������
   //ÿ������ÿ������ÿ���Ա�600��ͼ
   //�輶��=L���Ա�=S����ʼ֡=L*600+600*S
   HA: THumanAction=( //��ʼ֡       ��Ч֡     ����֡    ÿ֡�ӳ�
        ActStand:    (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:     (start: 64;     frame: 6;  skip: 2;  ftime: 90;   usetick: 2);
        ActRun:      (start: 128;    frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActRushLeft: (start: 128;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActRushRight:(start: 131;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActWarMode:  (start: 192;    frame: 1;  skip: 0;  ftime: 200;  usetick: 0);
        ActHit:      (start: 200;    frame: 6;  skip: 2;  ftime: 85;   usetick: 0);
        ActHeavyHit: (start: 264;   frame: 6;  skip: 2;  ftime: 90;   usetick: 0);
        ActBigHit:   (start: 328;    frame: 8;  skip: 0;  ftime: 70;   usetick: 0);
        ActFireHitReady: (start: 192; frame: 6;  skip: 4;  ftime: 70;   usetick: 0);
        ActSpell:    (start: 392;    frame: 6;  skip: 2;  ftime: 60;   usetick: 0);
        ActSitdown:  (start: 456;    frame: 2;  skip: 0;  ftime: 300;  usetick: 0);
        ActStruck:   (start: 472;    frame: 3;  skip: 5;  ftime: 70;  usetick: 0);
        ActDie:      (start: 536;    frame: 4;  skip: 4;  ftime: 120;  usetick: 0)
      );

   MA10: TMonsterAction = (  //ÿ������8֡
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 4;  skip: 4;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA11: TMonsterAction = (  //ÿ������10֡
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 120;  usetick: 3);
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA12: TMonsterAction = (  //ÿ������8֡��ÿ������8�����򣬹�7�ֶ���
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 6;  skip: 2;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 150;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA13: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 10;     frame: 8;  skip: 2;  ftime: 160;  usetick: 0); //����...
        ActAttack: (start: 30;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 110;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 130;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 20;     frame: 9;  skip: 0;  ftime: 150;  usetick: 0); //����..
      );
   MA14: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
      );
   MA15: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 1;      frame: 1;  skip: 0;  ftime: 100;  usetick: 0);
      );
   MA16: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 4;  skip: 6;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 1;  skip: 0;  ftime: 160;  usetick: 0);
      );
   MA17: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 60;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA19: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA20: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 170;  usetick: 0);
      );
   MA21: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActAttack: (start: 10;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 20;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 30;     frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA22: TMonsterAction = (  //
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0); //
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 6;  skip: 4;  ftime: 170;  usetick: 0); //�������
      );
   MA23: TMonsterAction = (  //
        ActStand:  (start: 20;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 100;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 180;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0); //
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 260;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 280;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 20; skip: 0;  ftime: 100;  usetick: 0); //�������
      );
   MA24: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start:240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 420;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA25: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 70;     frame: 10; skip: 0;  ftime: 200;  usetick: 3); //����
        ActAttack: (start: 20;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //��������
        ActCritical:(start: 10;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //��ħ����(���Ÿ�)
        ActStruck: (start: 50;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 60;     frame: 10; skip: 0;  ftime: 200;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA26: TMonsterAction = (  //
        ActStand:  (start: 0;      frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 160;  usetick: 0); //����...
        ActAttack: (start: 56;     frame: 6;  skip: 2;  ftime: 500;  usetick: 0); //����
        ActCritical:(start: 64;    frame: 6;  skip: 2;  ftime: 500;  usetick: 0); //�ݱ�
        ActStruck: (start: 0;      frame: 4;  skip: 4;  ftime: 100;  usetick: 0);
        ActDie:    (start: 24;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 150;  usetick: 0); //����..
      );
   MA27: TMonsterAction = (  //
        ActStand:  (start: 0;     frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;     frame: 0;  skip: 0;  ftime: 160;  usetick: 0); //����...
        ActAttack: (start: 0;     frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActCritical:(start: 0;    frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActStruck: (start: 0;     frame: 0;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 0;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;     frame: 0;  skip: 0;  ftime: 150;  usetick: 0); //����..
      );
   MA28: TMonsterAction = (  //
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start:  0;     frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0); //����..
      );
   MA29: TMonsterAction = (  //
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0); //����..
      );
   MA50: TMonsterAction = (
        ActStand:  (start: 0;    frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;    frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
        ActAttack: (start: 30;   frame: 10; skip: 0;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 0;    frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
        ActDie:    (start: 0;    frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
        ActDeath:  (start: 0;    frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
      );


   WORDER: Array[0..1, 0..599] of byte = (  //��һά���Ա𣬵ڶ�ά�Ƕ���ͼƬ����
      (
      //վ
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //��
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //��
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war
      0,1,1,1,0,0,0,0,
      //��
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //�� 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //��3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //����
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //�ر�
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //�±�
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //������
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      ),

      (
      //����
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //�ȱ�
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //�ٱ�
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war���
      1,1,1,1,0,0,0,0,
      //����
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //���� 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //����3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //����
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //�ر�
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //�±�
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //������
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      )
   );

   EffDir : array[0..7] of byte = (0, 0, 1, 1, 1, 1, 1, 0);


type
   TActor = class
      RecogId: integer;
      XX:   word;
      YY:   word;
      Dir:  byte;
      Sex:  byte;
      Race:    byte;
      Hair:    byte;
      Dress:   byte;
      Weapon:  byte;
      Job:  byte;           //սʿ 0:��ʦ  1:��ʿ  2:����
      Appearance: word;     // DIV 10=���壨��ò���� Mod 10=��òͼƬ��ͼƬ���е�λ�ã��ڼ��֣�
      DeathState: byte;     //����״̬
      Feature: integer;     //
      State:   integer;     //״̬
      Death: Boolean;
      Skeleton: Boolean;
      BoDelActor: Boolean;
      BoDelActionAfterFinished: Boolean;
      DescUserName: string; //��ҵ�����
      UserName: string;     //���ID
      NameColor: integer;   //���ֵ���ɫ
      Abil: TAbility;       //����
      Gold: integer;        //�������
      HitSpeed: shortint;   //�����ٶ� 0: ����, (-)���� (+)�ӿ�
      Visible: Boolean;
      BoHoldPlace: Boolean;

      Saying: array[0..MAXSAY-1] of string;     //���˵�Ļ�
      SayWidths: array[0..MAXSAY-1] of integer; //ÿ�仰�Ŀ��
      SayTime: longword;
      SayX, SayY: integer;
      SayLineCount: integer;

      ShiftX:  integer;
      ShiftY:  integer;

      px, hpx, wpx:   integer;       //���塢ͷ��������ͼƬ��ʾλ��
      py, hpy, wpy:   integer;
      Rx, Ry: integer;
      DownDrawLevel: integer;        //�� �� ������ �׸��� ��...
      TargetX, TargetY: integer;     //�ƶ���Ŀ��λ������
      TargetRecog: integer;          //
      HiterCode: integer;
      MagicNum: integer;
      CurrentEvent: integer;         //������ �̺�Ʈ ���̵�
      BoDigFragment: Boolean;        //�����У�
      BoThrow: Boolean;

      BodyOffset, HairOffset, WeaponOffset: integer;
      BoUseMagic: Boolean;
      BoHitEffect: Boolean;
      BoUseEffect: Boolean;          //ȿ���� ����ϴ���..
      HitEffectNumber: integer;
      WaitMagicRequest: longword;
      WaitForRecogId: integer;       //�ڽ��� ������� WaitFor�� actor�� visible ��Ų��.
      WaitForFeature: integer;
      WaitForStatus: integer;


      CurEffFrame: integer;
      SpellFrame: integer;           //������ ���� ������
      CurMagic: TUseMagicInfo;
      //GlimmingMode: Boolean;
      //CurGlimmer: integer;
      //MaxGlimmer: integer;
      //GlimmerTime: longword;
      GenAniCount: integer;
      BoOpenHealth: Boolean;
      BoInstanceOpenHealth: Boolean;
      OpenHealthStart: longword;
      OpenHealthTime: integer;

      //SRc: TRect;  //Screen Rect ȭ���� ������ǥ(���콺 ����)
      BodySurface: TDirectDrawSurface;

      Grouped: Boolean; //���� �׷��� ���
      CurrentAction: integer;
      ReverseFrame: Boolean;
      WarMode: Boolean;
      WarModeTime: longword;
      ChrLight: integer;
      MagLight: integer;
      RushDir: integer;  //0, 1 �ѹ��� ���� �ѹ��� ������

      LockEndFrame: Boolean;
      LastStruckTime: longword;
      SendQueryUserNameTime: longword;
      DeleteTime: longword;

      //���� ȿ��
      MagicStruckSound: integer;
      borunsound: Boolean;
      footstepsound: integer;  //���ΰ��ΰ��, CM_WALK, CM_RUN
      strucksound: integer;  //������ ���� �Ҹ�    SM_STRUCK
      struckweaponsound: integer;

      appearsound: integer;  //����Ҹ� 0
      normalsound: integer;  //�ϹݼҸ� 1
      attacksound: integer;  //         2
      weaponsound: integer; //          3
      screamsound: integer;  //         4
      diesound: integer;     //������   5  ���� �Ҹ�    SM_DEATHNOW
      die2sound: integer;

      magicstartsound: integer;
      magicfiresound: integer;
      magicexplosionsound: integer;

   private
   protected
      startframe: integer;
      endframe: integer;
      currentframe: integer;
      effectstart: integer;
      effectframe: integer;
      effectend: integer;
      effectstarttime: longword;
      effectframetime: longword;
      frametime: longword;   //�� �����Ӵ� �ð�
      starttime: longword;   //�ֱ��� �������� ���� �ð�
      maxtick: integer;
      curtick: integer;
      movestep: integer;
      msgmuch: Boolean;
      struckframetime: longword;
      currentdefframe: integer;
      defframetime: longword;
      defframecount: integer;
      SkipTick: integer;
      smoothmovetime: longword;
      genanicounttime: longword;
      loadsurfacetime: longword;

      oldx, oldy, olddir: integer;
      actbeforex, actbeforey: integer;  //�ൿ ���� ��ǥ
      wpord: integer;

      procedure CalcActorFrame; dynamic;
      procedure DefaultMotion; dynamic;
      function  GetDefaultFrame (wmode: Boolean): integer; dynamic;
      procedure DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
      procedure DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
   public
      MsgList: TList;       //list of PTChrMsg
      RealActionMsg: TChrMsg; //FrmMain���� �����

      constructor Create; dynamic;
      destructor Destroy; override;
      procedure  SendMsg (ident: word; x, y, cdir, feature, state: integer; str: string; sound: integer);
      procedure  UpdateMsg (ident: word; x, y, cdir, feature, state: integer; str: string; sound: integer);
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
      procedure  RunFrameAction (frame: integer); dynamic;  //�����Ӹ��� ��Ư�ϰ� �ؾ�����
      procedure  ActionEnded; dynamic;
      function   Move (step: integer): Boolean;
      procedure  MoveFail;
      function   CanCancelAction: Boolean;
      procedure  CancelAction;
      procedure  FeatureChanged; dynamic;
      function   Light: integer; dynamic;
      procedure  LoadSurface; dynamic;
      function   GetDrawEffectValue: TColorEffect;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean); dynamic;
      procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); dynamic;
   end;

   TNpcActor = class (TActor)
   private
   public
      procedure  Run; override;
      procedure  CalcActorFrame; override;
      function   GetDefaultFrame (wmode: Boolean): integer; override;
      procedure  LoadSurface; override;
   end;

   THumActor = class (TActor)
   private
      HairSurface: TDirectDrawSurface;
      WeaponSurface: TDirectDrawSurface;
      BoWeaponEffect: Boolean;  //���� ���ü���,���� ȿ��
      CurWpEffect: integer;
      CurBubbleStruck: integer;
      wpeffecttime: longword;
      BoHideWeapon: Boolean;
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
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean); override;
   end;

   function RaceByPM (race: integer): PTMonsterAction;
   function GetMonImg (appr: integer): TWMImages;
   function GetOffset (appr: integer): integer;



implementation

uses
   ClMain, SoundUtil, clEvent;

//�������巵�ض�������
function RaceByPM (race: integer): PTMonsterAction;
begin
   Result := nil;
   case race of
      10:      Result := @MA10;
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
      32:      Result := @MA24;  //����, ������ 2���� ���
      33:      Result := @MA25;
      54:      Result := @MA28;
      55:      Result := @MA29;
      98:      Result := @MA27;
      99:      Result := @MA26;
      50:      Result := @MA50;
   end;
end;
//������òȷ��ͼƬ��
function GetMonImg (appr: integer): TWMImages;
begin
   Result := FrmMain.WMonImg; //Default
   case (appr div 10) of
      0: Result := FrmMain.WMonImg;   //
      1: Result := FrmMain.WMon2Img;  //������
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
      90: Result := FrmMain.WEffectImg;  //����, ����
   end;
end;

function GetOffset (appr: integer): integer;
var
   nrace, npos: integer;
begin
   Result := 0;
   nrace := appr div 10;
   npos := appr mod 10;
   case nrace of
      0:    Result := npos * 280;  //8������
      1:    Result := npos * 230;
      2, 3, 7..16:    Result := npos * 360;  //10������ �⺻
      4:    begin
               Result := npos * 360;        //
               if npos = 1 then Result := 600;  //�񸷿���
            end;
      5:    Result := npos * 430;   //����
      6:    Result := npos * 440;   //�ָ�����,ȣ��,��
      17:   Result := npos * 350;   //�ż�
      90:   case npos of
               0: Result := 80;   //����
               1: Result := 168;
               2: Result := 184;
               3: Result := 200;
            end;
   end;
end;


constructor TActor.Create;
begin
   inherited Create;
   MsgList := TList.Create;
   RecogId := 0;
   BodySurface := nil;
   FillChar (Abil, sizeof(TAbility), 0);
   Gold := 0;
   Visible := TRUE;
   BoHoldPlace := TRUE;

   //���� �������� ����, ����� ������ ����
   //������ currentframe�� endframe�� �Ѿ����� ������ �Ϸ�Ȱ����� ��
   CurrentAction := 0;
   ReverseFrame := FALSE;
   ShiftX := 0;
   ShiftY := 0;
   DownDrawLevel := 0;
   currentframe := -1;
   effectframe := -1;
   RealActionMsg.Ident := 0;
   UserName := '';
   NameColor := clWhite;
   SendQueryUserNameTime := 0; //GetTickCount;

   WarMode := FALSE;
   WarModeTime := 0;    //War mode�� ����� ������ �ð�
   Death := FALSE;
   Skeleton := FALSE;
   BoDelActor := FALSE;
   BoDelActionAfterFinished := FALSE;
   
   ChrLight := 0;
   MagLight := 0;
   LockEndFrame := FALSE;
   smoothmovetime := 0; //GetTickCount;
   genanicounttime := 0;
   defframetime := 0;
   loadsurfacetime := GetTickCount;
   Grouped := FALSE;
   BoOpenHealth := FALSE;
   BoInstanceOpenHealth := FALSE;

   CurMagic.ServerMagicCode := 0;
   //CurMagic.MagicSerial := 0;
   
   SpellFrame := DEFSPELLFRAME;

   normalsound := -1;
   footstepsound := -1; //����  //���ΰ��ΰ��, CM_WALK, CM_RUN
   attacksound := -1;
   weaponsound := -1;
   strucksound := s_struck_body_longstick;  //������ ���� �Ҹ�    SM_STRUCK
   struckweaponsound := -1;
   screamsound := -1;
   diesound := -1;    //����    //������ ���� �Ҹ�    SM_DEATHNOW
   die2sound := -1;
end;

destructor TActor.Destroy;
begin
   MsgList.Free;
   inherited Destroy;
end;

//��ɫ���յ�����Ϣ
procedure TActor.SendMsg (ident: word; x, y, cdir, feature, state: integer; str: string; sound: integer);
var
   pmsg: PTChrMsg;
begin
   new (pmsg);
   pmsg.ident  := ident;
   pmsg.x      := x;
   pmsg.y      := y;
   pmsg.dir    := cdir;
   pmsg.feature:= feature;
   pmsg.state  := state;
   pmsg.saying := str;
   pmsg.Sound := sound;
   MsgList.Add (pmsg);
end;

//������Ϣ���£����Ѿ����ڣ���Ϣ�б�
procedure TActor.UpdateMsg (ident: word; x, y, cdir, feature, state: integer; str: string; sound: integer);
var
   i, n: integer;
   pmsg: PTChrMsg;
begin
   if self = Myself then begin  //��ǰ���������
      n := 0;
      while TRUE do begin
         if n >= MsgList.Count then break;
         if (PTChrMsg (MsgList[n]).Ident >= 3000) and //Ŭ���̾�Ʈ���� ���� �޼�����
            (PTChrMsg (MsgList[n]).Ident <= 3099) or  //�����ص� �ȴ�.
            (PTChrMsg (MsgList[n]).Ident = ident)     //������ ����
         then begin
            Dispose (PTChrMsg (MsgList[n]));          //ɾ���Ѿ����ڵ���ͬ��Ϣ
            MsgList.Delete (n);
         end else
            Inc (n);
      end;
      SendMsg (ident, x, y, cdir, feature, state, str, sound);  //�����Ϣ
   end else begin            //��ǰ���������
      if MsgList.Count > 0 then begin
         for i:=0 to MsgList.Count-1 do begin
            if PTChrMsg (MsgList[i]).Ident = ident then begin
               Dispose (PTChrMsg (MsgList[i]));
               MsgList.Delete (i);
               break;
            end;
         end;
      end;
      SendMsg (ident, x, y, cdir, feature, state, str, sound);
   end;
end;

//�����Ϣ����[3000,3099]֮�����Ϣ
procedure TActor.CleanUserMsgs;
var
   n: integer;
begin
   n := 0;
   while TRUE do begin
      if n >= MsgList.Count then break;
      if (PTChrMsg (MsgList[n]).Ident >= 3000) and //Ŭ���̾�Ʈ���� ���� �޼�����
         (PTChrMsg (MsgList[n]).Ident <= 3099)     //�����ص� �ȴ�.
         then begin
         Dispose (PTChrMsg (MsgList[n]));
         MsgList.Delete (n);
      end else
         Inc (n);
   end;
end;

//���㶯���Ŀ�ʼ֡��֡����
procedure TActor.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
   BoUseMagic := FALSE;
   currentframe := -1;

   BodyOffset := GetOffset (Appearance);
   pm := RaceByPM (Race);
   if pm = nil then exit;

   case CurrentAction of
      SM_TURN:
         begin
            startframe := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            endframe := startframe + pm.ActStand.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := pm.ActStand.frame;
            Shift (Dir, 0, 0, 1);
         end;
      SM_WALK, SM_RUSH, SM_RUSHKUNG, SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            endframe := startframe + pm.ActWalk.frame - 1;
            frametime := pm.ActWalk.ftime;
            starttime := GetTickCount;
            maxtick := pm.ActWalk.UseTick;
            curtick := 0;
            movestep := 1;
            if CurrentAction = SM_BACKSTEP then
               Shift (GetBack(Dir), movestep, 0, endframe-startframe+1)
            else
               Shift (Dir, movestep, 0, endframe - startframe+1);
         end;
      SM_HIT:
         begin
            startframe := pm.ActAttack.start + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            startframe := pm.ActStruck.start + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
            endframe := startframe + pm.ActStruck.frame - 1;
            frametime := struckframetime; //pm.ActStruck.ftime;
            starttime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end;
      SM_DEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            startframe := endframe; //
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            startframe := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip);
            endframe := startframe + pm.ActDie.frame - 1;
            frametime := pm.ActDie.ftime;
            starttime := GetTickCount;
         end;
      SM_SKELETON:
         begin
            startframe := pm.ActDeath.start + Dir;
            endframe := startframe + pm.ActDeath.frame - 1;
            frametime := pm.ActDeath.ftime;
            starttime := GetTickCount;
         end;
   end;
end;

procedure TActor.ReadyAction (msg: TChrMsg);
var
   n: integer;
   pmag: PTUseMagicInfo;
begin
   actbeforex := XX;
   actbeforey := YY;

   if msg.Ident = SM_ALIVE then begin
      Death := FALSE;
      Skeleton := FALSE;
   end;

   if not Death then begin
      case msg.Ident of
         SM_TURN, SM_WALK, SM_BACKSTEP, SM_RUSH, SM_RUSHKUNG, SM_RUN, SM_DIGUP, SM_ALIVE:
            begin
               Feature := msg.feature;
               State := msg.state;
               //�Ƿ񷵻ص�������
               if State and STATE_OPENHEATH <> 0 then BoOpenHealth := TRUE
               else BoOpenHealth := FALSE;
            end;
      end;
      if msg.ident = SM_LIGHTING then
         n := 0;
      if Myself = self then begin
         if (msg.Ident = CM_WALK) then
            if not PlayScene.CanWalk (msg.x, msg.y) then
               exit;  //��������
         if (msg.Ident = CM_RUN) then
            if not PlayScene.CanRun (Myself.XX, Myself.YY, msg.x, msg.y) then
               exit; //������
         //msg
         case msg.Ident of
            CM_TURN,
            CM_WALK,
            CM_SITDOWN,
            CM_RUN,
            CM_HIT,
            CM_POWERHIT,
            CM_LONGHIT,
            CM_WIDEHIT,
            CM_HEAVYHIT,
            CM_BIGHIT:
               begin
                  RealActionMsg := msg; //���� ����ǰ� �ִ� �ൿ, ������ �޼����� ����.
                  msg.Ident := msg.Ident - 3000;//   CM_??ת��Ϊ��Ӧ��SM_?? 
               end;
            CM_THROW:
               begin
                  if feature <> 0 then begin
                     TargetX := TActor(msg.feature).XX;    //x ��֪���������ת����ʲô��˼���ѵ�msg.feature��һ����ַ��
                     TargetY := TActor(msg.feature).YY;    //y
                     TargetRecog := TActor(msg.feature).RecogId;
                  end;
                  RealActionMsg := msg;
                  msg.Ident := SM_THROW;
               end;
            CM_FIREHIT:
               begin
                  RealActionMsg := msg;
                  msg.Ident := SM_FIREHIT;
               end;
            CM_SPELL:
               begin
                  RealActionMsg := msg;
                  pmag := PTUseMagicInfo (msg.feature);     //msg.feature����һ����ַ��
                  RealActionMsg.Dir := pmag.MagicSerial;
                  msg.Ident := msg.Ident - 3000;  //SM_?? ���� ��ȯ ��
               end;
         end;

         oldx := XX;
         oldy := YY;
         olddir := Dir;
      end;
      case msg.Ident of
         SM_STRUCK:
            begin
               MagicStruckSound := msg.x; //1�̻�, ����ȿ��
               n := Round (200 - Abil.Level * 5);
               if n > 80 then struckframetime := n
               else struckframetime := 80;
               LastStruckTime := GetTickCount;
            end;
         SM_SPELL:
            begin
               Dir := msg.dir;
               //msg.x  :targetx
               //msg.y  :targety
               pmag := PTUseMagicInfo (msg.feature);
               if pmag <> nil then begin
                  CurMagic := pmag^;
                  CurMagic.ServerMagicCode := -1; //FIRE ���
                  //CurMagic.MagicSerial := 0;
                  CurMagic.TargX := msg.x;
                  CurMagic.TargY := msg.y;
                  Dispose (pmag);
               end;
               //DScreen.AddSysMsg ('SM_SPELL');
            end;
         else begin
               XX := msg.x;
               YY := msg.y;
               Dir := msg.dir;
            end;
      end;

      CurrentAction := msg.Ident;
      CalcActorFrame;
      //DScreen.AddSysMsg (IntToStr(msg.Ident) + ' ' + IntToStr(XX) + ' ' + IntToStr(YY) + ' : ' + IntToStr(msg.x) + ' ' + IntToStr(msg.y));
   end else begin
      if msg.Ident = SM_SKELETON then begin
         CurrentAction := msg.Ident;
         CalcActorFrame;
         Skeleton := TRUE;
      end;
   end;
   if (msg.Ident = SM_DEATH) or (msg.Ident = SM_NOWDEATH) then begin
      Death := TRUE;
      PlayScene.ActorDied (self);
   end;
   RunSound;
end;

procedure TActor.ProcMsg;
var
   msg: TChrMsg;
   meff: TMagicEff;
begin
   while TRUE do begin
      if MsgList.Count <= 0 then break;
      if CurrentAction <> 0 then break;
      msg := PTChrMsg (MsgList[0])^;
      Dispose (PTChrMsg (MsgList[0]));
      MsgList.Delete (0);
      case msg.ident of
         SM_STRUCK:
            begin
               HiterCode := msg.Sound; //���� ������
               ReadyAction (msg);
            end;
         SM_DEATH,
         SM_NOWDEATH,
         SM_SKELETON,
         SM_ALIVE,
         SM_ACTION_MIN..SM_ACTION_MAX,
         SM_ACTION2_MIN..SM_ACTION2_MAX,
         4000..4099: //3000..3099  Ŭ���̾�Ʈ �̵� �޼����� �����
            begin
               ReadyAction (msg);
            end;
         SM_SPACEMOVE_HIDE:
            begin
               meff := TScrollHideEffect.Create (250, 10, XX, YY, self);
               PlayScene.EffectList.Add (meff);
               PlaySound (s_spacemove_out);
            end;
         SM_SPACEMOVE_HIDE2:
            begin
               meff := TScrollHideEffect.Create (1590, 10, XX, YY, self);
               PlayScene.EffectList.Add (meff);
               PlaySound (s_spacemove_out);
            end;
         SM_SPACEMOVE_SHOW:
            begin
               meff := TCharEffect.Create (260, 10, self);
               PlayScene.EffectList.Add (meff);
               msg.ident := SM_TURN;
               ReadyAction (msg);
               PlaySound (s_spacemove_in);
            end;
         SM_SPACEMOVE_SHOW2:
            begin
               meff := TCharEffect.Create (1600, 10, self);
               PlayScene.EffectList.Add (meff);
               msg.ident := SM_TURN;
               ReadyAction (msg);
               PlaySound (s_spacemove_in);
            end;
         else
            begin
            end;
      end;
   end;

end;

procedure TActor.ProcHurryMsg; //���� ó���ؾ� �Ǵ� �޼��� ó����..
var
   n: integer;
   msg: TChrMsg;
   fin: Boolean;
begin
   n := 0;
   while TRUE do begin
      if MsgList.Count <= n then break;
      msg := PTChrMsg (MsgList[n])^;
      fin := FALSE;
      case msg.Ident of
         SM_MAGICFIRE:
            if CurMagic.ServerMagicCode <> 0 then begin
               CurMagic.ServerMagicCode := 111;
               CurMagic.Target := msg.x;
               if msg.y in [0..MAXMAGICTYPE-1] then
                  CurMagic.EffectType := TMagicType(msg.y);
               CurMagic.EffectNumber := msg.dir;
               CurMagic.TargX := msg.feature;
               CurMagic.TargY := msg.state;
               CurMagic.Recusion := TRUE;
               fin := TRUE;
               //DScreen.AddSysMsg ('SM_MAGICFIRE GOOD');
            end;
         SM_MAGICFIRE_FAIL:
            if CurMagic.ServerMagicCode <> 0 then begin
               CurMagic.ServerMagicCode := 0;
               fin := TRUE;
            end;
      end;
      if fin then begin
         Dispose (PTChrMsg (MsgList[n]));
         MsgList.Delete (n);
      end else
         Inc (n);
   end;
end;

//��ǰ�Ƿ�û�п�ִ�еĶ���
function  TActor.IsIdle: Boolean;
begin
   Result := (CurrentAction = 0) and (MsgList.Count = 0);
end;

//��ǰ�����Ƿ��Ѿ����
function  TActor.ActionFinished: Boolean;
begin
   Result :=(CurrentAction = 0) or (currentframe >= endframe);
end;

function  TActor.CanWalk: Integer;
begin
   if (GetTickCount - LatestSpellTime < MagicPKDelayTime) then
      Result := -1   //������
   else
      Result := 1;
end;

function  TActor.CanRun: Integer;
begin
   Result := 1;
   if Abil.HP < RUN_MINHEALTH then begin //��ǰ�����Ƿ�С���߶�ʱ��Ҫ���ĵ���С����
      Result := -1;
   end else   //�����κ�3���ڻ�����С��ħ��������ʱ�䶼��������
     if (GetTickCount - LastStruckTime < 3*1000) or (GetTickCount - LatestSpellTime < MagicPKDelayTime) then
       Result := -2;
end;

//�Ƿ񱻴���
function  TActor.Strucked: Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to MsgList.Count-1 do begin
      if PTChrMsg (MsgList[i]).Ident = SM_STRUCK then begin
         Result := TRUE;
         break;
      end;
   end;
end;


//dir : ����
//step : ����  (����1������2��
//cur : ��ǰ֡(ȫ��֡�еĵڼ�֡��
//max : ȫ��֡
procedure TActor.Shift (dir, step, cur, max: integer);
var
   unx, uny, ss, v: integer;
begin
   unx := UNITX * step;
   uny := UNITY * step;
   if cur > max then cur := max;
   Rx := XX;
   Ry := YY;
   ss := Round((max-cur-1) / max) * step;
   case dir of
      DR_UP:
         begin
            ss := Round((max-cur) / max) * step;
            ShiftX := 0;
            Ry := YY + ss;
            if ss = step then ShiftY := -Round(uny / max * cur)
            else ShiftY := Round(uny / max * (max-cur));
         end;
      DR_UPRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            Rx := XX - ss;
            Ry := YY + ss;
            if ss = step then begin
               ShiftX :=  Round(unx / max * cur);
               ShiftY := -Round(uny / max * cur);
            end else begin
               ShiftX := -Round(unx / max * (max-cur));
               ShiftY :=  Round(uny / max * (max-cur));
            end;
         end;
      DR_RIGHT:
         begin
            ss := Round((max-cur) / max) * step;
            Rx := XX - ss;
            if ss = step then ShiftX := Round(unx / max * cur)
            else ShiftX := -Round(unx / max * (max-cur));
            ShiftY := 0;
         end;
      DR_DOWNRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            Rx := XX - ss;
            Ry := YY - ss;
            if ss = step then begin
               ShiftX := Round(unx / max * cur);
               ShiftY := Round(uny / max * cur);
            end else begin
               ShiftX := -Round(unx / max * (max-cur));
               ShiftY := -Round(uny / max * (max-cur));
            end;
         end;
      DR_DOWN:
         begin
            if max >= 6 then v := 1
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            ShiftX := 0;
            Ry := YY - ss;
            if ss = step then ShiftY := Round(uny / max * cur)
            else ShiftY := -Round(uny / max * (max-cur));
         end;
      DR_DOWNLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            Rx := XX + ss;
            Ry := YY - ss;
            if ss = step then begin
               ShiftX := -Round(unx / max * cur);
               ShiftY :=  Round(uny / max * cur);
            end else begin
               ShiftX :=  Round(unx / max * (max-cur));
               ShiftY := -Round(uny / max * (max-cur));
            end;
         end;
      DR_LEFT:
         begin
            ss := Round((max-cur) / max) * step;
            Rx := XX + ss;
            if ss = step then ShiftX := -Round(unx / max * cur)
            else ShiftX := Round(unx / max * (max-cur));
            ShiftY := 0;
         end;
      DR_UPLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            Rx := XX + ss;
            Ry := YY + ss;
            if ss = step then begin
               ShiftX := -Round(unx / max * cur);
               ShiftY := -Round(uny / max * cur);
            end else begin
               ShiftX := Round(unx / max * (max-cur));
               ShiftY := Round(uny / max * (max-cur));
            end;
         end;
   end;
end;

procedure  TActor.FeatureChanged;
var
   haircount: integer;
begin
   case Race of
      //human
      0: begin
         hair   := HAIRfeature (Feature);         //����ȴ�.
         dress  := DRESSfeature (Feature);
         weapon := WEAPONfeature (Feature);
         BodyOffset := HUMANFRAME * Dress; //����0, ����1
         haircount := FrmMain.WHairImg.ImageCount div HUMANFRAME div 2;
         if hair > haircount-1 then hair := haircount-1;
         hair := hair * 2;
         if hair > 1 then
            HairOffset := HUMANFRAME * (hair + Sex)
         else HairOffset := -1;
         WeaponOffset := HUMANFRAME * weapon; //(weapon*2 + Sex);
      end;
      50: ;  //npc
      else begin
         Appearance := APPRfeature (Feature);
         BodyOffset := GetOffset (Appearance);
         //BodyOffset := MONFRAME * (Appearance mod 10);
      end;
   end;
end;

function   TActor.Light: integer;
begin
   Result := ChrLight;
end;

//װ�ص�ǰ������Ӧ��ͼƬ
procedure  TActor.LoadSurface;
var
   mimg: TWMImages;
begin
   mimg := GetMonImg (Appearance);
   if mimg <> nil then begin
      if (not ReverseFrame) then
         BodySurface := mimg.GetCachedImage (GetOffset (Appearance) + currentframe, px, py)
      else
         BodySurface := mimg.GetCachedImage (
                            GetOffset (Appearance) + endframe - (currentframe-startframe),
                            px, py);
   end;
end;

//ȡ��ɫ�Ŀ��
function  TActor.CharWidth: Integer;
begin
   if BodySurface <> nil then
      Result := BodySurface.Width
   else Result := 48;
end;

//ȡ��ɫ�ĸ߶�
function  TActor.CharHeight: Integer;
begin
   if BodySurface <> nil then
      Result := BodySurface.Height
   else Result := 70;
end;

//�ж�ĳһ���Ƿ��ǽ�ɫ������
function  TActor.CheckSelect (dx, dy: integer): Boolean;
var
   c: integer;
begin
   Result := FALSE;
   if BodySurface <> nil then begin
      c := BodySurface.Pixels[dx, dy];
      if (c <> 0) and
         ((BodySurface.Pixels[dx-1, dy] <> 0) and
          (BodySurface.Pixels[dx+1, dy] <> 0) and
          (BodySurface.Pixels[dx, dy-1] <> 0) and
          (BodySurface.Pixels[dx, dy+1] <> 0)) then
         Result := TRUE;
   end;
end;

procedure TActor.DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
begin
   if State and $00800000 <> 0 then begin  //����
      blend := TRUE;  //�����ʾ
   end;
   if not Blend then begin
      if ceff = ceNone then begin      //ɫ����Ч������͸��Ч��ֱ����ʾ
         if source <> nil then
            dsurface.Draw (ddx, ddy, source.ClientRect, source, TRUE);
      end else begin
         if source <> nil then begin   //������ɫ���Ч�����ٻ���
            ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
            DrawEffect (0, 0, source.Width, source.Height, ImgMixSurface, ceff);
            dsurface.Draw (ddx, ddy, source.ClientRect, ImgMixSurface, TRUE);
         end;
      end;
   end else begin
      if ceff = ceNone then begin
         if source <> nil then
            DrawBlend (dsurface, ddx, ddy, source, 0);
      end else begin
         if source <> nil then begin
            ImgMixSurface.Fill(0);
            ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
            DrawEffect (0, 0, source.Width, source.Height, ImgMixSurface, ceff);
            DrawBlend (dsurface, ddx, ddy, ImgMixSurface, 0);
         end;
      end;
   end;
end;

//��������˸��
procedure TActor.DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
begin
   //������..(��ȭ��) �׷��� ����...
   (*if BoNextTimeFireHit and WarMode and GlimmingMode then begin
      if GetTickCount - GlimmerTime > 200 then begin
         GlimmerTime := GetTickCount;
         Inc (CurGlimmer);
         if CurGlimmer >= MaxGlimmer then CurGlimmer := 0;
      end;
      idx := GetEffectBase (5-1{��ȭ���¦��}, 1) + Dir*10 + CurGlimmer;
      d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface, ddx + ax, ddy + ay, d, 1);
                          //dx + ax + ShiftX,
                          //dy + ay + ShiftY,
                          //d, 1);
   end;*)
end;

//���ݵ�ǰ״̬state�����ɫЧ���������ж�״̬�ȣ�������ʾ����ɫ�Ϳ��ܲ�ͬ��
function TActor.GetDrawEffectValue: TColorEffect;
var
   ceff: TColorEffect;
begin
   ceff := ceNone;

   //���õ� ĳ�� ���.
   if (FocusCret = self) or (MagicTarget = self) then begin
      ceff := ceBright;
   end;

   //�ߵ�
   if State and $80000000 <> 0 then begin
      ceff := ceGreen;
   end;
   if State and $40000000 <> 0 then begin
      ceff := ceRed;
   end;
   if State and $20000000 <> 0 then begin
      ceff := ceBlue;
   end;
   if State and $10000000 <> 0 then begin
      ceff := ceYellow;
   end;
   //�����
   if State and $08000000 <> 0 then begin
      ceff := ceFuchsia;
   end;
   if State and $04000000 <> 0 then begin
      ceff := ceGrayScale;
   end;
   Result := ceff;
end;

//��ʾ��ɫ
procedure TActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
begin
   if not (Dir in [0..7]) then exit;
   if GetTickCount - loadsurfacetime > 60 * 1000 then begin
      loadsurfacetime := GetTickCount;
      LoadSurface; //����ͼƬÿ60����ͷ�һ�Σ�60����δʹ�õĻ���������ÿ60��Ҫ���һ���Ƿ��Ѿ����ͷ��ˡ�
   end;

   ceff := GetDrawEffectValue;

   if BodySurface <> nil then begin
      DrawEffSurface (dsurface, BodySurface, dx + px + ShiftX, dy + py + ShiftY, blend, ceff);
   end;

   if BoUseMagic {and (EffDir[Dir] = 1)} and (CurMagic.EffectNumber > 0) then
      if CurEffFrame in [0..SpellFrame-1] then begin
         GetEffectBase (Curmagic.EffectNumber-1, 0, wimg, idx);
         idx := idx + CurEffFrame;
         if wimg <> nil then
            d := wimg.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + ShiftX,
                             dy + ay + ShiftY,
                             d, 1);
      end;
end;

procedure  TActor.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
end;

//ȱʡ֡
function  TActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
   pm := RaceByPM (Race);
   if pm = nil then exit;

   if Death then begin             //����
      if Skeleton then             //����
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + Dir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      defframecount := pm.ActStand.frame;
      if currentdefframe < 0 then cf := 0
      else if currentdefframe >= pm.ActStand.frame then cf := 0
      else cf := currentdefframe;
      Result := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
end;

procedure TActor.DefaultMotion;   //ȱʡ����
begin
   ReverseFrame := FALSE;
   if WarMode then begin
      if (GetTickCount - WarModeTime > 4*1000) then //and not BoNextTimeFireHit then //ս��״ֻ̬��4��
         WarMode := FALSE;
   end;
   currentframe := GetDefaultFrame (WarMode);
   Shift (Dir, 0, 1, 1);
end;

//������Ч
procedure TActor.SetSound;
var
   cx, cy, bidx, wunit, attackweapon: integer;
   hiter: TActor;
begin
   if Race = 0 then begin                  //�������
      if (self = Myself) and               //��������
         ((CurrentAction=SM_WALK) or
          (CurrentAction=SM_BACKSTEP) or
          (CurrentAction=SM_RUN) or
          (CurrentAction=SM_RUSH) or
          (CurrentAction=SM_RUSHKUNG)
         )
      then begin
         cx := Myself.XX - Map.BlockLeft;
         cy := Myself.YY - Map.BlockTop;
         cx := cx div 2 * 2;
         cy := cy div 2 * 2;
         bidx := Map.MArr[cx, cy].BkImg and $7FFF;  //����ͼ����
         wunit := Map.MArr[cx, cy].Area;
         bidx := wunit * 10000 + bidx - 1;    //�����������������������������10000�Ƿ�Ӧ����1000��������
         case bidx of
              330..349, 450..454, 550..554, 750..754,
            950..954, 1250..1254, 1400..1424, 1455..1474,
            1500..1524, 1550..1574:
               footstepsound := s_walk_lawn_l;   //�ݵ�������

            250..254, 1005..1009, 1050..1054, 1060..1064, 1450..1454,
            1650..1654:
               footstepsound := s_walk_rough_l;  //�ֲڵĵ���

            605..609, 650..654, 660..664, 2000..2049,
            3025..3049, 2400..2424, 4625..4649, 4675..4678:
               footstepsound := s_walk_stone_l;  //ʯͷ����������

            1825..1924, 2150..2174, 3075..3099, 3325..3349,
            3375..3399:
               footstepsound := s_walk_cave_l;   //��Ѩ������

           3230, 3231, 3246, 3277:
               footstepsound := s_walk_wood_l;   //ľͷ��������

           3780..3799:
               footstepsound := s_walk_wood_l;   //

           3825..4434:
               if (bidx-3825) mod 25 = 0 then footstepsound := s_walk_wood_l
               else footstepsound := s_walk_ground_l;

             2075..2099, 2125..2149:
               footstepsound := s_walk_room_l;    //������

            1800..1824:
               footstepsound := s_walk_water_l;   //ˮ��

            else
               footstepsound := s_walk_ground_l;
         end;

         if (bidx >= 825) and (bidx <= 1349) then begin
            if ((bidx-825) div 25) mod 2 = 0 then
               footstepsound := s_walk_stone_l;
         end;

         if (bidx >= 1375) and (bidx <= 1799) then begin
            if ((bidx-1375) div 25) mod 2 = 0 then
               footstepsound := s_walk_cave_l;
         end;
         case bidx of
            1385, 1386, 1391, 1392:
               footstepsound := s_walk_wood_l;
         end;

         bidx := Map.MArr[cx, cy].MidImg and $7FFF;
         bidx := bidx - 1;
         case bidx of
            0..115:
               footstepsound := s_walk_ground_l;
            120..124:
               footstepsound := s_walk_lawn_l;
         end;

         bidx := Map.MArr[cx, cy].FrImg and $7FFF;
         bidx := bidx - 1;
         case bidx of
            //������
            221..289, 583..658, 1183..1206, 7163..7295,
            7404..7414:
               footstepsound := s_walk_stone_l;
            //��������
            3125..3267, {3319..3345, 3376..3433,} 3757..3948,
            6030..6999:
               footstepsound := s_walk_wood_l;
            //��ٴ�
            3316..3589:
               footstepsound := s_walk_room_l;
         end;
         if CurrentAction = SM_RUN then
            footstepsound := footstepsound + 2;

      end;

      if Sex = 0 then begin //��
         screamsound := s_man_struck;
         diesound := s_man_die;
      end else begin //Ů
         screamsound := s_wom_struck;
         diesound := s_wom_die;
      end;

      case CurrentAction of    //��������
         SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT:
            begin
               case (weapon div 2) of
                  6, 20:  weaponsound := s_hit_short;
                  1:  weaponsound := s_hit_wooden;
                  2, 13, 9, 5, 14, 22:  weaponsound := s_hit_sword;
                  4, 17, 10, 15, 16, 23:  weaponsound := s_hit_do;
                  3, 7, 11:  weaponsound := s_hit_axe;
                  24:  weaponsound := s_hit_club;
                  8, 12, 18, 21:  weaponsound := s_hit_long;
                  else weaponsound := s_hit_fist;
               end;
            end;
         SM_STRUCK:
            begin
               if MagicStruckSound >= 1 then begin  //�������� ����
                  //strucksound := s_struck_magic;  //�ӽ�..
               end else begin
                  hiter := PlayScene.FindActor (HiterCode);
                  attackweapon := 0;
                  if hiter <> nil then begin //�������� �������� ���ȴ��� �˻�
                     attackweapon := hiter.weapon div 2;
                     if hiter.Race = 0 then
                        case (dress div 2) of
                           3: //����
                              case attackweapon of
                                 6:  strucksound := s_struck_armor_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: strucksound := s_struck_armor_sword;
                                 3,7,11: strucksound := s_struck_armor_axe;
                                 8,12,18: strucksound := s_struck_armor_longstick;
                                 else strucksound := s_struck_armor_fist;
                              end;
                           else //�Ϲ�
                              case attackweapon of
                                 6: strucksound := s_struck_body_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: strucksound := s_struck_body_sword;
                                 3,7,11: strucksound := s_struck_body_axe;
                                 8,12,18: strucksound := s_struck_body_longstick;
                                 else strucksound := s_struck_body_fist;
                              end;
                        end;
                  end;
               end;
            end;
      end;

      //���� �Ҹ�
      if BoUseMagic and (CurMagic.MagicSerial > 0) then begin
         magicstartsound := 10000 + CurMagic.MagicSerial * 10;
         magicfiresound := 10000 + CurMagic.MagicSerial * 10 + 1;
         magicexplosionsound := 10000 + CurMagic.MagicSerial * 10 + 2;
      end;

   end else begin
      if CurrentAction = SM_STRUCK then begin
         if MagicStruckSound >= 1 then begin  //�������� ����
            //strucksound := s_struck_magic;  //�ӽ�..
         end else begin
            hiter := PlayScene.FindActor (HiterCode);
            if hiter <> nil then begin  //�������� �������� ���ȴ��� �˻�
               attackweapon := hiter.weapon div 2;
               case attackweapon of
                  6: strucksound := s_struck_body_sword;
                  1,2,4,5,9,10,13,14,15,16,17: strucksound := s_struck_body_sword;
                  3,11: strucksound := s_struck_body_axe;
                  8,12,18: strucksound := s_struck_body_longstick;
                  else strucksound := s_struck_body_fist;
               end;
            end;
         end;
      end;

      if Race = 50 then begin
      end else begin
         appearsound := 200 + (Appearance) * 10;
         normalsound := 200 + (Appearance) * 10 + 1;
         attacksound := 200 + (Appearance) * 10 + 2;  //�����
         weaponsound := 200 + (Appearance) * 10 + 3;  //��(�����ֵη�)
         screamsound := 200 + (Appearance) * 10 + 4;
         diesound := 200 + (Appearance) * 10 + 5;
         die2sound := 200 + (Appearance) * 10 + 6;
      end;
   end;

   //Į �´� �Ҹ�
   if CurrentAction = SM_STRUCK then begin
      hiter := PlayScene.FindActor (HiterCode);
      attackweapon := 0;
      if hiter <> nil then begin  //�������� �������� ���ȴ��� �˻�
         attackweapon := hiter.weapon div 2;
         if hiter.Race = 0 then
            case (attackweapon div 2) of
               6, 20:  struckweaponsound := s_struck_short;
               1:  struckweaponsound := s_struck_wooden;
               2, 13, 9, 5, 14, 22:  struckweaponsound := s_struck_sword;
               4, 17, 10, 15, 16, 23:  struckweaponsound := s_struck_do;
               3, 7, 11:  struckweaponsound := s_struck_axe;
               24:  struckweaponsound := s_struck_club;
               8, 12, 18, 21:  struckweaponsound := s_struck_wooden; //long;
               //else struckweaponsound := s_struck_fist;
            end;
      end;
   end;

end;

procedure  TActor.RunSound;
begin
   borunsound := TRUE;
   SetSound;
   case CurrentAction of
      SM_STRUCK:
         begin
            if (struckweaponsound >= 0) then PlaySound (struckweaponsound);
            if (strucksound >= 0) then PlaySound (strucksound);
            if (screamsound >= 0) then PlaySound (screamsound);
         end;
      SM_NOWDEATH:
         begin
            if (diesound >= 0) then PlaySound (diesound);
         end;
      SM_THROW, SM_HIT, SM_FLYAXE, SM_LIGHTING, SM_DIGDOWN{������}:
         begin
            if attacksound >= 0 then PlaySound (attacksound);
         end;
      SM_ALIVE, SM_DIGUP{����,������}:
         begin
            PlaySound (appearsound);
         end;
      SM_SPELL:
         begin
            PlaySound (magicstartsound);
         end;
   end;
end;

procedure  TActor.RunActSound (frame: integer);
begin
   if boRunSound then begin  //��Ҫ������Ч
      if Race = 0 then begin   //����
         case CurrentAction of
            SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2:  //�ӡ���
               if frame = 2 then begin
                  PlaySound (weaponsound);
                  boRunSound := FALSE; //��Ч�Ѿ�����
               end;
            SM_POWERHIT:
               if frame = 2 then begin
                  PlaySound (weaponsound);
                  //�������������
                  if Sex = 0 then PlaySound (s_yedo_man)
                  else PlaySound (s_yedo_woman);
                  borunsound := FALSE;
               end;
            SM_LONGHIT:
               if frame = 2 then begin
                  PlaySound (weaponsound);
                  PlaySound (s_longhit);
                  borunsound := FALSE;
               end;
            SM_WIDEHIT:
               if frame = 2 then begin
                  PlaySound (weaponsound);
                  PlaySound (s_widehit);
                  borunsound := FALSE;
               end;
            SM_FIREHIT:
               if frame = 2 then begin
                  PlaySound (weaponsound);
                  PlaySound (s_firehit);
                  borunsound := FALSE;
               end;
         end;
      end else begin
         if Race = 50 then begin
         end else begin
          //(** �� ����
            if (CurrentAction = SM_WALK) or (CurrentAction = SM_TURN) then begin
               if (frame = 1) and (Random(8) = 1) then begin
                  PlaySound (normalsound);
                  borunsound := FALSE;
               end;
            end;
            if CurrentAction = SM_HIT then begin
               if (frame = 3) and (attacksound >= 0) then begin
                  PlaySound (weaponsound);
                  borunsound := FALSE;
               end;
            end;
            case Appearance of
               80: 
                  begin
                     if CurrentAction = SM_NOWDEATH then begin
                        if (frame = 2) then begin
                           PlaySound (die2sound);
                           borunsound := FALSE;
                        end;
                     end;
                  end;
            end;
         end; //*)

      end;
   end;
end;

procedure  TActor.RunFrameAction (frame: integer);
begin
end;

procedure  TActor.ActionEnded;
begin
end;

procedure TActor.Run;
   function MagicTimeOut: Boolean;
   begin
      if self = Myself then begin
         Result := GetTickCount - WaitMagicRequest > 3000;
      end else
         Result := GetTickCount - WaitMagicRequest > 2000;
      if Result then
         CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   frametimetime: longword;
   bofly: Boolean;
begin
   if (CurrentAction = SM_WALK) or
      (CurrentAction = SM_BACKSTEP) or
      (CurrentAction = SM_RUN) or
      (CurrentAction = SM_RUSH) or
      (CurrentAction = SM_RUSHKUNG)
   then exit;

   msgmuch := FALSE;
   if self <> Myself then begin
      if MsgList.Count >= 2 then msgmuch := TRUE;
   end;

   //���� ȿ��
   RunActSound (currentframe - startframe);
   RunFrameAction (currentframe - startframe);

   prv := currentframe;
   if CurrentAction <> 0 then begin
      if (currentframe < startframe) or (currentframe > endframe) then
         currentframe := startframe;

      if (self <> Myself) and (BoUseMagic) then begin
         frametimetime := Round(frametime / 1.8);
      end else begin
         if msgmuch then frametimetime := Round(frametime * 2 / 3)
         else frametimetime := frametime;
      end;

      if GetTickCount - starttime > frametimetime then begin
         if currentframe < endframe then begin
            //������ ��� ������ ��ȣ�� �޾�, ����/���и� Ȯ������
            //������������ ������.
            if BoUseMagic then begin
               if (CurEffFrame = SpellFrame-2) or (MagicTimeOut) then begin //��ٸ� ��
                  if (CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin //������ ���� ���� ���. ���� �ȿ����� ��ٸ�
                     Inc (currentframe);
                     Inc(CurEffFrame);
                     starttime := GetTickCount;
                  end;
               end else begin
                  if currentframe < endframe - 1 then Inc (currentframe);
                  Inc (CurEffFrame);
                  starttime := GetTickCount;
               end;
            end else begin
               Inc (currentframe);
               starttime := GetTickCount;
            end;

         end else begin
            if BoDelActionAfterFinished then begin
               //�� ������ �����.
               BoDelActor := TRUE;
            end;
            //������ ����.
            if self = Myself then begin
               //���ΰ� �ΰ��
               if FrmMain.ServerAcceptNextAction then begin
                  ActionEnded;
                  CurrentAction := 0;
                  BoUseMagic := FALSE;
               end;
            end else begin
               ActionEnded;
               CurrentAction := 0; //����
               BoUseMagic := FALSE;
            end;
         end;
         if BoUseMagic then begin
            //������ ���� ���
            if CurEffFrame = SpellFrame-1 then begin //���� �߻� ����
               //���� �߻�
               if CurMagic.ServerMagicCode > 0 then begin
                  with CurMagic do
                     PlayScene.NewMagic (self,
                                      ServerMagicCode,
                                      EffectNumber,
                                      XX,
                                      YY,
                                      TargX,
                                      TargY,
                                      Target,
                                      EffectType,
                                      Recusion,
                                      AniTime,
                                      bofly);
                  if bofly then
                     PlaySound (magicfiresound)
                  else
                     PlaySound (magicexplosionsound);
               end;
               //LatestSpellTime := GetTickCount;
               CurMagic.ServerMagicCode := 0;
            end;
         end;
      end;
      if Appearance in [0, 1, 43] then currentdefframe := -10
      else currentdefframe := 0;
      defframetime := GetTickCount;
   end else begin
      if GetTickCount - smoothmovetime > 200 then begin
         if GetTickCount - defframetime > 500 then begin
            defframetime := GetTickCount;
            Inc (currentdefframe);
            if currentdefframe >= defframecount then
               currentdefframe := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> currentframe then begin
      loadsurfacetime := GetTickCount;
      LoadSurface;
   end;

end;
//���ݵ�ǰ������״̬������һ��������Ӧ��֡
function  TActor.Move (step: integer): Boolean;
var
   prv, curstep, maxstep: integer;
   fastmove, normmove: Boolean;
begin
   Result := FALSE;
   fastmove := FALSE;
   normmove := FALSE;
   if (CurrentAction = SM_BACKSTEP) then //or (CurrentAction = SM_RUSH) or (CurrentAction = SM_RUSHKUNG) then
      fastmove := TRUE;
   if (CurrentAction = SM_RUSH) or (CurrentAction = SM_RUSHKUNG) then
      normmove := TRUE;
   if (self = Myself) and (not fastmove) and (not normmove) then begin
      BoMoveSlow := FALSE;
      BoAttackSlow := FALSE;
      MoveSlowLevel := 0;
      if Abil.Weight > Abil.MaxWeight then begin           //���س�����������
         MoveSlowLevel := Abil.Weight div Abil.MaxWeight;  //�ƶ��ٶȼ���
         BoMoveSlow := TRUE;
      end;
      if Abil.WearWeight > Abil.MaxWearWeight then begin
         MoveSlowLevel := MoveSlowLevel + Abil.WearWeight div Abil.MaxWearWeight;
         BoMoveSlow := TRUE;
      end;
      if Abil.HandWeight > Abil.MaxHandWeight then begin
         BoAttackSlow := TRUE;
      end;
      if BoMoveSlow and (SkipTick < MoveSlowLevel) then begin
         Inc (SkipTick); //����.
         exit;
      end else begin
         SkipTick := 0;
      end;
      //�߶�������
      if (CurrentAction = SM_WALK) or
         (CurrentAction = SM_BACKSTEP) or
         (CurrentAction = SM_RUN) or
         (CurrentAction = SM_RUSH) or
         (CurrentAction = SM_RUSHKUNG)
      then begin
         case (currentframe - startframe) of
            1: PlaySound (footstepsound);
            4: PlaySound (footstepsound + 1);
         end;
      end;
   end;

   Result := FALSE;
   msgmuch := FALSE;
   if self <> Myself then begin
      if MsgList.Count >= 2 then msgmuch := TRUE;
   end;
   prv := currentframe;
   //�ƶ�
   if (CurrentAction = SM_WALK) or
      (CurrentAction = SM_RUN) or
      (CurrentAction = SM_RUSH) or
      (CurrentAction = SM_RUSHKUNG)
   then begin
      //������ǰ֡
      if (currentframe < startframe) or (currentframe > endframe) then begin
         currentframe := startframe - 1;
      end;
      if currentframe < endframe then begin
         Inc (currentframe);
         if msgmuch and not normmove then //�ӿ첽��
            if currentframe < endframe then
               Inc (currentframe);
         //
         curstep := currentframe-startframe + 1;
         maxstep := endframe-startframe + 1;
         Shift (Dir, movestep, curstep, maxstep); //����
      end;
      if currentframe >= endframe then begin
         if self = Myself then begin
            if FrmMain.ServerAcceptNextAction then begin
               CurrentAction := 0;     //��ǰ��������
               LockEndFrame := TRUE;   //
               smoothmovetime := GetTickCount;
            end;
         end else begin
            CurrentAction := 0; //
            LockEndFrame := TRUE;
            smoothmovetime := GetTickCount;
         end;
         Result := TRUE;
      end;
      if CurrentAction = SM_RUSH then begin
         if self = Myself then begin
            DizzyDelayStart := GetTickCount;
            DizzyDelayTime := 300; //������
         end;
      end;
      if CurrentAction = SM_RUSHKUNG then begin
         if currentframe >= endframe - 3 then begin
            XX := actbeforex;
            YY := actbeforey;
            Rx := XX;
            Ry := YY;
            CurrentAction := 0;
            LockEndFrame := TRUE;
            //smoothmovetime := GetTickCount;
         end;
      end;
      Result := TRUE;
   end;
   //����
   if (CurrentAction = SM_BACKSTEP) then begin
      if (currentframe > endframe) or (currentframe < startframe) then begin
         currentframe := endframe + 1;
      end;
      if currentframe > startframe then begin
         Dec (currentframe);
         if msgmuch or fastmove then
            if currentframe > startframe then Dec (currentframe);

         //
         curstep := endframe - currentframe + 1;
         maxstep := endframe - startframe + 1;
         Shift (GetBack(Dir), movestep, curstep, maxstep);
      end;
      if currentframe <= startframe then begin
         if self = Myself then begin
            //if FrmMain.ServerAcceptNextAction then begin
               CurrentAction := 0;     //������ ��ȣ�� ������ ���� ����
               LockEndFrame := TRUE;   //�����ǽ�ȣ�� ��� �����������ӿ��� ����
               smoothmovetime := GetTickCount;

               //�ڷ� �и� ���� �ѵ��� �� �����δ�.
               DizzyDelayStart := GetTickCount;
               DizzyDelayTime := 1000; //1�� ������
            //end;
         end else begin
            CurrentAction := 0; //���� �Ϸ�
            LockEndFrame := TRUE;
            smoothmovetime := GetTickCount;
         end;
         Result := TRUE;
      end;
      Result := TRUE;
   end;
   //����ǰ��������һ������֡��ͬ����װ�ص�ǰ��������
   if prv <> currentframe then begin
      loadsurfacetime := GetTickCount;
      LoadSurface;
   end;
end;
//�ƶ�ʧ�ܣ��������������ƶ����ʱ���˻ص��ϴε�λ��
procedure TActor.MoveFail;
begin
   CurrentAction := 0; //���� �Ϸ�
   LockEndFrame := TRUE;
   Myself.XX := oldx;
   Myself.YY := oldy;
   Myself.Dir := olddir;
   CleanUserMsgs;
end;

function  TActor.CanCancelAction: Boolean;
begin
   result:=(CurrentAction = SM_HIT) and not BoUseEffect;
end;

procedure TActor.CancelAction;
begin
   CurrentAction := 0; //���� �Ϸ�
   LockEndFrame := TRUE;
end;

procedure TActor.CleanCharMapSetting (x, y: integer);
begin
   Myself.XX := x;
   Myself.YY := y;
   Myself.RX := x;
   Myself.RY := y;
   oldx := x;
   oldy := y;
   CurrentAction := 0;
   currentframe := -1;
   CleanUserMsgs;
end;
//ʵ�ַ�����ʾ˵�����ݵ�Saying
procedure TActor.Say (str: string);
var
   i, len, aline, n: integer;
   dline, temp: string;
   loop: Boolean;
const
   MAXWIDTH = 150;
begin
   SayTime := GetTickCount;
   SayLineCount := 0;

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
            Saying[n] := temp;
            SayWidths[n] := aline;
            Inc (SayLineCount);
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
            Saying[n] := temp;
            SayWidths[n] := FrmMain.Canvas.TextWidth (temp);
            Inc (SayLineCount);
         end;
      end;
   end;
end;


{============================== NPCActor =============================}

procedure TNpcActor.CalcActorFrame;
var
   pm: PTMonsterAction;
   haircount: integer;
begin
   BoUseMagic := FALSE;
   currentframe := -1;

   if Race = 50 then   //����
      BodyOffset := MERCHANTFRAME * Appearance;

   pm := RaceByPM (Race);
   if pm = nil then exit;
   Dir := Dir mod 3;  //������ 0, 1, 2 �ۿ� ����..
   case CurrentAction of
      SM_TURN:
         begin
            startframe := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip);
            endframe := startframe + pm.ActStand.frame - 1;
            frametime := pm.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := pm.ActStand.frame;
            Shift (Dir, 0, 0, 1);
         end;
      SM_HIT:
         begin
            startframe := pm.ActAttack.start + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
            endframe := startframe + pm.ActAttack.frame - 1;
            frametime := pm.ActAttack.ftime;
            starttime := GetTickCount;
         end;
   end;
end;
//��ɫ��ȱʡ֡��վ�����棩
function  TNpcActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
   pm := RaceByPM (Race);
   if pm = nil then exit;
   Dir := Dir mod 3;  //������ 0, 1, 2 �ۿ� ����..

   if currentdefframe < 0 then cf := 0
   else if currentdefframe >= pm.ActStand.frame then cf := 0
   else cf := currentdefframe;
   Result := pm.ActStand.start + Dir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
end;

procedure TNpcActor.LoadSurface;
begin
   case Race of
      //���� Npc
      50: begin
            BodySurface := FrmMain.WNpcImg.GetCachedImage (BodyOffset + currentframe, px, py);
         end;
   end;
end;


procedure TNpcActor.Run;
begin
   inherited Run;
end;


{============================== HUMActor =============================}


constructor THumActor.Create;
begin
   inherited Create;
   HairSurface := nil;
   WeaponSurface := nil;
   BoWeaponEffect := FALSE;
end;

destructor THumActor.Destroy;
begin
   inherited Destroy;
end;

procedure THumActor.CalcActorFrame;
var
   haircount: integer;
begin
   BoUseMagic := FALSE;
   BoHitEffect := FALSE;
   currentframe := -1;
   //human
   hair   := HAIRfeature (Feature);         //����
   dress  := DRESSfeature (Feature);        //��װ
   weapon := WEAPONfeature (Feature);       //����
   BodyOffset := HUMANFRAME * (dress);      //Sex; //��0, Ů1

   haircount := FrmMain.WHairImg.ImageCount div HUMANFRAME div 2; //����ͷ����=3600/600/2=3,��ÿ���Ա�ķ�����
   if hair > haircount-1 then hair := haircount-1;
   hair := hair * 2;
   if hair > 1 then
      HairOffset := HUMANFRAME * (hair + Sex)
   else HairOffset := -1;
   WeaponOffset := HUMANFRAME * weapon; //(weapon*2 + Sex);  //����ͼƬ��ʼ֡�������Ա𣿣�

   case CurrentAction of
      SM_TURN:
         begin
            startframe := HA.ActStand.start + Dir * (HA.ActStand.frame + HA.ActStand.skip);
            endframe := startframe + HA.ActStand.frame - 1;
            frametime := HA.ActStand.ftime;
            starttime := GetTickCount;
            defframecount := HA.ActStand.frame;
            Shift (Dir, 0, 0, endframe-startframe+1);
         end;
      SM_WALK,
      SM_BACKSTEP:
         begin
            startframe := HA.ActWalk.start + Dir * (HA.ActWalk.frame + HA.ActWalk.skip);
            endframe := startframe + HA.ActWalk.frame - 1;
            frametime := HA.ActWalk.ftime;
            starttime := GetTickCount;
            maxtick := HA.ActWalk.UseTick;
            curtick := 0;
            //WarMode := FALSE;
            movestep := 1;
            if CurrentAction = SM_BACKSTEP then
               Shift (GetBack(Dir), movestep, 0, endframe-startframe+1)
            else
               Shift (Dir, movestep, 0, endframe-startframe+1);
         end;
      SM_RUSH:
         begin
            if RushDir = 0 then begin
               RushDir := 1;
               startframe := HA.ActRushLeft.start + Dir * (HA.ActRushLeft.frame + HA.ActRushLeft.skip);
               endframe := startframe + HA.ActRushLeft.frame - 1;
               frametime := HA.ActRushLeft.ftime;
               starttime := GetTickCount;
               maxtick := HA.ActRushLeft.UseTick;
               curtick := 0;
               movestep := 1;
               Shift (Dir, 1, 0, endframe-startframe+1);
            end else begin
               RushDir := 0;
               startframe := HA.ActRushRight.start + Dir * (HA.ActRushRight.frame + HA.ActRushRight.skip);
               endframe := startframe + HA.ActRushRight.frame - 1;
               frametime := HA.ActRushRight.ftime;
               starttime := GetTickCount;
               maxtick := HA.ActRushRight.UseTick;
               curtick := 0;
               movestep := 1;
               Shift (Dir, 1, 0, endframe-startframe+1);
            end;
         end;
      SM_RUSHKUNG:
         begin
            startframe := HA.ActRun.start + Dir * (HA.ActRun.frame + HA.ActRun.skip);
            endframe := startframe + HA.ActRun.frame - 1;
            frametime := HA.ActRun.ftime;
            starttime := GetTickCount;
            maxtick := HA.ActRun.UseTick;
            curtick := 0;
            movestep := 1;
            Shift (Dir, movestep, 0, endframe-startframe+1);
         end;
      {SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            endframe := startframe - (pm.ActWalk.frame - 1);
            frametime := pm.ActWalk.ftime;
            starttime := GetTickCount;
            maxtick := pm.ActWalk.UseTick;
            curtick := 0;
            movestep := 1;
            Shift (GetBack(Dir), movestep, 0, endframe-startframe+1);
         end;  }
      SM_SITDOWN:
         begin
            startframe := HA.ActSitdown.start + Dir * (HA.ActSitdown.frame + HA.ActSitdown.skip);
            endframe := startframe + HA.ActSitdown.frame - 1;
            frametime := HA.ActSitdown.ftime;
            starttime := GetTickCount;
         end;
      SM_RUN:
         begin
            startframe := HA.ActRun.start + Dir * (HA.ActRun.frame + HA.ActRun.skip);
            endframe := startframe + HA.ActRun.frame - 1;
            frametime := HA.ActRun.ftime;
            starttime := GetTickCount;
            maxtick := HA.ActRun.UseTick;
            curtick := 0;
            //WarMode := FALSE;
            if CurrentAction = SM_RUN then movestep := 2
            else movestep := 1;
            //movestep := 2;
            Shift (Dir, movestep, 0, endframe-startframe+1);
         end;
      SM_THROW:
         begin
            startframe := HA.ActHit.start + Dir * (HA.ActHit.frame + HA.ActHit.skip);
            endframe := startframe + HA.ActHit.frame - 1;
            frametime := HA.ActHit.ftime;
            starttime := GetTickCount;
            WarMode := TRUE;
            WarModeTime := GetTickCount;
            BoThrow := TRUE;
            Shift (Dir, 0, 0, 1);
         end;
      SM_HIT, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT:
         begin
            startframe := HA.ActHit.start + Dir * (HA.ActHit.frame + HA.ActHit.skip);
            endframe := startframe + HA.ActHit.frame - 1;
            frametime := HA.ActHit.ftime;
            starttime := GetTickCount;
            WarMode := TRUE;
            WarModeTime := GetTickCount;
            if (CurrentAction = SM_POWERHIT) then begin
               BoHitEffect := TRUE;
               MagLight := 2;
               HitEffectNumber := 1;
            end;
            if (CurrentAction = SM_LONGHIT) then begin
               BoHitEffect := TRUE;
               MagLight := 2;
               HitEffectNumber := 2;
            end;
            if (CurrentAction = SM_WIDEHIT) then begin
               BoHitEffect := TRUE;
               MagLight := 2;
               HitEffectNumber := 3;
            end;
            if (CurrentAction = SM_FIREHIT) then begin
               BoHitEffect := TRUE;
               MagLight := 2;
               HitEffectNumber := 4;
            end;
            Shift (Dir, 0, 0, 1);
         end;
      SM_HEAVYHIT:
         begin
            startframe := HA.ActHeavyHit.start + Dir * (HA.ActHeavyHit.frame + HA.ActHeavyHit.skip);
            endframe := startframe + HA.ActHeavyHit.frame - 1;
            frametime := HA.ActHeavyHit.ftime;
            starttime := GetTickCount;
            WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end;
      SM_BIGHIT:
         begin
            startframe := HA.ActBigHit.start + Dir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
            endframe := startframe + HA.ActBigHit.frame - 1;
            frametime := HA.ActBigHit.ftime;
            starttime := GetTickCount;
            WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end;
      SM_SPELL:
         begin
            startframe := HA.ActSpell.start + Dir * (HA.ActSpell.frame + HA.ActSpell.skip);
            endframe := startframe + HA.ActSpell.frame - 1;
            frametime := HA.ActSpell.ftime;
            starttime := GetTickCount;
            CurEffFrame := 0;
            BoUseMagic := TRUE;
            case CurMagic.EffectNumber of
               22: begin //�ڼ�ȭ
                     MagLight := 4;  //�ڼ�ȭ
                     SpellFrame := 10; //�ڼ�ȭ�� 10 ���������� ����
                  end;
               26: begin //Ž���Ŀ�
                     MagLight := 2;
                     SpellFrame := 20;
                     frametime := frametime div 2;
                  end;
               else begin //.....  ��ȸ����, ������ȸ, ����ǳ
                  MagLight := 2;
                  SpellFrame := DEFSPELLFRAME;
               end;
            end;
            WaitMagicRequest := GetTickCount;
            WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end;
      (*SM_READYFIREHIT:
         begin
            startframe := HA.ActFireHitReady.start + Dir * (HA.ActFireHitReady.frame + HA.ActFireHitReady.skip);
            endframe := startframe + HA.ActFireHitReady.frame - 1;
            frametime := HA.ActFireHitReady.ftime;
            starttime := GetTickCount;

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
            startframe := HA.ActStruck.start + Dir * (HA.ActStruck.frame + HA.ActStruck.skip);
            endframe := startframe + HA.ActStruck.frame - 1;
            frametime := struckframetime; //HA.ActStruck.ftime;
            starttime := GetTickCount;
            Shift (Dir, 0, 0, 1);

            genanicounttime := GetTickCount;
            CurBubbleStruck := 0;
         end;
      SM_NOWDEATH:
         begin
            startframe := HA.ActDie.start + Dir * (HA.ActDie.frame + HA.ActDie.skip);
            endframe := startframe + HA.ActDie.frame - 1;
            frametime := HA.ActDie.ftime;
            starttime := GetTickCount;
         end;
   end;
end;

procedure THumActor.DefaultMotion;
begin
   inherited DefaultMotion;
end;

function  THumActor.GetDefaultFrame (wmode: Boolean): integer;  //��̬����
var
   cf, dr: integer;
   pm: PTMonsterAction;
begin
   //GlimmingMode := FALSE;
   //dr := Dress div 2;            //HUMANFRAME * (dr)
   if Death then       //����
      Result := HA.ActDie.start + Dir * (HA.ActDie.frame + HA.ActDie.skip) + (HA.ActDie.frame - 1)
   else
   if wmode then begin    //ս��״̬
      //GlimmingMode := TRUE;
      Result := HA.ActWarMode.start + Dir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
   end else begin        //վ��״̬
      defframecount := HA.ActStand.frame;
      if currentdefframe < 0 then cf := 0
      else if currentdefframe >= HA.ActStand.frame then cf := 0 //HA.ActStand.frame-1
      else cf := currentdefframe;
      Result := HA.ActStand.start + Dir * (HA.ActStand.frame + HA.ActStand.skip) + cf;
   end;
end;

procedure  THumActor.RunFrameAction (frame: integer);
var
   meff: TMapEffect;
   event: TClEvent;
   mfly: TFlyingAxe;
begin
   BoHideWeapon := FALSE;
   if CurrentAction = SM_HEAVYHIT then begin
      if (frame = 5) and (BoDigFragment) then begin
         BoDigFragment := FALSE;
         meff := TMapEffect.Create (8 * Dir, 3, XX, YY);
         meff.ImgLib := FrmMain.WEffectImg;
         meff.NextFrameTime := 80;
         PlaySound (s_strike_stone);
         //PlaySound (s_drop_stonepiece);
         PlayScene.EffectList.Add (meff);
         event := EventMan.GetEvent (XX, YY, ET_PILESTONES);
         if event <> nil then
            event.EventParam := event.EventParam + 1;
      end;
   end;
   if CurrentAction = SM_THROW then begin
      if (frame = 3) and (BoThrow) then begin
         BoThrow := FALSE;
         //�Ӹ�ͷЧ��
         mfly := TFlyingAxe (PlayScene.NewFlyObject (self,
                          XX,
                          YY,
                          TargetX,
                          TargetY,
                          TargetRecog,
                          mtFlyAxe));
         if mfly <> nil then begin
            TFlyingAxe(mfly).ReadyFrame := 40;
            mfly.ImgLib := FrmMain.WMon3Img;
            mfly.FlyImageBase := FLYOMAAXEBASE;   //=447
         end;

      end;
      if frame >= 3 then
         BoHideWeapon := TRUE;
   end;
end;

procedure  THumActor.DoWeaponBreakEffect;
begin
   BoWeaponEffect := TRUE;
   CurWpEffect := 0;
end;

procedure  THumActor.Run;
   //�ж�ħ���Ƿ��Ѿ���ɣ����ࣺ3�룬������2�룩
   function MagicTimeOut: Boolean;
   begin
      if self = Myself then begin
         Result := GetTickCount - WaitMagicRequest > 3000;
      end else
         Result := GetTickCount - WaitMagicRequest > 2000;
      if Result then
         CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   frametimetime: longword;
   bofly: Boolean;
begin
   if GetTickCount - GenAnicounttime > 120 then begin //�ּ��Ǹ� ��... �ִϸ��̼� ȿ��
      GenAnicounttime := GetTickCount;
      Inc (GenAniCount);
      if GenAniCount > 100000 then GenAniCount := 0;
      Inc (CurBubbleStruck);
   end;
   if BoWeaponEffect then begin  //����Ч����ÿ120��仯һ֡����5֡
      if GetTickCount - wpeffecttime > 120 then begin
         wpeffecttime := GetTickCount;
         Inc (CurWpEffect);
         if CurWpEffect >= MAXWPEFFECTFRAME then
            BoWeaponEffect := FALSE;
      end;
   end;

   if (CurrentAction = SM_WALK) or
      (CurrentAction = SM_BACKSTEP) or
      (CurrentAction = SM_RUN) or
      (CurrentAction = SM_RUSH) or
      (CurrentAction = SM_RUSHKUNG)
   then exit;

   msgmuch := FALSE;
   if self <> Myself then begin
      if MsgList.Count >= 2 then msgmuch := TRUE;
   end;

   //������Ч
   RunActSound (currentframe - startframe);
   RunFrameAction (currentframe - startframe);

   prv := currentframe;
   if CurrentAction <> 0 then begin
      if (currentframe < startframe) or (currentframe > endframe) then
         currentframe := startframe;

      if (self <> Myself) and (BoUseMagic) then begin
         frametimetime := Round(frametime / 1.8);
      end else begin
         if msgmuch then frametimetime := Round(frametime * 2 / 3)
         else frametimetime := frametime;
      end;

      if GetTickCount - starttime > frametimetime then begin
         if currentframe < endframe then begin

            //������ ��� ������ ��ȣ�� �޾�, ����/���и� Ȯ������
            //������������ ������.
            if BoUseMagic then begin
               if (CurEffFrame = SpellFrame-2) or (MagicTimeOut) then begin //��ٸ� ��
                  if (CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin //������ ���� ���� ���. ���� �ȿ����� ��ٸ�
                     Inc (currentframe);
                     Inc(CurEffFrame);
                     starttime := GetTickCount;
                  end;
               end else begin
                  if currentframe < endframe - 1 then Inc (currentframe);
                  Inc (CurEffFrame);
                  starttime := GetTickCount;
               end;
            end else begin
               Inc (currentframe);
               starttime := GetTickCount;
            end;

         end else begin
            if self = Myself then begin
               if FrmMain.ServerAcceptNextAction then begin
                  CurrentAction := 0;
                  BoUseMagic := FALSE;
               end;
            end else begin
               CurrentAction := 0; //���� �Ϸ�
               BoUseMagic := FALSE;
            end;
            BoHitEffect := FALSE;
         end;
         if BoUseMagic then begin
            if CurEffFrame = SpellFrame-1 then begin //���� �߻� ����
               //���� �߻�
               if CurMagic.ServerMagicCode > 0 then begin
                  with CurMagic do
                     PlayScene.NewMagic (self,
                                      ServerMagicCode,
                                      EffectNumber,
                                      XX,
                                      YY,
                                      TargX,
                                      TargY,
                                      Target,
                                      EffectType,
                                      Recusion,
                                      AniTime,
                                      bofly);
                  if bofly then
                     PlaySound (magicfiresound)
                  else
                     PlaySound (magicexplosionsound);
               end;
               if self = Myself then
                  LatestSpellTime := GetTickCount;
               CurMagic.ServerMagicCode := 0;
            end;
         end;

      end;
      if Race = 0 then currentdefframe := 0
      else currentdefframe := -10;
      defframetime := GetTickCount;
   end else begin
      if GetTickCount - smoothmovetime > 200 then begin
         if GetTickCount - defframetime > 500 then begin
            defframetime := GetTickCount;
            Inc (currentdefframe);
            if currentdefframe >= defframecount then
               currentdefframe := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> currentframe then begin
      loadsurfacetime := GetTickCount;
      LoadSurface;
   end;

end;

function   THumActor.Light: integer;
var
   l: integer;
begin
   l := ChrLight;
   if l < MagLight then begin
      if BoUseMagic or BoHitEffect then
         l := MagLight;
   end;
   Result := l;
end;

procedure  THumActor.LoadSurface;
begin
   BodySurface := FrmMain.WHumImg.GetCachedImage (BodyOffset + currentframe, px, py);
   if HairOffset >= 0 then
      HairSurface := FrmMain.WHairImg.GetCachedImage (HairOffset + currentframe, hpx, hpy)
   else HairSurface := nil;
   WeaponSurface := FrmMain.WWeapon.GetCachedImage (WeaponOffset + currentframe, wpx, wpy);
end;

procedure  THumActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
begin
   if not (Dir in [0..7]) then exit;
   if GetTickCount - loadsurfacetime > 60 * 1000 then begin  //60���ͷ�һ��δʹ�õ�ͼƬ������ÿ��60��Ҫ����װ��һ��
      loadsurfacetime := GetTickCount;
      LoadSurface; //����װ��ͼƬ��bodysurface
   end;

   ceff := GetDrawEffectValue;

   if Race = 0 then begin  //����
      if (currentframe >= 0) and (currentframe <= 599) then
         wpord := WORDER[Sex, currentframe];
      //������
      if (wpord = 0) and (not blend) and (Weapon >= 2) and (WeaponSurface <> nil) and (not BoHideWeapon) then begin
         DrawEffSurface (dsurface, WeaponSurface, dx + wpx + ShiftX, dy + wpy + ShiftY, blend, ceNone);  //Į�� ���� �Ⱥ���
         DrawWeaponGlimmer (dsurface, dx + ShiftX, dy + ShiftY);   //�������ֱ�ӷ��أ���ʵ��Ч����
         //dsurface.Draw (dx + wpx + ShiftX, dy + wpy + ShiftY, WeaponSurface.ClientRect, WeaponSurface, TRUE);
      end;
      //������
      if BodySurface <> nil then
         DrawEffSurface (dsurface, BodySurface, dx + px + ShiftX, dy + py + ShiftY, blend, ceff);
      //��ͷ��
      if HairSurface <> nil then
         DrawEffSurface (dsurface, HairSurface, dx + hpx + ShiftX, dy + hpy + ShiftY, blend, ceff);

      //���̴� ������ ���� ��,�Ӹ�,���⸦ �׸��� ������ �޶�����.
      if (wpord = 1) and {(not blend) and} (Weapon >= 2) and (WeaponSurface <> nil) and (not BoHideWeapon) then begin
         DrawEffSurface (dsurface, WeaponSurface, dx + wpx + ShiftX, dy + wpy + ShiftY, blend, ceNone);
         DrawWeaponGlimmer (dsurface, dx + ShiftX, dy + ShiftY);
         //dsurface.Draw (dx + wpx + ShiftX, dy + wpy + ShiftY, WeaponSurface.ClientRect, WeaponSurface, TRUE);
      end;

      //�����Ƿ���һ����������
      if State and $00100000{STATE_BUBBLEDEFENCEUP} <> 0 then begin  //�ּ��Ǹ�
         if (CurrentAction = SM_STRUCK) and (CurBubbleStruck < 3) then
            idx := MAGBUBBLESTRUCKBASE + CurBubbleStruck
         else
            idx := MAGBUBBLEBASE + (GenAniCount mod 3);
         d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + ShiftX,
                             dy + ay + ShiftY,
                             d, 1);
      end;

   end;

   //��ʾħ��
   if BoUseMagic {and (EffDir[Dir] = 1)} and (CurMagic.EffectNumber > 0) then begin
      if CurEffFrame in [0..SpellFrame-1] then begin
         GetEffectBase (CurMagic.EffectNumber-1, 0, wimg, idx);
         idx := idx + CurEffFrame;
         if wimg <> nil then
            d := wimg.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + ShiftX,
                             dy + ay + ShiftY,
                             d, 1);
      end;
   end;

   //��ʾ����Ч��
   if BoHitEffect and (HitEffectNumber > 0) then begin
      GetEffectBase (HitEffectNumber-1, 1, wimg, idx);
      idx := idx + Dir*10 + (currentframe-startframe);
      if wimg <> nil then
         d := wimg.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                          dx + ax + ShiftX,
                          dy + ay + ShiftY,
                          d, 1);
   end;

   //��ʾ����Ч��
   if BoWeaponEffect then begin
      idx := WPEFFECTBASE + Dir*10 + CurWpEffect;
      d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                     dx + ax + ShiftX,
                     dy + ay + ShiftY,
                     d, 1);
   end;

end;




end.
