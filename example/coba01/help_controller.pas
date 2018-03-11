unit help_controller;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, html_lib, fpcgi, HTTPDefs, fastplaz_handler, database_lib;

type
  THelpModule = class(TMyCustomWebModule)
  private
    function Tag_MainContent_Handler(const TagName: string; Params: TStringList
      ): string;
    procedure BeforeRequestHandler(Sender: TObject; ARequest: TRequest);
  public
    constructor CreateNew(AOwner: TComponent; CreateMode: integer); override;
    destructor Destroy; override;

    procedure Get; override;
    procedure Post; override;
  end;

implementation

uses theme_controller, common;

constructor THelpModule.CreateNew(AOwner: TComponent; CreateMode: integer);
begin
  inherited CreateNew(AOwner, CreateMode);
  BeforeRequest := @BeforeRequestHandler;
end;

destructor THelpModule.Destroy;
begin
  inherited Destroy;
end;

// Init First
procedure THelpModule.BeforeRequestHandler(Sender: TObject; ARequest: TRequest);
begin
end;

// GET Method Handler
procedure THelpModule.Get;
begin
  ThemeUtil.Layout:='help';
  //Tags['maincontent'] := @Tag_MainContent_Handler; //<<-- tag maincontent handler
  Response.Content := ThemeUtil.Render();
end;

// POST Method Handler
procedure THelpModule.Post;
begin
  Response.Content := 'This is POST Method';
end;

function THelpModule.Tag_MainContent_Handler(const TagName: string; 
  Params: TStringList): string;
begin

  // your code here
  Result:=h3('Hello "Help" Module ... FastPlaz !');

end;



initialization
  // -> http://yourdomainname/help
  // The following line should be moved to a file "routes.pas"
  Route.Add('help', THelpModule);

end.

