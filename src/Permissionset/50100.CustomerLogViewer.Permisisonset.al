permissionset 50100 "Customer Log Viewer"
{
    Assignable = true;

    // IncludedPermissionSets = SomePermissionSet;

    Permissions = 
        // Read, Modify, Insert, Delete
        tabledata "Customer Log" = RMID;
}