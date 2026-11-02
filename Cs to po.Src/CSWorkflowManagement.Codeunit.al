codeunit 600001 "CS Workflow Management"
{
    procedure OnSendCSForApproval(var TargetRec: Record "Purchase Line")
    begin
        if TargetRec."CS Approval Status" = TargetRec."CS Approval Status"::"Pending Approval" then
            Error('An approval request has already been sent for this line.');

        TargetRec."CS Approval Status" := TargetRec."CS Approval Status"::"Pending Approval";
        TargetRec.Modify(true);

        Message('Approval request sent successfully for Purchase Line %1.', TargetRec."Line No.");
    end;

    procedure OnCancelCSForApproval(var TargetRec: Record "Purchase Line")
    begin
        if TargetRec."CS Approval Status" <> TargetRec."CS Approval Status"::"Pending Approval" then
            Error('There is no active approval request to cancel for this line.');

        TargetRec."CS Approval Status" := TargetRec."CS Approval Status"::Open;
        TargetRec.Modify(true);

        Message('Approval request canceled for Purchase Line %1.', TargetRec."Line No.");
    end;
}