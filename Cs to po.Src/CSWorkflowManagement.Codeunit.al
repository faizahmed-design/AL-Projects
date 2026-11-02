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

    procedure OnApproveCSForApproval(var TargetRec: Record "Purchase Line")
    var
        PurchHeader: Record "Purchase Header";
        PurchQuoteToOrder: Codeunit "Purch.-Quote to Order";
    begin
        if TargetRec."CS Approval Status" <> TargetRec."CS Approval Status"::"Pending Approval" then
            Error('Only pending approval requests can be approved.');

        // 1. Set status to Approved
        TargetRec."CS Approval Status" := TargetRec."CS Approval Status"::Approved;
        TargetRec.Modify(true);

        // 2. Fetch the parent Purchase Header (Quote) and convert it to a Purchase Order
        if PurchHeader.Get(TargetRec."Document Type", TargetRec."Document No.") then begin
            if PurchHeader."Document Type" = PurchHeader."Document Type"::Quote then begin
                PurchQuoteToOrder.Run(PurchHeader);
                Message('Approval granted. Purchase Order created successfully from Quote %1.', PurchHeader."No.");
            end else
                Message('Approval granted for Purchase Line %1.', TargetRec."Line No.");
        end;
    end;

    procedure OnRejectCSForApproval(var TargetRec: Record "Purchase Line")
    begin
        if TargetRec."CS Approval Status" <> TargetRec."CS Approval Status"::"Pending Approval" then
            Error('Only pending approval requests can be rejected.');

        // Set status to Rejected - PO will not be created
        TargetRec."CS Approval Status" := TargetRec."CS Approval Status"::Rejected;
        TargetRec.Modify(true);

        Message('Approval request rejected. Purchase Order will NOT be created for Purchase Line %1.', TargetRec."Line No.");
    end;
}