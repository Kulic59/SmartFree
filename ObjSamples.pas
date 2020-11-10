unit ObjSamples;

{$mode Delphi}

interface

uses
  Classes, SysUtils;

type
  TSampleObj = class(TObject)
  public
    procedure Print( List: TStrings); virtual; abstract;
  end;

  { TIntObj }

  PIntObj = ^TIntObj;
  TIntObj = class(TSampleObj)
  public
    Value: integer;
    constructor Create(AValue: integer);
    procedure Print( List: TStrings); override;
  end;

  { TStrObj }

  PStrObj = ^TStrObj;
  TStrObj = class(TSampleObj)
  public
    Value: string;
    constructor Create(AValue: string);
    procedure BeforeDestruction; override;
    procedure Print( List: TStrings); override;
  end;

  { TObjX }

  PObjX = ^TObjX;
  TObjX = class(TSampleObj)
  public
    xStrObj: PStrObj;
    xIntObj: PIntObj;
    procedure Print( List: TStrings); override;
  end;


implementation

{ TStrObj }

constructor TStrObj.Create(AValue: string);
begin
  Value := AValue;
end;

procedure TStrObj.BeforeDestruction;
begin
  inherited;
  Value := '';
end;

procedure TStrObj.Print(List: TStrings);
begin
  List.Add( 'StrObj.Value='+Value);
end;

{ TIntObj }

constructor TIntObj.Create(AValue: integer);
begin
  Value := AValue;
end;

procedure TIntObj.Print(List: TStrings);
begin
  List.Add( 'IntObj.Value='+IntToStr(Value));
end;

{ TObjX }


procedure TObjX.Print(List: TStrings);
begin
  List.Add('TObjX start print');
  xIntObj^.Print(List);
  xStrObj^.Print(List);
  List.Add('TObjX end print');
end;

end.

