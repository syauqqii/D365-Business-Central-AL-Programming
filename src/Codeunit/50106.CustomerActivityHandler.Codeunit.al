codeunit 50106 "Customer Activity Handler"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnInsert(var Rec: Record Customer)
    begin
        LogSafe('Create', Rec.Name);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    local procedure OnModify(var Rec: Record Customer)
    begin
        LogSafe('Modify', Rec.Name);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnDelete(var Rec: Record Customer)
    begin
        LogSafe('Delete', Rec.Name);
    end;

    local procedure LogSafe(Action: Text; CustName: Text)
    var
        Manager: Codeunit "Logger Manager";
        Success: Boolean;
    begin
        Success := TryLog(Action, CustName, Manager);
        if not Success then
            Message('Log Gagal! Tapi aplikasi aman.');
    end;

    [TryFunction]
    local procedure TryLog(Action: Text; CustName: Text; Manager: Codeunit "Logger Manager")
    begin
        Manager.RunLogger(Action, CustName);
    end;

}