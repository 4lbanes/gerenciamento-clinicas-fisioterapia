-- -----------------------------------------------------
-- Script de Carga para as Tabelas do Cenário "Fortaleza"
-- -----------------------------------------------------

-- Unidade Federativa e Município
INSERT INTO unidade_federativa (uni_sigla, uni_nome) VALUES 
('CE', 'Ceará');

INSERT INTO municipio (unidade_federativa_uni_id, mun_name, mun_tipo) VALUES 
(1, 'Fortaleza', 0);

-- Tipos de Logradouro
INSERT INTO tipo_logradouro (tip_tipo, tip_nome, tip_abreviatura) VALUES
(1, 'Rua', 'R.'),
(2, 'Avenida', 'Av.'),
(3, 'Praça', 'Pç.');

-- Bairros em Fortaleza
INSERT INTO bairro (municipio_mun_id, bai_nome, bai_abrev) VALUES
(1, 'Aldeota', 'Aldt'),
(1, 'Centro', 'Cen'),
(1, 'Meireles', 'Meir');

-- Logradouros em Fortaleza
INSERT INTO logradouro (tipo_logradouro_tip_id, bairro_bai_id, log_nome, log_cep, log_complemento) VALUES
(1, 1, 'Rua Silva Paulet', '60120-021', NULL),
(2, 2, 'Avenida Dom Manuel', '60060-090', NULL),
(3, 3, 'Praça Luíza Távora', '60125-002', NULL);

-- Pacientes
INSERT INTO paciente (pac_name, pac_datanascimento, pac_sexo, pac_telefone1, pac_telefone2, pac_email, pac_rg, pac_cpf) VALUES
('Carlos Souza', '1990-05-20', 1, '(85) 99999-1234', '(85) 98888-5678', 'carlos.souza@example.com', '123456789', '123.456.789-00'),
('Ana Paula Martins', '1985-08-15', 0, '(85) 98765-4321', NULL, 'ana.martins@example.com', '987654321', '987.654.321-00');

-- Endereços dos Pacientes
INSERT INTO paciente_logradouro (paciente_pac_id, logradouro_log_id) VALUES
(1, 1),  -- Carlos Souza mora na Rua Silva Paulet
(2, 2);  -- Ana Paula Martins mora na Avenida Dom Manuel

-- Tipos de Exame
INSERT INTO tipo_exame (tipe_name) VALUES
('Raio-X de Coluna'),
('Ultrassonografia de Tórax'),
('Ressonância Magnética');

-- Exames dos Pacientes
INSERT INTO exame (exa_id, paciente_pac_id, tipo_exame_tipe_id, exa_nome, exa_laudo, exa_dataexame) VALUES
(1, 1, 1, 'Raio-X de Coluna', LOAD_FILE('/path/to/laudo1.jpg'), '2024-10-10 14:00:00'),
(2, 2, 2, 'Ultrassonografia de Tórax', LOAD_FILE('/path/to/laudo2.jpg'), '2024-11-01 10:00:00');

-- Especialidades dos Profissionais
INSERT INTO especialidade (esp_name) VALUES
('Fisioterapia Respiratória'),
('Fisioterapia Ortopédica');

-- Profissionais Médicos
INSERT INTO agendaprofissional (age_dia, age_mes, age_ano, age_datahora) VALUES
('2024-11-05', 'Novembro', 2024, '2024-11-05 08:00:00');

INSERT INTO profissionalmedico (especialidade_esp_id, agendaprofissional_age_id, prof_name, prof_crefito, prof_coffito, prof_iniciotrabalho, prof_fimtrabalho, prof_telefone) VALUES
(1, 1, 'Dr. João Oliveira', '12345-CE', '67890-CE', '2024-01-01 08:00:00', '2024-01-01 18:00:00', '(85) 99999-0001');

-- Tratamentos
INSERT INTO tratamento (tra_descricao) VALUES
('Tratamento Respiratório para Condições Pulmonares'),
('Reabilitação Pós-Cirúrgica de Coluna');

-- Consultas dos Pacientes com Profissionais
INSERT INTO consulta (tratamento_tra_id, paciente_pac_id, profissionalmedico_prof_id, profissionalmedico_especialidade_esp_id, con_data, con_observacoes, con_duracao) VALUES
(1, 1, 1, 1, '2024-11-10 09:00:00', 'Paciente com dificuldades respiratórias leves', 60),
(2, 2, 1, 2, '2024-11-11 10:00:00', 'Paciente se recuperando de cirurgia de coluna', 45);

-- Formas de Pagamento
INSERT INTO tipopagamento (tipp_modalidade) VALUES
('Cartão de Crédito'),
('Plano de Saúde');

-- Cartão de Crédito dos Pacientes
INSERT INTO cartaocredito (car_id, car_nametitular, car_bandeira, car_numero, car_validade, car_cvv, car_parcelas) VALUES
(1, 'Carlos Souza', 'Visa', 1234123412341234, '2025-06-01', 123, 12),
(2, 'Ana Paula Martins', 'Mastercard', 5678567856785678, '2024-12-01', 456, 6);

-- Convênios
INSERT INTO convenio (con_id, con_name) VALUES
(1, 'Unimed Fortaleza'),
(2, 'Hapvida');

-- Planos de Saúde dos Pacientes
INSERT INTO planosaude (plan_id, convenio_con_id, plan_numero, plan_validade, plan_titular) VALUES
(1, 1, 12345, '2025-08-01', 'Carlos Souza'),
(2, 2, 67890, '2024-09-01', 'Ana Paula Martins');

-- Pagamentos realizados pelos Pacientes
INSERT INTO pagamento (tipopagamento_tipp_id, cartaocredito_car_id, planosaude_plan_id, planosaude_convenio_con_id, pag_valor, pag_pago, pag_comprovante) VALUES
(1, 1, NULL, NULL, 150.00, 1, NULL),  -- Pagamento com Cartão de Crédito por Carlos Souza
(2, NULL, 2, 2, 0.00, 1, NULL);       -- Pagamento com Plano de Saúde por Ana Paula Martins

a