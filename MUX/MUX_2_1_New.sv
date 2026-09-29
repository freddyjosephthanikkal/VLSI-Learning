module mux_2_All
(
    input logic A,B,S,clk,
    output logic Y_Gate, Y_Nand, Y_Nor, Y_Combined, Y_If_Else, Y_Case, Y_Ternary
);

    logic X1,X2,X3,X4,X5,X6,X7,Y_Comb;

    always_comb
    begin
        X1 = ~S;
        X2 = A & X1;
        X3 = B & S;
    end

    assign X4 = ~(X2);
    assign X5 = ~(X3);
    assign X6 = ~(A | S);
    assign X7 = ~(B | X1);
    assign Y_Comb = (X2)|(X3);

    always_ff @(posedge clk)
    begin

        Y_Gate <= X2 | X3;
        Y_Nand <= ~(X4 & X5);
        Y_Nor <= ~(X6 | X7);
        Y_Combined <= Y_Comb;

        if (S == 0)
            begin
                Y_If_Else <= A;
            end
        else
            begin
                Y_If_Else <= B;
            end

        case(S)
            0: Y_Case <= A;
            1: Y_Case <= B;
            default: Y_Case <= 1'bx;
        endcase

        Y_Ternary <= S ? B : A;

    end

endmodule
