//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit Share;

interface
uses
  Windows, Messages, SysUtils, StrUtils;

const
  RUNLOGINCODE = 0; //������Ϸ״̬��,Ĭ��Ϊ0 ����Ϊ 9

  STDCLIENT = 0;
  RMCLIENT = 99;
  CLIENTTYPE = STDCLIENT; //��ͨ��Ϊ0 ,99 Ϊ����ͻ���

  //RMCLIENTTITLE      = '��������';    dfsdfd

  MAXLEFT2 = 10;
  MAXTOP2 = 8;

  DEBUG = 0;
  SWH800 = 0;
  SWH1024 = 1;
  SWH = SWH800;

  {VERDEF       = 0;
  //VERWOWUYU    = 1;     //��..����
  VERBLUEYU    = 1;
  SOFTNEWVER   = VERDEF;     }

  ADOPEN = 0;    //�Ƿ������
  ADCLOSE = 1;

  OPENFILL = 0; //�Ƿ������ڻ�
  CLOSEFILL = 1;

  OPENPROCESS = 0; //�Ƿ��������
  CLOSEPROCESS = 1;

  OEMVER   = 0; //���ڹҶ��ƿͻ���

  DEFVER = 0; //���Ե�¼��
  VERDEMO = 1; //��ͨ��¼��
  BLUEVER = 2; //��������¼��
  MONEYVER = 3; //����վ��¼��

  TOOLVER =DEFVER;  //��ͬ�汾������Ϳ�����

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
    //VERWIND      = VERWINDOFF;   //�ǵ������ڹ� g_WgClass:=wl.lTag2

  CUSTOMLIBFILE = 0; //�Զ���ͼ��λ��

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

  MAPDIR = 'Map\'; //��ͼ�ļ�����Ŀ¼
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

  DEFAULTCURSOR = 0; //ϵͳĬ�Ϲ��
  IMAGECURSOR = 1; //ͼ�ι��

  USECURSOR = DEFAULTCURSOR; //ʹ��ʲô���͵Ĺ��

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

