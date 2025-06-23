controladdin ProgressBarAddIn
{
    Scripts = './src/Control_AddIn/ProgressBar/js/script.js';
    StartupScript = './src/Control_AddIn/ProgressBar/js/startup.js';
    StyleSheets = './src/Control_AddIn/ProgressBar/css/style.css';

    MinimumHeight = 50;
    MaximumHeight = 50;

    HorizontalStretch = true;

    event StartUp();

    procedure SetProgress(Progress: Integer);
}