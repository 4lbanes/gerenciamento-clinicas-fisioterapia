-- Relatório 1
SELECT 
    p.pac_name AS Paciente,
    t.tra_descricao AS Tipo_Tratamento,
    COUNT(c.con_id) AS Total_Sessoes,
    SUM(pg.pag_valor) AS Custo_Total
FROM 
    paciente p
    LEFT JOIN consulta c ON c.paciente_pac_id = p.pac_id
    LEFT JOIN tratamento t ON c.tratamento_tra_id = t.tra_id
    LEFT JOIN pagamento pg ON pg.pag_id = c.con_id
GROUP BY 
    p.pac_name, t.tra_descricao
ORDER BY 
    p.pac_name, t.tra_descricao;

-- Relatório 2
SELECT 
    pm.prof_name AS Fisioterapeuta,
    COUNT(DISTINCT c.paciente_pac_id) AS Numero_Pacientes,
    SUM(pg.pag_valor) AS Total_Valor_Pago
FROM 
    profissionalmedico pm
    LEFT JOIN consulta c ON pm.prof_id = c.profissionalmedico_prof_id
    LEFT JOIN pagamento pg ON pg.pag_id = c.con_id
GROUP BY 
    pm.prof_name
ORDER BY 
    pm.prof_name;

-- Relatório 3
SELECT 
    t.tra_descricao AS Tipo_Tratamento,
    COUNT(c.con_id) AS Numero_Sessoes
FROM 
    tratamento t
    LEFT JOIN consulta c ON c.tratamento_tra_id = t.tra_id
WHERE 
    c.con_data BETWEEN '2024-01-01' AND '2024-12-31' OR c.con_data IS NULL
GROUP BY 
    t.tra_descricao
ORDER BY 
    t.tra_descricao;


-- Relatório 4
SELECT 
    MONTH(c.con_data) AS Mes,
    YEAR(c.con_data) AS Ano,
    pm.prof_name AS Fisioterapeuta,
    SUM(pg.pag_valor) AS Ganhos_Total,
    COUNT(c.con_id) AS Total_Sessoes,
    COUNT(DISTINCT c.paciente_pac_id) AS Total_Pacientes
FROM 
    profissionalmedico pm
    LEFT JOIN consulta c ON c.profissionalmedico_prof_id = pm.prof_id
    LEFT JOIN pagamento pg ON pg.pag_id = c.con_id
GROUP BY 
    Mes, Ano, pm.prof_name
ORDER BY 
    Ano, Mes, pm.prof_name;
