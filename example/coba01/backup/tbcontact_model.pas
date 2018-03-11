unit tbcontact_model;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, database_lib;

type
  TTbcontactModel = class(TSimpleModel)
  private
  public
    constructor Create(const DefaultTableName: string = '');
  end;

implementation

constructor TTbcontactModel.Create(const DefaultTableName: string = '');
begin
  DefaultTableName:='tb_contact';

  inherited Create( DefaultTableName); // table name = tbcontacts
  primaryKey:='id';
  //inherited Create('yourtablename'); // if use custom tablename
end;

end.

