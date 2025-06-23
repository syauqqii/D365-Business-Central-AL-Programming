codeunit 50105 "Logger Manager"
{
    procedure RunLogger(Action: Text; CustName: Text)
    var
        InterfaceLogger: Interface ILogger;
        TableLogger: Codeunit "Table Logger";
        // MessageLogger: Codeunit "Message Logger";
    begin
        InterfaceLogger := TableLogger;
        InterfaceLogger.Log(Action, CustName);
    end;
}
