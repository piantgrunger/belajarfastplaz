unit contacts_controller;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, html_lib, fpcgi, HTTPDefs, fastplaz_handler, database_lib
  ,tbcontact_model,fpjson,json_lib;

type

  { TContactsModule }

  TContactsModule = class(TMyCustomWebModule)
  private
    function Tag_MainContent_Handler(const TagName: string; Params: TStringList
      ): string;
    procedure BeforeRequestHandler(Sender: TObject; ARequest: TRequest);
  public
    constructor CreateNew(AOwner: TComponent; CreateMode: integer); override;
    destructor Destroy; override;
     procedure loaddata;

    procedure Get; override;
    procedure Post; override;
  end;

implementation

uses theme_controller, common;

constructor TContactsModule.CreateNew(AOwner: TComponent; CreateMode: integer);
begin
  inherited CreateNew(AOwner, CreateMode);
  BeforeRequest := @BeforeRequestHandler;
end;

destructor TContactsModule.Destroy;
begin
  inherited Destroy;
end;

procedure TContactsModule.loaddata;
var     Data :string;
   contacts:TTbcontactModel;
       i:integer;
begin
   DataBaseInit();

  contacts:= TTbcontactModel.Create('tb_contact');
  contacts.GetAll;
  ThemeUtil.Assign('$contacts',@contacts.Data);
{
  json :=TJSONArray.Create();
  DataToJSON(contacts.Data,json,false);
  Response.Content:=json.AsJSON;
  exit;

}



end;

// Init First
procedure TContactsModule.BeforeRequestHandler(Sender: TObject; 
  ARequest: TRequest);
begin
end;

// GET Method Handler
procedure TContactsModule.Get;


begin




  //          Response.ContentType := 'application/json';
//          Response.Content:=json.AsJSON;

             loaddata;
 // ThemeUtil.Assign('nama',contacts['name']);
  Tags['maincontent'] := @Tag_MainContent_Handler; //<<-- tag maincontent handler
  Response.Content := ThemeUtil.Render();

  //json.Free;


end;

// POST Method Handler
procedure TContactsModule.Post;
 var contacts:TTbcontactModel;
    pesan :string;


begin
  DataBaseInit();
  contacts:= TTbcontactModel.Create('tb_contact');
  contacts['name']:=_POST['name'];
  contacts['address']:=_POST['address'];
    Tags['maincontent'] := @Tag_MainContent_Handler;
  if contacts.Save() then
     pesan:='<script> alert("Data Berhasil Disimpan") </script>';
  loaddata;
  Response.Content := ThemeUtil.Render()+pesan+'<br>';
end;

function TContactsModule.Tag_MainContent_Handler(const TagName: string; 
  Params: TStringList): string;
begin

  // your code here
  //Result:=h3('Hello "Contacts" Module ... FastPlaz !');
  Result:=ThemeUtil.RenderFromContent(@TagController,'','modules\contact\view\view.html');
end;



initialization
  // -> http://yourdomainname/contacts
  // The following line should be moved to a file "routes.pas"
  Route.Add('contacts', TContactsModule);

end.

