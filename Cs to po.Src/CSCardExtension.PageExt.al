pageextension 600000 "CS Card Extension" extends "D01 Purch. Quote Comparison"
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

                action(ApproveRequest)
                {
                    Caption = 'Approve';
                    ApplicationArea = All;
                    Image = Approve;

                    trigger OnAction()
                    var
                        CSWorkflowMgt: Codeunit "CS Workflow Management";
                    begin
                        CSWorkflowMgt.OnApproveCSForApproval(Rec);
                    end;
                }

                action(RejectRequest)
                {
                    Caption = 'Reject';
                    ApplicationArea = All;
                    Image = Reject;

                    trigger OnAction()
                    var
                        CSWorkflowMgt: Codeunit "CS Workflow Management";
                    begin
                        CSWorkflowMgt.OnRejectCSForApproval(Rec);
                    end;
                }
            }
        }
    }
}