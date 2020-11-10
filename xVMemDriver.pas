unit xVMemDriver;

{$mode Delphi}

interface
uses
  Classes, contnrs;

type

  PObject = ^TObject;

  { TPtrList }

  TPtrList=class
  private
    MaxCount: integer; // Полная емкость списка
    Count: integer; // присвоенная емкость
    PtrList: array of pointer;
  public
    constructor Create(AMaxCount: integer);
    function AddXObj(Obj: TObject): pointer;
    destructor Destroy; override;
  end;

var
  MemList: TPtrList;

implementation
uses
  LCL, SysUtils;

{ TPtrList }

function TPtrList.AddXObj(Obj: TObject): pointer;
begin
  if Obj=nil then exit;
  {if Count=MaxCount then
  begin
    CheckListForNil;
    if NilCount=0 then
      raise Exception.Create('X Memory pool overflow');
  end;}
  inc(Count);
  PtrList[Count-1] := Obj;
  result := @PtrList[Count-1];
end;

constructor TPtrList.Create(AMaxCount: integer);
begin
  SetLength(PtrList,AMaxCount);
  MaxCount := AMaxCount;
  Count := 0;
end;

destructor TPtrList.Destroy;
var
  i: integer;
  Item: TObject;
begin
  for i:=0 to count-1 do
  begin
    Item := TObject(PtrList[i]);
    if (Item<>nil) and (Item is TObject) then
      FreeAndNil(Item);
  end;
  inherited;
end;

initialization
  MemList := TPtrList.Create(1000);
finalization
  FreeAndNil(MemList);

end.
