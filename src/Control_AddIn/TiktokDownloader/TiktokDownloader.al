controladdin "Tiktok Downloader"
{
    Scripts = './src/Control_AddIn/TiktokDownloader/js/script.js';
    StartupScript = './src/Control_AddIn/TiktokDownloader/js/startup.js';
    StyleSheets = './src/Control_AddIn/TiktokDownloader/css/style.css';

    RequestedHeight = 400;
    RequestedWidth = 600;

    HorizontalStretch = true;
    VerticalStretch = true;

    event Download(link: Text);
    procedure Show(data: JsonObject);
}