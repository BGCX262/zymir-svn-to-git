unit Grobal2;

interface
uses
   Math,windows;
Const
  BUFFERSIZE    =1024;

  //�ͻ��˷��͵�����
  CM_SOFTCLOSE  =0;

 

  //��¼�йص�����
  CM_IDPASSWORD  =1;
  CM_QUERYUSERSTATE=2;
  CM_ADDNEWUSER =3;
  CM_UPDATEUSER =4;
  CM_SELECTSERVER =5;
  CM_CHANGEPASSWORD =6;
  CM_NEWCHR =7;
  CM_QUERYCHR =8;
  CM_DELCHR =9;
  CM_SELCHR =10;
  CM_QUERYUSERNAME=11;

  CM_SAY =22;

  CM_MAGICKEYCHANGE = 30;
  CM_CREATEGROUP =42;
  CM_WANTMINIMAP =43;
  CM_OPENGUILDDLG =45;
  CM_GROUPMODE=41;
  CM_ADDGROUPMEMBER =51;
  CM_DELGROUPMEMBER =52;

  CM_SPEEDHACKUSER =59;
  CM_ADJUST_BONUS =60;

  CM_QUERYBAGITEMS=62;
  CM_LOGINNOTICEOK = 63;
  //��������1
  CM_TURN       =4001;
  CM_WALK       =4002;
  CM_SITDOWN    =4003;
  CM_RUN        =4004;
  CM_HIT        =4005;
  CM_POWERHIT   =4008;
  CM_LONGHIT    =4009;
  CM_WIDEHIT    =4010;
  CM_HEAVYHIT   =4011;
  CM_BIGHIT     =4012;
  CM_THROW      =4013;
  CM_FIREHIT    =4014;
  CM_SPELL      =4015;

  CM_CLICKNPC   =3015;

  //��������2
  CM_OPENDOOR   =2001;
  CM_DROPITEM =2010;
  CM_PICKUP =2011;
  CM_TAKEONITEM =2021;
  CM_TAKEOFFITEM = 2022;
  CM_EAT =2023;
  CM_BUTCH =2024;

  CM_MERCHANTDLGSELECT =2030;
  CM_MERCHANTQUERYSELLPRICE =2031;
  CM_MERCHANTQUERYREPAIRCOST =2032;

  CM_USERSELLITEM =2040;
  CM_USERREPAIRITEM =2041;
  CM_USERSTORAGEITEM =2042;
  CM_USERGETDETAILITEM =2043;
  CM_USERBUYITEM =2044;
  CM_USERTAKEBACKSTORAGEITEM =2045;
  CM_USERMAKEDRUGITEM =2046;
  CM_DROPGOLD =2050;

  CM_DEALTRY =2060;
  CM_DEALCANCEL =2061;
  CM_DEALADDITEM =2062;
  CM_DEALDELITEM =2063;
  CM_DEALCHGGOLD =2064;
  CM_DEALEND =2069;

  CM_GUILDHOME =2070;
  CM_GUILDMEMBERLIST =2071;
  CM_GUILDADDMEMBER =2072;
  CM_GUILDDELMEMBER =2073;
  CM_GUILDUPDATENOTICE =2074;
  CM_GUILDUPDATERANKINFO =2075;

  //װ����Ŀ
  U_WEAPON      =0;    //����
  U_RIGHTHAND   =1;    //����
  U_DRESS       =2;    //�·�
  U_HELMET      =3;    //ͷ��
  U_NECKLACE    =4;    //����
  U_ARMRINGR    =5;    //���ֽ�ָ
  U_ARMRINGL    =6;    //���ֽ�ָ
  U_RINGR       =7;    //�ҽ�ָ
  U_RINGL       =8;    //���ָ

  //�������˷��͵�����

  //��¼�����ʺš��½�ɫ����ѯ��ɫ��
  SM_NEWID_SUCCESS =101;
  SM_NEWID_FAIL =102;
  SM_PASSWD_FAIL =103;
  SM_NEEDUPDATE_ACCOUNT =104;
  SM_UPDATEID_SUCCESS =105;
  SM_UPDATEID_FAIL =106;
  SM_PASSOK_SELECTSERVER = 107;
  SM_SELECTSERVER_OK =109;
  SM_QUERYCHR =111;
  SM_QUERYCHR_FAIL =112;
  SM_NEWCHR_SUCCESS  =113;
  SM_NEWCHR_FAIL =114;
  SM_CHGPASSWD_SUCCESS =115;
  SM_CHGPASSWD_FAIL =116;
  SM_DELCHR_SUCCESS =117;
  SM_DELCHR_FAIL =118;
  SM_STARTPLAY=119;
  SM_STARTFAIL =120;

  SM_VERSION_FAIL =121;
  SM_OUTOFCONNECTION =122;
  SM_RECONNECT =125;
  SM_SENDNOTICE =202;

  SM_MYSTATUS =131;
  SM_TIMECHECK_MSG = 227;

  SM_CHANGEMAP   =201;
  SM_AREASTATE = 228;
  SM_NEWMAP =223;
  SM_MAPDESCRIPTION = 229;
  SM_LOGON =224;

  SM_CHANGELIGHT =240;
  SM_LAMPCHANGEDURA=241;
  SM_LIGHTING =242;

  SM_OPENDOOR_OK=249;
  SM_OPENDOOR_LOCK=250;
  SM_CLOSEDOOR =251;

  SM_DEATH=260;
  SM_NOWDEATH =261;
  SM_SKELETON=262;
  SM_ALIVE =263;
  SM_ABILITY =264;
  SM_SUBABILITY=265;
  SM_DAYCHANGING=266;
  SM_WINEXP =267;
  SM_LEVELUP =268;
  SM_HEALTHSPELLCHANGED =269;
  SM_ADJUST_BONUS =280;

  SM_STRUCK =310;
  SM_CHANGEFACE=311;
  SM_OPENHEALTH=312;
  SM_CLOSEHEALTH =313;
  SM_INSTANCEHEALGUAGE=314;
  SM_BREAKWEAPON=315;

  //�Ի���Ϣ
  SM_CRY=316;
  SM_GROUPMESSAGE =347;
  SM_GUILDMESSAGE =348;
  SM_WHISPER=349;
  SM_HEAR=351;
  SM_SYSMESSAGE=390;

  SM_USERNAME =352;
  SM_CHANGENAMECOLOR=353;
  
  //�ƶ�����
  SM_TURN       =1001;
  SM_WALK       =1002;
  SM_SITDOWN    =1003;
  SM_RUN        =1004;
  SM_HIT        =1005;
  SM_POWERHIT   =1008;
  SM_LONGHIT    =1009;
  SM_WIDEHIT    =1010;
  SM_HEAVYHIT   =1011;
  SM_BIGHIT     =1012;
  SM_THROW      =1013;
  SM_FIREHIT    =1014;
  SM_SPELL      =1015;
  SM_BACKSTEP   =1021;
  SM_RUSH       =1022;
  SM_RUSHKUNG   =1023;

  SM_SPACEMOVE_HIDE =1041;
  SM_SPACEMOVE_HIDE2=1042;
  SM_SPACEMOVE_SHOW =1043;
  SM_SPACEMOVE_SHOW2=1044;
  SM_MOVEFAIL       =1045;
  SM_BUTCH          =1046;

  SM_FLYAXE         =1060;

  SM_MAGICFIRE      =1072;
  SM_MAGICFIRE_FAIL = 1073;

  SM_HIDE =1224;
  SM_GHOST=1225;
  SM_DISAPPEAR=1226;
  SM_DIGUP=1227;
  SM_DIGDOWN=1228;
  SM_SHOWEVENT =1229;
  SM_HIDEEVENT = 1230;

  SM_ADDITEM=2040;
  SM_BAGITEMS =2041;
  SM_UPDATEITEM=2042;
  SM_DELITEM =2043;
  SM_DELITEMS=2044;
  SM_DROPITEM_SUCCESS=2045;
  SM_DROPITEM_FAIL=2046;
  SM_ITEMSHOW=2047;
  SM_ITEMHIDE=2048;


  SM_TAKEON_OK=2052;
  SM_TAKEON_FAIL=2053;
  SM_TAKEOFF_OK=2054;
  SM_TAKEOFF_FAIL=2055;
  SM_EXCHGTAKEON_OK=2056;
  SM_EXCHGTAKEON_FAIL=2057;

  SM_SENDUSEITEMS=2058;
  SM_WEIGHTCHANGED=2059;
  SM_GOLDCHANGED=2060;
  SM_FEATURECHANGED=2061;
  SM_CHARSTATUSCHANGED=2062;
  SM_CLEAROBJECTS=2063;
  SM_EAT_OK=2064;
  SM_EAT_FAIL=2065;
  SM_ADDMAGIC=2066;
  SM_SENDMYMAGIC=2067;
  SM_DELMAGIC=2068;
  SM_MAGIC_LVEXP=2069;
  SM_DURACHANGE=2070;
  SM_MERCHANTSAY=2071;
  SM_MERCHANTDLGCLOSE=2072;

  SM_SENDGOODSLIST=2073;
  SM_SENDUSERMAKEDRUGITEMLIST=2074;
  SM_SENDUSERSELL=2075;
  SM_SENDUSERREPAIR=2076;
  SM_SENDBUYPRICE=2077;
  SM_USERSELLITEM_OK=2078;
  SM_USERSELLITEM_FAIL=2079;
  SM_SENDREPAIRCOST=2080;
  SM_USERREPAIRITEM_OK=2081;
  SM_USERREPAIRITEM_FAIL=2082;
  SM_STORAGE_OK=2083;
  SM_STORAGE_FULL=2084;
  SM_STORAGE_FAIL=2085;
  SM_SAVEITEMLIST=2086;

  SM_TAKEBACKSTORAGEITEM_OK=2087;
  SM_TAKEBACKSTORAGEITEM_FAIL=2088;
  SM_TAKEBACKSTORAGEITEM_FULLBAG=2089;

  SM_BUYITEM_SUCCESS=2090;
  SM_BUYITEM_FAIL=2091;

  SM_MAKEDRUG_SUCCESS=2092;
  SM_MAKEDRUG_FAIL=2093;

  SM_SENDDETAILGOODSLIST=2094;
  SM_TEST=2095;
  SM_GROUPMODECHANGED=2096;
  SM_CREATEGROUP_OK=2097;
  SM_CREATEGROUP_FAIL=2098;
  SM_GROUPADDMEM_OK=2099;
  SM_GROUPADDMEM_FAIL=2100;
  SM_GROUPDELMEM_OK=2101;
  SM_GROUPDELMEM_FAIL=2102;
  SM_GROUPCANCEL=2103;
  SM_GROUPMEMBERS=2104;

  SM_OPENGUILDDLG=2105;
  SM_SENDGUILDMEMBERLIST=2106;
  SM_OPENGUILDDLG_FAIL=2107;
  SM_CHANGEGUILDNAME=2124;
  SM_GUILDADDMEMBER_OK=2126;
  SM_GUILDADDMEMBER_FAIL=2127;
  SM_GUILDDELMEMBER_OK=2128;
  SM_GUILDDELMEMBER_FAIL=2129;
  SM_GUILDRANKUPDATE_FAIL=2130;
  SM_GUILDMAKEALLY_OK=2131;
  SM_GUILDMAKEALLY_FAIL=2132;
  SM_GUILDBREAKALLY_OK=2133;
  SM_GUILDBREAKALLY_FAIL=2134;

  SM_DEALTRY_FAIL=2108;
  SM_DEALMENU=2109;
  SM_DEALCANCEL=2110;
  SM_DEALADDITEM_OK=2111;
  SM_DEALADDITEM_FAIL=2112;
  SM_DEALDELITEM_OK=2113;
  SM_DEALDELITEM_FAIL=2114;
  SM_DEALREMOTEADDITEM=2115;
  SM_DEALREMOTEDELITEM=2116;
  SM_DEALCHGGOLD_OK=2117;
  SM_DEALCHGGOLD_FAIL=2118;
  SM_DEALREMOTECHGGOLD=2119;
  SM_DEALSUCCESS=2120;

  SM_SENDUSERSTORAGEITEM=2121;

  SM_READMINIMAP_OK=2122;
  SM_READMINIMAP_FAIL=2123;

  SM_SENDUSERSTATE=2125;

  SM_BUILDGUILD_OK=2135;
  SM_BUILDGUILD_FAIL=2136;
  SM_MENU_OK=2137;
  SM_DLGMSG=2138;
  SM_DONATE_OK=2139;
  SM_DONATE_FAIL=2140;

  SM_ACTION_MIN=2200;
  SM_ACTION_MAX=2499;
  SM_ACTION2_MIN=2500;
  SM_ACTION2_MAX=2999;

  RCC_MERCHANT  =1;
  RCC_GUARD     =2;

  VERSION_NUMBER_0522=522;

  DEFBLOCKSIZE =16;

  UNITX = 48;
  UNITY = 32;
  LOGICALMAPUNIT =20;
  HALFX = 24;
  HALFY = 16;

  ET_DIGOUTZOMBI =0;
  ET_PILESTONES = 1;
  ET_HOLYCURTAIN = 2;
  ET_FIRE= 3;
  ET_SCULPEICE = 4;

  STATE_STONE_MODE =0;
  STATE_OPENHEATH = 1;

  MAXBAGITEM = 52;

  DR_UP=0;
  DR_UPRIGHT =1;
  DR_RIGHT =2;
  DR_DOWNRIGHT =3;
  DR_DOWN =4;
  DR_DOWNLEFT =5;
  DR_LEFT =6;
  DR_UPLEFT =7;

type

  TDefaultMessage=packed record  //Size=12
    Ident :word;
    Recog :integer;  //ʶ����
    Param :smallint;
    Tag   :smallint;
    Series:smallint;
  end;
  //Ident=SM_DAYCHANGING
  //   Param=DayBright
  //   Tag=���Ũ�ȣ�0��1��2��3

  TUserInfo=Record
     Name:String[32];
     Looks:integer;
     StdMode:Integer;
     Shape:Integer;
  end;

  TStdItem=record
     Name:String[16];   //��Ʒ����
     Looks:integer;     //��ۣ���Items.WIL�е�ͼƬ����
     StdMode:integer;   //0/1/2/3��ҩ�� 5/6:������10/11�����ף�15��ͷ����22/23����ָ��24/26������19/20/21������
     Shape:integer;
     AC:Integer;
     MAC:integer;
     Weight:integer;
     DuraMax:integer;
     NeedIdentify:byte;
     DC,MC,SC:Integer;
     Source:integer;
     Need:integer;
     NeedLevel:integer;
  end;

  PTClientItem=^TClientItem;
  TClientItem=Record
     s:TStdItem;
     MakeIndex:Integer;
     Dura:Integer;
     DuraMax:Integer;
  end;

  TAbility= packed record
     MP,MaxMP:Integer;
     HP,MaxHP:integer;
     Exp,MaxExp:Integer;
     Level:Integer;
     Weight,MaxWeight:Integer;
     WearWeight,MaxWearWeight:Integer;
     HandWeight,MaxHandWeight:Integer;
     AC:Integer;
     MAC:Integer;
     DC:Integer;
     MC,SC:Integer;
  end;

  PTChrMsg=^TChrMsg;
  TChrMsg=Record
     Ident:integer;
     Dir:Integer;
     X,Y:Integer;
     State:integer;
     feature:integer;
     saying:string;
     Sound:integer;
  end;

  TUserStateInfo=Record
     UserName:String[32];
     GuildName:String[32];
     GuildRankName:String[32];
     NameColor:Integer;
     Feature:integer;
     UseItems:Array[0..127] of TClientItem;
  end;

  TUserCharacterInfo=Record
     Name:String;
     Job:byte;
     Hair:smallint;
     level:Integer;
     Sex:byte;
  end;

  TUserEntryInfo=Record
     LoginId:String[16];
     Password:String[16];
     UserName:String[32];
     SSNo:String[18];
     Quiz:String[32];
     Answer:String[32];
     Phone:String[15];
     EMail:String[64];
     
  end;

  TUserEntryAddInfo=Record
     Quiz2:String[32];
     Answer2:String[32];
     MobilePhone:String[15];
     BirthDay:String[16];
  end;

  PTDropItem=^TDropItem;
  TDropItem=record
     Id:Integer;
     X,Y:Integer;
     Looks:integer;
     FlashTime:LongInt;
     Name:String[16];
     BoFlash:Boolean;
     FlashStepTime:LongInt;
     FlashStep:Integer;
  end;

  TDef=Record
    Spell:integer;
    DefSpell:integer;
    EffectType:Integer;
    MagicId:Integer;
    Effect:Integer;
    DelayTime:Integer;
    MagicName:String[16];
    MaxTrain:Array [0..255] of integer;
  end;

  PTClientMagic=^TClientMagic;
  TClientMagic=Record
     Key:Char;
     Def:TDef;
     Level:Integer;
     CurTrain:Integer;
  end;

  TNakedAbility=Record
     DC,MC,SC,AC,MAC:Integer;
     HP,MP:Integer;
     Hit:integer;
     Speed:integer;
  end;

  TShortMessage=Record
     Ident:Integer;
  end;

  TMessageBodyW=Record
     Param1:integer;
     Param2:integer;
     Tag1:integer;
     Tag2:integer;
  end;

  TCharDesc=Record
     Feature:Integer;
     Status:Integer;
  end;

  TMessageBodyWL=Record
     lParam1,lParam2:longint;
     lTag1,lTag2:longint;
  end;

  PTClientGoods=^TClientGoods;
  TClientGoods=record
     Name:string[16];
     SubMenu:Integer;
     Price:Integer;
     Stock:integer;
     Grade:integer;
  end;

function  MakeDefaultMsg (msg:smallint; Recog:integer; param, tag, series:smallint):TDefaultMessage;
function  UpInt(i:double):integer;
Function  RACEfeature(Feature:word):smallint;
Function  HAIRfeature(Feature:word):byte;
Function  DRESSfeature(Feature:word):byte;
Function  APPRfeature(Feature:word):byte;
Function  WEAPONfeature(Feature:word):byte;
function  MakeFeature(Race:Word;Appr,Hair,Dress,Weapon:byte):Integer;
implementation

function  MakeDefaultMsg (msg:smallint; Recog:integer; param, tag, series:smallint):TDefaultMessage;
begin
    result.Ident:=Msg;
    result.Param:=Param;
    result.Tag:=Tag;
    result.Series:=Series;
    result.Recog:=Recog;
end;

function  UpInt(i:double):integer;
begin
  result:=Ceil(i);
end;

//����Feature���Եķֽ�ͺϳɣ���32λ����16λΪRace��Appr,
//   ��16λ�У�������λ��ʾHair,������6λ��ʾDress,����6λ��ʾWeapon��
//   ��Race=0ʱ,Dress mod 2 ��ʾ�Ա�
//   Race=0ʱ����Ҳ����Ů���е�����Ӧ����ż����Ů��������
//*******��Feature�Ľ��Ϳ����Լ����壬��Raceȡֵ����0..90��Appr:0..9
//*******Hair�����6�ַ��ͣ�3600��ͼƬ��ÿ600��ͼƬһ�ַ��ͣ�����Ů��3
//*******Dress������������Hum.WIL�б�ʾ���ж�����ͼƬ���ж����ַ�װ��Hum.WIL������չ
//*******Weapon��������Weapon.WIL���������ͼƬ��ͬ���ģ�ÿ600����Ӧһ��Appr������Ů
//*********����40800����Ӧ68����������Ů�ϼƣ�
Function  RACEfeature(Feature:word):smallint;
begin
  result:=Hiword(Feature) div 10;
end;

Function  HAIRfeature(Feature:word):byte;
begin
  result:=(LoWord(Feature) and $F000) shr 12 ;  //1111000000000000
end;

Function  DRESSfeature(Feature:word):byte;
begin
  result:=(LoWord(Feature) and $3F00) shr 7;    //0000111111000000
end;

Function  WEAPONfeature(Feature:word):byte;
begin
  result:=LoWord(Feature) and $3F;              //0000000000111111
end;

Function  APPRfeature(Feature:word):byte;
begin
  result:=hiword(Feature) mod 10;
end;

function  MakeFeature(Race:Word;Appr,Hair,Dress,Weapon:byte):Integer;
begin
  result:=MakeLong(((Hair And $0F)shl 12) + ((Dress And $3F) shl 6) + (Weapon And $3F) ,Race*10+Appr);
end;

end.
