unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, html_lib, fpcgi, HTTPDefs, fastplaz_handler, database_lib;

type
  TMainModule = class(TMyCustomWebModule)
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

constructor TMainModule.CreateNew(AOwner: TComponent; CreateMode: integer);
begin
  inherited CreateNew(AOwner, CreateMode);
  BeforeRequest := @BeforeRequestHandler;
end;

destructor TMainModule.Destroy;
begin
  inherited Destroy;
end;

// Init First
procedure TMainModule.BeforeRequestHandler(Sender: TObject; ARequest: TRequest);
begin
end;

// GET Method Handler


procedure TMainModule.Get;
var s:string;
begin
 // Tags['maincontent'] := @Tag_MainContent_Handler;//<<-- tag maincontent handler

 Response.Content := ThemeUtil.Render();
 // S:= _GET['id'];
 // Response.Content := 'HELlO '+s;

end;

// POST Method Handler
procedure TMainModule.Post;
var nama,alamat :string;
begin
  Response.Content := 'This is POST Method';
  nama := _POST['nama'];
  alamat := _POST['alamat'];

 //Tags['greetings']
 Response.Content:= '<script>alert("nama saya '+nama+' alamat saya '+alamat +'")</script>'+ ThemeUtil.Render();
end;

function TMainModule.Tag_MainContent_Handler(const TagName: string; 
  Params: TStringList): string;

begin

  // your code here
  Result:=h3('Hello "Main" Module ... FastPlaz !');

end;


end.

