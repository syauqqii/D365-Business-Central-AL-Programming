codeunit 50107 "Whatsapp Sender"
{
    procedure sendMessage(phoneNumber: Text; message: Text)//: JsonObject
    var
        Client: HttpClient;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestJson, ResponseJson: JsonObject;
        Headers: HttpHeaders;
        BodyText: Text;
    begin
        RequestJson.Add('to', phoneNumber);
        RequestJson.Add('text', message);
        RequestJson.WriteTo(BodyText);
        RequestContent.WriteFrom(BodyText);

        RequestContent.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        if not Client.Post('http://165.232.161.141:4437/send-message', RequestContent, ResponseMessage) then
            Error('Gagal melakukan request ke WhatsApp API');
        
        if not ResponseMessage.IsSuccessStatusCode() then
            Error('Gagal kirim pesan. Status %1 - %2', ResponseMessage.HttpStatusCode(), ResponseMessage.ReasonPhrase());

        // ResponseMessage.Content().ReadAs(BodyText);
        // if not ResponseJson.ReadFrom(BodyText) then
        //     Error('Gagal parsing response JSON.');

        // exit(ResponseJson);
    end;
}