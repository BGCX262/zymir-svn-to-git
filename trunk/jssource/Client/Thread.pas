unit Thread;

interface

uses
  Classes;

type
  TMusicThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation
uses ClMain;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TMusicThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TMusicThread }

procedure TMusicThread.Execute;
begin
  { Place thread code here }
end;

end.
 