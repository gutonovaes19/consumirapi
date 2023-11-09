unit umain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, uFormat;

type
  TForm1 = class(TForm)
    ImagemPrincipal: TImage;
    Layout1: TLayout;
    Layout5: TLayout;
    Rectangle3: TRectangle;
    Image5: TImage;
    rectBusca: TRectangle;
    Label1: TLabel;
    edtCEP: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    memTable: TFDMemTable;
    lblResultado: TLabel;
    procedure edtCEPTyping(Sender: TObject);
    procedure rectBuscaClick(Sender: TObject);
  private
    procedure BuscarCep(avalue: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

Procedure TForm1.BuscarCep(avalue:string);
begin
    if somentenumero(avalue).Length <> 0 then
    begin
      ShowMessage('CEP informado invalido');
      exit;
    end;
    restclient1.BaseURL := '//viacep.com.br/ws';
    RESTRequest1.Resource := SomenteNumero(edtcep.text)+'/json';
    RESTRequest1.Execute;
    if (RESTRequest1.Response.StatusCode <> 200) or
       (RESTRequest1.Response.Content.IndexOf('erro') > 0) then
    begin
        ShowMessage('Erro ao pesquisar CEP '+RESTRequest1.Response.StatusCode.ToString);
        exit;
    end;
    with memTable do
    begin
      lblResultado.Text := 'CEP: ' + FieldByName('cep').AsString + sLineBreak +
                            'End: ' + FieldByName('logradouro').AsString + sLineBreak +
                            'Compl: ' + FieldByName('complemento').AsString + sLineBreak +
                            'Bairro: ' + FieldByName('bairro').AsString + sLineBreak +
                            'Cidade: ' + FieldByName('localidade').AsString + sLineBreak +
                            'UF: ' + FieldByName('uf').AsString + sLineBreak +
                            'Cod. IBGE: ' + FieldByName('ibge').AsString;
    end;



end;

procedure TForm1.edtCEPTyping(Sender: TObject);
begin
     Formatar(edtcep,TFormato.CEP)
end;

procedure TForm1.rectBuscaClick(Sender: TObject);
begin
  if SomenteNumero(edtCEP.text).Length < 0 then
    BuscarCep(edtCEP.Text);
end;

end.
