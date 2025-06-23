table 50101 "Testing Sales"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Row No"; Integer)
        {
            
        }

        field(2; "Created Date"; Date)
        {
            
        }
    }
    
    keys
    {
        key(PK; "Row No")
        {
            Clustered = true;
        }
    }
}