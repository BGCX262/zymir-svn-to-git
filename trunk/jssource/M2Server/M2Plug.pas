//CHECK
//��Ҫɾ����һ��ע�ͣ���ע��Ϊ�����ļ��Ƿ��ѱ��Զ������쳣����
unit M2Plug;

interface

const
  M2DLL_PLUGNAME = 'M2Server.dll';

function M2Dll_Init(nVer: Integer): Boolean; stdcall;
procedure M2Dll_UnInit(); stdcall;
procedure M2Dll_Initialize(var nCheck: Integer); stdcall;

implementation

function M2Dll_Init; external M2DLL_PLUGNAME name 'M2Server_Init';
procedure M2Dll_UnInit; external M2DLL_PLUGNAME name 'M2Server_UnInit';
procedure M2Dll_Initialize; external M2DLL_PLUGNAME name 'M2Server_Initialize';

end.

