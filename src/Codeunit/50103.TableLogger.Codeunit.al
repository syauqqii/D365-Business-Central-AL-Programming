codeunit 50103 "Table Logger" implements "ILogger"
{
    procedure Log(Action: Text; CustName: Text)
    var
        Log: Record "Customer Log";
    begin
        Log.Init();
        Log."Time Stamp" := CurrentDateTime();
        Log."Action" := Action;
        Log."Customer Name" := CustName;
        Log."User ID" := UserId();
        Log.Insert();
    end;
}