page 50106 "Tiktok Downloader Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Tiktok Downloader Page';

    layout
    {
        area(Content)
        {
            usercontrol("Tiktok Downloader"; "Tiktok Downloader")
            {
                ApplicationArea = All;

                trigger Download(link: Text)
                var
                    Client: HttpClient;
                    RequestContent: HttpContent;
                    ResponseMessage: HttpResponseMessage;
                    ResponseText: Text;

                    JsonRequest, JsonResponse, JsonData, JsonUrl: JsonObject;
                    JsonToken: JsonToken;

                    mp3Url: Text;
                    mp4WithoutWatermark: Text;
                    mp4WithWatermark: Text;
                    filename: Text;

                    Headers: HttpHeaders;
                    Result: JsonObject;
                begin
                    JsonRequest.Add('url', link);
                    JsonRequest.WriteTo(ResponseText);
                    RequestContent.WriteFrom(ResponseText);

                    RequestContent.GetHeaders(Headers);
                    Headers.Clear();
                    Headers.Add('Content-Type', 'application/json');

                    if not Client.Post('http://165.232.161.141:4446/tiktok', RequestContent, ResponseMessage) then
                        Error('❌ Gagal melakukan request ke TikTok Downloader API.');

                    if not ResponseMessage.IsSuccessStatusCode() then
                        Error('❌ Server error: %1 - %2', ResponseMessage.HttpStatusCode(), ResponseMessage.ReasonPhrase());

                    ResponseMessage.Content().ReadAs(ResponseText);
                    if not JsonResponse.ReadFrom(ResponseText) then
                        Error('❌ Failed to parse JSON response.');

                    if JsonResponse.Get('data', JsonToken) and JsonToken.IsObject() then begin
                        JsonData := JsonToken.AsObject();

                        JsonData.Get('filename', JsonToken);
                        filename := JsonToken.AsValue().AsText();

                        if JsonData.Get('url', JsonToken) and JsonToken.IsObject() then begin
                            JsonUrl := JsonToken.AsObject();

                            JsonUrl.Get('mp3', JsonToken);
                            mp3Url := JsonToken.AsValue().AsText();

                            JsonUrl.Get('mp4_without_watermark', JsonToken);
                            mp4WithoutWatermark := JsonToken.AsValue().AsText();

                            JsonUrl.Get('mp4_with_watermark', JsonToken);
                            mp4WithWatermark := JsonToken.AsValue().AsText();
                        end;

                        Result.Add('filename', filename);
                        Result.Add('mp3', mp3Url);
                        Result.Add('mp4_without_watermark', mp4WithoutWatermark);
                        Result.Add('mp4_with_watermark', mp4WithWatermark);

                        CurrPage."Tiktok Downloader".Show(Result);
                    end else
                        Error('❌ JSON "data" field tidak ditemukan.');
                end;
            }
        }
    }
}