unit grobal2;

interface
uses
  Windows, Classes, strUtils, JSocket;

const
  //MG_Connect          = 'O';
  //MG_SendData         = 'A';
  //MG_Close            = 'X';

  MG_Connect          = 'N';
  MG_SendData         = 'D';
  MG_Close            = 'C';

  MG_EDCODE           = 'JsMir';
  MG_RSAEDCODE        = 'Mir2';
  MG_GETPROCESS       = 'PROCESS';

 // VERSION_NUMBER_STR = '版本号：20080808';
  VERSION_NUMBER_STR = '版本号：奥运最终版';
  VERSION_NUMBER = 200808024;
  CLIENT_VERSION_NUMBER = 1200808024;
  CM_POWERBLOCK = 0; //Damian

  M2PLUG_VERSION= 200808024;

  CHECKVERION   = 'fR[NjY^Dt`Dkt`GT^IFufRX';
  M2SERVER      = 'OOEoUSErUSDjUS]a';

  RSA_LOGIN_KEY  = 'cK02edFlvbz=AKQ7pvMM2J9nlq'; //25537
  RSA_LOGIN_MODE = 'ax1BfhHUFiJZXN3bhhx9e7gS4Nadiii1koSrxIwxt2GuWwKMliUGIbLArGDiZT9It65uKDufEeA0ii'; //3677918794034898225315606711625099467199
  RSA_LOGIN_PKEY = 'axw=fogrncy8IVL59bAwrlbYgSQ065EKUT9SK8yZaSpY0xcehhMpGrtPShtiVEZyhlwOOP1i9=trCi'; //2192464181436999517404087498130549607273

  JOB_WARR      = 0;
  JOB_WIZARD    = 1;
  JOB_TAOS      = 2;

  ADMAX         = 4;

  AD_SELFONE    = 0;  //小退广告
  AD_SELFTWO    = 1;  //开启人物退出弹出网页
  AD_SELFWEB    = 2;  //创建网页快捷方式
  AD_SELFMAIN   = 3;  //用户首页
  AD_SELFIE     = 4;  //用户收藏夹

  AD_NOTICE     = 10;
  AD_SYSMSG     = 11;

  USERDATADIR       = 'UserData\';
  STORAGEDIR        = 'Storage\';
  CONSIGNATIONDIR   = 'Consignation\';
  ChallengeDir      = 'Challenge\';

  ALLHUM        = 'AllHum.DB';
  WARRHUM       = 'WarrHum.DB';
  WIZARDHUM     = 'WizardHum.DB';
  TAOSHUM       = 'TaosHum.DB';
  ALLHERO       = 'AllHero.DB';
  WARRHERO      = 'WarrHero.DB';
  WIZARDHERO    = 'WizardHero.DB';
  TAOSHERO      = 'TaosHero.DB';
  MASTERALL     = 'Master.DB';

  GAMEEXPNAME     = '经验';
  GAMECREDITPOINT = '声望';
  GAMEDIAMOND     = '金刚石';

  CORPS_DELETEHERO  = 1;

  Effect_75     = 75;    //默认效果
  Effect_76     = 76;    //双倍经验效果
  Effect_77     = 77;    //宠物升级效果
  Effect_78     = 78;    //烟花效果
  Effect_79     = 79;    //烟花效果
  Effect_80     = 80;    //烟花效果
  Effect_81     = 81;    //烟花效果
  Effect_82     = 82;    //烟花效果
  Effect_83     = 83;    //烟花效果
  Effect_84     = 84;    //烟花效果
  Effect_85     = 85;    //升级效果
  Effect_86     = 86;    //未挖到物品效果
  Effect_87     = 87;    //护体神盾效果
  Effect_88     = 88;    //护体神盾效果
  Effect_89     = 89;    //护体神盾消失效果
  Effect_100    = 100;
  Effect_THUNDER = 110; //地图闪电
  Effect_LAVA   = 111;  //岩浆

  ITEMSTATE_DROP    = 0;  //扔
  ITEMSTATE_DEAL    = 1;  //交易
  ITEMSTATE_STORAGE = 2;  //存
  ITEMSTATE_REPAIR  = 3;  //存
  ITEMSTATE_SELL    = 4;  //出售
  ITEMSTATE_SCATTER = 5;  //爆出
  ITEMSTATE_SHINE   = 6;

  MapNameLen    = 16;
  CurMapNameLen = 16;
  HomMapNameLen = 17;
  ActorNameLen  = 14;
  AccountNameLen= 16;

  DR_UP         =0;
  DR_UPRIGHT    =1;
  DR_RIGHT      =2;
  DR_DOWNRIGHT  =3;
  DR_DOWN       =4;
  DR_DOWNLEFT   =5;
  DR_LEFT       =6;
  DR_UPLEFT     =7;

  U_DRESS       = 0;
  U_WEAPON      = 1;
  U_RIGHTHAND   = 2;
  U_NECKLACE    = 3;
  U_HELMET      = 4;
  U_ARMRINGL    = 5;
  U_ARMRINGR    = 6;
  U_RINGL       = 7;
  U_RINGR       = 8;
  U_BUJUK       = 9;
  U_BELT        = 10;
  U_BOOTS       = 11;
  U_CHARM       = 12;
  U_STRAW       = 13;

  MAXUSEITEMS   = 13;

  MAXBTVALUE    = 15;


  DEFBLOCKSIZE  = 16;
  BUFFERSIZE    = 10000;

  LOGICALMAPUNIT= 40;
  MAXTAXISCOUNT = 2000;//排行榜保存数量

  UNITX         = 48;
  UNITY         = 32;

  HALFX         = 24;
  HALFY         = 16;

  MAXBAGITEM    = 46;       //用户最大的物品
  MAXSTORAGEITEMS = 45;     //仓库最大物品数
  //MAXBAGITEM    = 48;
  HOWMANYMAGICS = 20;          //用户最大技能数
  //MAXBAGITEM   = 46;         //用户最大的物品
  MaxSkillLevel = 3;
  MAX_STATUS_ATTRIBUTE = 15;             //神圣战甲术等属性保存   //新增三项，攻，魔，道

  ITEM_WEAPON           = 0;    //武器
  ITEM_ARMOR				    = 1;    //装备
  ITEM_ACCESSORY		    = 2;    //辅助物品
  ITEM_ETC					    = 3;    //其它物品
  ITEM_LEECHDOM         = 4;
  ITEM_GOLD				      = 10;   //金币
  ITEM_Wine             = 60;  //酒

  POISON_DECHEALTH      = 0;  //中毒类型 - 绿毒
  POISON_DAMAGEARMOR    = 1;  //中毒类型 - 红毒
  POISON_LOCKSPELL			= 2;
  POISON_DONTMOVE				= 4;
  POISON_STONE				  = 5;
  POISON_68             = 68;

  STATE_TRANSPARENT			= 8;
  STATE_DEFENCEUP				= 9;     //神圣战甲术
  STATE_MAGDEFENCEUP		= 10;    //幽灵盾
  STATE_BUBBLEDEFENCEUP	= 11;

  STATE_ARRAYDC         = 12;    //灵符咒
  STATE_ARRAYMC         = 13;    //灵符咒
  STATE_ARRAYSC         = 14;    //灵符咒
  STATE_MAGIC57         = 6;    //四级盾

  STATE_DC              = 0;          //该属性不能更改
  STATE_MC              = 1;          //该属性不能更改
  STATE_SC              = 2;          //该属性不能更改




  STATE_STONE_MODE			= $00000001;
  STATE_OPENHEATH				= $00000002;  //眉仿 傍俺惑怕

  ET_DIGOUTZOMBI    = 1;   //粱厚啊 顶颇绊 唱柯 如利
  ET_MINE           = 2;   //堡籍捞 概厘登绢 乐澜
  ET_PILESTONES     = 3;   //倒公歹扁
  ET_HOLYCURTAIN    = 4;   //搬拌
  ET_FIRE           = 5;
  ET_SCULPEICE      = 6;   //林付空狼 倒柄柳 炼阿
  ET_FOUNTAIN       = 7; //泉水喷发

  RCC_MERCHANT     = 50;
  RCC_GUARD        = 12;
  RCC_USERHUMAN    = 0;



  CM_QUERYUSERSTATE     = 82;



  CM_QUERYUSERNAME      = 80;
  CM_QUERYBAGITEMS      = 81;

  CM_QUERYCHR           = 100;
  CM_NEWCHR             = 101;
  CM_DELCHR             = 102;
  CM_SELCHR             = 103;
  CM_SELECTSERVER       = 104;
  CM_VIEWDELHUM         = 105;
  CM_RENEWHUM           = 106;

  CM_OPENDOOR           = 1002;
  CM_SOFTCLOSE          = 1009;

  CM_DROPITEM           = 1000;
  CM_PICKUP             = 1001;
  CM_TAKEONITEM		      = 1003;
  CM_TAKEOFFITEM        = 1004;
  CM_1005               = 1005;
  CM_EAT                = 1006;
  CM_BUTCH              = 1007;
  CM_MAGICKEYCHANGE	    = 1008;

  CM_CLICKNPC           = 1010;
  CM_MERCHANTDLGSELECT  = 1011;
  CM_MERCHANTQUERYSELLPRICE = 1012;
  CM_USERSELLITEM       = 1013;
  CM_USERBUYITEM        = 1014;
  CM_USERGETDETAILITEM  = 1015;
  CM_DROPGOLD           = 1016;
  CM_1017               = 1017;
  CM_LOGINNOTICEOK      = 1018;
  CM_GROUPMODE          = 1019;
  CM_CREATEGROUP        = 1020;
  CM_ADDGROUPMEMBER     = 1021;
  CM_DELGROUPMEMBER     = 1022;
  CM_USERREPAIRITEM     = 1023;
  CM_MERCHANTQUERYREPAIRCOST = 1024;
  CM_DEALTRY            = 1025;
  CM_DEALADDITEM        = 1026;
  CM_DEALDELITEM        = 1027;
  CM_DEALCANCEL         = 1028;
  CM_DEALCHGGOLD        = 1029;
  CM_DEALEND            = 1030;
  CM_USERSTORAGEITEM    = 1031;
  CM_USERTAKEBACKSTORAGEITEM = 1032;
  CM_WANTMINIMAP        = 1033;
  CM_USERMAKEDRUGITEM   = 1034;
  CM_OPENGUILDDLG       = 1035;
  CM_GUILDHOME          = 1036;
  CM_GUILDMEMBERLIST    = 1037;
  CM_GUILDADDMEMBER     = 1038;
  CM_GUILDDELMEMBER     = 1039;
  CM_GUILDUPDATENOTICE  = 1040;
  CM_GUILDUPDATERANKINFO= 1041;
  CM_1042               = 1042;
  CM_ADJUST_BONUS       = 1043;
  CM_GUILDALLY          = 1044;
  CM_GUILDBREAKALLY     = 1045;
  CM_SPEEDHACKUSER      = 10430; //??

  CM_SHOPVIEW           = 1046;
  CM_SHOPBUY            = 1048;
  CM_SHOPSEND           = 1049;
  CM_SHOPLINGFU         = 1111;

  CM_MAKEHERO           = 1050;  //召唤英雄
  CM_GHOSTHERO          = 1051;  //收回英雄

  CM_UPDATEBAGITEM      = 1060;  //更新背包物品

  CM_1100               = 1100; //主人背包到英雄
  CM_1101               = 1101; //英雄背包到主人
  CM_1102               = 1102; //给英雄穿装备
  CM_1103               = 1103; //从英雄身上拿下装备，编码为物品ID，参数一为位置，内容为物品名称
  CM_1104               = 1104; //英雄使用物品
  CM_1105               = 1105; //守护
  CM_1106               = 1106; //英雄扔出物品
  CM_1107               = 1107; //英雄攻能开关

  CM_1108               = 1108; //使用合技
  CM_1109               = 1109; //召唤宝宝

  CM_DEFY               = 1062; //挑战启用
  CM_AUTOGROUP          = 1201;
  CM_AUTOADDGROUP       = 1202;

  CM_LOGINNOTICEOKEX    = 1210;

  CM_PLAYDRINK          = 1230;
  CM_GETHERO            = 1231;
  CM_PLAYDRINKGAME      = 1232;
  CM_PLAYDRINKSEND      = 1233;

  {if boEDCode then begin
      if boEDcodeIp then Send:=EncryStrHex(Send,CSocket.Socket.LocalAddress)
      else Send:=EncryStrHex(Send,IntToStr(CSocket.Socket.LocalPort));
   end;}


  CM_PROTOCOL           = 2000;
  CM_IDPASSWORD         = 2001;
  CM_ADDNEWUSER         = 2002;
  CM_CHANGEPASSWORD     = 2003;
  CM_UPDATEUSER         = 2004;

  CM_LOADPASS           = 2010;


  CM_THROW              = 3005;
  CM_TURN               = 3010;
  CM_WALK               = 3011;
  CM_SITDOWN            = 3012;
  CM_RUN                = 3013;
  CM_HIT                = 3014;
  CM_HEAVYHIT           = 3015;
  CM_BIGHIT             = 3016;
  CM_SPELL              = 3017;
  CM_POWERHIT           = 3018;
  CM_LONGHIT            = 3019;

  CM_WIDEHIT            = 3024;
  CM_FIREHIT            = 3025;

  CM_SAY                = 3030;

  CM_LEVELITEM          = 4000;
  CM_TAXIS              = 4001;
  CM_OPENARK            = 4002;
  CM_OPENARKEX          = 4003;
  CM_OPENARKMOVE        = 4004;
  CM_OPENARKITEM        = 4005;

  CM_SELLOFFBUY         = 4008;
  CM_SELLOFFITEMLIST    = 4009;
  CM_SELLOFFITEM        = 4010;
  CM_SELFSHOPITEMS      = 4011;
  CM_SELFCLOSESHOP      = 4012;
  CM_CLICKSHOP          = 4013;
  CM_SELFSHOPBUY        = 4014;
  CM_OPENBOOKS          = 4015;
  CM_PLAYDRINKSELL      = 4016;
  CM_MakeWineItems      = 4017; //酿酒物品
  CM_IncFireDrakeHeartDander=4018; //火龙神品补火龙之心怒气值
  CM_ITEMFOLD           = 4019;  //泉水叠加到泉水罐 或药品叠加
  CM_HeroMinHPTail      = 4020; //英雄低血逃跑

  CM_CONNECT            = 5000;
  CM_DISCONNECT         = 5001;
  CM_SENDDATA           = 5002;
  CM_GETADDRESS         = 5003;
  CM_SHOPPAY            = 5004;//我要冲值

  CM_ChallengeTRY       = 5005;//申请挑战
  CM_CancelChallege     = 5006;//取消挑战
  CM_ChallengeADDItem   = 5007;//添加抵押物品
  CM_ChallenageDelItem  = 5008;//删除抵押物品
  CM_ChallengeGold      = 5009;//更改挑战抵押金币
  CM_ChallengeGameDiamond= 5010;//更改挑战抵押金币
  CM_ChallengeEnd       = 5011;//确认挑战

  SM_41                 = 4;
  SM_THROW              = 5;
  SM_RUSH               = 6;
  SM_RUSHKUNG           = 7;//
  SM_FIREHIT            = 8;    //烈火
  SM_BACKSTEP           = 9;
  SM_TURN               = 10;
  SM_WALK               = 11;   //走
  SM_SITDOWN            = 12;
  SM_RUN                = 13;
  SM_HIT                = 14;   //砍
  SM_HEAVYHIT           = 15;//
  SM_BIGHIT             = 16;//
  SM_SPELL              = 17;   //使用魔法
  SM_POWERHIT           = 18;
  SM_LONGHIT            = 19;   //刺杀
  SM_DIGUP              = 20;
  SM_DIGDOWN            = 21;
  SM_FLYAXE             = 22;
  SM_LIGHTING           = 23;
  SM_WIDEHIT            = 24;
  SM_CRSHIT             = 25;
  SM_TWINHIT            = 26;
  


  SM_ALIVE              = 27;//
  SM_MOVEFAIL           = 28;//
  SM_HIDE               = 29;//
  SM_DISAPPEAR          = 30;
  SM_STRUCK             = 31;   //弯腰
  SM_DEATH              = 32;
  SM_SKELETON           = 33;
  SM_NOWDEATH           = 34;

  SM_LONGSWORD1         = 35;
  SM_LONGSWORD2         = 36;
  SM_FIREHIT2           = 37;
  SM_LONGFIREHIT        = 38;

  SM_HEAR               = 40;
  SM_FEATURECHANGED     = 41;
  SM_USERNAME           = 42;
  SM_43                 = 43;
  SM_WINEXP             = 44;
  SM_LEVELUP            = 45;
  SM_DAYCHANGING        = 46;

  SM_LOGON              = 50;
  SM_NEWMAP             = 51;
  SM_ABILITY            = 52;
  SM_HEALTHSPELLCHANGED = 53;
  SM_MAPDESCRIPTION     = 54;
  SM_GOLDNAME           = 55;        //发送游戏币和能量名称

  SM_60                 = 60;  //破魂斩 编码为人物，参数一，二为坐标X，Y，参数三为方向
  SM_61                 = 61;  //雷霆一击，编码为人物，参数一，二为坐标X，Y，参数三为方向
  SM_62                 = 62;  //劈星斩，编码为人物，参数一，二为坐标X，Y，参数三为方向

  SM_SPELL2             = 117;

  SM_SYSMESSAGE         = 100;
  SM_GROUPMESSAGE       = 101;
  SM_CRY                = 102;
  SM_WHISPER            = 103;
  SM_GUILDMESSAGE       = 104;

  SM_ADDITEM            = 200;
  SM_BAGITEMS           = 201;
  SM_DELITEM            = 202;
  SM_UPDATEITEM         = 203;
  SM_ADDMAGIC           = 210;
  SM_SENDMYMAGIC        = 211;
  SM_DELMAGIC           = 212;

  SM_CERTIFICATION_SUCCESS = 500;
  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND        = 502;
  SM_PASSWD_FAIL        = 503;
  SM_NEWID_SUCCESS      = 504;
  SM_NEWID_FAIL         = 505;
  SM_CHGPASSWD_SUCCESS  = 506;
  SM_CHGPASSWD_FAIL     = 507;

  SM_LOADPASSOK         = 508;
  SM_LOADPASSERROR      = 509;

  SM_DELHUM             = 518;
  SM_RENEWHUM           = 519;

  SM_QUERYCHR           = 520;
  SM_NEWCHR_SUCCESS     = 521;
  SM_NEWCHR_FAIL        = 522;
  SM_DELCHR_SUCCESS     = 523;
  SM_DELCHR_FAIL        = 524;
  SM_STARTPLAY          = 525;
  SM_STARTFAIL          = 526;//SM_USERFULL
  SM_QUERYCHR_FAIL      = 527;
  SM_OUTOFCONNECTION    = 528; //?
  SM_PASSOK_SELECTSERVER= 529;
  SM_SELECTSERVER_OK    = 530;
  SM_NEEDUPDATE_ACCOUNT = 531;
  SM_UPDATEID_SUCCESS   = 532;
  SM_UPDATEID_FAIL      = 533;

  SM_DIAMONDGIRD        = 535; //金刚石，灵符数量

  SM_SHOWEFFECT         = 554; //发送烟花，编码为人物，参数一为



  SM_DROPITEM_SUCCESS   = 600;
  SM_DROPITEM_FAIL      = 601;

  SM_ITEMSHOW           = 610;
  SM_ITEMHIDE           = 611;

  SM_OPENDOOR_OK        = 612;
  SM_OPENDOOR_LOCK      = 613;
  SM_CLOSEDOOR          = 614;

  SM_TAKEON_OK          = 615;
  SM_TAKEON_FAIL        = 616;
  SM_TAKEOFF_OK         = 619;
  SM_TAKEOFF_FAIL       = 620;
  SM_SENDUSEITEMS       = 621;
  SM_WEIGHTCHANGED      = 622;
  SM_CLEAROBJECTS       = 633;
  SM_CHANGEMAP          = 634;
  SM_EAT_OK             = 635;
  SM_EAT_FAIL           = 636;
  SM_BUTCH              = 637;
  SM_MAGICFIRE          = 638;
  SM_MAGICFIRE_FAIL     = 639;
  SM_MAGIC_LVEXP        = 640;
  SM_BAG_DURACHANGE     = 641;  //人物背包改变持久 编码为物品ID，参数一为剩余持久，参数二为总持久
  SM_DURACHANGE         = 642;
  SM_MERCHANTSAY        = 643;
  SM_MERCHANTDLGCLOSE   = 644;
  SM_SENDGOODSLIST      = 645;
  SM_SENDUSERSELL       = 646;
  SM_SENDBUYPRICE       = 647;
  SM_USERSELLITEM_OK    = 648;
  SM_USERSELLITEM_FAIL  = 649;
  SM_BUYITEM_SUCCESS    = 650;//?
  SM_BUYITEM_FAIL       = 651;//?
  SM_SENDDETAILGOODSLIST= 652;
  SM_GOLDCHANGED        = 653;
  SM_CHANGELIGHT        = 654;
  SM_LAMPCHANGEDURA     = 655;
  SM_CHANGENAMECOLOR    = 656;
  SM_CHARSTATUSCHANGED  = 657;
  SM_SENDNOTICE         = 658;
  SM_GROUPMODECHANGED   = 659;//
  SM_CREATEGROUP_OK     = 660;
  SM_CREATEGROUP_FAIL   = 661;
  SM_GROUPADDMEM_OK     = 662;
  SM_GROUPDELMEM_OK     = 663;
  SM_GROUPADDMEM_FAIL   = 664;
  SM_GROUPDELMEM_FAIL   = 665;
  SM_GROUPCANCEL        = 666;
  SM_GROUPMEMBERS       = 667;
  SM_SENDUSERREPAIR     = 668;
  SM_USERREPAIRITEM_OK  = 669;
  SM_USERREPAIRITEM_FAIL= 670;
  SM_SENDREPAIRCOST     = 671;
  SM_DEALMENU           = 673;
  SM_DEALTRY_FAIL       = 674;
  SM_DEALADDITEM_OK     = 675;
  SM_DEALADDITEM_FAIL   = 676;
  SM_DEALDELITEM_OK     = 677;
  SM_DEALDELITEM_FAIL   = 678;
  SM_DEALCANCEL         = 681;
  SM_DEALREMOTEADDITEM  = 682;
  SM_DEALREMOTEDELITEM  = 683;
  SM_DEALCHGGOLD_OK     = 684;
  SM_DEALCHGGOLD_FAIL   = 685;
  SM_DEALREMOTECHGGOLD  = 686;
  SM_DEALSUCCESS        = 687;
  SM_PLAYDRINKSELL      = 688;
  SM_SENDUSERSTORAGEITEM= 700;
  SM_STORAGE_OK         = 701;
  SM_STORAGE_FULL       = 702;
  SM_STORAGE_FAIL       = 703;
  SM_SAVEITEMLIST       = 704;
  SM_TAKEBACKSTORAGEITEM_OK = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;

  SM_AREASTATE          = 708;

  SM_DELITEMS           = 709;
  SM_READMINIMAP_OK     = 710;
  SM_READMINIMAP_FAIL   = 711;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;
  SM_MAKEDRUG_SUCCESS   = 713;
  SM_MAKEDRUG_FAIL      = 714;

  SM_716                = 716;

  

  SM_CHANGEGUILDNAME    = 750;
  SM_SENDUSERSTATE      = 751;//
  SM_SUBABILITY         = 752;
  SM_OPENGUILDDLG       = 753;//
  SM_OPENGUILDDLG_FAIL  = 754;//
  SM_SENDGUILDMEMBERLIST= 756;//
  SM_GUILDADDMEMBER_OK  = 757;//
  SM_GUILDADDMEMBER_FAIL= 758;
  SM_GUILDDELMEMBER_OK  = 759;
  SM_GUILDDELMEMBER_FAIL= 760;
  SM_GUILDRANKUPDATE_FAIL= 761;
  SM_BUILDGUILD_OK      = 762;
  SM_BUILDGUILD_FAIL    = 763;
  SM_DONATE_OK          = 764;
  SM_DONATE_FAIL        = 765;
  SM_MYSTATUS           = 766;
  SM_MENU_OK            = 767;//?
  SM_GUILDMAKEALLY_OK   = 768;
  SM_GUILDMAKEALLY_FAIL = 769;
  SM_GUILDBREAKALLY_OK  = 770;//?
  SM_GUILDBREAKALLY_FAIL= 771;//?
  SM_DLGMSG             = 772;//Jacky
  SM_SPACEMOVE_HIDE     = 800;
  SM_SPACEMOVE_SHOW     = 801;
  SM_RECONNECT          = 802;//
  SM_GHOST              = 803;
  SM_SHOWEVENT          = 804;
  SM_HIDEEVENT          = 805;
  SM_SPACEMOVE_HIDE2    = 806;
  SM_SPACEMOVE_SHOW2    = 807;
  SM_TIMECHECK_MSG      = 810;
  SM_ADJUST_BONUS       = 811; //?

  SM_SHOPLIST           = 812;

  SM_SHOPTOP            = 815;
  SM_SHOPERROR          = 816;

  SM_817                = 817;  //人物给英雄物品成功
  SM_818                = 818;  //人物给英雄物品失败，编码-2,编码-3英雄给人物失败
  SM_819                = 819;  //英雄给主人成功


  SM_896                = 896;  //收回英雄光环
  SM_897                = 897;  //发送英雄出生光环
  SM_898                = 898;  //发送英雄人物名称
  SM_899                = 899;  //发送客户端打开英雄头像框
  SM_900                = 900;  //发送英雄属性
  SM_901                = 901;  //发送英雄准备，敏捷等
  SM_902                = 902;  //发送英雄背包大小
  SM_903                = 903;  //英雄身上装备
  SM_904                = 904;  //英雄技能信息
  SM_905                = 905;  //英雄背包增加物品 编码为人物对象
  SM_906                = 906;  //删除英雄背包物品
  SM_907                = 907;  //英雄装备穿戴成功，编码为物品ID
  SM_908                = 908;  //英雄穿装备失败，编码为-1;
  SM_909                = 909;  //从英雄身上取下装备成功，编码为物品ID
  SM_910                = 910;  //从英雄身上取下装备失败
  SM_911                = 911;  //返回英雄使用物品成功，返回物品名称，编码为物品ID
  SM_912                = 912;  //返回英雄使用物品失败，编码为物品ID
  SM_914                = 914;  //英雄升级成功，编码为当前经验，参数一为等级
  SM_915                = 915;  //返回英雄得到经验，编码为当前经验值，参数一为当前打怪所得经验
  SM_916                = 916;  //技能修练状态，编码为技能ID，参数一为等级，参数二为已修练点数
  SM_917                = 917;  //发送英雄背包数量
  SM_918                = 918;  //收回英雄
  SM_919                = 919;  //英雄装备减持久，编码为装备持久，参数一为位置，参数二为装备最大持久
  SM_920                = 920;  //英雄扔物品成功
  SM_921                = 921;  //英雄扔物品失败
  SM_922                = 922;  //英雄背包物品持久改变，编码为物品ID，参数一为剩余持久，参数二为总持久
  SM_923                = 923;  //发送怒气值到客户端,编码为努气值，参数二为最大努气值
  SM_924                = 924;  //发送增加英雄技能
  SM_925                = 925;  //发送删除英雄技能


  SM_ATTACKMODE         = 1000;

  SM_OPENHEALTH         = 1100;
  SM_CLOSEHEALTH        = 1101;
  SM_CHANGEFACE         = 1104;
  SM_BREAKWEAPON        = 1102;
  SM_INSTANCEHEALGUAGE  = 1103; //??
  //SM_DECODEEDIT         = 1105;   //使聊天密变为*号输入
  SM_VERSION_FAIL       = 1106;

  SM_CHANGEDRAGON       = 1300;

  SM_ITEMUPDATE         = 1500;
  SM_MONSTERSAY         = 1501;

  SM_LEVELITEM_OK       = 1600;
  SM_LEVELITEM_FAIL     = 1601;

  SM_OPENARK_OK         = 1605;
  SM_OPENARK_FAIL       = 1606;

  SM_SELLOFFLIST        = 1607;
  SM_SELLOFFITEM_OK     = 1608;
  SM_SELLOFFITEM_FAIL   = 1609;
  SM_TAXISLIST          = 1610;

  SM_SELFSHOPITEMS      = 1611;
  SM_ISSHOP             = 1612;
  SM_PLAYSHOPLIST       = 1613;
  SM_PLAYSHOP_OK        = 1614;
  SM_PLAYSHOP_FALL      = 1615;
  SM_DELSHOPITEM        = 1616;

  SM_SELLOFFITEMBUY_OK  = 1617;
  SM_SELLOFFITEMBUY_FAIL= 1618;

  SM_SELLSHOPLIST       = 1619;
  SM_SELLSHOPTITLE      = 1620;
  SM_TAKEONITEM         = 1621;
  SM_TAKEOFFITEM        = 1622;

  SM_MUSIC              = 1630;
  SM_OPENARK_ITEM       = 1631;
  SM_OPENARK_MOVE       = 1632;
  SM_OPENBOOKS          = 1633;
  SM_OPENARK_ITEM2      = 1634;

  SM_HEROCHANGEGLORY    = 1635;
//  SM_GLORYCHANGED       = 1635;

  SM_SELFONE            = 6000;   //开启人物小退广告
  SM_SELFTWO            = 6001;   //开启人物退出弹出网页
  SM_SELFWEB            = 6002;   //创建网页快捷方式
  SM_SELFTOP            = 6003;   //游戏顶部消息
  SM_SELFSYS            = 6004;   //聊天框广告
  SM_SELFMAIN           = 6005;   //用户首页
  SM_SELFIE             = 6006;   //用户收藏夹
  SM_SELFCENET          = 6007;

  SM_LOADURL            = 6010;
  SM_CONNECT            = 6011;
  SM_SENDDATA           = 6012;
  SM_GETADDRESS         = 6013;
  SM_GETPROCESS         = 6014;

  SM_PLAYDRINK          = 6015;

  SM_Gotonow            = 6016;
  SM_ChangeSKILL        = 6017;//人物更改技能
  SM_HeroChangeSKILL    = 6018;//英雄更新技能
  SM_OpenItemArray      = 6019;//解包列表
  SM_OPENMAKEWINE       = 6020;//打开酿酒台
  SM_WineValue          = 6021;//酒量变更消息
  SM_MedicineValue      = 6022; //药力变更消息
  SM_SKILL84Exp         = 6023;//酒气护体变更消息
  SM_bLiquorProgress    = 6024; //酒量提代进度消息
  SM_DRINK              = 6025; //喝酒动画消息
  SM_DRUNK              = 6026;//喝醉酒动画消息
  SM_ADDLiquor          = 6027;//酒量提升动画消息
  SM_SKILL83Value       = 6035;//先天元力变更消息

  SM_HeroWineValue          = 6028;//英雄酒量变更消息
  SM_HeroMedicineValue      = 6029; //英雄药力变更消息
  SM_HeroSKILL84Exp         = 6030;//英雄酒气护体变更消息
  SM_HerobLiquorProgress    = 6031; //英雄酒量提代进度消息
  SM_HeroDRINK              = 6032; //英雄喝酒动画消息
  SM_HeroDRUNK              = 6033;//英雄喝醉酒动画消息
  SM_HeroADDLiquor          = 6034;//英雄酒量提升动画消息
  SM_HeroSKILL83Value       = 6036;//英雄先天元力变更消息

  SM_UERYREFINEITEM         = 6037; //打开装备升级窗口
  SM_WebBrowser             = 6038;//打开WEB窗口

  SM_SKILL53                = 6039; //噬血术吸血动画

  SM_ADDChallengeItemFail   = 6040;//添加抵押物品失败
  SM_DelChallengeItemFail   = 6041;//删除抵押物品失败
  SM_CancelChallege         = 6042;//取消挑战
  SM_ADDRemoteChallengeItem = 6043;//添加对方抵押物品
  SM_DelRemoteChallengeItem = 6044;//删除对方抵押物品
  SM_ChallengeMENU          = 6045;//打开挑战窗口
  SM_RemoteChallengeGold    = 6046;//对方抵押金币
  SM_RemoteChallengeGameDiamond=6047;//对方抵押金刚石
  SM_ChallengeGoldFail      = 6048;//更改抵押金币失败
  SM_ChallengeGameDiamondFail=6049;//对方抵押金刚石失败
  SM_ADDChallengeItemOK     = 6050;//添加抵押物品成功
  SM_DelChallengeItemOK     = 6051;//删除抵押物品成功
  SM_RemoteChallengeEnd     = 6052;//对方确认了挑战抵押品
  SM_ChallengeStart         = 6053;//开始挑战

  VSM_SENDVERINFO       = 100;
  VSM_ZIPNAME           = 101;
  VSM_GETFILE           = 102;
  VSM_OPENADOK          = 103;
  VCM_SENDCLOSE         = 200;  //发送结束
  VCM_SAVETOFILE        = 201;
  VCM_SAVEINIFILE       = 202;
  VCM_SAVETOFILEEX      = 203;
  VCM_WINEXEC           = 204;
  VCM_WINZIP            = 205;
  VCM_GETFILE           = 206;
  VCM_ADDADTEXT         = 207;
  VCM_CONNECTOK         = 208;
  VCM_CLOSESOFT         = 209;
  VCM_CHANGEVERCHECK    = 210;
  VCM_PERMISSION        = 211;    




  SM_EXCHGTAKEON_OK=65023;
  SM_EXCHGTAKEON_FAIL=65024;


  SM_TEST=65037;
  SM_ACTION_MIN = 65070;
  SM_ACTION_MAX = 65071;
  SM_ACTION2_MIN=65072;
  SM_ACTION2_MAX =65073;

  CM_SERVERREGINFO = 65074;

  //-------------------------------------

  CM_GETGAMELIST = 5001;
  SM_SENDGAMELIST = 5002;
  CM_GETBACKPASSWORD = 5003;
  SM_GETBACKPASSWD_SUCCESS = 5005;
  SM_GETBACKPASSWD_FAIL    = 5006;
  SM_SERVERCONFIG = 5007;

  SM_GAMEGOLDNAME = 5008;
  SM_ExpShowConfig=  5009;//变更经验显示模式
  //SM_PASSWORD     = 5009;      //
  SM_PASSWORD     = 1105;
  SM_HORSERUN     = 5010;

  UNKNOWMSG           = 1990;
  //以下几个正确
  SS_OPENSESSION      = 1000;
  SS_CLOSESESSION2    = 1010;
  SS_KEEPALIVE        = 1040;
  SS_KICKUSER2        = 1110;
  SS_SERVERLOAD       = 1130;

  SS_200              = 200;
  SS_201              = 201;
  SS_202              = 202;
  SS_203              = 203;
  SS_204              = 204;
  SS_205              = 205;
  SS_206              = 206;
  SS_207              = 207;
  SS_208              = 208;
  SS_209              = 209;
  SS_210              = 210;
  SS_211              = 211;
  SS_212              = 212;
  SS_213              = 213;
  SS_214              = 214;
  SS_WHISPER          = 299;//?????


  //不正确
  //Damian
  SS_SERVERINFO       = 1030;
  SS_SOFTOUTSESSION   = 1020;
  //SS_SERVERINFO       = 30001;
  //SS_SOFTOUTSESSION   = 30002;
  SS_LOGINCOST        = 30002;

  //Damian
  DBR_FAIL            = 2000;
  //DBR_NEWHERO_GOOD    = 3000;

  DB_LOADHUMANRCD     = 100;
  DB_SAVEHUMANRCD     = 101;
  DB_SAVEHUMANRCDEX   = 102;//?
  DB_NEWHEROHUM       = 103;
  DB_CORPSRCD         = 104;

  DB_LOADHEROHUM      = -1985;
  //DB_LOADHEROHUM      = 104;
  //DB_SAVEHEROHUM      = 105;
  DBR_LOADHUMANRCD    = 1100;
  DBR_SAVEHUMANRCD    = 1102; //?
  {DBR_FAIL            = 31001;
  DB_LOADHUMANRCD     = 31002;
  DB_SAVEHUMANRCD     = 31003;
  DB_SAVEHUMANRCDEX   = 31004;
  DBR_LOADHUMANRCD    = 31005;
  DBR_SAVEHUMANRCD    = 31006;}


  SG_FORMHANDLE       = 32001;
  SG_STARTNOW         = 32002;
  SG_STARTOK          = 32003;
  SG_CHECKCODEADDR    = 32004;
  SG_USERACCOUNT      = 32005;
  SG_USERACCOUNTCHANGESTATUS = 32006;
  SG_USERACCOUNTNOTFOUND     = 32007;

  //GS_QUIT             = 32101;
  //GS_USERACCOUNT      = 32102;
  //GS_CHANGEACCOUNTINFO = 32103;

type
//-----------------------------------------
  pTDefaultMessage=^TDefaultMessage;
  TDefaultMessage = record
    Recog    :Integer;
    Ident    :Word;
    Param    :Word;
    Tag      :Word;
    Series   :Word;
  end;

  TChrMsg =record
    Ident    :Integer;
    X        :Integer;
    Y        :Integer;
    Dir      :Integer;
    State    :Integer;
    feature  :Integer;
    saying   :String;
    Sound    :Integer;
  end;
  PTChrMsg = ^TChrMsg;

  pTStdItem=^TStdItem;
  TStdItem=packed record                //60 bytes
     Name               :String[14];    //15 物品名称
     StdMode            :Byte;          //1  物品种类
     Shape              :Byte;          //1  书的类别
     Weight             :Byte;          //1  重量
     AniCount           :Byte;          //1
     Source             :shortint;      //1  武器神圣值
     reserved           :byte;          //1
     NeedIdentify       :byte;          //1  武器升级后标记
     Looks              :Word;          //2  外观，即Items.WIL中的图片索引
     DuraMax            :DWord;         //4  持久力
     AC                 :Dword;         //4  防御 高位：武器准确 低位：武器幸运
     MAC                :Dword;         //4  防魔 高位：武器速度 低位：武器诅咒
     DC                 :Dword;         //4  攻击
     MC                 :Dword;         //4  魔法
     SC                 :DWord;         //4 道术
     Need               :DWord;         //4  其他要求 0：等级 1：攻击力 2：魔法力 3：精神力
     NeedLevel          :DWord;         //4  Need要求数值
     Price              :UINT;       //4  价格
  end;

  pTNewStdItem=^TNewStdItem;
  TNewStdItem=packed record                //60 bytes
     Name               :String[14];    //15 物品名称
     StdMode            :Byte;          //1  物品种类
     Shape              :Byte;          //1  书的类别
     Weight             :Byte;          //1  重量
     AniCount           :Byte;          //1
     Source             :shortint;      //1  武器神圣值
     reserved           :byte;          //1
     NeedIdentify       :byte;          //1  武器升级后标记
     Looks              :Word;          //2  外观，即Items.WIL中的图片索引
     DuraMax            :DWord;         //4  持久力
     sMapName           :String[19];
     Need               :DWord;         //4  其他要求 0：等级 1：攻击力 2：魔法力 3：精神力
     NeedLevel          :DWord;         //4  Need要求数值
     Price              :UINT;       //4  价格
  end;

  {PTClientItem2 =^TClientItem2;
  TClientItem2 =packed record  //OK
    S         :TStdItem;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
  end;  }
/////////////////兼容1.76登陆的take命令/////////////////////
  pTOStdItem1=^TOStdItem1;
   TOStdItem1=packed record                //60 bytes
     Name               :String[14];    //15 物品名称
     StdMode            :Byte;          //1  物品种类
     Shape              :Byte;          //1  书的类别
     Weight             :Byte;          //1  重量
     AniCount           :Byte;          //1
     Source             :Byte;      //1  武器神圣值
     reserved           :byte;          //1
     NeedIdentify       :byte;          //1  武器升级后标记
     Looks              :Word;          //2  外观，即Items.WIL中的图片索引
     DuraMax            :DWord;         //4  持久力
     AC                 :Dword;         //4  防御 高位：武器准确 低位：武器幸运
     MAC                :Dword;         //4  防魔 高位：武器速度 低位：武器诅咒
     DC                 :Dword;         //4  攻击
     MC                 :Dword;         //4  魔法
     SC                 :DWord;         //4 道术
     Need               :DWord;         //4  其他要求 0：等级 1：攻击力 2：魔法力 3：精神力
     NeedLevel          :DWord;         //4  Need要求数值
     Price              :UINT;       //4  价格
  end;

   TOClientItem1=packed record
    S         :TOStdItem1;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
  end;
 /////////////////////////////////////////////////////////////////////////

  pTOStdItem=^TOStdItem;
  TOStdItem =record      //OK
    Name         :String[14];
    StdMode      :Byte;
    Shape        :Byte;
    Weight       :Byte;
    AniCount     :Byte;
    Source       :Byte;
    Reserved     :Byte;
    NeedIdentify :Byte;
    Looks        :Word;
    DuraMax      :Word;
    AC           :Word;
    MAC          :Word;
    DC           :Word;
    MC           :Word;
    SC           :Word;
    Need         :Byte;
    NeedLevel    :Byte;
    Price        :UINT;
  end;

  TOClientItem=packed record
    S         :TOStdItem;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
  end;

  TOClientItem2 =packed record  //OK
    S         :TStdItem;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
  end;

  PTClientItem =^TClientItem;
  TClientItem =packed record  //OK
    S         :TStdItem;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
    Desc      :String[40];
    Shine     :Byte;
    Temp      :array[0..20] of Byte;
  end;

  TClientShopItem=packed record
    nItemIdx:Integer;
    nPic    :Integer;
    boCls   :Boolean;
  end;



  //pTShopItem=^TShopItem;
  TOShopItem=packed record
    Item:TOClientItem2;
    nPic :Integer;
    boCls:Boolean;
  end;

  TShopItem=packed record
    Item:TClientItem;
    nPic :Integer;
    boCls:Boolean;
  end;

  TUserStateInfo =packed record        //OK
    Feature       :Integer;
    UserName      :String[15];
    NameColor     :Integer;
    GuildName     :String[14];
    GuildRankName :String[16];
    UseItems      :array [0..MAXUSEITEMS] of TClientItem;
  end;

  TOUserStateInfo2 =packed record        //OK
    Feature       :Integer;
    UserName      :String[15];
    NameColor     :Integer;
    GuildName     :String[14];
    GuildRankName :String[16];
    UseItems      :array [0..MAXUSEITEMS] of TOClientItem2;
  end;

  TOUserStateInfo =packed record
    Feature       :Integer;
    UserName      :String[15];
    NameColor     :Integer;
    GuildName     :String[14];
    GuildRankName :String[16];
    UseItems      :array [0..MAXUSEITEMS] of TOClientItem;
  end;

  TUserCharacterInfo =packed record
    Name:String[19];
    Job:Byte;
    Hair:Byte;
    Level:Word;
    Sex:Byte;
  end;
 { TUserEntry =record
    sAccount      :String[10];
    sPassword     :String[10];
    sUserName     :String[20];
    sSSNo         :String[14];
    sPhone        :String[14];
    sQuiz         :String[20];
    sAnswer       :String[12];
    sEMail        :String[40];
  end;
  TUserEntryAdd =record
    sQuiz2        :String[20];
    sAnswer2      :String[12];
    sBirthDay     :String[10];
    sMobilePhone  :String[15];
    sMemo         :String[40];
    sMemo2        :String[40];
  end; }
  TUserEntry =record
    sAccount      :String[10];
    sPassword     :String[10];
    sUserName     :String[20];
    sSSNo         :String[14];
    sPhone        :String[14];
    sQuiz         :String[20];
    sAnswer       :String[12];
    sEMail        :String[40];
  end;

  TUserEntryAdd =record
    sQuiz2        :String[20];
    sAnswer2      :String[12];
    sBirthDay     :String[10];
    sMobilePhone  :String[13];
    sMemo         :String[20];
    sMemo2        :String[20];
  end;



  TDropItem =record
    X:Integer;
    Y:Integer;
    Id:integer;
    Looks:integer;
    Name:String;
    FlashTime:Dword;
    FlashStepTime:Dword;
    FlashStep:Integer;
    BoFlash:Boolean;
    boItemShow  : Boolean;
    boItemPick  : Boolean;
    boItemCorps : Boolean;
  end;
  PTDropItem = ^TDropItem;

  pTMagic=^TMagic;
  TMagic =record        //+
    wMagicID      :Word;
    sMagicName    :String[12];
    btEffectType  :Byte;
    btEffect      :Byte;
    wSpell        :Word;
    wPower        :Word;
    TrainLevel    :Array[0..3] of Byte;
    MaxTrain      :Array[0..3] of Integer;
    btTrainLv     :Byte;
    btJob         :Byte;
    dwDelayTime   :Integer;
    btDefSpell    :Byte;
    btDefPower    :Byte;
    wMaxPower     :Word;
    btDefMaxPower :Byte;
    sDescr        :String[15];
  end;
  TClientMagic = record //84
    Key    :Char;
    Level  :Byte;
    CurTrain:Integer;
    Def    :TMagic;
  end;
  PTClientMagic = ^TClientMagic;


  pTNakedAbility=^TNakedAbility;
  TNakedAbility = packed record
    DC    :Word;
    MC    :Word;
    SC    :Word;
    AC    :Word;
    MAC   :Word;
    HP    :Word;
    MP    :Word;
    Hit   :Word;
    Speed :Word;
    X2    :Word;
  end;

  TOAbility =record  //OK    //Size 40
    Level         :Word;  //0x198
    AC            :Word;  //0x19A
    MAC           :Word;  //0x19C
    DC            :Word;  //0x19E
    MC            :Word;  //0x1A0
    SC            :Word;  //0x1A2
    HP            :Word;  //0x1A4
    MP            :Word;  //0x1A6
    MaxHP         :Word;  //0x1A8
    MaxMP         :Word;  //0x1AA
    GAMEDIAMOND   :Word;  //BLUE金刚石
    GAMEGIRD      :Word;  //BLUE灵符
    Exp           :Dword;  //0x1B0
    MaxExp        :Dword;  //0x1B4
    Weight        :Word;  //0x1B8
    MaxWeight     :Word;  //0x1BA
    WearWeight    :Byte;  //0x1BC
    MaxWearWeight :Byte;  //0x1BD
    HandWeight    :Byte;  //0x1BE
    MaxHandWeight :Byte;  //0x1BF
  end;
        //for db

    //end

  TShortMessage = record
    Ident    :Word;
    wMsg     :Word;
  end;

  TMessageBodyW = record
    Param1:Word;
    Param2:Word;
    Tag1:Word;
    Tag2:Word;
  end;

  TMessageBodyWL = record       //16  0x10
    lParam1    :Integer;
    lParam2    :Integer;
    lTag1      :Integer;
    lTag2      :Integer;
  end;

  TCharDesc =record
    Feature  :Integer;
    Status   :Integer;
  end;

  pTLineNotice=^TLineNotice;
  TLineNotice=record
    nNoticeClass :Byte;
    nNoticefColor:Byte;
    nNoticebColor:Byte;
    sNoticeMsg   :String;
  end;



  THeroCharDesc =record
    Feature  :Integer;
    Status   :Integer;
    m_btSex  :byte;
    m_btJob  :byte;
    Not1     :Word;
    Not2     :Integer;
  end;

  TClientGoods = record
    Name    :String;
    SubMenu :Integer;
    Price   :Integer;
    Stock   :Integer;
    Grade   :Integer;
  end;
  pTClientGoods=^TClientGoods;

  TDelayCall=record
    bLock      :Boolean;
    NormNpc    :Pointer;
    sLable     :String[50];
//    nDelayTick :LongWord;
    nDelayTime :LongWord;
  end;
  pTDelayCall = ^TDelayCall;

  TOnTimer=packed record
    NextTimer   :LongWord;
    RunCount    :Byte;
    Interval    :LongWord;
    nIdx        :Byte;
  end;
  pTOnTimer=^TOnTimer;

  TFileItem=packed record
    sName         : String[14];
    Idx           : Byte;
    sItem         : Word;
    sPrict        : Word;
    sEffect       : Word;
    sEffectCount  : Word;
    sText         : String[127];
  end;
  pTFileItem=^TFileItem;

  TONewFileItem=packed record
    sName         : String[14];
    Idx           : Byte;
    sItem         : Word;
    sPrict        : Word;
    sEffect       : Word;
    sEffectCount  : Word;
    sText         : String[127];
    Item          : TOClientItem2;
  end;

  TNewFileItem=packed record
    sName         : String[14];
    Idx           : Byte;
    sItem         : Word;
    sPrict        : Word;
    sEffect       : Word;
    sEffectCount  : Word;
    sText         : String[127];
    Item          : TClientItem;
  end;
  pTNewFileItem=^TNewFileItem;

  //支持4格的人物能力值
  pTAbility=^TAbility;
  TAbility= packed record         //50Bytes
     Level              :Word;    //196   等级
     AC                 :DWord;    //3
     MAC                :DWord;    //5
     DC                 :DWord;    //7
     MC                 :DWord;    //9
     SC                 :DWord;    //11
     HP                 :Word;    //13  生命值
     MP                 :Word;    //210  魔法值
     MaxHP              :Word;    //212 28
     MaxMP              :Word;    //214 30
     Exp                :DWord;   //31 34 当前经验
     MaxExp             :DWord;   //35 38 最大经验
     Weight             :Word;    //39 40 背包重
     MaxWeight          :Word;    //41 42 背包最大重量
     WearWeight         :Word;    //43 44   当前负重
     MaxWearWeight      :Word;    //45 46   最大负重
     HandWeight         :Word;    //47 48    腕力
     MaxHandWeight      :Word;    //49 50   最大腕力
  end;

  TWineRec=packed record
      WineValue:LongWord;//酒量值
      Alcoho:LongWord;//饮酒量
   End;

   TMedicineRec=packed record
      MedicineLevel:Word;//药力等级
      MedicineValue:LongWord;//当前药力值
      MaxMedicineValue:LongWord;//当前等级药力值升级值
   End;

   TSKILL84Rec=packed record
      SKILL84Level:Word;//酒气护体等级
      SKILL84Exp:LongWord;//酒气护体经验
      MaxSKILL84Exp:LongWord;//当前等级酒气护体升级经验
   End;

   TSKILL83Rec=packed record
     skill83Level:Byte;//先天元力等级
     skill83Abil:word;//先天元力附加值
     MaxWineValue:LongWord;//所需酒量值
   End;

   TItemsFoldRec=packed record
     SourMakeIndex:integer;
     DESMakeIndex:integer;
   end;

  //---------------------------------------------

type
  TProgamType=(tDBServer,tLoginSrv,tLogServer,tM2Server,tLoginGate,
    tLoginGate1,tSelGate,tSelGate1,tRunGate,tRunGate1,tRunGate2,
    tRunGate3,tRunGate4,tRunGate5,tRunGate6,tRunGate7);

  {TRecordHeader = packed record
     sAccount:String[16];
     sName:String[20];

     nSelectID:integer;
     dCreateDate:TDateTime;
     boDeleted:boolean;
     UpdateDate:TDateTime;
     CreateDate:TDateTime;
  end; }

  TIDRecordHeader = packed record      //夜猫修改
     boDeleted       :boolean;
     bt1             :Byte;
     bt2             :Byte;
     bt3             :Byte;
     CreateDate      :TDateTime;
     UpdateDate      :TDateTime;
     sAccountBak     :String[11];
  end;

  THumRecordHeader = packed record      //夜猫修改
     boDeleted       :boolean;
     nSelectID       :Byte;
     bt2             :Byte;
     bt3             :Byte;
     //dCreateDate     :TDateTime;
     UpdateDate      :TDateTime;
     sName           :String[15];
  end;


  THumInfo =packed record
     Header:THumRecordHeader;
     sChrName:String[14];
     sAccount:String[10];
     boDeleted:Boolean;
     boSelected:Boolean;
     dModDate:TDateTime;
     btCount:Byte;
     boHero:Boolean;
     btNo:array[0..5] of byte;
  end;

  pTUserItem=^TUserItem;
  TUserItem=record                         //=24
    MakeIndex       :Integer;              //+4
    wIndex          :Word;                 //+2
    Dura            :word;                 //+2
    DuraMax         :Word;                 //+2
    btValue         :Array[0..MAXBTVALUE] of byte; //+14
  end;

  pTUserShopItem=^TUserShopItem;
  TUserShopItem=record
    Item :Integer;
    nPic :Integer;
    boCls:Boolean;
  end;

  TUserWineItem=record
    MakeIndex:Integer;
    idx:Byte;
  end;
  
 pTUserWineItem=^TUserWineItem;

  pTNewUserItem=^TNewUserItem;
  TNewUserItem=record                         //=24
    MakeIndex       :Integer;              //+4
    wIndex          :Word;                 //+2
    Dura            :word;                 //+2
    DuraMax         :Word;                 //+2
    sMapName        :String[MAXBTVALUE]; //+14
  end;

  THumanUseItems=array[0..MAXUSEITEMS] of TUserItem;
  THumItems=array[0..MAXUSEITEMS] of TUserItem;
  pTHumItems=^THumItems;
  pTBagItems=^TBagItems;
  TBagItems=array[0..MAXBAGITEM-1] of  TUserItem;
  pTStorageItems=^TStorageItems;
  TStorageItems=array[0..MAXSTORAGEITEMS] of TUserItem;


  pTUserMagic=^TUserMagic;
  TUserMagic=record
    MagicInfo:pTMagic;
    wMagIdx:word;
    btLevel:byte;
    btKey:byte;
    nTranPoint:integer;
  end;

  TSaveUserMagic=record
    wMagIdx:word;
    btLevel:byte;
    btKey:byte;
    nTranPoint:integer;
  end;
  pTSaveUserMagic=^TSaveUserMagic;


  pTHumMagic=^THumMagic;
  THumMagic=Array[0..HOWMANYMAGICS-1] of TSaveUserMagic;

  pTHumMagicInfo=^THumMagicInfo;
  THumMagicInfo=TUserMagic;

  TStatusTime=array [0..MAX_STATUS_ATTRIBUTE - 1] of Word;

  TQuestUnit=array[0..12] of Byte;

  TQuestFlag=array[0..99] of Byte;

  //TQuestNew=array[0..99] of Byte;

  pTHumData=^THumData;
  THumData = packed record       //3164
    sChrName        :String[ActorNameLen];   //152
    sCurMap         :String[CurMapNameLen];     //167
    wCurX           :Word;                   //184
    wCurY           :Word;                   //186
    btDir           :Byte;                   //188
    btHair          :Byte;                   //189
    btSex           :Byte;                   //190
    btJob           :Byte;                   //191
    nGold           :Integer;                //192

//    Abil            :TAbility;               //196
    Abil            :TOAbility;
    wStatusTimeArr  :TStatusTime;
    sHomeMap        :String[HomMapNameLen];
    wHomeX          :Word;
    wHomeY          :Word;

    sDieMap         :String[HomMapNameLen];
    wDieX           :Word;
    wDieY           :Word;

    sDearName       :String[ActorNameLen];       //夫妻名称
    sMasterName     :String[ActorNameLen];       //师徒名称
    boMaster        :Boolean;                    //是否为师父
    sHeroName       :String[ActorNameLen];    //英雄名称
    boHero          :Boolean;                 //是否为英雄
    btCreditPoint   :integer;                  //声望点数
    btReLevel       :Byte;                 //转生等级
    sStoragePwd     :String[7];

    nMentExp        :LongWord;                  //双倍经验
    nMentExpTime    :LongWord;               //双倍经验时间

    BonusAbil       :TNakedAbility;
    nBonusPoint     :Integer;

    nGameGold       :Integer;
    nGamePoint      :Integer;
    nGameDiamond    :Integer;     //金刚石
    nGameGird       :Integer;     //灵符
    nPayMentPoint   :Integer;       //充值点数
    nPKPoint        :Integer;
    nKillMonCount   :Integer;            //杀怪次数   \
    btMasterCount   :Integer;

    btAllowGroup    :Byte;
    btF9            :Byte;
    btAttatckMode   :Byte;           //攻击模式 374
    btIncHealth     :Byte;
    btIncSpell      :Byte;
    btIncHealing    :Byte;
    btFightZoneDieCount:Byte;
    //btEE            :Byte;
    //btEF            :Byte;
    sAccount        :String[AccountNameLen];
    boLockLogon     :Boolean;

    wContribution   :Word;
    nHungerStatus   :Integer;
    boAllowGuildReCall:Boolean;
    wGroupRcallTime :Word;
    dBodyLuck       :TDateTime;
    boAllowGroupReCall:Boolean;
    boChangeName    :Boolean;
    nIconIdx        :Array[0..4] of Word;
    nDiploidRate    :Byte;                //爆击机率
    nGloryPoint     :Word;
    HeroName1       :String[ActorNameLen];
    HeroLevel1      :Word;
    HeroJob1        :Byte;
    HeroGender1     :Byte;
    HeroName2       :String[ActorNameLen];
    HeroLevel2      :Word;
    HeroJob2        :Byte;
    HeroGender2     :Byte;
    HeroClass       :Boolean;

    //Reserved        :Array[0..339] of Byte;
    Magic1          :THumMagic;//SIZE 160 技能列表2
    dwWineValue     :LongWord;//酒量值
    dwAlcoho        :LongWord;//饮酒量

    dwMedicineValue :Word;//当前药力值
    dwMedicineLevel :Word;//药力等级

    dwSKILL84Level  :Word;//酒气护体等级
    dwSKILL84Exp    :LongWord;//酒气护体经验

    boISONMAKEWINE  :Byte;//是否在酿哪种酒 0没有1普通2药酒
    dtGetGuildFountain:TDateTime; //领取行会泉水时间
    dtMakeWineTime  :TDateTime;//开始酿酒的时间
    WineItem        :TUserItem;//酿造的酒

    dtAlcohoTime:TDateTime;//饮普通酒时间
    dtMedicineAlcohoTime:TDateTime;//饮药酒时间

    bLiquorProgress:Byte;//酒量提升进度值
    dtGetCastleFountain:TDateTime; //领沙城泉水时间
 //   skill83Level:Byte; //先天元力等级
    CallCloneTick:LongWord; //分身的时间
    dwOpenShieldTick:LongWord;//护体神盾
    
    Reserved        :Array[0..83] of Byte;

    QuestFlag       :TQuestFlag;
    Reserved2       :Array[0..25] of Byte;
    //QuestOpen       :TQuestUnit;
    //QuestUnit       :TQuestUnit;

    HumItems        :THumItems;
    BagItems        :TBagItems;
    Magic           :THumMagic;
    StorageItems    :TStorageItems;
  end;

  TClientGetHero=packed record
    HeroName1       :String[ActorNameLen];
    HeroLevel1      :Word;
    HeroJob1        :Byte;
    HeroGender1     :Byte;
    HeroName2       :String[ActorNameLen];
    HeroLevel2      :Word;
    HeroJob2        :Byte;
    HeroGender2     :Byte;
  end;

  THumDataInfo= packed record
    Header:THumRecordHeader;
    Data:THumData;
  end;

{  pTQuickID=^TQuickID;
  TQuickID=record
    nSelectID:integer;
    sAccount:String[16];
    nIndex:integer;
    sChrName:String[20];
  end; }

  pTGlobaSessionInfo=^TGlobaSessionInfo;
  TGlobaSessionInfo=record
     sAccount:String[10];
     sUserName:String[14];
     nSessionID:integer;
     boLoadRcd:Boolean;
     boStartPlay:Boolean;
     sIPaddr:String[15];
     n24:integer;
     dwAddTick:DWord;
     dAddDate:TDateTime;
     boLoadHeroRcd:Boolean;
  end;

  TCheckCode = packed record
     dwThread0:DWord;
     sThread0:String;
  end;

  {TAccountDBRecord = record
     Header:TRecordHeader;
     nErrorCount:integer;
     dwActionTick:DWord;
     UserEntry:TUserEntry;
     UserEntryAdd:TUserEntryAdd;
  end; }
  TAccountDBRecord = packed record
     Header:TIDRecordHeader;
     UserEntry:TUserEntry;
     UserEntryAdd:TUserEntryAdd;
     nErrorCount:INteger;
     dwActionTick:LongWord;
     sMemo:String[38];
  end;


  pTConnInfo=^TConnInfo;
  TConnInfo=record

  end;

  pTQueryChr=^TQueryChr;
  TQueryChr=packed record
    btClass:Byte;
    btHair:Byte;
    btGender:Byte;
    btLevel:Byte;
    sName:String[19];
  end;

Const
  //Damian
  RUNGATECODE = $AA55AA55;

  GM_OPEN             = 1;
  GM_CLOSE            = 2;
  GM_CHECKSERVER      = 3;// Send check signal to Server
  GM_CHECKCLIENT      = 4;// Send check signal to Client
  GM_DATA             = 5;
  GM_SERVERUSERINDEX  = 6;
  GM_RECEIVE_OK       = 7;
  GM_CHECKCONNECT     = 15;
  GM_TEST             = 20;

  {RUNGATECODE = 1;

  GM_CHECKCLIENT = 7001;
  GM_DATA        = 7002;
  GM_OPEN        = 7003;
  GM_CLOSE       = 7004;
  GM_CHECKSERVER = 7005;
  GM_SERVERUSERINDEX = 7006;
  GM_RECEIVE_OK  = 7007;
  GM_TEST        = 7008;}

type
  pTMsgHeader=^TMsgHeader;
  TMsgHeader = record
    dwCode:DWord;
    nSocket:integer;
    wGSocketIdx:word;
    wIdent:word;
    wUserListIndex:word;
    nLength:integer;
  end;

//M2Server

Const

  GROUPMAX        = 11;

  CM_42HIT        = 42;

  CM_PASSWORD     = 2001;
  CM_CHGPASSWORD  = 2002;
  CM_SETPASSWORD  = 2004;


  CM_HORSERUN     = 3035;     //------------未知消息码
  CM_CRSHIT       = 3036;     //------------未知消息码
  CM_3037         = 3037;
  CM_TWINHIT      = 3038;
  CM_QUERYUSERSET = 3040;

  CM_LONGSWORD1   = 3050;
  CM_LONGSWORD2   = 3051;
  CM_LONGFIRESWORD= 3052;

  //Damian
  SM_PLAYDICE    = 8001;
  SM_PASSWORDSTATUS = 8002;
  SM_NEEDPASSWORD = 8003; 
  SM_GETREGINFO = 8004;

  DATA_BUFSIZE        = 1024;

//  RUNGATEMAX          = 8;

  //MAX_STATUS_ATTRIBUTE = 13;
  MAXMAGIC             = 54;

  PN_GETRGB            = 'GetRGB';
  PN_GAMEDATALOG       = 'GameDataLog';
  PN_SENDBROADCASTMSG  = 'SendBroadcastMsg';

  sSTRING_GOLDNAME     = '金币';
  MAXLEVEL             = 65535;
  SLAVEMAXLEVEL        = 50;

  LOG_GAMEGOLD         = 28;
  LOG_GAMEPOINT        = 29;
  LOG_SHOPBUY          = 30;
  LOG_LEVELITEM        = 31;
  LOG_SELLOFFITEM      = 32;
  LOG_SELLOFFITEMBUY   = 33;
  LOG_SELFSHOPITEM     = 34;
  LOG_OPENBOXITEM      = 35;
  LOG_BUTCHITEM        = 36;

  //RC_ANIMAL            = 50;
  //RC_PEACENPC          = 15;
  //RC_MONSTER           = 80;
  //RC_PLAYOBJECT        = 1;
  //RC_NPC               = 10;
  //RC_GUARD             = 12;
  //RC_ARCHERGUARD       = 52;

  RC_PLAYOBJECT  = 0;
  RC_GUARD       = 11;
  RC_PEACENPC    = 15;
  RC_ANIMAL      = 50;
  RC_EXERCISE    = 55; //练功师
  RC_PLAYCLONE   = 60; //人型怪物
  RC_MONSTER     = 80;
  RC_NPC         = 10;
  RC_ARCHERGUARD = 112;
  RC_135         = 135; //魔王岭弓箭手
  RC_136         = 136; //魔王岭弓箭手
  RC_153         = 153; //任务怪物


  RM_TURN              = 10001;
  RM_WALK              = 10002;
  RM_HORSERUN          = 50003;
  RM_RUN               = 10003;
  RM_HIT               = 10004;
  RM_BIGHIT            = 10006;
  RM_HEAVYHIT          = 10007;
  RM_SPELL             = 10008;
  RM_SPELL2            = 10009;
  RM_MOVEFAIL          = 10010;
  RM_LONGHIT           = 10011;
  RM_WIDEHIT           = 10012;
  RM_FIREHIT           = 10014;
  RM_CRSHIT            = 10015;
  RM_DEATH             = 10021;
  RM_SKELETON          = 10024;

  RM_SPELL3            = 10030;
  //RM_SPELL4            = 10031;

  RM_LOGON             = 10050;
  RM_ABILITY           = 10051;
  RM_HEALTHSPELLCHANGED= 10052;
  RM_DAYCHANGING       = 10053;
//  RM_HEROSUBABILITY    = 10054;

  RM_10054             = 10054;
  RM_10055             = 10055;
  RM_10056             = 10056;
  RM_10057             = 10057;
  RM_SHOWEFFECT        = 10058; //例烟花效果代码

  RM_10101             = 10101;
  RM_WEIGHTCHANGED     = 10115;
  RM_FEATURECHANGED    = 10116;
  RM_BUTCH             = 10119;
  RM_MAGICFIRE         = 10120;
  RM_MAGICFIREFAIL     = 10121;
  RM_SENDMYMAGIC       = 10122;

  RM_MAGIC_LVEXP       = 10123;
  RM_DURACHANGE        = 10125;
  RM_BAG_DURACHANGE2    = 10126;
  RM_MERCHANTDLGCLOSE  = 10127;
  RM_SENDGOODSLIST     = 10128;
  RM_SENDUSERSELL      = 10129;
  RM_SENDBUYPRICE      = 10130;
  RM_USERSELLITEM_OK   = 10131;
  RM_USERSELLITEM_FAIL = 10132;
  RM_BUYITEM_SUCCESS   = 10133;
  RM_BUYITEM_FAIL      = 10134;
  RM_SENDDETAILGOODSLIST=10135;
  RM_GOLDCHANGED       = 10136;
  RM_CHANGELIGHT       = 10137;
  RM_LAMPCHANGEDURA    = 10138;
  RM_CHARSTATUSCHANGED = 10139;
  RM_GROUPCANCEL       = 10140;
  RM_SENDUSERREPAIR    = 10141;

  RM_SENDUSERSREPAIR   = 50142;
  RM_SENDREPAIRCOST    = 10142;
  RM_USERREPAIRITEM_OK = 10143;
  RM_USERREPAIRITEM_FAIL=10144;
  RM_USERSTORAGEITEM   = 10146;
  RM_USERGETBACKITEM   = 10147;
  RM_SENDDELITEMLIST   = 10148;
  RM_USERMAKEDRUGITEMLIST=10149;
  RM_MAKEDRUG_SUCCESS  = 10150;
  RM_MAKEDRUG_FAIL     = 10151;
  RM_ALIVE             = 10153;
  RM_PLAYDRINK         = 10154;

  RM_10155             = 10155;
  RM_DIGUP             = 10200;
  RM_DIGDOWN           = 10201;
  RM_FLYAXE            = 10202;
  RM_LIGHTING          = 10204;
  RM_10205             = 10205;

  RM_CHANGEGUILDNAME   = 10301;
  RM_SUBABILITY        = 10302;
  RM_BUILDGUILD_OK     = 10303;
  RM_BUILDGUILD_FAIL   = 10304;
  RM_DONATE_OK         = 10305;
  RM_DONATE_FAIL       = 10306;

  RM_MENU_OK           = 10309;

  RM_RECONNECTION      = 10332;
  RM_HIDEEVENT         = 10333;
  RM_SHOWEVENT         = 10334;

  RM_10401             = 10401;
  RM_OPENHEALTH        = 10410;
  RM_CLOSEHEALTH       = 10411;
  RM_BREAKWEAPON       = 10413;
  RM_10414             = 10414;
  RM_CHANGEFACE        = 10415;
  RM_PASSWORD          = 10416;

  RM_PLAYDICE          = 10500;

  RM_HEROLOGIN         = 10501; //英雄登录
  RM_HEROCOLOR         = 10502; //英雄名称颜色
  RM_HEROLOGINEX       = 10503; //返回英雄背包物品
  RM_HEROLOGINHALO     = 10504; //返回英雄背包物品

  RM_CLOSEHERO         = 10505;
  RM_CLOSEHEROHALO     = 10506;
  //RM_SENDUSEITEMS      = 10504; //
  RM_DANDERCHANG       = 10507;
  RM_SELFSHOPLIST      = 10508;
//  RM_GLORYCHANGED      = 10509;


  RM_HEAR              = 11001;
  RM_WHISPER           = 11002;
  RM_CRY               = 11003;
  RM_SYSMESSAGE        = 11004;
  RM_GROUPMESSAGE      = 11005;
  RM_SYSMESSAGE2       = 11006;
  RM_GUILDMESSAGE      = 11007;
  RM_SYSMESSAGE3       = 11008;
  RM_MERCHANTSAY       = 11009;


  RM_ZEN_BEE           = 8020;
  RM_DELAYMAGIC        = 8021;
  RM_STRUCK            = 8018;
  RM_MAGSTRUCK_MINE    = 8030;
  RM_MAGHEALING        = 8034;

  RM_POISON            = 8037;
  
  RM_DOOPENHEALTH      = 8040;
  RM_SPACEMOVE_FIRE2   = 8042;
  RM_DELAYPUSHED       = 8043;
  RM_MAGSTRUCK         = 8044;
  RM_TRANSPARENT       = 8045;

  RM_DOOROPEN          = 8046;
  RM_DOORCLOSE         = 8047;
  RM_DISAPPEAR         = 8061;
  RM_SPACEMOVE_FIRE    = 8062;
  RM_SENDUSEITEMS      = 8074;
  RM_WINEXP            = 8075;
  RM_ADJUST_BONUS      = 8078;
  RM_ITEMSHOW          = 8082;
  RM_GAMEGOLDCHANGED   = 8084;
  RM_ITEMHIDE          = 8085;
  RM_LEVELUP           = 8086;

  RM_CHANGENAMECOLOR   = 8090;
  RM_PUSH              = 8092;

  RM_CLEAROBJECTS      = 8097;
  RM_CHANGEMAP         = 8098;
  RM_SPACEMOVE_SHOW2   = 8099;
  RM_SPACEMOVE_SHOW    = 8100;
  RM_USERNAME          = 8101;
  RM_MYSTATUS          = 8102;
  RM_STRUCK_MAG        = 8103;
  RM_RUSH              = 8104;
  RM_RUSHKUNG          = 8105;
  RM_PASSWORDSTATUS    = 8106;
  RM_POWERHIT          = 8107;

  RM_41                = 9041;
  RM_TWINHIT           = 9042;
  RM_43                = 9043;
  RM_LONGSWORD1        = 9044;
  RM_LONGSWORD2        = 9045;
  RM_FIREHIT2          = 9049;
  RM_LONGFIRESWORD     = 9050;

  RM_ISSHOP            = 9046;
//  RM_OFFLINE           = 9047;
  RM_HEROCHANGEGLORY   = 9048;
  RM_SKILL_82          = 9051;
  RM_WineValue         = 9052;//酒量变更消息
  RM_MedicineValue     = 9053; //药力变更消息
  RM_SKILL84Exp        = 9054;//酒气护体变更消息
  RM_bLiquorProgress   = 9055; //酒量提升进度消息
  RM_DRINK             = 9056; //喝酒动画消息
  RM_DRUNK             = 9057;//喝醉酒动画消息
  RM_ADDLiquor         = 9058;//酒量提升动画消息
  RM_SKILL83Value      = 9059;//先天元力变更消息

  RM_SKILL53           = 9060; //噬血术吸血动画消息
  //  RM_SHIELDEFFECT      = 9048;
//  RM_CHANGEDRAGON      = 9048;

  //RM_SHOPLIST          = 9044;
  //RM_SHOPTOP           = 9047;
  //RM_SHOPERROR         = 9048;
  //RM_DECODEEDIT        = 9044;



  OS_EVENTOBJECT       = 1;
  OS_MOVINGOBJECT      = 2;
  OS_ITEMOBJECT        = 3;
  OS_GATEOBJECT        = 4;
  OS_MAPEVENT          = 5;
  OS_DOOR              = 6;
  OS_ROON              = 7;
  OS_DROPITEM          = 11;
  OS_PICKUPITEM        = 12;
  OS_HEAVYHIT          = 13;
  OS_WALK              = 14;
  OS_RUN               = 15;
  OS_HORSERUN          = 16;


  //技能编号（正确）
  SKILL_FIREBALL       = 1;
  SKILL_HEALLING       = 2;
  SKILL_ONESWORD       = 3;
  SKILL_ILKWANG        = 4;
  SKILL_FIREBALL2      = 5;
  SKILL_AMYOUNSUL      = 6;
  SKILL_YEDO           = 7;
  SKILL_FIREWIND       = 8;
  SKILL_FIRE           = 9;
  SKILL_SHOOTLIGHTEN   = 10;
  SKILL_LIGHTENING     = 11;
  SKILL_ERGUM          = 12;
  SKILL_FIRECHARM      = 13;
  SKILL_HANGMAJINBUB   = 14;
  SKILL_DEJIWONHO      = 15;
  SKILL_HOLYSHIELD     = 16;
  SKILL_SKELLETON      = 17;
  SKILL_CLOAK          = 18;
  SKILL_BIGCLOAK       = 19;
  SKILL_TAMMING        = 20;
  SKILL_SPACEMOVE      = 21;
  SKILL_EARTHFIRE      = 22;
  SKILL_FIREBOOM       = 23;
  SKILL_LIGHTFLOWER    = 24;
  SKILL_BANWOL         = 25;
  SKILL_FIRESWORD      = 26;
  SKILL_MOOTEBO        = 27;
  SKILL_SHOWHP         = 28;
  SKILL_BIGHEALLING    = 29;
  SKILL_SINSU          = 30;
  SKILL_SHIELD         = 31;
  SKILL_KILLUNDEAD     = 32;
  SKILL_SNOWWIND       = 33;
  SKILL_UNAMYOUNSUL    = 34; //Purification
  SKILL_WINDTEBO       = 35;
  SKILL_MABE           = 36;
  SKILL_GROUPLIGHTENING= 37;
  SKILL_GROUPAMYOUNSUL = 38;
  SKILL_GROUPDEDING    = 39;
  SKILL_CROSSMOON      = 40{SKILL_CROSSMOON}; //CHM
  SKILL_ANGEL          = 41;
  SKILL_TWINBLADE      = 42;
  SKILL_43             = 43;
  SKILL_44             = 44; //FrostCrunch
  SKILL_45             = 45; //FlameDisruptor
  SKILL_46             = 46; //Mirroring
  SKILL_47             = 47;
  SKILL_ENERGYREPULSOR = 48;
  SKILL_49             = 49;
  SKILL_UENHANCER      = 50;
  SKILL_51             = 51;
  SKILL_52             = 52;
  SKILL_53             = 53;
  SKILL_54             = 54;
  SKILL_55             = 55;
  SKILL_REDBANWOL      = 56;
  SKILL_57             = 57;//四级魔法盾
  SKILL_58             = 58;
  SKILL_59             = 59;
  SKILL_60             = 60; //破魂斩
  SKILL_61             = 61;  //劈星斩
  SKILL_62             = 62;  //雷霆一击
  SKILL_63             = 63;  //噬魂沼泽
  SKILL_64             = 64;  //末日审判
  SKILL_65             = 65;  //火龙气焰
  SKILL_71             = 71;//擒龙手
  SKILL_72             = 72;  //召唤月灵
  SKILL_73             = 73;  //逐日剑法
  SKILL_74             = 74;  //流星火雨
  SKILL_75             = 75;
  SKILL_80             = 80; //道力盾
  SKILL_81             = 81; //四级道力盾
  SKILL_82             = 82; //乾坤大挪移
  SKILL_83             = 83; //先天元力
  SKILL_84             = 84; //酒气护体
  SKILL_100            = 100; //月灵攻击
  SKILL_101            = 101; //月灵重击


  //夜猫仔新增魔法技能
//  SKILL_200            = 200;


  LA_UNDEAD            = 1;

  sENCYPTSCRIPTFLAG    = 'JSENCYPTSCRIPTFLAG';
  sENCRYPTSCRIPTDEMO   = 'JSENCRYPTSCRIPTDEMO';
  sSCRIPTOFPLUG        = 'JSPLUGOFSCRIPT';
  sSTATUS_FAIL     = '+FAIL/';
  sSTATUS_GOOD     = '+GOOD/';

type
  PTMapItem=^TMapItem;
  TMapItem=record
    Name            :String[40];
    Looks           :word;
    AniCount        :byte;
    Reserved        :integer;
    Count           :integer;
    DropBaseObject  :TObject;
    OfBaseObject    :TObject;
    dwCanPickUpTick :Dword;
    UserItem        :TUserItem;
  end;

  pTDoorStatus=^TDoorStatus;
  TDoorStatus=record
    bo01:boolean;
    n04:integer;
    boOpened:Boolean;
    dwOpenTick:dword;
    nRefCount:integer;
  end;

  pTDoorInfo=^TDoorInfo;
  TDoorInfo=record
    nX,nY:Integer;
    Status:pTDoorStatus;
    n08:integer;
  end;

  pTMapFlag=^TMapFlag;
  TMapFlag=record
     boSAFE:Boolean;
     nNEEDSETONFlag:integer;
     nNeedONOFF:integer;
     sMusic:String;
     boDarkness:boolean;
     boDayLight:boolean;
     boFightZone:boolean;
     boFight3Zone:boolean;
     boFight2Zone:Boolean;
     boQUIZ:boolean;
     boNORECONNECT:boolean;
     boNOTALLOWUSEMAGIC:Boolean;
     boNOTALLOWUSEITEMS:Boolean;
     NotMagicList:TStringList;
     NotEatItems:TStringList;
     sNoReConnectMap:string;
     boMUSIC:boolean;
     boEXPRATE:boolean;
     nEXPRATE:integer;
     boPKWINLEVEL:boolean;
     nPKWINLEVEL:integer;
     boPKWINEXP:boolean;
     nPKWINEXP:integer;
     boPKLOSTLEVEL:boolean;
     nPKLOSTLEVEL:integer;
     boPKLOSTEXP:boolean;
     nPKLOSTEXP:integer;
     boDECHP:boolean;
     nDECHPPOINT:integer;
     nDECHPTIME:integer;
     boINCHP:boolean;
     nINCHPPOINT:integer;
     nINCHPTIME:integer;
     boDECGAMEGOLD:boolean;
     nDECGAMEGOLD:integer;
     nDECGAMEGOLDTIME:integer;
     boDECGAMEPOINT:boolean;
     nDECGAMEPOINT:integer;
     nDECGAMEPOINTTIME:integer;
     boINCGAMEGOLD:boolean;
     nINCGAMEGOLD:integer;
     nINCGAMEGOLDTIME:integer;
     boINCGAMEPOINT:boolean;
     nINCGAMEPOINT:integer;
     nINCGAMEPOINTTIME:integer;
     boRUNHUMAN:boolean;
     boRUNMON:boolean;
     boNEEDHOLE:boolean;
     boNORECALL:boolean;
     boNOGUILDRECALL:boolean;
     boNODEARRECALL:boolean;
     boNOMASTERRECALL:boolean;
     boNORANDOMMOVE:boolean;
     boNODRUG:boolean;
     boMINE:boolean;
     boMINE2:boolean;
     boNOPOSITIONMOVE:boolean;
     boNODROPITEM:boolean;
     boNOTHROWITEM:boolean;
     boNOHORSE:Boolean;
     boNOCHAT:Boolean;
     boSHOP:Boolean;
     boMission:Boolean;
     boNight:Boolean;
     boNOCALLHERO:Boolean;  //注意手动清空
     boMapEvent:Boolean;
     boNoManNoMon:Boolean;
     NOHEROPROTECT:Boolean;//禁止英雄守护
     sKillMon:string;
     nTHUNDER: Integer;
     nLAVA: Integer;
     boFIGHT4:Boolean;//挑战地图
  end;

  TSuitItems=record
    {nHP,nMP,nExp,nDC,nDC2,nDCExp:Word;
    nMC,nMC2,nMCExp,nSC,nSC2,nSCExp:Word;
    nAC,nAC2,nACExp,nMAC,nMAC2,nMACExp:Word;
    nHitPoint,nSpeedPoint,nAntiMagic:Word;
    nHealthRecover,nSpellRecover,nAntiPoison,nPoisonRecover:Word;}
    nCount:Word;
    sHint:String[20];
    sItems:array[0..13] of String[14];
    nPoint:array[0..29] of Word;
  end;
  pTSuitItems=^TSuitItems;

  TRuleItems=record
    sItemName:String[14];
    nRule:array[0..17] of Boolean;
  end;
  pTRuleItems=^TRuleItems;

  TAddAbility=record //Damian
     wHP,wMP:Word;
     wHitPoint,wSpeedPoint:Word;
     wAC,wMAC,wDC,wMC,wSC:DWord;
     wAntiPoison,wPoisonRecover,
     wHealthRecover,wSpellRecover:Word;
     wAntiMagic:Word;
     btLuck,btUnLuck:Byte;
     btWeaponStrong:BYTE;
     nHitSpeed:Word;
     btUndead:Byte;

     Weight,WearWeight,HandWeight:Word;
  end;

  pTMapEvent=^TMapEvent;
  TMapEvent=record
    nFlag         :Integer;
    btValue       :Byte;
    btEventObject :Byte;
    sItemName     :String;
    boGroup       :Boolean;
    nRate         :Integer;
    boEvent       :Boolean;
    sEvent        :String;
  end;


  TMsgColor=(c_Red,c_Green,c_Blue,c_White);
  TMsgType=(t_System,t_Notice,t_Hint,t_Say,t_Castle,t_Cust,t_GM,t_Mon,t_Cudt);

  pTProcessMessage=^TProcessMessage;
  TProcessMessage=record
     wIdent:word;
     wParam:word;
     nParam1:integer;
     nParam2:integer;
     nParam3:integer;
     dwDeliveryTime:dword;
     BaseObject:TObject;
     boLateDelivery:Boolean;
     sMsg:String;

  end;

  pTSessInfo=^TSessInfo;
  TSessInfo=record
     nSessionID       :Integer;
     sAccount         :String[10];
     sIPaddr          :String;
     nPayMent         :integer;
     nPayMode         :integer;
     nSessionStatus   :integer;
     dwStartTick      :dword;
     dwActiveTick     :dword;
     nRefCount        :integer;
     nSocket          :integer;
     nGateIdx         :integer;
     nGSocketIdx      :integer;
     dwNewUserTick    :dword;
     nSoftVersionDate :integer;
  end;

  TScriptQuestInfo=record
     wFlag:word;
     btValue:byte;
     nRandRage:integer;
  end;
  TQuestInfo=array of TScriptQuestInfo;

  pTScript=^TScript;
  TScript=record
     boQuest:boolean;
     QuestInfo:TQuestInfo;
     RecordList:TList;
     nQuest:Integer;
  end;

  pTGameCmd=^TGameCmd;
  TGameCmd=record
     sCmd           :String;
     nPerMissionMin :integer;
     nPerMissionMax :integer;
  end;



  pTCorpsRcdInfo=^TCorpsRcdInfo;
  TCorpsRcdInfo=record
    sAccount:String[10];
    sCharName:String[14];
    sReserve:String[14];
    nCode:Byte;
    PlayObject:TObject;
  end;

  TSendCorpsRcdInfo=record
    sAccount:String[10];
    sCharName:String[14];
    sReserve:String[14];
    nCode:Byte;
  end;

  pTLoadDBInfo=^TLoadDBInfo;
  TLoadDBInfo=record
    nGateIdx:integer;
    nSocket:integer;
    sAccount:String[10];
    sCharName:String[14];
    nSessionID:integer;
    sIPaddr:String[15];
    nSoftVersionDate:integer;
    nPayMent:integer;
    nPayMode:integer;
    nGSocketIdx:integer;
    dwNewUserTick:dword;
    PlayObject:TObject;
    nReLoadCount:Integer;
    boLoadHero:Boolean;
    boNewHero:Boolean;
    nHeroJob:Byte;
    nHeroMan:Byte;
    sMasterName:String[ActorNameLen];
  end;

  pTGoldChangeInfo=^TGoldChangeInfo;
  TGoldChangeInfo=record
     sGameMasterName:string;
     sGetGoldUser:String;
     nGold:integer;
  end;

  pTSaveRcd=^TSaveRcd;
  TSaveRcd=record
    sAccount:String[16];
    sChrName:String[20];
    nSessionID:integer;
    PlayObject:TObject;
    HumanRcd:THumDataInfo;
    nReTryCount:integer;
  end;

  TBoxsSet=record
    boNext:Boolean;
    nGold:Integer;
    nGameGold:Integer;
    nAddGold:Integer;
    nAddGameGold:Integer;
    nEndGold:Integer;
    nEndGameGold:Integer;
    nCount:Byte;
    nNowGold:Integer;
    nNowGameGold:Integer;
    nNowCount:Byte;
  end;

  TBosxList=record
    BoxsSet:TBoxsSet;
    ShowItem:TStringList;
    NoItem:TStringList;
    EnItem:TStringList;
    EndNoItem:TStringList;
  end;
  pTBoxList=^TBosxList;

  pTMonGenInfo=^TMonGenInfo;
  TMonGenInfo=packed record
     sMapName:String;
     nX,nY:Integer;
     sMonName:String;
     nRange:Integer;
     nCount:Integer;
     dwZenTime:dword;
     nMissionGenRate:integer;
     CertList:TList;
     Envir:TObject;
     nRace:integer;
     dwStartTick:LongWord;
     nIconIdx:Array[0..4] of Word;
     nColor:Byte;
     boNoManNoMon:Boolean;
//     boMonGhost:Boolean;
//     dwNoHumTime:LongWord;
//     boNoManNoMon:Boolean;
  end;

  pTMonInfo=^TMonInfo;
  TMonInfo=record
    ItemList:TList;
    sName:String;
    btRace:Byte;
    btRaceImg:byte;
    wAppr:word;
    wLevel:word;
    btLifeAttrib:byte;
    wCoolEye:word;
    dwExp:dword;
    wHP,wMP:word;
    wAC,wMAC,wDC,wMaxDC,wMC,wSC:Word;
    wSpeed,wHitPoint,wWalkSpeed,wWalkStep,wWalkWait,wAttackSpeed:Word;
    wAntiPush:Word;
    boAggro,boTame:Boolean;
  end;

  pTMonItem=^TMonItem;
  TMonItem=record
    MaxPoint:integer;
    SelPoint:integer;
    ItemName:String[14];
    Count:integer;
  end;

  pTUnbindInfo=^TUnbindInfo;
  TUnbindInfo=record
    nUnbindCode  :Integer;
    sItemName    :String[14];
  end;

  TSlaveInfo=record
    sSlaveName:String;
    btSlaveLevel:byte;
    dwRoyaltySec:dword;
    nKillCount:integer;
    btSlaveExpLevel:byte;
    nHP,nMP:integer;
  end;
  pTSlaveInfo=^TSlaveInfo;

  pTSwitchDataInfo=^TSwitchDataInfo;
  TSwitchDataInfo=record
     sMap:String;
     wX,wY:word;
     Abil:TAbility;
     sChrName:String;
     nCode:integer;
     boC70:boolean;
     boBanShout:boolean;
     boHearWhisper:boolean;
     boBanGuildChat:boolean;
     boAdminMode:boolean;
     boObMode:boolean;
     BlockWhisperArr:array of string;
     SlaveArr:array of TSlaveInfo;
     StatusValue:Array [0..5] of word;
     StatusTimeOut:array [0..5] of LongWord;
  end;

  TIPaddr=record
    sIpaddr:String;
    dIPaddr:String;
  end;

  pTGateInfo=^TGateInfo;
  TGateInfo=record
    boUsed:Boolean;
    Socket:TCustomWinSocket;
    sAddr :String;
    nPort :integer;
    n520  :integer;
    UserList :TList;
    nUserCount :Integer;
    Buffer:Pchar;
    nBuffLen:integer;
    BufferList:TList;
    boSendKeepAlive:Boolean;
    nSendChecked:integer;
    nSendBlockCount:integer;
    dwStartTime:dword;
    nSendMsgCount:integer;
    nSendRemainCount:integer;
    dwSendTick:Dword;
    nSendMsgBytes:integer;
    nSendBytesCount:integer;
    nSendedMsgCount:integer;
    nSendCount:integer;
    dwSendCheckTick:dword;
  end;

  pTGateUserInfo=^TGateUserInfo;
  TGateUserInfo=record
     PlayObject:TObject;
     nSessionID:integer;
     sAccount:String[10];
     nGSocketIdx:integer;
     sIPaddr:string[15];
     boCertification:boolean;
     sCharName:String[20];
     nClientVersion:integer;
     SessInfo:pTSessInfo;
     nSocket:integer;
     FrontEngine:TObject;
     UserEngine:TObject;
     dwNewUserTick:Dword;
  end;

  TClassProc=procedure(Sender:TObject);


  TCheckVersion=class

  end;

  TGameDataLog=function (p:Pchar;len:integer):Boolean;
  TMainMessageProc=procedure (Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TFindProcTableProc=function (ProcName:PChar;nNameLen:Integer):Pointer;stdcall;
  TSetProcTableProc=function(ProcAddr:Pointer;ProcName:PChar;nNameLen:Integer):Boolean;stdcall;
  TFindObj=function(ObjName:PChar;nNameLen:Integer):TObject;stdcall;
  TPlugInit=function (hnd:THandle;p:TMainMessageProc;p2:TFindProcTableProc;p3:TSetProcTableProc;p4:TFindOBj):Pchar;
  TDeCryptString=Procedure (src:Pointer;dest:pointer;srcLen:integer;var destLen:Integer);
  TMsgProc=procedure (Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TFindProc=function(sProcName:Pchar;len:Integer):Pointer;
  TSetProc=function (ProcAddr:Pointer;ProcName:PChar;len:integer):Boolean;




  TSpitMap=array [0..7] of array[0..4,0..4] of integer;

  TLevelNeedExp=Array[1..500] of dword;
  TSkill83Exp=array[0..3] of DWORD;

  TClientConf=record
     boClientCanSet    :boolean;
     boRunHuman        :boolean;
     boRunMon          :boolean;
     boRunNpc          :boolean;
     boWarRunAll       :boolean;
     btDieColor        :byte;
     wSpellTime        :word;
     wHitIime          :word;
     wItemFlashTime    :word;
     btItemSpeed       :byte;
     boCanStartRun     :boolean;
     boParalyCanRun    :boolean;
     boParalyCanWalk   :boolean;
     boParalyCanHit    :boolean;
     boParalyCanSpell  :boolean;
     boShowRedHPLable  :boolean;
     boShowHPNumber    :boolean;
     boShowJobLevel    :boolean;
     boDuraAlert       :boolean;
     boMagicLock       :boolean;
     boAutoPuckUpItem  :boolean;
  end;

  TRecallMigic=record
    nHumLevel:integer;
    sMonName:String;
    nCount:integer;
    nLevel:integer;
  end;

  pTM2Config=^TM2Config;
  pTThreadInfo=^TThreadInfo;
  TThreadInfo=Record
    dwRunTick       :dword;
    boTerminaled    :boolean;
    nRunTime        :integer;
    nMaxRunTime     :integer;
    boActived       :boolean;
    nRunFlag        :integer;
    Config          :pTM2Config;
    hThreadHandle   :THandle;
    dwThreadID      :dword;
  end;
  
  TGlobaDyMval=Array of word;


  TClientWGInfo=record
    boShowRedHPLable:Boolean;
    boShowGroupMember:Boolean;
    boShowAllItem:Boolean;
    boAutoMagic:Boolean;
    boShowBlueMpLable:Boolean;
    boShowName:Boolean;
    boAutoPuckUpItem:Boolean;
    boMoveRedShow:Boolean;
    boShowHPNumber:Boolean;
    boShowAllName:Boolean;
    boForceNotViewFog:boolean;
    boMagicLock:Boolean;
    boParalyCan:Boolean;
    boMoveSlow:Boolean;
    boCanStartRun:Boolean;
    boRunHum:Boolean;
    boRunMon:Boolean;
    boRunNpc:Boolean;
    nMoveTime:Byte;
    nHitTime:Byte;
    nSpellTime:Byte;
    nFireHitSkillTime:LongWord;
    nLongFireHitSkillTime:LongWord;
    nHPUpUseTime:integer;
  end;

  TM2Config=record
    //070521New
    //bMagicYldAddDc          :Boolean;
    //Old
    //英雄增加
    nGuildMemberCount       :Integer;
    boOfflineSaveExp        :Boolean;
    boCloseShowHp           :Boolean;
    boMonShowLevel          :Boolean;
    boMonShowLevelMsg       :String;
    boInfinityStorage       :Boolean;
    nInfinityStorageCount   :integer;

    boOpenSelfShop          :Boolean;
    boSafeZoneShop          :Boolean;
    boMapShop               :Boolean;
    nSellOffGoldTaxRate     :Integer;
    nSellOffGameGoldTaxRate :Integer;
    nSellOffItemCount       :Integer;
    nLevelItemRate          :Integer;
//    boLevelItemGetGold      :Boolean;
//    boLevelItemGetGameGold  :Boolean;
    nLevelItemGoldCount     :Integer;
    nLevelItemGameGoldCount :Integer;

    boPlayShowMystery       :Boolean;
    boHeroShowMystery       :Boolean;
    boCloneShowMystery      :Boolean;

    HPStoneStartRate        :Byte;  //气血石
    MPStoneStartRate        :Byte;  //魔血石
    HPStoneIntervalTime     :LongWord;  //气血石
    MPStoneIntervalTime     :LongWord;  //魔血石
    HPStoneAddRate          :Byte;  //气血石
    MPStoneAddRate          :Byte;  //魔血石
    HPStoneDecDura          :LongWord;  //气血石
    MPStoneDecDura          :LongWord;  //魔血石

    nHeroCallTick           :LongWord; //召唤英雄时间间隔
    nClearHeroGhostTick     :LongWord;//清理英雄尸体间隔
    nHeroNameColor          :Byte;     //英雄名称颜色
    nHeroKillMonExp         :Byte;     //英雄获得经验
    nHeroMagicBlazeTick     :LongWord; //烈火间隔
    nHeroWarrDefaultMagic   :Byte;     //战士野认技能

    nHeroFealtyCallAdd      :Word;
    nHeroFealtyExp          :LongWord;
    nHeroFealtyExpAdd       :Word;
    nHeroFealtyDeathDel     :Word;
    nHeroFealtyCallDel      :Word;
    nHeroFourMagic          :Word;

    nWarrAttackTick         :LongWord;
    nWizardAttackTick       :LongWord;
    nTaosAttackTick         :LongWord;
    nWarrWalkTime           :LongWord;
    nWizardWalkTime         :LongWord;
    nTaosWalkTime           :LongWord;

    nRunMagTick             :LongWord;  //跑位魔法间隔

    nEatItemsTime           :LongWord;
    nHpEatItemsCount        :Integer;
    nMpEatItemsCount        :Integer;


    bHeroPickUpItem         :Boolean;  //允许英雄捡取物品
    bHeroAutoPoison         :Boolean;  //允许英雄自动换毒
    bHeroAddWeaponSpeed     :Boolean;  //计算武器速度
    bHeroKillManAddPK       :Boolean;  //增加PK值
    bHeroUseBump            :Boolean;  //使用野蛮冲撞
    bHeroShowMasterName     :Boolean;  //显示主人名称

    sHeroName               :String[ActorNameLen];
    sHeroNameSuffix         :String[ActorNameLen];

    nHeroMaxDanderCount     :Integer;   //最大怒气值
    //nHeroDanderCount        :Integer;

    boAllowJointAttack      :Boolean;   //是否允许合击
    nEnergyStepUpRate       :Integer;   //补充怒气倍数
    nSkillWWPowerRate       :Integer;   //破魂斩
    nSkillTWPowerRate       :Integer;   //劈星斩
    nSkillZWPowerRate       :Integer;   //雷霆一击
    nSkillTTPowerRate       :Integer;   //噬魂沼泽
    nSkillZTPowerRate       :Integer;   //末日审判
    nSkillZZPowerRate       :Integer;   //火龙气焰


    //英雄结束
    nConfigSize             :integer;
    sServerName             :String;
    sServerIPaddr           :String;
    sWebSite                :String;
    sBbsSite                :String;
    sClientDownload         :String;
    sQQ                     :String;
    sPhone                  :String;
    sBankAccount0           :String;
    sBankAccount1           :String;
    sBankAccount2           :String;
    sBankAccount3           :String;
    sBankAccount4           :String;
    sBankAccount5           :String;
    sBankAccount6           :String;
    sBankAccount7           :String;
    sBankAccount8           :String;
    sBankAccount9           :String;
    nServerNumber           :integer;
    boVentureServer         :boolean;
    boTestServer            :boolean;
    boServiceMode           :boolean;
    boNonPKServer           :boolean;
    boSafeOffLine           :boolean;
    boSafeOffShop           :Boolean;
    boSafeOffHero           :Boolean;
    boSafeOffSlave          :Boolean;
    boClientConnect         :Boolean;
    nTestLevel              :integer;
    nTestHeroLevel          :Integer;
    boHeroExpMode           :Boolean;
    nTestGold               :integer;
    nTestUserLimit          :integer;
    nSendBlock              :integer;
    nCheckBlock             :integer;
    boDropLargeBlock        :Boolean;
    nAvailableBlock         :integer;
    nGateLoad               :integer;
    nUserFull               :integer;
    nZenFastStep            :integer;
    DBName                  :String[15];
    sGateAddr               :String[15];
    nGatePort               :integer;
    sDBAddr                 :String[15];
    nDBPort                 :integer;
    sIDSAddr                :String[15];
    nIDSPort                :integer;
    sMsgSrvAddr             :String[15];
    nMsgSrvPort             :integer;
    sLogServerAddr          :String[15];
    nLogServerPort          :integer;
    boDiscountForNightTime  :boolean;
    nHalfFeeStart           :integer;
    nHalfFeeEnd             :integer;
    boViewHackMessage       :Boolean;
    boViewAdmissionFailure  :Boolean;
    sBaseDir                :String;
    sGuildDir               :String;
    sGuildFile              :String;
    sVentureDir             :String;
    sConLogDir              :String;
    sCastleDir              :String;
    sCastleFile             :String;
    sEnvirDir               :String[80];
    sMapDir                 :String[80];
    sNoticeDir              :String;
    sLogDir                 :String;
    sPlugDir                :String;
    sSort                   :String;
    sStorageDir             :String;
    sUserDataDir            :String[80];
    sClientFile1            :String;
    sClientFile2            :String;
    sClientFile3            :String;
    sClothsMan              :String[14];
    sClothsWoman            :String[14];
    sWoodenSword            :String[14];
    sCandle                 :String[14];
    sBasicDrug              :String[14];
    sGoldStone              :String[14];
    sSilverStone            :String[14];
    sSteelStone             :String[14];
    sCopperStone            :String[14];
    sBlackStone             :String[14];
    sGemStone1              :String[14];
    sGemStone2              :String[14];
    sGemStone3              :String[14];
    sGemStone4              :String[14];

    sZuma                   :Array[0..3] of String[ActorNameLen];
    sBee                    :String[ActorNameLen];
    sSpider                 :String[ActorNameLen];
    sWomaHorn               :String[14];
    sZumaPiece              :String[14];
    sGameGoldName           :String[14];
    sGamePointName          :String;
    sGAMEDIAMONDname        :String[10];
    sGAMEGIRDname           :String[10];
    sPayMentPointName       :String;
    DBSocket                :integer;
    nHealthFillTime         :integer;
    nSpellFillTime          :integer;
    nMonUpLvNeedKillBase    :integer;
    nMonUpLvRate            :integer;
    MonUpLvNeedKillCount    :Array[0..7] of integer;
    SlaveColor              :Array[0..8] of Byte;
    dwNeedExps              :TLevelNeedExp;
    dwMedicineExps          :TLevelNeedExp;//药力值升级值
    dwskill84Exps           :TLevelNeedExp;//酒气护体升级经验
    dwskill83Exps           :TSkill83Exp;//先天元力经验
    dwskill83Abils          :TSkill83Exp;//先天元力属性
    WideAttack              :Array[0..2] of integer;
    CrsAttack               :Array [0..5] of integer;
    TwinAttack              :Array [0..2] of integer;
    SpitMap                 :TSpitMap;
    sHomeMap                :String;
    nHomeX                  :integer;
    nHomeY                  :integer;
    sRedHomeMap             :String;
    nRedHomeX               :integer;
    nRedHomeY               :integer;
    sRedDieHomeMap          :String;
    nRedDieHomeX            :integer;
    nRedDieHomeY            :integer;

    boJobHomePoint          :Boolean;
    sWarriorHomeMap         :String;
    nWarriorHomeX           :integer;
    nWarriorHomeY           :integer;
    sWizardHomeMap          :String;
    nWizardHomeX            :integer;
    nWizardHomeY            :integer;
    sTaoistHomeMap          :String;
    nTaoistHomeX            :integer;
    nTaoistHomeY            :integer;
    dwDecPkPointTime        :dword;
    nDecPkPointCount        :integer;
    dwPKFlagTime            :dword;
    nKillHumanAddPKPoint    :integer;
    nKillHumanDecLuckPoint  :integer;
    dwDecLightItemDrugTime  :dword;
    nSafeZoneSize           :integer;
    nStartPointSize         :integer;
    dwHumanGetMsgTime       :dword;
    nGroupMembersMax        :integer;
    sFireBallSkill          :String[12];
    sHealSkill              :String[12];
    sRingSkill              :Array[0..10] of String[12];
    ReNewNameColor          :Array[0..9] of byte;
    dwReNewNameColorTime    :dword;
    boReNewChangeColor      :boolean;
    boReNewLevelClearExp    :boolean;
    BonusAbilofWarr,
    BonusAbilofWizard,
    BonusAbilofTaos,
    NakedAbilofWarr,
    NakedAbilofWizard,
    NakedAbilofTaos         :TNakedAbility;
    nUpgradeWeaponMaxPoint  :integer;
    nUpgradeWeaponPrice     :integer;
    dwUPgradeWeaponGetBackTime     :dword;
    nClearExpireUpgradeWeaponDays  :integer;
    nUpgradeWeaponDCRate           :integer;
    nUpgradeWeaponDCTwoPointRate   :integer;
    nUpgradeWeaponDCThreePointRate :integer;
    nUpgradeWeaponSCRate           :integer;
    nUpgradeWeaponSCTwoPointRate   :integer;
    nUpgradeWeaponSCThreePointRate :integer;
    nUpgradeWeaponMCRate           :integer;
    nUpgradeWeaponMCTwoPointRate   :integer;
    nUpgradeWeaponMCThreePointRate :integer;
    dwProcessMonstersTime          :LongWord;
    dwRegenMonstersTime            :LongWord;
    nMonGenRate                    :integer;
    boVerNoTime                    :Boolean;
    nProcessMonRandRate            :integer;
    nProcessMonLimitCount          :integer;
    nSoftVersionDate               :integer;
    boCanOldClientLogon            :boolean;
    boCanJSClientLogon             :boolean;
    boCanVipClientLogon            :boolean;
    dwConsoleShowUserCountTime     :dword;
    dwShowLineNoticeTime           :dword;
    dwShowLineNoticeTime2          :dword;
    nLineNoticeColor               :integer;
    nStartCastleWarDays            :integer;
    nStartCastlewarTime            :integer;
    sGetAddress                    :String[16];
    dwShowCastleWarEndMsgTime      :dword;
    dwCastleWarTime                :dword;
    dwGetCastleTime                :dword;
    dwGuildWarTime                 :dword;
    nCheckCount                    :Integer;
//    boCheckOk                      :Boolean;
    boCheckNow                     :Boolean;
    dwCheckTime                    :LongWord;
    sCheckVer                      :LongWord;
    nBuildGuildPrice               :integer;
    nGuildWarPrice                 :integer;
    nMakeDurgPrice                 :integer;
    nHumanMaxGold                  :integer;
    nHumanTryModeMaxGold           :integer;
    nTryModeLevel                  :integer;
    boTryModeUseStorage            :boolean;
    nCanShoutMsgLevel              :integer;
    boShowMakeItemMsg              :boolean;
    boShutRedMsgShowGMName         :boolean;
    nSayMsgMaxLen                  :integer;
    dwSayMsgTime                   :dword;
    nSayMsgCount                   :integer;
    dwDisableSayMsgTime            :dword;
    nSayRedMsgMaxLen               :integer;
    boShowGuildName                :boolean;
    boShowRankLevelName            :boolean;
    boMonSayMsg                    :boolean;
    nStartPermission               :integer;
    boKillHumanWinLevel            :boolean;
    boKilledLostLevel              :boolean;
    boKillHumanWinExp              :boolean;
    boKilledLostExp                :boolean;
    AD_SELFONE                     :boolean;
    AD_SELFTWO                     :boolean;
    AD_SELFWEB                     :boolean;
    AD_SELFMAIN                    :boolean;
    AD_SELFIE                      :boolean;
    SAD_SELFONE                    :String;
    SAD_SELFTWO                    :String;
    SAD_SELFWEB                    :String;
    SAD_SELFMAIN                   :String;
    SAD_SELFIE                     :String;
    nKillHumanWinLevel             :integer;
    nKilledLostLevel               :integer;
    nKillHumanWinExp               :integer;
    nKillHumanLostExp              :integer;
    nHumanLevelDiffer              :integer;
    nMonsterPowerRate              :integer;
    nItemsPowerRate                :integer;
    nItemsACPowerRate              :integer;
    boSendOnlineCount              :boolean;
    nSendOnlineCountRate           :integer;
    dwSendOnlineTime               :dword;
    dwSaveHumanRcdTime             :dword;
    dwHumanFreeDelayTime           :dword;
    dwMakeGhostTime                :dword;//人形怪尸体清理时间
    dwMakeMonGhostTime             :DWORD;//怪物尸体清理时间
  //  dwMakeAnimalGhostTime          :DWORD;//可挖类尸体清理时间
    dwClearDropOnFloorItemTime     :dword;
    dwFloorItemCanPickUpTime       :dword;
    boPasswordLockSystem           :boolean;  //是否启用密码保护系统
    boLockDealAction               :boolean;  //是否锁定交易操作
    boLockDropAction               :boolean;  //是否锁定扔物品操作
    boLockGetBackItemAction        :boolean;  //是否锁定取仓库操作
    boLockHumanLogin               :boolean;  //是否锁定走操作
    boLockWalkAction               :boolean;  //是否锁定走操作
    boLockRunAction                :boolean;  //是否锁定跑操作
    boLockHitAction                :boolean;  //是否锁定攻击操作
    boLockSpellAction              :boolean;  //是否锁定魔法操作
    boLockSendMsgAction            :boolean;  //是否锁定发信息操作
    boLockUserItemAction           :boolean;  //是否锁定使用物品操作
    boLockInObModeAction           :boolean;  //锁定时进入隐身状态
    nPasswordErrorCountLock        :integer;  //输入密码错误超过 指定次数则锁定密码
    boPasswordErrorKick            :boolean;  //输入密码错误超过限制则踢下线
    nSendRefMsgRange               :integer;
    boDecLampDura                  :boolean;
    boHungerSystem                 :boolean;
    boHungerDecHP                  :boolean;
    boHungerDecPower               :boolean;
    boDiableHumanRun               :boolean;
    boRunHuman                     :boolean;
    boRunMon                       :boolean;
    boRunNpc                       :boolean;
    boRunGuard                     :boolean;
    boWarDisHumRun                 :boolean;
    boGMRunAll                     :boolean;
    boSafeZoneRunAll               :Boolean;
    dwTryDealTime                  :dword;
    dwDealOKTime                   :dword;
    boCanNotGetBackDeal            :boolean;
    boDisableDeal                  :boolean;
    nMasterOKLevel                 :integer;
    nMasterOKCreditPoint           :integer;
    nMasterOKBonusPoint            :integer;
    boPKLevelProtect               :boolean;
    nPKProtectLevel                :integer;
    nRedPKProtectLevel             :integer;
    nItemPowerRate                 :integer;
    nItemExpRate                   :integer;
    nScriptGotoCountLimit          :integer;
    btHearMsgFColor                :byte; //前景
    btHearMsgBColor                :byte; //背景
    btWhisperMsgFColor             :byte; //前景
    btWhisperMsgBColor             :byte; //背景
    btGMWhisperMsgFColor           :byte; //前景
    btGMWhisperMsgBColor           :byte; //背景
    btCryMsgFColor                 :byte; //前景
    btCryMsgBColor                 :byte; //背景
    btGreenMsgFColor               :byte; //前景
    btGreenMsgBColor               :byte; //背景
    btBlueMsgFColor                :byte; //前景
    btBlueMsgBColor                :byte; //背景
    btRedMsgFColor                 :byte; //前景
    btRedMsgBColor                 :byte; //背景
    btGuildMsgFColor               :byte; //前景
    btGuildMsgBColor               :byte; //背景
    btGroupMsgFColor               :byte; //前景
    btGroupMsgBColor               :byte; //背景
    btCustMsgFColor                :byte; //前景
    btCustMsgBColor                :byte; //背景
    btCudtMsgFColor                :byte; //前景
    btCudtMsgBColor                :byte; //背景
    nMonRandomAddValue             :integer;
    nMakeRandomAddValue            :integer;
    nWeaponDCAddValueMaxLimit      :integer;
    nWeaponDCAddValueRate          :integer;
    nWeaponMCAddValueMaxLimit      :integer;
    nWeaponMCAddValueRate          :integer;
    nWeaponSCAddValueMaxLimit      :integer;
    nWeaponSCAddValueRate          :integer;
    nDressDCAddRate                :integer;
    nDressDCAddValueMaxLimit       :integer;
    nDressDCAddValueRate           :integer;
    nDressMCAddRate                :integer;
    nDressMCAddValueMaxLimit       :integer;
    nDressMCAddValueRate           :integer;
    nDressSCAddRate                :integer;
    nDressSCAddValueMaxLimit       :integer;
    nDressSCAddValueRate           :integer;
    nNeckLace202124DCAddRate                    :integer;
    nNeckLace202124DCAddValueMaxLimit           :integer;
    nNeckLace202124DCAddValueRate               :integer;
    nNeckLace202124MCAddRate                    :integer;
    nNeckLace202124MCAddValueMaxLimit           :integer;
    nNeckLace202124MCAddValueRate               :integer;
    nNeckLace202124SCAddRate                    :integer;
    nNeckLace202124SCAddValueMaxLimit           :integer;
    nNeckLace202124SCAddValueRate               :integer;
    nNeckLace19DCAddRate                    :integer;
    nNeckLace19DCAddValueMaxLimit           :integer;
    nNeckLace19DCAddValueRate               :integer;
    nNeckLace19MCAddRate                    :integer;
    nNeckLace19MCAddValueMaxLimit           :integer;
    nNeckLace19MCAddValueRate               :integer;
    nNeckLace19SCAddRate                    :integer;
    nNeckLace19SCAddValueMaxLimit           :integer;
    nNeckLace19SCAddValueRate               :integer;
    nArmRing26DCAddRate                    :integer;
    nArmRing26DCAddValueMaxLimit           :integer;
    nArmRing26DCAddValueRate               :integer;
    nArmRing26MCAddRate                    :integer;
    nArmRing26MCAddValueMaxLimit           :integer;
    nArmRing26MCAddValueRate               :integer;
    nArmRing26SCAddRate                    :integer;
    nArmRing26SCAddValueMaxLimit           :integer;
    nArmRing26SCAddValueRate               :integer;
    nRing22DCAddRate                    :integer;
    nRing22DCAddValueMaxLimit           :integer;
    nRing22DCAddValueRate               :integer;
    nRing22MCAddRate                    :integer;
    nRing22MCAddValueMaxLimit           :integer;
    nRing22MCAddValueRate               :integer;
    nRing22SCAddRate                    :integer;
    nRing22SCAddValueMaxLimit           :integer;
    nRing22SCAddValueRate               :integer;
    nRing23DCAddRate                    :integer;
    nRing23DCAddValueMaxLimit           :integer;
    nRing23DCAddValueRate               :integer;
    nRing23MCAddRate                    :integer;
    nRing23MCAddValueMaxLimit           :integer;
    nRing23MCAddValueRate               :integer;
    nRing23SCAddRate                    :integer;
    nRing23SCAddValueMaxLimit           :integer;
    nRing23SCAddValueRate               :integer;
    nHelMetDCAddRate                    :integer;
    nHelMetDCAddValueMaxLimit           :integer;
    nHelMetDCAddValueRate               :integer;
    nHelMetMCAddRate                    :integer;
    nHelMetMCAddValueMaxLimit           :integer;
    nHelMetMCAddValueRate               :integer;
    nHelMetSCAddRate                    :integer;
    nHelMetSCAddValueMaxLimit           :integer;
    nHelMetSCAddValueRate               :integer;
    nUnknowHelMetACAddRate              :integer;
    nUnknowHelMetACAddValueMaxLimit     :integer;
    nUnknowHelMetMACAddRate             :integer;
    nUnknowHelMetMACAddValueMaxLimit    :integer;
    nUnknowHelMetDCAddRate              :integer;
    nUnknowHelMetDCAddValueMaxLimit     :integer;
    nUnknowHelMetMCAddRate              :integer;
    nUnknowHelMetMCAddValueMaxLimit     :integer;
    nUnknowHelMetSCAddRate              :integer;
    nUnknowHelMetSCAddValueMaxLimit     :integer;
    nUnknowRingACAddRate                :integer;
    nUnknowRingACAddValueMaxLimit       :integer;
    nUnknowRingMACAddRate               :integer;
    nUnknowRingMACAddValueMaxLimit      :integer;
    nUnknowRingDCAddRate                :integer;
    nUnknowRingDCAddValueMaxLimit       :integer;
    nUnknowRingMCAddRate                :integer;
    nUnknowRingMCAddValueMaxLimit       :integer;
    nUnknowRingSCAddRate                :integer;
    nUnknowRingSCAddValueMaxLimit       :integer;
    nUnknowNecklaceACAddRate            :integer;
    nUnknowNecklaceACAddValueMaxLimit   :integer;
    nUnknowNecklaceMACAddRate           :integer;
    nUnknowNecklaceMACAddValueMaxLimit  :integer;
    nUnknowNecklaceDCAddRate            :integer;
    nUnknowNecklaceDCAddValueMaxLimit   :integer;
    nUnknowNecklaceMCAddRate            :integer;
    nUnknowNecklaceMCAddValueMaxLimit   :integer;
    nUnknowNecklaceSCAddRate            :integer;
    nUnknowNecklaceSCAddValueMaxLimit   :integer;
    nMonOneDropGoldCount                :integer;
    nMonButchMaxTime                    :Integer;
    boNoManClearMon                     :Boolean;
    dwNoManClearMonTime                 :LongWord;
    nMakeMineHitRate                    :integer; //挖矿命中率
    nMakeMineRate                       :integer; //挖矿率
    nStoneTypeRate                      :integer;
    nStoneTypeRateMin                   :integer;
    nGoldStoneMin                       :integer;
    nGoldStoneMax                       :integer;
    nSilverStoneMin                     :integer;
    nSilverStoneMax                     :integer;
    nSteelStoneMin                      :integer;
    nSteelStoneMax                      :integer;
    nBlackStoneMin                      :integer;
    nBlackStoneMax                      :integer;
    nStoneMinDura                       :integer;
    nStoneGeneralDuraRate               :integer;
    nStoneAddDuraRate                   :integer;
    nStoneAddDuraMax                    :integer;
    nWinLottery6Min                     :integer;
    nWinLottery6Max                     :integer;
    nWinLottery5Min                     :integer;
    nWinLottery5Max                     :integer;
    nWinLottery4Min                     :integer;
    nWinLottery4Max                     :integer;
    nWinLottery3Min                     :integer;
    nWinLottery3Max                     :integer;
    nWinLottery2Min                     :integer;
    nWinLottery2Max                     :integer;
    nWinLottery1Min                     :integer;
    nWinLottery1Max                     :integer;//16180 + 1820;
    nWinLottery1Gold                    :integer;
    nWinLottery2Gold                    :integer;
    nWinLottery3Gold                    :integer;
    nWinLottery4Gold                    :integer;
    nWinLottery5Gold                    :integer;
    nWinLottery6Gold                    :integer;
    nWinLotteryRate                     :integer;
    nWinLotteryCount                    :integer;
    nNoWinLotteryCount                  :integer;
    nWinLotteryLevel1                   :integer;
    nWinLotteryLevel2                   :integer;
    nWinLotteryLevel3                   :integer;
    nWinLotteryLevel4                   :integer;
    nWinLotteryLevel5                   :integer;
    nWinLotteryLevel6                   :integer;
    GlobalVal                           :Array[0..999] of integer;
    GlobalStrVal                        :Array[0..999] of String;
    GlobalNameVal                       :Array[0..20] of String;
    btClientWgInfo                      :Byte;
    boClientExpShowConfig               :boolean; //经验是否显示在聊天窗口
    boBagShowItemDec                    :Boolean;//包裹里是不是显示物品备注说明
    nItemNumber                         :integer;
    nItemNumberEx                       :integer;
    nGuildRecallTime                    :integer;
    nGroupRecallTime                    :integer;
    boControlDropItem                   :boolean;
    boInSafeDisableDrop                 :boolean;
    nCanDropGold                        :integer;
    nCanDropPrice                       :integer;
    boSendCustemMsg                     :boolean;
    boSubkMasterSendMsg                 :boolean;
    nSuperRepairPriceRate               :integer; //特修价格倍数
    nRepairItemDecDura                  :integer; //普通修理掉持久数(特持久上限减下限再除以此数为减的数值)
    boDieScatterBag                     :boolean;
    nDieScatterBagRate                  :integer;
    boDieRedScatterBagAll               :boolean;
    nDieDropUseItemRate                 :integer;
    nDieRedDropUseItemRate              :integer;
    boDieDropGold                       :boolean;
    boKillByHumanDropUseItem            :boolean;
    boKillByMonstDropUseItem            :boolean;
    boKickExpireHuman                   :boolean;
    nGuildRankNameLen                   :integer;
    nGuildMemberMaxLimit                :integer;
    nGuildNameLen                       :integer;
    nCastleNameLen                      :Integer;
    nAttackPosionRate                   :integer;
    nAttackPosionTime                   :integer;
    dwRevivalTime                       :dword; //复活间隔时间
    boUserMoveCanDupObj                 :boolean;
    boUserMoveCanOnItem                 :boolean;
    dwUserMoveTime                      :integer;
    dwPKDieLostExpRate                  :integer;
    nPKDieLostLevelRate                 :integer;
    btPKFlagNameColor                   :Byte;
    btPKLevel1NameColor                 :Byte;
    btPKLevel2NameColor                 :Byte;
    btAllyAndGuildNameColor             :Byte;
    btWarGuildNameColor                 :Byte;
    btInFreePKAreaNameColor             :Byte;
    boSpiritMutiny                      :boolean;
    dwSpiritMutinyTime                  :dword;
    nSpiritPowerRate                    :integer;
    boMasterDieMutiny                   :boolean;
    nMasterDieMutinyRate                :integer;
    nMasterDieMutinyPower               :integer;
    nMasterDieMutinySpeed               :integer;
    boBBMonAutoChangeColor              :boolean;
    dwBBMonAutoChangeColorTime          :integer;
    boOldClientShowHiLevel2              :boolean;
    boShowScriptActionMsg               :boolean;
    nRunSocketDieLoopLimit              :integer;
//    boThreadRun                         :boolean;
    boShowExceptionMsg                  :boolean;
    boShowPreFixMsg                     :boolean;
    nMagicAttackRage                    :integer; //魔法锁定范围
    nFireHitSkillTime                   :LongWord;
    nLongFireHitSkillTime               :LongWord;
    nLongFireHitPower                   :Integer;
    nMeteorRainPower                    :Integer;
    nMeteorRainTime                     :LongWord;
    nVampirePower                       :Integer;
    nAttackPower                        :Integer;
    nSkill82Time                        :LongWord;
    nSkill82Rate                        :Integer;
    nVampireHpRate                      :Integer;
    nTwinHitSkillRange                  :Byte;
    nTwinHitMaxCount                    :Integer;
    nTwinHitCount                       :Integer;
    nShieldTime                         :LongWord;
    nShieldTick                         :LongWord;
    nShieldAttackRate                   :Word;
    nShieldSmashRate                    :Word;
    boShieldAttackEff                   :Byte;
    boAutoOpenShield                    :Boolean;
    boShieldShowEffect                  :Boolean;
    boShieldYEDO                        :Boolean;
    boShieldErgum                       :Boolean;
    boShieldFire                        :Boolean;
    boShieldLong                        :Boolean;
    boPlayObjectReduceMP                :Boolean;
    nLongSwordTime                      :LongWord;
    nLongSwordRate                      :Integer;
    nUenhancerTime                      :Integer;
    nUenhancerRate                      :Integer;
    sPlayCloneName                      :String[ActorNameLen];
    boCloneShowMasterName               :Boolean;
    boCloneMakeSlave                    :Boolean;
    nPlayCloneTime                      :LongWord;
    nCallCloneTime                      :LongWord;
    sSkeleton                           :String[ActorNameLen];
    nSkeletonCount                      :integer;
    SkeletonArray                       :array[0..9] of TRecallMigic;
    sDragon                             :String[ActorNameLen];
    sDragon1                            :String[ActorNameLen];
    nDragonCount                        :integer;
    DragonArray                         :array[0..9] of TRecallMigic;
    sFairy                              :String[ActorNameLen];
    nFairyCount                         :integer;
    FairyArray                          :array[0..9] of TRecallMigic;
    nFairyDuntRate                      :Integer;
    nFairyAttackRate                    :integer;
    sAngel                              :String[ActorNameLen];
    nAmyOunsulPoint                     :integer;
    boDisableInSafeZoneFireCross        :boolean;
    boChangeMapCloseFire                :Boolean;
    boPlayDethCloseFire                 :Boolean;
    boPlayGhostCloseFire                :Boolean;
    dwFireCrossMaxTime                  :LongWord;
    boGroupMbAttackPlayObject           :boolean;
    boGroupMbAttackMonObject            :boolean;
    boGroupMbAttackHeroObject           :boolean;
    boFastenAttackPlayObject            :Boolean;
    boFastenAttackHeroObject            :Boolean;
    boFastenAttackSlaveObject           :Boolean;
    dwPosionDecHealthTime               :dword;
    dwMagicDeDingTime                   :dWord;
    nPosionDamagarmor                   :integer;//中红毒着持久及减防量（实际大小为 12 / 10）
    boLimitSwordLong                    :boolean;
    nSwordLongPowerRate                 :integer;
    nFireBoomRage                       :integer;
    nSnowWindRange                      :integer;
    nElecBlizzardRange                  :integer;
    nMagTurnUndeadLevel                 :integer; //圣言怪物等级限制
    nMagTammingLevel                    :integer; //诱惑之光怪物等级限制
    nMagTammingTargetLevel              :integer; //诱惑怪物相差等级机率，此数字越小机率越大；
    nMagTammingHPRate                   :integer; //成功机率=怪物最高HP 除以 此倍率，此倍率越大诱惑机率越高
    nMagTammingCount                    :integer;
    nMabMabeHitRandRate                 :integer;
    nMabMabeHitMinLvLimit               :integer;
    nMabMabeHitSucessRate               :integer;
    nMabMabeHitMabeTimeRate             :integer;
    sCastleName                         :String;
    sCastleHomeMap                      :String;
    nCastleHomeX                        :integer;
    nCastleHomeY                        :integer;
    nCastleWarRangeX                    :integer;
    nCastleWarRangeY                    :integer;
    nCastleTaxRate                      :integer;
    boGetAllNpcTax                      :boolean;
    nHireGuardPrice                     :integer;
    nHireArcherPrice                    :integer;
    nCastleGoldMax                      :integer;
    nCastleOneDayGold                   :integer;
    nRepairDoorPrice                    :integer;
    nRepairWallPrice                    :integer;
    nCastleMemberPriceRate              :integer;
    nMaxHitMsgCount                     :integer;
    nMaxSpellMsgCount                   :integer;
    nMaxRunMsgCount                     :integer;
    nMaxWalkMsgCount                    :integer;
    nMaxTurnMsgCount                    :integer;
    nMaxSitDonwMsgCount                 :integer;
    nMaxDigUpMsgCount                   :integer;
    boSpellSendUpdateMsg                :boolean;
    boActionSendActionMsg               :boolean;
    boKickOverSpeed                     :boolean;
    btSpeedControlMode                  :integer;
    nOverSpeedKickCount                 :integer;
    dwDropOverSpeed                     :dword;
    dwHitIntervalTime                   :dword; //攻击间隔
    dwMagicHitIntervalTime              :dword; //魔法间隔
    dwRunIntervalTime                   :dword; //跑步间隔
    dwWalkIntervalTime                  :dword; //走路间隔
    dwTurnIntervalTime                  :dword; //换方向间隔
    boControlActionInterval             :boolean;
    boControlWalkHit                    :boolean;
    boControlRunLongHit                 :boolean;
    boControlRunHit                     :boolean;
    boControlRunMagic                   :boolean;
    dwActionIntervalTime                :dword; //组合操作间隔
    dwRunLongHitIntervalTime            :dword; //跑位刺杀间隔
    dwRunHitIntervalTime                :dword; //跑位攻击间隔
    dwWalkHitIntervalTime               :dword; //走位攻击间隔
    dwRunMagicIntervalTime              :dword; //跑位魔法间隔
    boDisableStruck                     :boolean; //不显示人物弯腰动作
    boDisableSelfStruck                 :boolean; //自己不显示人物弯腰动作
    dwStruckTime                        :dword; //人物弯腰停留时间
    dwKillMonExpMultiple                :dword; //杀怪经验倍数
    nHeroEatingTime                     :word;
    nAutoPuckUpItemTime                 :word;
    nAspeederTime                       :word;
    nDemoVerIdx                         :Integer;
    dwRequestVersion                    :dword;
    boHighLevelKillMonFixExp            :boolean;
    boHighLevelGroupFixExp              :Boolean;
    boGroupSameScreen                   :Boolean;
    boGroupSameMap                      :Boolean;
    boAddUserItemNewValue               :boolean;
    boCloneNotCheckAmulet2              :Boolean;
    nPlayMaxLevel                       :Word;
    nHeroMaxLevel                       :Word;
    nHeroExpRate                        :Integer;
    nPlayFixupExp                       :LongWord;
    nHeroFixupExp                       :LongWord;
    sLineNoticePreFix                   :String;
    sSysMsgPreFix                       :String;
    sGuildMsgPreFix                     :String;
    sGroupMsgPreFix                     :String;
    sHintMsgPreFix                      :String;
    sGMRedMsgpreFix                     :String;
    sMonSayMsgpreFix                    :String;
    sCustMsgpreFix                      :String;
    sCastleMsgpreFix                    :String;
    sClairaudientFix                    :String;
    sGuildNotice                        :String;
    sGuildWar                           :String;
    sGuildAll                           :String;
    sGuildMember                        :String;
    sGuildMemberRank                    :String;
    sGuildChief                         :String;
    boKickAllUser                       :boolean;
    boTestSpeedMode                     :boolean;
    ClientConf                          :TClientConf;
    nWeaponMakeUnLuckRate               :integer;
    nWeaponMakeLuckPoint1               :integer;
    nWeaponMakeLuckPoint2               :integer;
    nWeaponMakeLuckPoint3               :integer;
    nWeaponMakeLuckPoint2Rate           :integer;
    nWeaponMakeLuckPoint3Rate           :integer;
    boCheckUserItemPlace                :boolean;
    nClientKey                          :integer;
    nLevelValueOfTaosHP                 :integer;
    nLevelValueOfTaosHPRate             :double;
    nLevelValueOfTaosMP                 :integer;
    nLevelValueOfWizardHP               :integer;
    nLevelValueOfWizardHPRate           :double;
    nLevelValueOfWarrHP                 :integer;
    nLevelValueOfWarrHPRate             :double;
    nProcessMonsterInterval2            :integer;
    nAppIconCrc                         :integer;
    boIDSocketConnected                 :Boolean;
    UserIDSection                       :TRTLCriticalSection;
    sIDSocketRecvText                   :String;
    IDSocket                            :integer;
    nIDSocketRecvIncLen                 :integer;
    nIDSocketRecvMaxLen                 :integer;
    nIDSocketRecvCount                  :integer;
    nIDReceiveMaxTime                   :integer;
    nIDSocketWSAErrCode                 :integer;
    nIDSocketErrorCount                 :integer;
    nLoadDBCount                        :integer;
    nLoadDBErrorCount                   :integer;
    nSaveDBCount                        :integer;
    nDBQueryID                          :integer;
    UserEngineThread                    :TThreadInfo;
    IDSocketThread                      :TThreadInfo;
    DBSocketThread                      :TThreadInfo;
    boDBSocketConnected                 :boolean;
    nDBSocketRecvIncLen                 :integer;
    nDBSocketRecvMaxLen                 :integer;
    sDBSocketRecvText                   :String;
    boDBSocketWorking                   :boolean;
    nDBSocketRecvCount                  :integer;
    nDBReceiveMaxTime                   :integer;
    nDBSocketWSAErrCode                 :integer;
    nDBSocketErrorCount                 :integer;
    nServerFile_CRCB                    :integer;
//    nClientFile1_CRC                    :integer;
//    nClientFile2_CRC                    :integer;
//    nClientFile3_CRC                    :integer;
    //GlobaDyMval                         :TGlobaDyMval;
    GlobaDyMval                         :Array[0..999] of integer;
    GlobaDyMStrVal                      :Array[0..999] of String;
 //   nM2Crc                              :integer;
  //  nCheckLicenseFail                   :integer;
  //  dwCheckTick                         :LongWord;
 //   nCheckFail                          :Integer;
    boDropGoldToPlayBag                 :Boolean;

    boSendCurTickCount                  :Boolean;
    dwSendWhisperTime                   :LongWord;
    nSendWhisperPlayCount               :Integer;
    boMoveCanDupObj                     :Boolean;
    boJsCheckFail                       :Boolean;
    nProcessTick                        :integer;
    nProcessTime                        :integer;
    nDBSocketSendLen                    :Integer;
    nMakeWineTime                       :integer;//酿普通酒需要等待的时间
    nMakeWineTime1                      :integer;//酿药酒需要等待的时间
    nMakeWineRate                       :integer;//酒曲机率
    nDesMedicineValue                   :integer;//在指定时间内没有饮用药酒,则减药力值
    nDecMaxAlcoholTime                  :integer;//在指定的时间内没有饮用酒,则减少酒量上限
    nWinequality                        :integer;//酒的品质高于
    nTempAbil                           :integer;//临时属性提升
    nSpeedupAlcoholTick                 :integer;//酒量提升速度
    nGettempAbilRate                    :integer;//饮酒获得临时属性的机率
    nDesMedicineTick                    :integer;//长期没有饮酒,间隔多长时间减药力值
    nIncAlcoholTick                     :integer;//酒量进度增加时间间隔
    nDesDrinkTick                       :integer;//醉酒度减少间隔
    nMaxAlcoholValue                    :integer;//酒量初始上限值
    nIncAlcoholValue                    :integer;//当前酒量值达到上限后,酒量上限增加指定的值
    nDECAlcoholValue                    :integer;//在指定时间没有饮酒量减少的酒量值
    nDecGuildFountain                   :integer;//行会成员领取酒泉时,行会蓄量减少指定的值
    nInFountainTime                     :integer;//采集泉水需站在泉眼上的时间,达到
    nMinDrinkValue83                    :integer;//先天元力当饮酒量低于 总酒量* 设置值/100 时,技能无法使用
    nMinDrinkValue84                    :integer;//酒气护体当饮酒量低 总酒量* 设置值/100 时于技能无法使用
    nHPUpUseTime                        :integer;//酒气护体增加HP的持续时间
    nDRUNKTick                          :integer;//显示醉酒状态间隔
    nHighDRUNKTick                      :integer;//醉酒度高于指定值
    nHighAlcoholTick                     :integer;//酒量提升进度加快几秒
    nlowDRUNKTick                       :integer;//醉酒度低于指定值
    nlowAlcoholTick                     :integer;//酒量提升进度减慢几秒
    nRUNKValue                          :integer;//酒醉值
    nskill84MaxLevel                    :integer;//酒气护体最大等级
    nMakeMedicineWineMinQuality         :integer;//酿造药酒普通酒所须最低品质
    nMedicineIncAbil                    :integer;//每级药力值所加的属生点
    nskill84HPUpTick                    :integer;//酒气护体第级HP的倍数
  //  nHPUpTick                           :integer;//酒气护体每次使用技能的间隔
    nSkill57DecDamage                   :integer;//四级盾抵消伤害百分比
    nChallengeTime                      :LongWord;//挑战时间
    nChallengeGoldIndex                 :Byte;//挑战附加币种类
    WgInfo                              :TClientWGInfo;
  end;

  TGameCommand=record
    //英雄新增
    RestHero,
    AllSysMsg,
    ShowEffect,
    HeroLevel,
    HeroFealty,
    SignMove,
    DATA,
    PRVMSG,
    ALLOWMSG,
    LETSHOUT,
    LETTRADE,
    LETGUILD,
    ENDGUILD,
    BANGUILDCHAT,
    AUTHALLY,
    AUTH,
    AUTHCANCEL,
    DIARY,
    USERMOVE,
    SEARCHING,
    ALLOWGROUPCALL,
    GROUPRECALLL,
    ALLOWGUILDRECALL,
    GUILDRECALLL,
    UNLOCKSTORAGE,
    UNLOCK,
    LOCK,
    PASSWORDLOCK,
    SETPASSWORD,
    CHGPASSWORD,
    CLRPASSWORD,
    UNPASSWORD,
    MEMBERFUNCTION,
    MEMBERFUNCTIONEX,
    DEAR,
    ALLOWDEARRCALL,
    DEARRECALL,
    MASTER,
    ALLOWMASTERRECALL,
    MASTERECALL,
    ATTACKMODE,
    REST,
    TAKEONHORSE,
    TAKEOFHORSE,
    HUMANLOCAL,
    MOVE,
    POSITIONMOVE,
    INFO,
    MOBLEVEL,
    MOBCOUNT,
    HUMANCOUNT,
    MAP,
    KICK,
    TING,
    SUPERTING,
    MAPMOVE,
    SHUTUP,
    RELEASESHUTUP,
    SHUTUPLIST,
    GAMEMASTER,
    OBSERVER ,
    SUEPRMAN,
    LEVEL,
    SABUKWALLGOLD,
    RECALL,
    REGOTO,
    SHOWFLAG,
    SHOWOPEN,
    SHOWUNIT,
    ATTACK,
    MOB,
    MOBNPC,
    DELNPC,
    NPCSCRIPT,
    RECALLMOB,
    LUCKYPOINT,
    LOTTERYTICKET,
    RELOADGUILD,
    RELOADLINENOTICE,
    RELOADABUSE,
    BACKSTEP,
    BALL,
    FREEPENALTY,
    PKPOINT,
    INCPKPOINT,
    CHANGELUCK,
    HUNGER,
    HAIR,
    TRAINING,
    DELETESKILL,
    CHANGEJOB,
    CHANGEGENDER,
    NAMECOLOR,
    MISSION,
    MOBPLACE,
    TRANSPARECY,
    DELETEITEM,
    LEVEL0,
    CLEARMISSION,
    SETFLAG,
    SETOPEN,
    SETUNIT,
    RECONNECTION,
    DISABLEFILTER,
    CHGUSERFULL,
    CHGZENFASTSTEP,
    CONTESTPOINT,
    STARTCONTEST,
    ENDCONTEST,
    ANNOUNCEMENT,
    OXQUIZROOM,
    GSA,
    CHANGEITEMNAME,
    DISABLESENDMSG,
    ENABLESENDMSG,
    DISABLESENDMSGLIST,
    KILL,
    MAKE,
    SMAKE,
    BONUSPOINT,
    DELBONUSPOINT,
    RESTBONUSPOINT,
    FIREBURN,
    TESTFIRE,
    TESTSTATUS,
    DELGOLD,
    ADDGOLD,
    DELGAMEGOLD,
    ADDGAMEGOLD,
    GAMEGOLD,
    GAMEPOINT,
    CREDITPOINT,
    TESTGOLDCHANGE,
    REFINEWEAPON,
    RELOADADMIN,
    RELOADNPC,
    RELOADMANAGE,
    RELOADROBOTMANAGE,
    RELOADROBOT,
    RELOADMONITEMS,
    RELOADDIARY,
    RELOADITEMDB,
    RELOADMAGICDB,
    RELOADMONSTERDB,
    RELOADMINMAP,
    REALIVE,
    ADJUESTLEVEL,
    ADJUESTEXP,
    ADDGUILD,
    DELGUILD,
    CHANGESABUKLORD,
    FORCEDWALLCONQUESTWAR,
    ADDTOITEMEVENT,
    ADDTOITEMEVENTASPIECES,
    ITEMEVENTLIST,
    STARTINGGIFTNO,
    DELETEALLITEMEVENT,
    STARTITEMEVENT,
    ITEMEVENTTERM,
    ADJUESTTESTLEVEL,
    TRAININGSKILL,
    OPDELETESKILL,
    CHANGEWEAPONDURA,
    RELOADGUILDALL,
    WHO,
    TOTAL,
    TESTGA,
    MAPINFO,
    SBKDOOR,
    CHANGEDEARNAME,
    CHANGEMASTERNAME,
    STARTQUEST,
    SETPERMISSION,
    CLEARMON,
    RENEWLEVEL,
    DENYIPLOGON,
    DENYACCOUNTLOGON,
    DENYCHARNAMELOGON,
    DELDENYIPLOGON,
    DELDENYACCOUNTLOGON,
    DELDENYCHARNAMELOGON,
    SHOWDENYIPLOGON,
    SHOWDENYACCOUNTLOGON,
    SHOWDENYCHARNAMELOGON,
    VIEWWHISPER,
    SPIRIT,
    SPIRITSTOP,
    SETMAPMODE,
    SHOWMAPMODE,
    TESTSERVERCONFIG,
    SERVERSTATUS ,
    TESTGETBAGITEM,
    CLEARBAG,
    SHOWUSEITEMINFO,
    BINDUSEITEM,
    MOBFIREBURN,
    TESTSPEEDMODE,
    LOCKLOGON,
    Gotonow//,
  //  ChangeSKILL,
 //   GETGOODMAKEWINE,
  //  MAKEWINENPCMOVE,
  //  FOUNTAIN,
  //  SETGUILDFOUNTAIN,
//    GIVEGUILDFOUNTAIN,
 //   DECMAKEWINETIME,
 //   OPENMAKEWINE,
 //   GIVECASTLEFOUNTAIN,
//    QUERYREFINEITEM
    :TGameCmd;

  end;

  TIPLocal=procedure (sIPaddr:Pchar;sLocal:Pchar;len:integer);

  pTAdminInfo=^TAdminInfo;
  TAdminInfo=record
    nLv:integer;
    sChrName:String[20];
    sIPaddr:String[15];
  end;

  pTMonDrop=^TMonDrop;
  TMonDrop=record
    sItemName:String[14];
    nDropCount:integer;
    nNoDropCount:integer;
    nCountLimit:integer;
  end;

  TMonStatus=(s_KillHuman,s_UnderFire,s_Die,s_MonGen);

  pTMonSayMsg=^TMonSayMsg;
  TMonSayMsg=record
    State:TMonStatus;
    Color:TMsgColor;
    nRate:integer;
    sSayMsg:String;
  end;

  

  TVarType=(vNone,VInteger,VString);
  pTDynamicVar=^TDynamicVar;
  TDynamicVar=record
     sName:String;
     VarType:TVarType;
     nInternet:Integer;
     sString:String;
  end;

  pTItemName=^TItemName;
  TItemName=record
    nMakeIndex:integer;
    nItemIndex:integer;
    sItemName:String[14];
  end;

  TLoadHuman=record
    sAccount:String[16];
    sChrName:String[20];
    sUserAddr:String[15];
    nSessionID2:integer;
    boHero:Boolean;
    nHeroJob:Byte;
    nHeroMan:Byte;
    sHeroMaster:String[ActorNameLen];
  end;

  pTSrvNetInfo=^TSrvNetInfo;
  TSrvNetInfo=record
    sIPaddr  :String;
    nPort    :Integer;
  end;

  pTUserOpenInfo=^TUserOpenInfo;
  TUserOpenInfo=record
     sChrName:String[20];
     LoadUser:TLoadDBInfo;
     HumanRcd:THumDataInfo;
  end;

  pTGateObj=^TGateObj;
  TGateObj=record
     DEnvir:TObject;
     nDMapX,
     nDMapY:integer;
     boFlag:Boolean;
  end;

  pTMapGate = ^TMapGate;
  TMapGate = record
    sIdx     :String[20];
    nX       :Integer;
    nY       :Integer;
    GetObj   :pTGateObj;
  end;

  pTMapQuestInfo=^TMapQuestInfo;
  TMapQuestInfo=record
     nFlag:integer;
     nValue:integer;
     sMonName:string[ActorNameLen];
     sItemName:String[14];
     boGrouped:boolean;
     NPC:TObject;
  end;

  //Damian
  TRegInfo = record
    sKey:String;
    sServerName:String;
    sRegSrvIP:String[15];
    nRegPort:Integer;
  end;

  TOClientPlacing =packed  record
    Item      :TOClientItem2;
    nPrice    :Integer;
    nPicCls   :Boolean;
    nSell     :Boolean;
    nTime     :TDateTime;
    sName     :String[ActorNameLen];
  end;

  TClientPlacing =packed  record
    Item      :TClientItem;
    nPrice    :Integer;
    nPicCls   :Boolean;
    nSell     :Boolean;
    nTime     :TDateTime;
    sName     :String[ActorNameLen];
  end;

  TUserPlacing =packed  record
    Item      :TUserItem;
    nPrice    :Integer;
    nPicCls   :Boolean;
    nTime     :TDateTime;
    sName     :String[ActorNameLen];
    sItemName :String[ActorNameLen];
    boSell    :Boolean;
    nIdx      :Byte;
  end;
  pTUserPlacing = ^TUserPlacing;

//挑战
  TChallengeItem =packed  record
    Items           :array [0..3] of PTUserItem;
    nGold           :Integer;     //金币
    nGameDiamond    :Integer;     //金刚石
  end;
  PTChallengeItem=^TChallengeItem;

  Taxis = record
    sName     : String[14];
    sHeroName : String[14];
    nLevel    : Integer;
    nExp      : LongWord;
    nMaster   : Integer;
  end;
  pTaxis = ^Taxis;

  TTaxisSelf = record
    nTop:Word;
    sName:String[14];
    nLevel:Word;
  end;
  TTaxisHero = record
    nTop:Word;
    sHeroName:String[14];
    sName:String[14];
    nLevel:Word;
  end;

  THumList  = Array[0..MAXTAXISCOUNT-1] of TTaxisSelf;
  THeroList = Array[0..MAXTAXISCOUNT-1] of TTaxisHero;

  THumSort = record
    nUpDate : TDateTime;
    nMaxIdx : Integer;
    List    : THumList;
  end;
  THeroSort = record
    nUpDate : TDateTime;
    nMaxIdx : Integer;
    List    : THeroList;
  end;

  pTPowerBlock = ^TPowerBlock;
  TPowerBlock = array[0..100-1] of Word; //Damian

  //解包物品
  TOpenItem = record
    sItemName: string[20];
    sBItemName: string[20];
    sHitTime: LongWord;
  end;
  pTOpenItem = ^TOpenItem;

  function MakeDefaultMsg (msg:smallint; Recog:integer; param, tag, series:word):TDefaultMessage;
  function APPRfeature(cfeature:integer):Word;
  function RACEfeature(cfeature:integer):Byte;
  function HAIRfeature(cfeature:integer):Byte;
  function DRESSfeature(cfeature:integer):Byte;
  function WEAPONfeature(cfeature:integer):Byte;
  function Horsefeature(cfeature:integer):Byte;
  function Effectfeature(cfeature:integer):Byte;
  function MakeHumanFeature(btRaceImg,btDress,btWeapon,btHair:Byte):Integer;
  function MakeMonsterFeature(btRaceImg,btWeapon:Byte;wAppr:Word):Integer;


implementation

function  MakeDefaultMsg (msg:smallint; Recog:integer; param, tag, series:word):TDefaultMessage;
begin
    result.Ident:=Msg;
    result.Param:=Param;
    result.Tag:=Tag;
    result.Series:=Series;
    result.Recog:=Recog;
end;

function WEAPONfeature(cfeature:integer):Byte;
begin
  Result:=HiByte(cfeature);
end;
function DRESSfeature(cfeature:integer):Byte;
begin
  Result:= HiByte(HiWord(cfeature));
end;
function APPRfeature(cfeature:integer):Word;
begin
  Result:=HiWord(cfeature);
end;
function HAIRfeature(cfeature:integer):Byte;
begin
  Result:=HiWord(cfeature);
end;
function RACEfeature(cfeature:integer):Byte;
begin
  Result:=cfeature;
end;

function Horsefeature(cfeature:integer):Byte;
begin
  Result:=LoByte(LoWord(cfeature));
end;
function Effectfeature(cfeature:integer):Byte;
begin
  Result:=HiByte(LoWord(cfeature));
end;

function MakeHumanFeature(btRaceImg,btDress,btWeapon,btHair:Byte):Integer;
begin
  Result:=MakeLong(MakeWord(btRaceImg,btWeapon),MakeWord(btHair,btDress));
end;
function MakeMonsterFeature(btRaceImg,btWeapon:Byte;wAppr:Word):Integer;
begin
  Result:=MakeLong(MakeWord(btRaceImg,btWeapon),wAppr);
end;

end.

