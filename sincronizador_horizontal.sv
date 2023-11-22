// contador horizontal 
module sincronizador_horizontal (
    input clk_25MHz,
    output logic enable = 0,
    output logic [15:0] V_horizontal = 0
);

    always_ff @(posedge clk_25MHz)
    begin
        if (V_horizontal < 799)
        begin
            V_horizontal <= V_horizontal + 1;
            enable <= 0; // Apaga contador vertical
        end
        else
        begin
            V_horizontal <= 0; // Reinicia el contador horizontal
            enable <= 1; // Activa el contador vertical
        end
    end

endmodule