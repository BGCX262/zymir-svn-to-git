//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit Share;

interface
uses
  Windows, Messages, SysUtils, StrUtils;

const
  RUNLOGINCODE = 0; //进入游戏状态码,默认为0 测试为 9

  STDCLIENT = 0;
  RMCLIENT = 99;
  CLIENTTYPE = STDCLIENT; //普通的为0 ,99 为管理客户端

  //RMCLIENTTITLE      = '晋升网络';    dfsdfd

  MAXLEFT2 = 10;
  MAXTOP2 = 8;

  DEBUG = 0;
  SWH800 = 0;
  SWH1024 = 1;
  SWH = SWH800;

  {VERDEF       = 0;
  //VERWOWUYU    = 1;     //我..无语
  VERBLUEYU    = 1;
  SOFTNEWVER   = VERDEF;     }

  ADOPEN = 0;    //是否开启广告
  ADCLOSE = 1;

  OPENFILL = 0; //是否允许窗口化
  CLOSEFILL = 1;

  OPENPROCESS = 0; //是否允许反外挂
  CLOSEPROCESS = 1;

  OEMVER   = 0; //无内挂定制客户端

  DEFVER = 0; //调试登录器
  VERDEMO = 1; //普通登录器
  BLUEVER = 2; //配置器登录器
  MONEYVER = 3; //绑定网站登录器

  TOOLVER =DEFVER;  //不同版本改这里就可以了

{$IF TOOLVER     = MONEYVER}
  SOFTADOPEN = ADCLOSE;
  WINDOFILL = OPENFILL;
  WINDOPROCESS =OPENPROCESS;
{$IFEND}

{$IF TOOLVER     = VERDEMO}
  SOFTADOPEN = ADOPEN;
  WINDOFILL = CLOSEFILL;
  WINDOPROCESS =CLOSEPROCESS;
{$IFEND}

{$IF TOOLVER     = DEFVER}
  SOFTADOPEN = ADOPEN;
  WINDOFILL = OPENFILL;
  WINDOPROCESS =CLOSEPROCESS;
{$IFEND}

{$IF TOOLVER     = MONEYVER}
  RSAMODEKEY =
    'ax1BfhHUFiJZXN3bhhx9e7gS4Nadiii1koSrxIwxt2GuWwKMliUGIbLArGDiZT9It65uKDufEeA0ii';
  PRIVATEKEY =
    'axw=fogrncy8IVL59bAwrlbYgSQ065EKUT9SK8yZaSpY0xcehhMpGrtPShtiVEZyhlwOOP1i9=trCi';
{$IFEND}
  {/  RSAMODEKEY  = 'RbONTm4hzTHRJDwsk6LxbkXXWg8FTneoPOcN7xS2xns2fBnjBka';
    PRIVATEKEY  = 'aRbhO6V6SvNX8LLlmZ62FslkU0wQ0kRkiQvtzjuOQaXTZA7lDD4m';
  {$IFEND}

    //VERWINDOFF   = 0;
    //VERWINDON    = 1;
    //VERWIND      = VERWINDOFF;   //记得修正内挂 g_WgClass:=wl.lTag2

  CUSTOMLIBFILE = 0; //自定义图库位置

{$IF SWH = SWH800}
  SCREENWIDTH = 800;
  SCREENHEIGHT = 600;
{$ELSEIF SWH = SWH1024}
  SCREENWIDTH = 1024;
  SCREENHEIGHT = 768;
{$IFEND}

  MAPSURFACEWIDTH = SCREENWIDTH;
  MAPSURFACEHEIGHT = SCREENHEIGHT - 155;

  WINLEFT = 60;
  WINTOP = 60;
  WINRIGHT = SCREENWIDTH - 60;
  BOTTOMEDGE = SCREENHEIGHT - 30; // Bottom WINBOTTOM

  MAPDIR = 'Map\'; //地图文件所在目录
  CONFIGFILE = 'Config\%s.ini';
  INIFileDir = '.\Config\';
  FriendListFile = 'Friend.txt';
  BlackListFile = 'HeiMingDan.txt';
  GameAssistantDir = 'Assistant.ini';
  ItemUntieDir = 'Untie.txt';
  JsDefInfo = '.\Config\JsDefInfo\';
  ItemFiltrateDir = 'Filtrate.txt';
  MonHintDir = 'MonHint.txt';
  SaveIniFileDir = '.\Config\%s_%s\';
{$IF CUSTOMLIBFILE = 1}
  EFFECTIMAGEDIR = 'Graphics\Effect\';
  MAINIMAGEFILE = 'Graphics\FrmMain\Main.wil';
  MAINIMAGEFILE2 = 'Graphics\FrmMain\Main2.wil';
  MAINIMAGEFILE3 = 'Graphics\FrmMain\Main3.wil';
{$ELSE}
  MAINIMAGEFILE = 'Data\Prguse.wil';
  MAINIMAGEFILE2 = 'Data\Prguse2.wil';
  MAINIMAGEFILE3 = 'Data\Prguse3.wil';
  MAINIMAGEFILE99 = 'Data\JS_Prguse.wil';
  EFFECTIMAGEDIR = 'Data\';
{$IFEND}

  HORSEEFFECT = 'Data\JS_Horse.wil';
  HORSEHAIR = 'Data\JS_HorseHair.wil';
  HORSEHUM = 'Data\JS_HorseHum.wil';
  ICONIMAGES = 'Data\JS_icon.wil';
  HELMET = 'Data\JS_Helmet.wil';

  CHRSELIMAGEFILE = 'Data\ChrSel.wil';
  MINMAPIMAGEFILE = 'Data\mmap.wil';
  MINMAPIMAGEFILE1 = 'Data\mmap%d.wil';
  TITLESIMAGEFILE = 'Data\Tiles.wil';
  SMLTITLESIMAGEFILE = 'Data\SmTiles.wil';
  HUMWINGIMAGESFILE = 'Data\HumEffect.wil';
  MAGICONIMAGESFILE = 'Data\MagIcon.wil';
  HUMIMGIMAGESFILE = 'Data\Hum.wil';
  HUMIMGIMAGESFILE1 = 'Data\Hum%d.wil';
  //HAIRIMGIMAGESFILE  = 'Data\Hair.wil';
  HAIR2IMGIMAGESFILE = 'Data\Hair2.wil';
  WEAPONIMAGESFILE = 'Data\Weapon.wil';
  WEAPONIMAGESFILE1 = 'Data\Weapon%d.wil';
  NPCIMAGESFILE = 'Data\Npc.wil';
  NPCIMAGESFILE1 = 'Data\Npc%d.wil';
  MAGICIMAGESFILE = 'Data\Magic.wil';
  MAGIC2IMAGESFILE = 'Data\Magic2.wil';
  MAGIC3IMAGESFILE = 'Data\Magic3.wil';
  MAGIC4IMAGESFILE = 'Data\Magic4.wil';
  MAGIC5IMAGESFILE = 'Data\Magic5.wil';
  MAGIC6IMAGESFILE = 'Data\Magic6.wil';
  //EVENTEFFECTIMAGESFILE = EFFECTIMAGEDIR + 'Event.wil';
  BAGITEMIMAGESFILE = 'Data\Items.wil';
  BAGITEMIMAGESFILE1 = 'Data\Items%d.wil';
  STATEITEMIMAGESFILE = 'Data\StateItem.wil';
  STATEITEMIMAGESFILE1 = 'Data\StateItem%d.wil';
  DNITEMIMAGESFILE = 'Data\DnItems.wil';
  DNITEMIMAGESFILE1 = 'Data\DnItems%d.wil';
  OBJECTIMAGEFILE = 'Data\Objects.wil';
  OBJECTIMAGEFILE1 = 'Data\Objects%d.wil';
  MONIMAGEFILE = 'Data\Mon%d.wil';
  DRAGONIMAGEFILE = 'Data\Dragon.wil';
  EFFECTIMAGEFILE = 'Data\Effect.wil';

  //MONIMAGEFILEEX      = 'Data\Mon%d.wil';
  //MONPMFILE           = 'Data\Mon%d.pm';
  //MONIMAGEFILEEX      = 'Graphics\Monster\%d.wil';
  //MONPMFILE           = 'Graphics\Monster\%d.pm';

  {
  MAXX = 40;
  MAXY = 40;
  }
  MAXX = SCREENWIDTH div 20;
  MAXY = SCREENWIDTH div 20;

  DEFAULTCURSOR = 0; //系统默认光标
  IMAGECURSOR = 1; //图形光标

  USECURSOR = DEFAULTCURSOR; //使用什么类型的光标

  MAXBAGITEMCL = 49;
  MAXFONT = 8;
  ENEMYCOLOR = 69;

procedure SendGameCenterMsg(nHandle, wIdent: Integer; sSendMsg: string);

var
  boEDCode: Boolean = False;
  boRSACode: Boolean = False;
  boEDcodeIp:Boolean=False;
  boSend: Boolean = False;
  boGetProcess: Boolean = False;
  sEDcodeKey:String='';

    //g_ClearWg  :String = 'aKMiknYsNiS=E=WmaJ7vHAO3rxUq0wx3S2bpXEiai+SvnN4wqDPB';{'WindowsForms10.Window.8.app'}
    //g_ClearWg2  :String = 'aJGvoiWRQm+nWN9FwyG9dmWt69k';

implementation

procedure SendGameCenterMsg(nHandle, wIdent: Integer; sSendMsg: string);
var
  SendData: TCopyDataStruct;
begin
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(nHandle, WM_COPYDATA, wIdent, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

end.

