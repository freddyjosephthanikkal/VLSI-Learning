module mux_2_Gate
(
    input logic A,B,S,clk,
    output logic Y
);

    logic X1,X2,X3;

    always_comb
    begin
        X1 = ~S;
        X2 = A & X1;
        X3 = B & S;
    end

    always_ff @(posedge clk)
    begin
        Y <= X2 | X3;
    end

endmodule

module mux_2_NAND
(
    input logic A,B,S,clk,
    output logic Y
);

    logic X1,X2,X3;

    assign X1 = ~(S & S);
    assign X2 = ~(A & X1);
    assign X3 = ~(B & S);

    always_ff @(posedge clk)
    begin
        Y <= ~(X2 & X3);
    end

endmodule

module mux_2_NOR
(
    input logic A,B,S,clk,
    output logic Y
);

    logic X1,X2,X3;

    assign X1 = ~(S | S);
    assign X2 = ~(A | S);
    assign X3 = ~(B | X1);

    always_ff @(posedge clk)
    begin
        Y <= ~(X2 | X3);
    end

endmodule

module mux_2_Combined
(
    input logic A,B,S,clk,
    output logic Y
);

    logic Y_Combined;
    assign Y_Combined = (A & ~S)|(B & S);
    always_ff @(posedge clk)
    begin
        Y <= Y_Combined;
    end

endmodule

module mux_2_if_else
(
    input logic A,B,S,clk,
    output logic Y
);

    always_ff @(posedge clk)
    begin
        if (S == 0)
            begin
                Y <= A;
            end
        else
            begin
                Y <= B;
            end
    end

endmodule

module mux_2_Case
(
    input logic A,B,S,clk,
    output logic Y
);

    always_ff @(posedge clk)
    begin
        case(S)
            0: Y <= A;
            1: Y <= B;
            default: Y <= 1'bx;
        endcase
    end

endmodule

module mux_2_Ternary
(
    input logic A,B,S,clk,
    output logic Y
);

    always_ff @(posedge clk)
    begin
        Y <= S ? B : A;
    end

endmodule
