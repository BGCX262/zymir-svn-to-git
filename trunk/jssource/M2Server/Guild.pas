//CHECK
//不要删除上一句注释，该注释为检查该文件是否已被自动增加异常处理
unit Guild;

interface
uses
  Windows, SysUtils, Classes, IniFiles, ObjBase;
type
  TGuildRank = record
    nRankNo: Integer;
    sRankName: string;
    MemberList: TStringList;
  end;
  pTGuildRank = ^TGuildRank;
  TWarGuild = record
    Guild: TObject;
    dwWarTick: LongWord;
    dwWarTime: LongWord;
  end;
  pTWarGuild = ^TWarGuild;
  TGuild = class
    sGuildName: string; //0x04
    NoticeList: TStringList; //0x08
    GuildWarList: TStringList; //0x0C
    GuildAllList: TStringList; //0x10
    m_RankList: TList; //0x14 职位列表
    nContestPoint: integer; //0x18
    boTeamFight: Boolean; //0x1C;
    //    MatchPoint   :Integer;
    TeamFightDeadList: TStringList; //0x20
    m_boEnableAuthAlly: Boolean; //0x24
    dwSaveTick: LongWord; //0x28
    boChanged: Boolean; //0x2C;
    m_DynamicVarList: TList;
  private
    m_Config: TIniFile;
    m_nBuildPoint: Integer; //建筑度
    m_nAurae: Integer; //人气度
    m_nStability: Integer; //安定度
    m_nFlourishing: Integer; //繁荣度
    m_nChiefItemCount: Integer; //行会领取装备数量
    m_nGuildFountain:Integer;//行会泉水量
    m_bGuildFountainOpen:Boolean;//行会泉水仓库是否打开

    function SetGuildInfo(sChief: string): Boolean;
    procedure ClearRank();
    procedure SaveGuildFile(sFileName: string);
    procedure SaveGuildConfig(sFileName: string);
    function GetMemberCount(): Integer;
    function GetMemgerIsFull(): Boolean;
    procedure SetAuraePoint(nPoint: Integer);
    procedure SetBuildPoint(nPoint: Integer);
    procedure SetStabilityPoint(nPoint: Integer);
    procedure SetFlourishPoint(nPoint: Integer);
    procedure SetGuildFountain(nPoint: Integer); //设置行会泉水量
    procedure SetGuildFountainOpen(nPoint: Boolean);//设置是否打开行会泉水仓库
    procedure SetChiefItemCount(nPoint: Integer);
  public
    constructor Create(sName: string);
    destructor Destroy; override;
    procedure SaveGuildInfoFile();
    function LoadGuild(): Boolean;
    function LoadGuildFile(sGuildFileName: string): Boolean;
    function LoadGuildConfig(sGuildFileName: string): Boolean;
    procedure UpdateGuildFile;
    procedure CheckSaveGuildFile;
    function IsMember(sName: string): Boolean;
    function IsAllyGuild(Guild: TGuild): Boolean;
    function IsWarGuild(Guild: TGuild): Boolean;
    function DelAllyGuild(Guild: TGuild): Boolean;
    procedure TeamFightWhoDead(sName: string);
    procedure TeamFightWhoWinPoint(sName: string; nPoint: Integer);
    procedure SendGuildMsg(sMsg: string);
    procedure RefMemberName();
    function GetRankName(PlayObject: TPlayObject; var nRankNo: integer): string;
    function DelMember(sHumName: string): Boolean;
    function UpdateRank(sRankData: string): Integer;
    function CancelGuld(sHumName: string): Boolean;
    function IsNotWarGuild(Guild: TGuild): Boolean;
    function AllyGuild(Guild: TGuild): Boolean;

    function AddMember(PlayObject: TPlayObject): Boolean;
    procedure DelHumanObj(PlayObject: TPlayObject);
    function GetChiefName(): string;
    procedure BackupGuildFile();
    procedure sub_499B4C(Guild: TGuild);
    function AddWarGuild(Guild: TGuild): pTWarGuild;
    procedure StartTeamFight();
    procedure EndTeamFight();
    procedure AddTeamFightMember(sHumanName: string);
    property Count: Integer read GetMemberCount;
    property IsFull: Boolean read GetMemgerIsFull;
    property nBuildPoint: Integer read m_nBuildPoint write SetBuildPoint;
    property nAurae: Integer read m_nAurae write SetAuraePoint;
    property nStability: Integer read m_nStability write SetStabilityPoint;
    property nFlourishing: Integer read m_nFlourishing write SetFlourishPoint;
    property nGuildFountain: Integer read m_nGuildFountain write SetGuildFountain;
    property bGuildFountainOpen: Boolean read m_bGuildFountainOpen write SetGuildFountainOpen;
    property nChiefItemCount: Integer read m_nChiefItemCount write
      SetChiefItemCount;
  end;
  TGuildManager = class
    GuildList: TList; //0x4
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadGuildInfo();
    procedure SaveGuildList();
    function MemberOfGuild(sName: string): TGuild;
    function AddGuild(sGuildName, sChief: string): Boolean;
    function FindGuild(sGuildName: string): TGuild;
    function DelGuild(sGuildName: string): Boolean;
    procedure ClearGuildInf();
    procedure Run();
  end;
implementation

uses M2Share, HUtil32, Grobal2;

{ TGuildManager }

function TGuildManager.AddGuild(sGuildName, sChief: string): Boolean; //0049A4A4
var
  Guild: TGuild;
begin
  try
    Result := False;
    if CheckGuildName(sGuildName) and (FindGuild(sGuildName) = nil) then
    begin
      Guild := TGuild.Create(sGuildName);
      Guild.SetGuildInfo(sChief);
      GuildList.Add(Guild);
      SaveGuildList();
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TGuildManager.AddGuild');
  end;
end;

function TGuildManager.DelGuild(sGuildName: string): Boolean; //0049A550
var
  I: Integer;
  Guild: TGuild;
begin
  try
    Result := False;
    for i := 0 to GuildList.Count - 1 do
    begin
      Guild := TGuild(GuildList.Items[I]);
      if CompareText(Guild.sGuildName, sGuildName) = 0 then
      begin
        if Guild.m_RankList.Count > 1 then
          break;
        Guild.BackupGuildFile();
        GuildList.Delete(I);
        SaveGuildList();
        Result := True;
        Break;
      end;
    end;
  except
    MainOutMessage('[Exception] TGuildManager.DelGuild');
  end;
end;

procedure TGuildManager.ClearGuildInf; //0049A02C
var
  I: Integer;
begin
  try
    for I := 0 to GuildList.Count - 1 do
    begin
      TGuild(GuildList.Items[I]).Free;
    end;
    GuildList.Clear;
  except
    MainOutMessage('[Exception] TGuildManager.ClearGuildInf');
  end;
end;

constructor TGuildManager.Create;
begin
  try
    GuildList := TList.Create;
  except
    MainOutMessage('[Exception] TGuildManager.Create');
  end;
end;

destructor TGuildManager.Destroy;
begin
  try
    GuildList.Free;
    inherited;
  except
    MainOutMessage('[Exception] TGuildManager.Destroy');
  end;
end;

function TGuildManager.FindGuild(sGuildName: string): TGuild; //0049A36C
var
  i: Integer;
begin
  try
    Result := nil;
    for i := 0 to GuildList.Count - 1 do
    begin
      if TGuild(GuildList.Items[i]).sGuildName = sGuildName then
      begin
        Result := TGuild(GuildList.Items[i]);
        Break;
      end;
    end;
  except
    MainOutMessage('[Exception] TGuildManager.FindGuild');
  end;
end;

procedure TGuildManager.LoadGuildInfo; //0049A078
var
  LoadList: TStringList;
  Guild: TGuild;
  sGuildName: string;
  i: integer;
begin
  try
    if FileExists(g_Config.sGuildFile) then
    begin
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(g_Config.sGuildFile);
      for i := 0 to LoadList.Count - 1 do
      begin
        sGuildName := Trim(LoadList.Strings[i]);
        if sGuildName <> '' then
        begin
          Guild := TGuild.Create(sGuildName);
          GuildList.Add(Guild);
        end;
      end;
      LoadList.Free;
      for i := GuildList.Count - 1 downto 0 do
      begin
        Guild := GuildList.Items[i];
        if not Guild.LoadGuild() then
        begin
          MainOutMessage('加载行会 ' + Guild.sGuildName + ' 失败...');
          Guild.Free;
          GuildList.Delete(i);
          SaveGuildList();
        end;
      end;
      MainOutMessage('已读取 ' + IntToStr(GuildList.Count) +
        '个行会信息...');
    end
    else
    begin
      MainOutMessage('加载行会信息错误！！！');
    end;

  except
    MainOutMessage('[Exception] TGuildManager.LoadGuildInfo');
  end;
end;

function TGuildManager.MemberOfGuild(sName: string): TGuild;
//0049A408
var
  i: Integer;
begin
  try
    Result := nil;
    for i := 0 to GuildList.Count - 1 do
    begin
      if TGuild(GuildList.Items[i]).IsMember(sName) then
      begin
        Result := TGuild(GuildList.Items[i]);
        Break;
      end;
    end;
  except
    MainOutMessage('[Exception] TGuildManager.MemberOfGuild');
  end;
end;

procedure TGuildManager.SaveGuildList; //0049A260
var
  I: Integer;
  SaveList: TStringList;
begin
  try
    if nServerIndex <> 0 then
      exit;
    SaveList := TStringList.Create;
    for I := 0 to GuildList.Count - 1 do
    begin
      SaveList.Add(TGuild(GuildList.Items[I]).sGuildName);
    end; // for
    try
      SaveList.SaveToFile(g_Config.sGuildFile);
    except
      MainOutMessage('Save Guild Error');
    end;
    SaveList.Free;
  except
    MainOutMessage('[Exception] TGuildManager.SaveGuildList');
  end;
end;

procedure TGuildManager.Run; //0049A61C
var
  I: Integer;
  II: Integer;
  Guild: TGuild;
  boChanged: Boolean;
  WarGuild: pTWarGuild;
begin
  try
    try
      for I := 0 to GuildList.Count - 1 do
      begin
        Guild := TGuild(GuildList.Items[I]);
        boChanged := False;
        for II := Guild.GuildWarList.Count - 1 downto 0 do
        begin
          WarGuild := pTWarGuild(Guild.GuildWarList.Objects[II]);
          if (GetTickCount - WarGuild.dwWarTick) > WarGuild.dwWarTime then
          begin
            Guild.sub_499B4C(TGuild(WarGuild.Guild));
            Guild.GuildWarList.Delete(II);
            Dispose(WarGuild);
            boChanged := True;
          end;
        end;

        if boChanged then
        begin
          Guild.UpdateGuildFile();
        end;
        Guild.CheckSaveGuildFile;
      end;
    except
      MainOutMessage('[Exception] TGuildManager.Run');
    end;
  except
    MainOutMessage('[Exception] TGuildManager.Run');
  end;
end;

{ TGuild }

procedure TGuild.ClearRank; //00497C78
var
  I: Integer;
  GuildRank: pTGuildRank;
begin
  try
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end; // for
    m_RankList.Clear;
  except
    MainOutMessage('[Exception] TGuild.ClearRank');
  end;
end;

constructor TGuild.Create(sName: string); //00497B04
var
  sFileName: string;
begin
  try
    sGuildName := sName;
    NoticeList := TStringList.Create;
    GuildWarList := TStringList.Create;
    GuildAllList := TStringList.Create;
    m_RankList := TList.Create;
    TeamFightDeadList := TStringList.Create;
    dwSaveTick := 0;
    boChanged := False;
    nContestPoint := 0;
    boTeamFight := False;
    m_boEnableAuthAlly := False;

    sFileName := g_Config.sGuildDir + sName + '.ini';
    m_Config := TIniFile.Create(sFileName);
    if not FileExists(sFileName) then
    begin
      m_Config.WriteString('Guild', 'GuildName', sName);
    end;

    m_nBuildPoint := 0;
    m_nAurae := 0;
    m_nStability := 0;
    m_nFlourishing := 0;
    m_nGuildFountain:=0;
    m_bGuildFountainOpen:=False;
    m_nChiefItemCount := 0;
    m_DynamicVarList := TList.Create;
  except
    MainOutMessage('[Exception] TGuild.Create');
  end;
end;

function TGuild.DelAllyGuild(Guild: TGuild): Boolean; //00499CEC
var
  I: Integer;
  AllyGuild: TGuild;
begin
  try
    Result := False;
    for I := 0 to GuildAllList.Count - 1 do
    begin
      AllyGuild := TGuild(GuildAllList.Objects[I]);
      if AllyGuild = Guild then
      begin
        GuildAllList.Delete(I);
        Result := True;
        break;
      end;
    end; // for
    SaveGuildInfoFile();
  except
    MainOutMessage('[Exception] TGuild.DelAllyGuild');
  end;
end;

destructor TGuild.Destroy; //00497C08
var
  I: Integer;
begin
  try
    NoticeList.Free;
    GuildWarList.Free;
    GuildAllList.Free;
    ClearRank();
    m_RankList.Free;
    TeamFightDeadList.Free;
    m_Config.Free;
    for I := 0 to m_DynamicVarList.Count - 1 do
    begin
      Dispose(pTDynamicVar(m_DynamicVarList.Items[I]));
    end;
    m_DynamicVarList.Free;
    inherited;
  except
    MainOutMessage('[Exception] TGuild.Destroy');
  end;
end;

function TGuild.IsAllyGuild(Guild: TGuild): Boolean; //00499BD8
var
  I: Integer;
  AllyGuild: TGuild;
begin
  try
    Result := False;
    for I := 0 to GuildAllList.Count - 1 do
    begin
      AllyGuild := TGuild(GuildAllList.Objects[I]);
      if AllyGuild = Guild then
      begin
        Result := True;
        break;
      end;
    end;
  except
    MainOutMessage('[Exception] TGuild.IsAllyGuild');
  end;
end;

function TGuild.IsMember(sName: string): Boolean; //00498714
var
  i, II: integer;
  GuildRank: pTGuildRank;
begin
  try
    Result := False;
    for i := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[i];
      for II := 0 to GuildRank.MemberList.Count - 1 do
      begin
        if GuildRank.MemberList.Strings[II] = sName then
        begin
          Result := True;
          exit;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TGuild.IsMember');
  end;
end;

function TGuild.IsWarGuild(Guild: TGuild): Boolean; //00499924
var
  I: Integer;
begin
  try
    Result := False;
    for I := 0 to GuildWarList.Count - 1 do
    begin
      if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then
      begin
        Result := True;
        break;
      end;
    end; // for
  except
    MainOutMessage('[Exception] TGuild.IsWarGuild');
  end;
end;

function TGuild.LoadGuild(): Boolean; //00497CE4
var
  sFileName: string;
begin
  try
    sFileName := sGuildName + '.txt';
    Result := LoadGuildFile(sFileName);
    LoadGuildConfig(sGuildName + '.ini');
  except
    MainOutMessage('[Exception] TGuild.LoadGuild');
  end;
end;

function TGuild.LoadGuildConfig(sGuildFileName: string): Boolean;
begin
  try
    m_nBuildPoint := m_Config.ReadInteger('Guild', 'BuildPoint', m_nBuildPoint);
    m_nAurae := m_Config.ReadInteger('Guild', 'Aurae', m_nAurae);
    m_nStability := m_Config.ReadInteger('Guild', 'Stability', m_nStability);
    m_nFlourishing := m_Config.ReadInteger('Guild', 'Flourishing',
      m_nFlourishing);
    m_nChiefItemCount := m_Config.ReadInteger('Guild', 'ChiefItemCount',
      m_nChiefItemCount);
    m_nGuildFountain:=m_Config.ReadInteger('Guild', 'GuildFountain',m_nGuildFountain);
    m_bGuildFountainOpen:=m_Config.ReadBool('Guild', 'GuildFountainOpen',m_bGuildFountainOpen);
    Result := True;
  except
    MainOutMessage('[Exception] TGuild.LoadGuildConfig');
  end;
end;

function TGuild.LoadGuildFile(sGuildFileName: string): Boolean; //00497D58
var
  I: Integer;
  LoadList: TStringList;
  s18, s1C, s20, s24, sFileName: string;
  n28, n2C: Integer;
  GuildWar: pTWarGuild;
  GuildRank: pTGuildRank;
  Guild: TGuild;
begin
  try
    Result := False;
    GuildRank := nil;
    sFileName := g_Config.sGuildDir + sGuildFileName;
    if not FileExists(sFileName) then
      exit;
    ClearRank();
    NoticeList.Clear;
    for I := 0 to GuildWarList.Count - 1 do
    begin
      Dispose(pTWarGuild(GuildWarList.Objects[I]));
    end; // for
    GuildWarList.Clear;
    GuildAllList.Clear;
    n28 := 0;
    n2C := 0;
    s24 := '';
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do
    begin
      s18 := LoadList.Strings[I];
      if (s18 = '') or (s18[1] = ';') then
        Continue;
      if s18[1] <> '+' then
      begin
        if s18 = g_Config.sGuildNotice then
          n28 := 1;
        if s18 = g_Config.sGuildWar then
          n28 := 2;
        if s18 = g_Config.sGuildAll then
          n28 := 3;
        if s18 = g_Config.sGuildMember then
          n28 := 4;
        if s18[1] = '#' then
        begin
          s18 := Copy(s18, 2, Length(s18) - 1);
          s18 := GetValidStr3(s18, s1C, [' ', ',']);
          n2C := Str_ToInt(s1C, 0);
          s24 := Trim(s18);
          GuildRank := nil;
        end;
        Continue;
      end; //00497F68
      s18 := Copy(s18, 2, Length(s18) - 1);
      case n28 of //
        1: NoticeList.Add(s18);
        2:
          begin
            while (s18 <> '') do
            begin
              s18 := GetValidStr3(s18, s1C, [' ', ',']);
              if s1C = '' then
                break;
              New(GuildWar);
              GuildWar.Guild := g_GuildManager.FindGuild(s1C);
              if GuildWar.Guild <> nil then
              begin
                GuildWar.dwWarTick := GetTickcount();
                GuildWar.dwWarTime := Str_ToInt(Trim(s20), 0);
                GuildWarList.AddObject(TGuild(GuildWar.Guild).sGuildName,
                  TObject(GuildWar));
              end
              else
              begin
                Dispose(GuildWar);
              end;
            end;
          end;
        3:
          begin
            while (s18 <> '') do
            begin
              s18 := GetValidStr3(s18, s1C, [' ', ',']);
              s18 := GetValidStr3(s18, s20, [' ', ',']);
              if s1C = '' then
                break;
              Guild := g_GuildManager.FindGuild(s1C);
              if Guild <> nil then
                GuildAllList.AddObject(s1C, Guild);
            end;
          end;
        4:
          begin
            if (n2C > 0) and (s24 <> '') then
            begin
              if length(s24) > 30 then //Jacky 限制职倍的长度
                s24 := Copy(s24, 1, g_Config.nGuildRankNameLen {30});

              if GuildRank = nil then
              begin
                New(GuildRank);
                GuildRank.nRankNo := n2C;
                GuildRank.sRankName := s24;
                GuildRank.MemberList := TStringList.Create;
                m_RankList.Add(GuildRank);
              end;
              while (s18 <> '') do
              begin
                s18 := GetValidStr3(s18, s1C, [' ', ',']);
                if s1C = '' then
                  break;
                GuildRank.MemberList.Add(s1C);
              end;
            end;
          end;
      end; // case
    end;
    LoadList.Free;
    Result := True;
  except
    MainOutMessage('[Exception] TGuild.LoadGuildFile');
  end;
end;

procedure TGuild.RefMemberName; //00498F60
var
  I, II: Integer;
  GuildRank: pTGuildRank;
  BaseObject: TBaseObject;
begin
  try
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      for II := 0 to GuildRank.MemberList.Count - 1 do
      begin
        BaseObject := TBaseObject(GuildRank.MemberList.Objects[II]);
        if BaseObject <> nil then
          BaseObject.RefShowName;
      end;
    end;
  except
    MainOutMessage('[Exception] TGuild.RefMemberName');
  end;
end;

procedure TGuild.SaveGuildInfoFile; //004985EC
begin
  try
    if nServerIndex = 0 then
    begin
      SaveGuildFile(g_Config.sGuildDir + sGuildName + '.txt');
      SaveGuildConfig(g_Config.sGuildDir + sGuildName + '.ini');
    end
    else
    begin
      SaveGuildFile(g_Config.sGuildDir + sGuildName + '.' +
        IntToStr(nServerIndex));
    end;
  except
    MainOutMessage('[Exception] TGuild.SaveGuildInfoFile');
  end;
end;

procedure TGuild.SaveGuildConfig(sFileName: string);
begin
  try
    m_Config.WriteString('Guild', 'GuildName', sGuildName);
    m_Config.WriteInteger('Guild', 'BuildPoint', m_nBuildPoint);
    m_Config.WriteInteger('Guild', 'Aurae', m_nAurae);
    m_Config.WriteInteger('Guild', 'Stability', m_nStability);
    m_Config.WriteInteger('Guild', 'Flourishing', m_nFlourishing);
    m_Config.WriteInteger('Guild', 'ChiefItemCount', m_nChiefItemCount);
    m_Config.WriteInteger('Guild', 'GuildFountain', m_nGuildFountain);
    m_Config.WriteBool('Guild', 'GuildFountainOpen', m_bGuildFountainOpen);
  except
    MainOutMessage('[Exception] TGuild.SaveGuildConfig');
  end;
end;

procedure TGuild.SaveGuildFile(sFileName: string);
var
  SaveList: TStringList;
  I, II: Integer;
  WarGuild: pTWarGuild;
  GuildRank: pTGuildRank;
  n14: Integer;
begin
  try
    SaveList := TStringList.Create;
    SaveList.Add(g_Config.sGuildNotice);
    for I := 0 to NoticeList.Count - 1 do
    begin
      SaveList.Add('+' + NoticeList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildWar);
    for I := 0 to GuildWarList.Count - 1 do
    begin
      WarGuild := pTWarGuild(GuildWarList.Objects[I]);
      n14 := WarGuild.dwWarTime - (GetTickCount - WarGuild.dwWarTick);
      if n14 <= 0 then
        Continue;
      SaveList.Add('+' + GuildWarList.Strings[I] + ' ' + IntToStr(n14));
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildAll);
    for I := 0 to GuildAllList.Count - 1 do
    begin
      SaveList.Add('+' + GuildAllList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildMember);
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      SaveList.Add('#' + IntToStr(GuildRank.nRankNo) + ' ' +
        GuildRank.sRankName);
      for II := 0 to GuildRank.MemberList.Count - 1 do
      begin
        SaveList.Add('+' + GuildRank.MemberList.Strings[II]);
      end;
    end;
    try
      SaveList.SaveToFile(sFileName);
    except
      MainOutMessage('保存行会信息失败！！！ ' + sFileName);
    end;
    SaveList.Free;
  except
    MainOutMessage('[Exception] TGuild.SaveGuildFile');
  end;
end;

procedure TGuild.SendGuildMsg(sMsg: string); //00498FF0
var
  I: Integer;
  II: Integer;
  GuildRank: pTGuildRank;
  BaseObject: TBaseObject;
  nCheckCode: Integer;
begin
  try
    nCheckCode := 0;
    try
      if g_Config.boShowPreFixMsg then
        sMsg := g_Config.sGuildMsgPreFix + sMsg;
      if m_RankList = nil then
        exit;
      nCheckCode := 1;
      for I := 0 to m_RankList.Count - 1 do
      begin
        GuildRank := m_RankList.Items[I];
        nCheckCode := 2;
        if GuildRank.MemberList = nil then
          Continue;
        for II := 0 to GuildRank.MemberList.Count - 1 do
        begin
          nCheckCode := 3;
          BaseObject := TBaseObject(GuildRank.MemberList.Objects[II]);
          if BaseObject = nil then
            Continue;
          nCheckCode := 4;
          if BaseObject.m_boBanGuildChat then
          begin
            nCheckCode := 5;
            BaseObject.SendMsg(BaseObject, RM_GUILDMESSAGE, 0,
              g_Config.btGuildMsgFColor, g_Config.btGuildMsgBColor, 0, sMsg);
            nCheckCode := 6;
          end;
        end;
      end;
      (*
      TGuild.SendGuildMsg CheckCode: 5 GuildName = 〖統治〗 Msg = 〖行会〗釢fěη﹖: 换的玩撒
    2004-12-2 15:45:48 Access violation at address 0041FD64 in module 'M2Server.exe'. Read of address 00000008
      *);
    except
      on e: Exception do
      begin
        MainOutMessage('[Exceptiion] TGuild.SendGuildMsg CheckCode: ' +
          IntToStr(nCheckCode) + ' GuildName = ' + sGuildName + ' Msg = ' +
            sMsg);
        MainOutMessage(E.Message);
      end;
    end;
  except
    MainOutMessage('[Exception] TGuild.SendGuildMsg');
  end;
end;


function TGuild.SetGuildInfo(sChief: string): Boolean; //00498984
var
  GuildRank: pTGuildRank;
begin
  try
    if m_RankList.Count = 0 then
    begin
      New(GuildRank);
      GuildRank.nRankNo := 1;
      GuildRank.sRankName := g_Config.sGuildChief;
      GuildRank.MemberList := TStringList.Create;
      GuildRank.MemberList.Add(sChief);
      m_RankList.Add(GuildRank);
      SaveGuildInfoFile();
    end;
    Result := True;
  except
    MainOutMessage('[Exception] TGuild.SetGuildInfo');
  end;
end;

function TGuild.GetRankName(PlayObject: TPlayObject; var nRankNo: integer):
  string; //004987F0
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  try
    Result := '';
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      for II := 0 to GuildRank.MemberList.Count - 1 do
      begin
        if GuildRank.MemberList.Strings[II] = PlayObject.m_sCharName then
        begin
          GuildRank.MemberList.Objects[II] := PlayObject;
          nRankNo := GuildRank.nRankNo;
          Result := GuildRank.sRankName;
          //PlayObject.RefShowName();
          PlayObject.SendMsg(PlayObject, RM_CHANGEGUILDNAME, 0, 0, 0, 0, '');
          exit;
        end;
      end; // for
    end;
  except
    MainOutMessage('[Exception] TGuild.GetRankName');
  end;
end;

function TGuild.GetChiefName: string; //00498928
var
  GuildRank: pTGuildRank;
begin
  try
    Result := '';
    if m_RankList.Count <= 0 then
      exit;
    GuildRank := m_RankList.Items[0];
    if GuildRank.MemberList.Count <= 0 then
      exit;
    Result := GuildRank.MemberList.Strings[0];
  except
    MainOutMessage('[Exception] TGuild.GetChiefName:');
  end;
end;

procedure TGuild.CheckSaveGuildFile();
begin
  try
    if boChanged and ((GetTickCount - dwSaveTick) > 30 * 1000) then
    begin
      boChanged := False;
      SaveGuildInfoFile();
    end;
  except
    MainOutMessage('[Exception] TGuild.CheckSaveGuildFile');
  end;
end;

procedure TGuild.DelHumanObj(PlayObject: TPlayObject); //00498ECC
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  try
    CheckSaveGuildFile();
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      for II := 0 to GuildRank.MemberList.Count - 1 do
      begin
        if TPlayObject(GuildRank.MemberList.Objects[II]) = PlayObject then
        begin
          GuildRank.MemberList.Objects[II] := nil;
          exit;
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TGuild.DelHumanObj');
  end;
end;

procedure TGuild.TeamFightWhoDead(sName: string); //00499EC8
var
  I, n10: Integer;
begin
  try
    if not boTeamFight then
      exit;
    for I := 0 to TeamFightDeadList.Count - 1 do
    begin
      if TeamFightDeadList.Strings[I] = sName then
      begin
        n10 := Integer(TeamFightDeadList.Objects[I]);
        TeamFightDeadList.Objects[I] := TObject(MakeLong(LoWord(n10) + 1,
          HiWord(n10)));
      end;
    end;
  except
    MainOutMessage('[Exception] TGuild.TeamFightWhoDead');
  end;
end;

procedure TGuild.TeamFightWhoWinPoint(sName: string; nPoint: Integer); //00499DE4
var
  I, n14: Integer;
begin
  try
    if not boTeamFight then
      exit;
    Inc(nContestPoint, nPoint);
    for I := 0 to TeamFightDeadList.Count - 1 do
    begin
      if TeamFightDeadList.Strings[I] = sName then
      begin
        n14 := Integer(TeamFightDeadList.Objects[I]);
        TeamFightDeadList.Objects[I] := TObject(MakeLong(LoWord(n14), HiWord(n14)
          + nPoint));
      end;
    end;
  except
    MainOutMessage('[Exception] TGuild.TeamFightWhoWinPoint');
  end;
end;

procedure TGuild.UpdateGuildFile();
begin
  try
    boChanged := True;
    dwSaveTick := GetTickCount();
    SaveGuildInfoFile();
  except
    MainOutMessage('[Exception] TGuild.UpdateGuildFile');
  end;
end;

procedure TGuild.BackupGuildFile; //00498AFC
var
  I, II: Integer;
  PlayObject: TPlayObject;
  GuildRank: pTGuildRank;
begin
  try
    if nServerIndex = 0 then
      SaveGuildFile(g_Config.sGuildDir + sGuildName + '.' +
        IntToStr(GetTickCount) + '.bak');
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      for II := 0 to GuildRank.MemberList.Count - 1 do
      begin
        PlayObject := TPlayObject(GuildRank.MemberList.Objects[II]);
        if PlayObject <> nil then
        begin
          PlayObject.m_MyGuild := nil;
          PlayObject.RefRankInfo(0, '');
          PlayObject.RefShowName(); //10/31
        end;
      end;
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end;
    m_RankList.Clear;
    NoticeList.Clear;
    for I := 0 to GuildWarList.Count - 1 do
    begin
      Dispose(pTWarGuild(GuildWarList.Objects[I]));
    end;
    GuildWarList.Clear;
    GuildAllList.Clear;
    SaveGuildInfoFile();
  except
    MainOutMessage('[Exception] TGuild.BackupGuildFile');
  end;
end;

function TGuild.AddMember(PlayObject: TPlayObject): Boolean; //00498CA8
var
  I: Integer;
  GuildRank: pTGuildRank;
  GuildRank18: pTGuildRank;
begin
  try
    Result := False;
    GuildRank18 := nil;
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.nRankNo = 99 then
      begin
        GuildRank18 := GuildRank;
        break;
      end;
    end;
    if GuildRank18 = nil then
    begin
      New(GuildRank18);
      GuildRank18.nRankNo := 99;
      GuildRank18.sRankName := g_Config.sGuildMemberRank;
      GuildRank18.MemberList := TStringList.Create;
      m_RankList.Add(GuildRank18);
    end;
    GuildRank18.MemberList.AddObject(PlayObject.m_sCharName,
      TObject(PlayObject));
    UpdateGuildFile();
    Result := True;
  except
    MainOutMessage('[Exception] TGuild.AddMember');
  end;
end;

function TGuild.DelMember(sHumName: string): Boolean; //00498DCC
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  try
    Result := False;
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      for II := 0 to GuildRank.MemberList.Count - 1 do
      begin
        if GuildRank.MemberList.Strings[II] = sHumName then
        begin
          GuildRank.MemberList.Delete(II);
          Result := True;
          break;
        end;
      end;
      if Result then
        break;
    end;
    if Result then
      UpdateGuildFile;

  except
    MainOutMessage('[Exception] TGuild.DelMember');
  end;
end;

function TGuild.CancelGuld(sHumName: string): Boolean; //00498A50
var
  GuildRank: pTGuildRank;
begin
  try
    Result := False;
    if m_RankList.Count <> 1 then
      exit;
    GuildRank := m_RankList.Items[0];
    if GuildRank.MemberList.Count <> 1 then
      exit;
    if GuildRank.MemberList.Strings[0] = sHumName then
    begin
      BackupGuildFile();
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TGuild.CancelGuld');
  end;
end;

function TGuild.UpdateRank(sRankData: string): Integer; //00499140
  procedure ClearRankList(var RankList: TList); //004990DC
  var
    I: Integer;
    GuildRank: pTGuildRank;
  begin
    for I := 0 to RankList.Count - 1 do
    begin
      GuildRank := RankList.Items[I];
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end;
    RankList.Free;
  end;
var
  I: Integer;
  II: Integer;
  III: Integer;
  GuildRankList: TList;
  GuildRank: pTGuildRank;
  NewGuildRank: pTGuildRank;
  sRankInfo: string;
  sRankNo: string;
  sRankName: string;
  sMemberName: string;
  n28: Integer;
  n2C: Integer;
  n30: Integer;
  boCheckChange: Boolean;
  PlayObject: TPlayObject;
begin
  try
    Result := -1;
    GuildRankList := TList.Create;
    GuildRank := nil;
    while (True) do
    begin
      if sRankData = '' then
        break;
      sRankData := GetValidStr3(sRankData, sRankInfo, [#$0D]);
      sRankInfo := Trim(sRankInfo);
      if sRankInfo = '' then
        Continue;
      if sRankInfo[1] = '#' then
      begin //取得职称的名称
        sRankInfo := Copy(sRankInfo, 2, Length(sRankInfo) - 1);
        sRankInfo := GetValidStr3(sRankInfo, sRankNo, [' ', '<']);
        sRankInfo := GetValidStr3(sRankInfo, sRankName, ['<', '>']);
        if length(sRankName) > 30 then //Jacky 限制职倍的长度
          sRankName := Copy(sRankName, 1, 30);
        if GuildRank <> nil then
        begin
          GuildRankList.Add(GuildRank);
        end;
        New(GuildRank);
        GuildRank.nRankNo := Str_ToInt(sRankNo, 99);
        GuildRank.sRankName := Trim(sRankName);
        GuildRank.MemberList := TStringList.Create;
        Continue;
      end;

      if GuildRank = nil then
        Continue;
      I := 0;
      while (True) do
      begin //将成员名称加入职称表里
        if sRankInfo = '' then
          break;
        sRankInfo := GetValidStr3(sRankInfo, sMemberName, [' ', ',']);
        if sMemberName <> '' then
          GuildRank.MemberList.Add(sMemberName);
        Inc(I);
        if I >= 10 then
          break;
      end;
    end;

    if GuildRank <> nil then
    begin
      GuildRankList.Add(GuildRank);
    end;

    //0049931F  校验成员列表是否有改变，如果未修改则退出
    if m_RankList.Count = GuildRankList.Count then
    begin
      boCheckChange := True;
      for I := 0 to m_RankList.Count - 1 do
      begin
        GuildRank := m_RankList.Items[I];
        NewGuildRank := GuildRankList.Items[I];
        if (GuildRank.nRankNo = NewGuildRank.nRankNo) and
          (GuildRank.sRankName = NewGuildRank.sRankName) and
          (GuildRank.MemberList.Count = NewGuildRank.MemberList.Count) then
        begin
          for II := 0 to GuildRank.MemberList.Count - 1 do
          begin
            if GuildRank.MemberList.Strings[II] <>
              NewGuildRank.MemberList.Strings[II] then
            begin
              boCheckChange := False; //如果有改变则将其置为FALSE
              break;
            end;
          end;
        end
        else
        begin
          boCheckChange := False;
          break;
        end;
      end;
      if boCheckChange then
      begin
        Result := -1; //$FFFFFFFF
        ClearRankList(GuildRankList);
        exit;
      end;
    end;

    //0049943D 检查行会掌门职业是否为空
    Result := -2; //$FFFFFFFE
    if (GuildRankList.Count > 0) then
    begin
      GuildRank := GuildRankList.Items[0];
      if GuildRank.nRankNo = 1 then
      begin
        if GuildRank.sRankName <> '' then
        begin
          Result := 0;
        end
        else
        begin
          Result := -3; //$FFFFFFFD
        end;
      end;
    end;

    //检查行会掌门人是否在线(？？？)
    if Result = 0 then
    begin //0049947A
      GuildRank := GuildRankList.Items[0];
      if GuildRank.MemberList.Count <= 2 then
      begin
        n28 := GuildRank.MemberList.Count;
        for I := 0 to GuildRank.MemberList.Count - 1 do
        begin
          if UserEngine.GetPlayObject(GuildRank.MemberList.Strings[I]) = nil
            then
          begin
            Dec(n28);
            break;
          end;
        end;
        if n28 <= 0 then
          Result := -5; //$FFFFFFFB
      end
      else
      begin
        Result := -4; //$FFFFFFFC
      end;
    end;

    if Result = 0 then
    begin //00499517
      n2C := 0;
      n30 := 0;
      for I := 0 to m_RankList.Count - 1 do
      begin
        GuildRank := m_RankList.Items[I];
        boCheckChange := True;
        for II := 0 to GuildRank.MemberList.Count - 1 do
        begin
          boCheckChange := False;
          sMemberName := GuildRank.MemberList.Strings[II];
          Inc(n2C);
          for III := 0 to GuildRankList.Count - 1 do
          begin //搜索新列表
            NewGuildRank := GuildRankList.Items[III];
            for n28 := 0 to NewGuildRank.MemberList.Count - 1 do
            begin
              if NewGuildRank.MemberList.Strings[n28] = sMemberName then
              begin
                boCheckChange := True;
                break;
              end;
            end;
            if boCheckChange then
              break;
          end;

          if not boCheckChange then
          begin //原列表中的人物名称是否在新的列表中
            Result := -6; //$FFFFFFFA
            break;
          end;
        end;
        if not boCheckChange then
          break;
      end;

      //00499640
      for I := 0 to GuildRankList.Count - 1 do
      begin
        GuildRank := GuildRankList.Items[I];
        boCheckChange := True;
        for II := 0 to GuildRank.MemberList.Count - 1 do
        begin
          boCheckChange := False;
          sMemberName := GuildRank.MemberList.Strings[II];
          Inc(n30);
          for III := 0 to GuildRankList.Count - 1 do
          begin
            NewGuildRank := GuildRankList.Items[III];
            for n28 := 0 to NewGuildRank.MemberList.Count - 1 do
            begin
              if NewGuildRank.MemberList.Strings[n28] = sMemberName then
              begin
                boCheckChange := True;
                break;
              end;
            end;
            if boCheckChange then
              break;
          end;
          if not boCheckChange then
          begin
            Result := -6; //$FFFFFFFA
            break;
          end;
        end;
        if not boCheckChange then
          break;
      end;
      if (Result = 0) and (n2C <> n30) then
      begin
        Result := -6;
      end;
    end; //0049976A

    if Result = 0 then
    begin //检查职位号是否重复及非法
      for I := 0 to GuildRankList.Count - 1 do
      begin
        n28 := pTGuildRank(GuildRankList.Items[I]).nRankNo;
        for III := I + 1 to GuildRankList.Count - 1 do
        begin
          if (pTGuildRank(GuildRankList.Items[III]).nRankNo = n28) or (n28 <= 0)
            or (n28 > 99) then
          begin
            Result := -7; //$FFFFFFF9
            break;
          end;
        end;
        if Result <> 0 then
          break;
      end;
    end; //004997E9

    if Result = 0 then
    begin
      ClearRankList(m_RankList);
      m_RankList := GuildRankList;
      //更新在线人物职位表
      for I := 0 to m_RankList.Count - 1 do
      begin
        GuildRank := m_RankList.Items[I];
        for III := 0 to GuildRank.MemberList.Count - 1 do
        begin
          PlayObject :=
            UserEngine.GetPlayObject(GuildRank.MemberList.Strings[III]);
          if PlayObject <> nil then
          begin
            GuildRank.MemberList.Objects[III] := TObject(PlayObject);
            PlayObject.RefRankInfo(GuildRank.nRankNo, GuildRank.sRankName);
            PlayObject.RefShowName(); //10/31
          end;
        end;
      end;
      UpdateGuildFile();
    end
    else
    begin //004998C3
      ClearRankList(GuildRankList);
    end;
  except
    MainOutMessage('[Exception] TGuild.UpdateRank');
  end;
end;

function TGuild.IsNotWarGuild(Guild: TGuild): Boolean; //00499C98
var
  I: Integer;
begin
  try
    Result := False;
    for I := 0 to GuildWarList.Count - 1 do
    begin
      if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then
      begin
        exit;
      end;
    end;
    Result := True;
  except
    MainOutMessage('[Exception] TGuild.IsNotWarGuild');
  end;
end;

function TGuild.AllyGuild(Guild: TGuild): Boolean; //00499C2C
var
  I: Integer;
begin
  try
    Result := False;
    for I := 0 to GuildAllList.Count - 1 do
    begin
      if GuildAllList.Objects[I] = Guild then
      begin
        exit;
      end;
    end;
    GuildAllList.AddObject(Guild.sGuildName, Guild);
    SaveGuildInfoFile();
    Result := True;
  except
    MainOutMessage('[Exception] TGuild.AllyGuild');
  end;
end;

function TGuild.AddWarGuild(Guild: TGuild): pTWarGuild;
var
  I: Integer;
  WarGuild: pTWarGuild;
begin
  try
    Result := nil;
    if Guild <> nil then
    begin
      if not IsAllyGuild(Guild) then
      begin
        WarGuild := nil;
        for I := 0 to GuildWarList.Count - 1 do
        begin
          if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then
          begin
            WarGuild := pTWarGuild(GuildWarList.Objects[I]);
            WarGuild.dwWarTick := GetTickCount();
            WarGuild.dwWarTime := g_Config.dwGuildWarTime {10800000};
            SendGuildMsg('与[' + Guild.sGuildName +
              ']行会战争延长3小时.');
            break;
          end;
        end;
        if WarGuild = nil then
        begin
          New(WarGuild);
          WarGuild.Guild := Guild;
          WarGuild.dwWarTick := GetTickCount();
          WarGuild.dwWarTime := g_Config.dwGuildWarTime {10800000};
          GuildWarList.AddObject(Guild.sGuildName, TObject(WarGuild));
          SendGuildMsg('与[' + Guild.sGuildName +
            ']行会战争开始(3小时).');
        end;
        Result := WarGuild;
      end;
    end;
    RefMemberName();
    UpdateGuildFile();

  except
    MainOutMessage('[Exception] TGuild.AddWarGuild');
  end;
end;

procedure TGuild.sub_499B4C(Guild: TGuild); //00499B4C
begin
  try
    SendGuildMsg('与[' + Guild.sGuildName + ']行会战争结束.');
  except
    MainOutMessage('[Exception] TGuild.sub_499B4C');
  end;
end;

function TGuild.GetMemberCount: Integer;
var
  I: Integer;
  GuildRank: pTGuildRank;
begin
  try
    Result := 0;
    for I := 0 to m_RankList.Count - 1 do
    begin
      GuildRank := m_RankList.Items[I];
      Inc(Result, GuildRank.MemberList.Count);
    end;
  except
    MainOutMessage('[Exception] TGuild.GetMemberCount:');
  end;
end;

function TGuild.GetMemgerIsFull: Boolean;
begin
  try
    Result := False;
    if GetMemberCount >= g_Config.nGuildMemberMaxLimit then
    begin
      Result := True;
    end;
  except
    MainOutMessage('[Exception] TGuild.GetMemgerIsFull:');
  end;
end;

procedure TGuild.StartTeamFight;
begin
  try
    nContestPoint := 0;
    boTeamFight := True;
    TeamFightDeadList.Clear;
  except
    MainOutMessage('[Exception] TGuild.StartTeamFight');
  end;
end;

procedure TGuild.EndTeamFight;
begin
  try
    boTeamFight := False;
  except
    MainOutMessage('[Exception] TGuild.EndTeamFight');
  end;
end;

procedure TGuild.AddTeamFightMember(sHumanName: string);
begin
  try
    TeamFightDeadList.Add(sHumanName);
  except
    MainOutMessage('[Exception] TGuild.AddTeamFightMember');
  end;
end;

procedure TGuild.SetAuraePoint(nPoint: Integer);
begin
  try
    m_nAurae := nPoint;
    boChanged := True;
  except
    MainOutMessage('[Exception] TGuild.SetAuraePoint');
  end;
end;

procedure TGuild.SetBuildPoint(nPoint: Integer);
begin
  try
    m_nBuildPoint := nPoint;
    boChanged := True;
  except
    MainOutMessage('[Exception] TGuild.SetBuildPoint');
  end;
end;

procedure TGuild.SetFlourishPoint(nPoint: Integer);
begin
  try
    m_nFlourishing := nPoint;
    boChanged := True;
  except
    MainOutMessage('[Exception] TGuild.SetFlourishPoint');
  end;
end;

procedure TGuild.SetGuildFountain(nPoint: Integer);
begin
   try
    m_nGuildFountain := nPoint;
    boChanged := True;
  except
    MainOutMessage('[Exception] TGuild.SetGuildFountain');
  end;
end;


procedure TGuild.SetGuildFountainOpen(nPoint: Boolean);
begin
     try
    m_bGuildFountainOpen := nPoint;
    boChanged := True;
  except
    MainOutMessage('[Exception] TGuild.SetGuildFountainOpen');
  end;
end;

procedure TGuild.SetStabilityPoint(nPoint: Integer);
begin
  try
    m_nStability := nPoint;
    boChanged := True;
  except
    MainOutMessage('[Exception] TGuild.SetStabilityPoint');
  end;
end;

procedure TGuild.SetChiefItemCount(nPoint: Integer);
begin
  try
    m_nChiefItemCount := nPoint;
    boChanged := True;
  except
    MainOutMessage('[Exception] TGuild.SetChiefItemCount');
  end;
end;

end.

