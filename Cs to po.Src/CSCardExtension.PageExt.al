pageextension 600000 "CS Card Extension" extends 70801697
{
    actions
    {
        addlast(processing)
        {
            group(ApprovalGroup)
            {
                Caption = 'Approval';
                Image = Approval;

                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    ApplicationArea = All;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        CSWorkflowMgt: Codeunit "CS Workflow Management";
                    begin
                        CSWorkflowMgt.OnSendCSForApproval(Rec);
                    end;
                }

                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    ApplicationArea = All;
                    Image = CancelApprovalRequest;

                    trigger OnAction()
                    var
                        CSWorkflowMgt: Codeunit "CS Workflow Management";
                    begin
                        CSWorkflowMgt.OnCancelCSForApproval(Rec);
                    end;
                }
            }
        }
    }
}