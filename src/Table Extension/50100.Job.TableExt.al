tableextension 50100 "My Job" extends Job
{
    fields
    {
        field(50100; MyProgress; Integer)
        {
            Caption = 'Progress';
            MinValue = 0;
            MaxValue = 100;
        }
    }
}