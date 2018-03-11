unit jsontest_controller;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcgi, fpjson, HTTPDefs, fastplaz_handler, database_lib;

type
  TJsontestModule = class(TMyCustomWebModule)
  private
  public
    constructor CreateNew(AOwner: TComponent; CreateMode: integer); override;
    destructor Destroy; override;

    procedure Get; override;
    procedure Post; override;
  end;

implementation

uses common, json_lib;

constructor TJsontestModule.CreateNew(AOwner: TComponent; CreateMode: integer);
begin
  inherited CreateNew(AOwner, CreateMode);
end;

destructor TJsontestModule.Destroy;
begin
  inherited Destroy;
end;

// GET Method Handler
procedure TJsontestModule.Get;
var
  json : TJSONUtil;
begin
  json := TJSONUtil.Create;

  json['code'] := Int16(0);
  json['variable'] := 'value';
  json['msg/nama'] := 'Alfian';
  json['msg/alamat'] := 'Gunungsari';
  //---
  Response.ContentType := 'application/json';
  Response.Content := json.AsJSONFormated;
  json.Free;
end;

// POST Method Handler
procedure TJsontestModule.Post;
begin
  Response.Content := '';
end;




initialization
  // -> http://yourdomainname/jsontest
  // The following line should be moved to a file "routes.pas"
  Route.Add('jsontest', TJsontestModule);

end.

