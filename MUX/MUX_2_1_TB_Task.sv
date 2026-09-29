`timescale 1ns/1ps
module MUX_2_1_TB_Task;
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

    mux_2_All Mux_dut
    (
        .A(A_in),
        .B(B_in),
        .S(S_in),
        .clk(clk),
        .Y_Gate(Y_Gate),
        .Y_Nand(Y_Nand),
        .Y_Nor(Y_Nor),
        .Y_Combined(Y_Combined),
        .Y_If_Else(Y_If_Else),
        .Y_Case(Y_Case),
        .Y_Ternary(Y_Ternary)
    );

    initial clk = 0;
    always #10 clk = ~clk;

    task automatic test_mux
    (
        input logic A_test,
        input logic B_test,
        input logic S_test
    );

    begin

        A_in = A_test;
        B_in = B_test;
        S_in = S_test;

        expected = S_test ? B_test : A_test;
        #20;

        if (       (Y_Gate==expected)
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
    endtask

    int i,j,k;
    initial
        begin
            $dumpfile("Mux_2_1_Task.vcd");
            $dumpvars(0,MUX_2_1_TB_Task);
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
                        test_mux(k,j,i);
                    end

        $finish;

        end

endmodule
