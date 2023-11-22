// contador vertical 
module sincronizador_vertical (
    input clk_25MHz,
    input enable,
    output logic [15:0] V_horizontal = 0
);

    always_ff @(posedge clk_25MHz)
    begin
        if (enable)
        begin
            if (V_horizontal < 524)
                V_horizontal <= V_horizontal + 1;
            else
                V_horizontal <= 0; // Reinicia el contador vertical
        end
    end

endmodule