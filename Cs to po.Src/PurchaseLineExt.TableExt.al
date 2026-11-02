tableextension 600000 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(60000; "CS Approval Status"; Option)
        {
            Caption = 'CS Approval Status';
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
        }
    }
}