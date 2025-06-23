controladdin ProgressBarAddIn
{
    Scripts = './src/Control_AddIn/ProgressBar/script.js';
    StartupScript = './src/Control_AddIn/ProgressBar/startup.js';
    StyleSheets = './src/Control_AddIn/ProgressBar/style.css';

    MinimumHeight = 50;
    MaximumHeight = 50;

    HorizontalStretch = true;

    event StartUp();

    procedure SetProgress(Progress: Integer);
}