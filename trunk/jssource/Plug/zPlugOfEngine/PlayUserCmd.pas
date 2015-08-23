unit PlayUserCmd;

interface
uses
  Windows,Classes,SysUtils, EngineAPI,EngineType;
  procedure InitPlayUserCmd();
  procedure UnInitPlayUserCmd();
  procedure LoadUserCmdList();
  function  PlayUserCommand(PlayObject:TObject;pszCmd,pszParam1,pszParam2,pszParam3,pszParam4,pszParam5,pszParam6,pszParam7:PChar):Boolean;stdcall;
  function  ProcessUserCmd(PlayObject:TObject;pszCmd,pszParam1,pszParam2,pszParam3,pszParam4,pszParam5,pszParam6,pszParam7:PChar):Boolean;
  procedure CmdReLoadUserCmdList(PlayObject:TObject);
  procedure CmdWho(PlayObject:TObject);
  procedure CmdReCallPlay(PlayObject:TObject;pszCmd,pszPlayName:PChar);
  procedure CmdReLoadCheckItemList(PlayObject:TObject;pszCmd:PChar);
var
  OldUserCmd:_TOBJECTUSERCMD;
implementation

uses PlugShare, HUtil32, PlayUser;
procedure InitPlayUserCmd();
begin
  OldUserCmd:=TPlayObject_GetHookUserCmd();
  TPlayObject_SetHookUserCmd(PlayUserCommand);
  g_UserCmdList:=Classes.TStringList.Create();
  LoadUserCmdList();
end;
procedure UnInitPlayUserCmd();
begin
  TPlayObject_SetHookUserCmd(OldUserCmd);
  g_UserCmdList.Free;
end;
procedure LoadUserCmdList();
var
  I             :Integer;
  sFileName     :String;
  LoadList      :Classes.TStringList;
  sLineText     :String;
  sUserCmd      :String;
  sCmdNo        :String;
  nCmdNo        :Integer;
begin
  sFileName:='.\UserCmd.txt';
  if not FileExists(sFileName) then
  begin
    LoadList:=Classes.TStringList.Create();
    LoadList.Add(';引擎插件配置文件');
    LoadList.Add(';命令名称'#9'对应编号');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    exit;
  end;
  g_UserCmdList.Clear;
  LoadList:=Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do
  begin
    sLineText:=LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then
    begin
      sLineText:=GetValidStr3(sLineText,sUserCmd,[' ',#9]);
      sLineText:=GetValidStr3(sLineText,sCmdNo,[' ',#9]);
      nCmdNo:=Str_ToInt(sCmdNo,-1);
      if (sUserCmd <> '') and (nCmdNo >= 0) then
      begin
        g_UserCmdList.AddObject(sUserCmd,TObject(nCmdNo));
      end;
    end;
  end;
  LoadList.Free;
end;
//处理游戏命令
//此函数在主程序内置游戏命令处理前调用
//返回值，True/False
//True  则主程序不再往下匹配其它命令退出函数
//False 则说明游戏命令未处理，主程序继续匹配其它命令
function  PlayUserCommand(PlayObject:TObject;pszCmd,pszParam1,pszParam2,pszParam3,pszParam4,pszParam5,pszParam6,pszParam7:PChar):Boolean;stdcall;
begin
  Result:=ProcessUserCmd(PlayObject, pszCmd,pszParam1,pszParam2,pszParam3,pszParam4,pszParam5,pszParam6,pszParam7);
  if Result then exit;

  if StrIComp(pszCmd,'reloadusercmd') = 0 then
  begin
    CmdReLoadUserCmdList(PlayObject);
    Result:=True;
  end else
  if StrIComp(pszCmd,'who') = 0 then
  begin
    CmdWho(PlayObject);
    Result:=True;
  end else
  if StrIComp(pszCmd,'recallplay') = 0 then
  begin
    CmdReCallPlay(PlayObject,pszCmd,pszParam1);
    Result:=True;
  end else
  if StrIComp(pszCmd,'reloadcheckitem') = 0 then
  begin
    CmdReLoadCheckItemList(PlayObject,pszCmd);
    Result:=True;
  end;

  if not Result and Assigned(OldUserCmd) then begin
    //调用下一个游戏命令处理插件
    Result:=OldUserCmd(PlayObject, pszCmd,pszParam1,pszParam2,pszParam3,pszParam4,pszParam5,pszParam6,pszParam7);
  end;
      
end;

function  ProcessUserCmd(PlayObject:TObject;pszCmd,pszParam1,pszParam2,pszParam3,pszParam4,pszParam5,pszParam6,pszParam7:PChar):Boolean;
var
  I: Integer;
  sLable:String;
  FunctionNPC:TNormNpc;
begin
  Result:=False;
  for I := 0 to g_UserCmdList.Count - 1 do
  begin
    if CompareText(pszCmd,g_UserCmdList.Strings[I]) = 0 then
    begin
      FunctionNPC:=TNormNpc_GetFunctionNpc();
      if FunctionNPC = nil then break;
      sLable:='@UserCmd'+IntToStr(Integer(g_UserCmdList.Objects[I]));
      TNormNpc_GotoLable(FunctionNPC,PlayObject,PChar(sLable));
      Result:=True;
      break;
    end;
  end;
end;
procedure CmdReLoadUserCmdList(PlayObject:TObject);
ResourceString
  sFormatText = '您没有权限使用此命令！！！';
  sFormatText1 = '自定义游戏命令加载完成...';
var
  btPermission:PByte;
begin
  btPermission:=TBaseObject_btPermission(PlayObject);
  if btPermission^ < 10 then
  begin
    TBaseObject_SysMsg(PlayObject,PChar(sFormatText),mc_Red,mt_Hint);
    exit;
  end;
  LoadUserCmdList();
  TBaseObject_SysMsg(PlayObject,PChar(sFormatText1),mc_Green,mt_Hint);
end;

procedure CmdWho(PlayObject:TObject);
ResourceString
  sFormatText = '在线用户数:%d';
  sFormatText1 = '您没有权限使用此命令！！！';
var
  nUserCount:Integer;
  sUserCountMsg:String;
  btPermission:PByte;
begin
  btPermission:=TBaseObject_btPermission(PlayObject);
  if btPermission^ < 10 then
  begin
    TBaseObject_SysMsg(PlayObject,PChar(sFormatText1),mc_Red,mt_Hint);
    exit;
  end;
  nUserCount:=TUserEngine_GetPlayObjectCount();
  sUserCountMsg:=format(sFormatText,[nUserCount]);
  TBaseObject_SysMsg(PlayObject,PChar(sUserCountMsg),mc_Blue,mt_Hint);
end;

procedure CmdReCallPlay(PlayObject:TObject;pszCmd,pszPlayName:PChar);
ResourceString
  sFormatText  = '命令格式不正确！！！';
  sFormatText1 = '命令格式:%s 人物名称';
  sFormatText2 = '%s 不在线！！！';
  sFormatText3 = '召唤失败！！！';
  sFormatText4 = '您没有权限使用此命令！！！';
var
  nX,nY,nRecallX,nRecallY:Integer;
  ReCallPlayObject:TPlayObject;
  sMsg:String;
  SString:_LPTSHORTSTRING;
  szMapName:array[0..256] of Char;
  btPermission:PByte;
begin
  btPermission:=TBaseObject_btPermission(PlayObject);
  if btPermission^ < 10 then begin
    TBaseObject_SysMsg(PlayObject,PChar(sFormatText4),mc_Red,mt_Hint);
    exit;
  end;
  if strlen(pszPlayName) = 0 then begin
    TBaseObject_SysMsg(PlayObject,PChar(sFormatText),mc_Red,mt_Hint);
    sMsg:=format(sFormatText1,[pszCmd]);
    TBaseObject_SysMsg(PlayObject,PChar(sMsg),mc_Red,mt_Hint);
    exit;
  end;    
  ReCallPlayObject:=TUserEngine_GetPlayObject(pszPlayName,True);
  if ReCallPlayObject = nil then begin
    sMsg:=format(sFormatText2,[pszPlayName]);
    TBaseObject_SysMsg(PlayObject,PChar(sMsg),mc_Red,mt_Hint);
    exit;
  end;
  if not TBaseObject_GetFrontPosition(PlayObject,nX,nY) then begin
    TBaseObject_SysMsg(PlayObject,PChar(sFormatText3),mc_Red,mt_Hint);
    exit;
  end;
  if TBaseObject_GetRecallXY(PlayObject,nX,nY,3,nRecallX,nRecallY) then begin
    SString:=TBaseObject_sMapName(PlayObject);
    ShortStringToPChar(SString,szMapName);
    TBaseObject_SpaceMove(ReCallPlayObject,szMapName,nRecallX,nRecallY,0);
  end else  TBaseObject_SysMsg(PlayObject,PChar(sFormatText3),mc_Red,mt_Hint);
end;
procedure CmdReLoadCheckItemList(PlayObject:TObject;pszCmd:PChar);
ResourceString
  sFormatText = '禁止物品列表加载完成...';
  sFormatText1 = '您没有权限使用此命令！！！';
var
  btPermission:PByte;
begin
  btPermission:=TBaseObject_btPermission(PlayObject);
  if btPermission^ < 10 then begin
    TBaseObject_SysMsg(PlayObject,PChar(sFormatText1),mc_Red,mt_Hint);
    exit;
  end;
  LoadCheckItemList();
  TBaseObject_SysMsg(PlayObject,PChar(sFormatText),mc_Green,mt_Hint);
end;
end.
