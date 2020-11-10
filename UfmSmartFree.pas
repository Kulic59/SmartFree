unit UfmSmartFree;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ObjSamples,
  xVMemDriver;

type

  { TfmSmartFree }

  TfmSmartFree = class(TForm)
    bnCreate: TButton;
    bnFreeStrObj: TButton;
    bnPrint: TButton;
    bnFreeIntObj: TButton;
    bnPrintObjX: TButton;
    edIntObj: TEdit;
    edStrObj: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    memPrint: TMemo;
    procedure bnCreateClick(Sender: TObject);
    procedure bnFreeIntObjClick(Sender: TObject);
    procedure bnFreeStrObjClick(Sender: TObject);
    procedure bnPrintClick(Sender: TObject);
    procedure bnPrintObjXClick(Sender: TObject);
  private
    xIntObj: PIntObj;
    xStrObj: PStrObj;
    xObjX: PObjX;
  public

  end;

var
  fmSmartFree: TfmSmartFree;

implementation

{$R *.lfm}

{ TfmSmartFree }

procedure TfmSmartFree.bnCreateClick(Sender: TObject);
begin
  xIntObj := MemList.AddXObj(TIntObj.Create(StrToInt(edIntObj.Text)));
  xStrObj := MemList.AddXObj(TStrObj.Create(edStrObj.Text));
  xObjX := MemList.AddXObj(TObjX.Create);
  xObjX.xIntObj := xIntObj;
  xObjX.xStrObj := xStrObj;
end;

procedure TfmSmartFree.bnFreeIntObjClick(Sender: TObject);
begin
  FreeAndNil(xIntObj^);
end;

procedure TfmSmartFree.bnFreeStrObjClick(Sender: TObject);
begin
  FreeAndNil(xStrObj^);
end;

procedure TfmSmartFree.bnPrintClick(Sender: TObject);
begin
  try
    memPrint.Clear;
    xIntObj^.Print(memPrint.Lines);
    xStrObj^.Print(memPrint.Lines);
    xObjX^.Print(memPrint.Lines);
  except
    on E:exception do
      ShowException(E,ExceptAddr);
  end;
end;

procedure TfmSmartFree.bnPrintObjXClick(Sender: TObject);
begin
  try
    xObjX^.Print(memPrint.Lines);
  except
    on E:exception do
      ShowException(E,ExceptAddr);
  end;
end;

end.

