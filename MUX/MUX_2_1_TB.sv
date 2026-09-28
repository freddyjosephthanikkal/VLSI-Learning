`timescale 1ns/1ps
module mux_2_1_TB;
    logic A_in;
    logic B_in;
    logic S_in;
    logic clk;
    logic Y_Gate;
    logic Y_Nand;
    logic Y_Nor;
    logic Y_Combined;
    logic Y_If_Else;
    logic Y_Case;
    logic Y_Ternary;
    logic expected;

    mux_2_Gate Gate_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y(Y_Gate)
    );

    mux_2_NAND Nand_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y(Y_Nand)
    );

    mux_2_NOR Nor_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y(Y_Nor)
    );

    mux_2_Combined Combined_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y(Y_Combined)
    );

    mux_2_if_else If_else_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y(Y_If_Else)
    );

    mux_2_Case Case_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y(Y_Case)
    );

    mux_2_Ternary Ternary_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y(Y_Ternary)
    );

    initial
        begin
            clk=0;
            forever
                begin
                    #10;
                    clk=!clk;
                end
        end

    int i,j,k;

    initial
        begin
            $dumpfile("Mux_2_1.vcd");
            $dumpvars(0,mux_2_1_TB);
            $monitor(
                        "A=%b B=%b S=%b expected=%b G=%b N=%b Nor=%b C=%b I_e=%b C=%b T=%b",
                        A_in,B_in,S_in,expected,Y_Gate,
                        Y_Nand,Y_Nor,Y_Combined,Y_If_Else,
                        Y_Case,Y_Ternary
                    );
            for(i=0;i<2;i++)
                for(j=0;j<2;j++)
                    for(k=0;k<2;k++)
                    begin
                        S_in = i;
                        B_in = j;
                        A_in = k;
                        expected = S_in ? B_in : A_in;
                        #20;
                        if (    (Y_Gate==expected)
                                && (Y_Nand==expected)
                                && (Y_Nor==expected)
                                && (Y_Combined==expected)
                                && (Y_If_Else==expected)
                                && (Y_Case==expected)
                                && (Y_Ternary==expected)
                           )
                        begin
                            $display("PASS....");
                        end
                        else
                        begin
                            $display("FAIL....");
                        end

                    end

            $finish;

        end

endmodule
