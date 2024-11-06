-- -----------------------------------------------------
-- Table paciente
-- -----------------------------------------------------
CREATE DATABASE IF not EXISTS av3_tuezin_senario_oitu;
use av3_tuezin_senario_oitu;
CREATE TABLE IF NOT EXISTS paciente (
  pac_id INT NOT NULL AUTO_INCREMENT,
  pac_name VARCHAR(255) NOT NULL,
  pac_datanascimento DATE NOT NULL,
  pac_sexo BIT default(0) NOT NULL COMMENT '0 - Feminino\n1 - Masculino',
  pac_telefone1 VARCHAR(45) NULL,
  pac_telefone2 VARCHAR(45) NULL,
  pac_email VARCHAR(255) NULL,
  pac_rg VARCHAR(45) NULL,
  pac_cpf VARCHAR(45) NOT NULL,
  PRIMARY KEY (pac_id),
  UNIQUE INDEX pac_cpf_UNIQUE (pac_cpf ASC)
);

-- -----------------------------------------------------
-- Table unidade_federativa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unidade_federativa (
  uni_id INT NOT NULL AUTO_INCREMENT,
  uni_sigla VARCHAR(2) NOT NULL,
  uni_nome VARCHAR(100) NOT NULL,
  PRIMARY KEY (uni_id)
);

-- -----------------------------------------------------
-- Table tipo_logradouro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipo_logradouro (
  tip_id INT NOT NULL AUTO_INCREMENT,
  tip_tipo INT NOT NULL,
  tip_nome VARCHAR(30) NOT NULL,
  tip_abreviatura VARCHAR(10) NULL,
  tip_logradourocol VARCHAR(45) NULL,
  PRIMARY KEY (tip_id)
);

-- -----------------------------------------------------
-- Table tipo_exame
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipo_exame (
  tipe_id INT NOT NULL AUTO_INCREMENT,
  tipe_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (tipe_id)
);

-- -----------------------------------------------------
-- Table especialidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS especialidade (
  esp_id INT NOT NULL AUTO_INCREMENT,
  esp_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (esp_id)
);

-- -----------------------------------------------------
-- Table agendaprofissional
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS agendaprofissional (
  age_id INT NOT NULL AUTO_INCREMENT,
  age_dia DATE NULL,
  age_mes VARCHAR(60) NULL,
  age_ano INT NULL,
  age_datahora DATETIME NULL,
  PRIMARY KEY (age_id)
);

-- -----------------------------------------------------
-- Table tratamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tratamento (
  tra_id INT NOT NULL AUTO_INCREMENT,
  tra_descricao VARCHAR(255) NOT NULL,
  PRIMARY KEY (tra_id)
);

-- -----------------------------------------------------
-- Table tipopagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipopagamento (
  tipp_id INT NOT NULL AUTO_INCREMENT,
  tipp_modalidade VARCHAR(255) NOT NULL,
  PRIMARY KEY (tipp_id)
);

-- -----------------------------------------------------
-- Table cartaocredito
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cartaocredito (
  car_id INT NOT NULL,
  car_nametitular VARCHAR(255) NOT NULL,
  car_bandeira VARCHAR(45) NOT NULL,
  car_numero BIGINT(16) NOT NULL,
  car_validade DATE NOT NULL,
  car_cvv INT NOT NULL,
  car_parcelas INT NOT NULL,
  PRIMARY KEY (car_id)
);

-- -----------------------------------------------------
-- Table convenio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS convenio (
  con_id INT NOT NULL,
  con_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (con_id)
);

-- -----------------------------------------------------
-- Table municipio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS municipio (
  mun_id INT NOT NULL AUTO_INCREMENT,
  unidade_federativa_uni_id INT NOT NULL,
  mun_name VARCHAR(255) NOT NULL,
  mun_tipo BIT DEFAULT(0) NULL,
  PRIMARY KEY (mun_id, unidade_federativa_uni_id),
  INDEX fk_municipio_unidade_federativa1_idx (unidade_federativa_uni_id ASC)
);

ALTER TABLE municipio ADD FOREIGN KEY fk_municipio_unidade_federativa1 (unidade_federativa_uni_id) REFERENCES unidade_federativa(uni_id);

-- -----------------------------------------------------
-- Table bairro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bairro (
  bai_id INT NOT NULL AUTO_INCREMENT,
  municipio_mun_id INT NOT NULL,
  bai_nome VARCHAR(255) NOT NULL,
  bai_abrev VARCHAR(30) NULL,
  bairrocol VARCHAR(45) NULL,
  PRIMARY KEY (bai_id, municipio_mun_id),
  INDEX fk_bairro_municipio1_idx (municipio_mun_id ASC)
);

ALTER TABLE bairro ADD FOREIGN KEY fk_bairro_municipio1 (municipio_mun_id) REFERENCES municipio (mun_id);

-- -----------------------------------------------------
-- Table logradouro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS logradouro (
  log_id INT NOT NULL AUTO_INCREMENT,
  tipo_logradouro_tip_id INT NOT NULL,
  bairro_bai_id INT NOT NULL,
  log_nome VARCHAR(255) NOT NULL,
  log_cep VARCHAR(8) NOT NULL,
  log_complemento VARCHAR(45) NULL,
  PRIMARY KEY (log_id, tipo_logradouro_tip_id, bairro_bai_id),
  INDEX fk_logradouro_tipo_logradouro1_idx (tipo_logradouro_tip_id ASC),
  INDEX fk_logradouro_bairro1_idx (bairro_bai_id ASC)
);

ALTER TABLE logradouro ADD FOREIGN KEY fk_logradouro_tipo_logradouro1(tipo_logradouro_tip_id) REFERENCES tipo_logradouro (tip_id);
ALTER TABLE logradouro ADD FOREIGN KEY fk_logradouro_bairro1(bairro_bai_id) REFERENCES bairro (bai_id);

-- -----------------------------------------------------
-- Table paciente_logradouro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS paciente_logradouro (
  paciente_pac_id INT NOT NULL,
  logradouro_log_id INT NOT NULL,
  PRIMARY KEY (paciente_pac_id, logradouro_log_id),
  INDEX fk_paciente_has_logradouro_logradouro1_idx (logradouro_log_id ASC),
  INDEX fk_paciente_has_logradouro_paciente1_idx (paciente_pac_id ASC)
);

ALTER TABLE paciente_logradouro ADD FOREIGN KEY fk_paciente_has_logradouro_paciente1(paciente_pac_id) REFERENCES paciente (pac_id);
ALTER TABLE paciente_logradouro ADD FOREIGN KEY fk_paciente_has_logradouro_logradouro1(logradouro_log_id) REFERENCES logradouro (log_id);

-- -----------------------------------------------------
-- Table exame
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS exame (
  exa_id INT NOT NULL,
  paciente_pac_id INT NOT NULL,
  tipo_exame_tipe_id INT NOT NULL,
  exa_nome VARCHAR(255) NOT NULL,
  exa_laudo LONGBLOB NOT NULL,
  exa_dataexame DATETIME NULL,
  PRIMARY KEY (exa_id, paciente_pac_id, tipo_exame_tipe_id),
  INDEX fk_exame_paciente1_idx (paciente_pac_id ASC),
  INDEX fk_exame_tipo_exame1_idx (tipo_exame_tipe_id ASC)
);

ALTER TABLE exame ADD FOREIGN KEY fk_exame_paciente1(paciente_pac_id) REFERENCES paciente (pac_id);
ALTER TABLE exame ADD FOREIGN KEY fk_exame_tipo_exame1(tipo_exame_tipe_id) REFERENCES tipo_exame (tipe_id);

-- -----------------------------------------------------
-- Table profissionalmedico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS profissionalmedico (
  prof_id INT NOT NULL AUTO_INCREMENT,
  especialidade_esp_id INT NOT NULL,
  agendaprofissional_age_id INT NOT NULL,
  prof_name VARCHAR(255) NOT NULL,
  prof_crefito VARCHAR(10) NOT NULL,
  prof_coffito VARCHAR(10) NOT NULL,
  prof_iniciotrabalho DATETIME NULL,
  prof_fimtrabalho DATETIME NULL,
  prof_telefone VARCHAR(45) NULL,
  PRIMARY KEY (prof_id, especialidade_esp_id, agendaprofissional_age_id),
  INDEX fk_profissionalmedico_especialidade1_idx (especialidade_esp_id ASC),
  INDEX fk_profissionalmedico_agendaprofissional1_idx (agendaprofissional_age_id ASC)
);

ALTER TABLE profissionalmedico ADD FOREIGN KEY fk_profissionalmedico_especialidade1(especialidade_esp_id) REFERENCES especialidade (esp_id);
ALTER TABLE profissionalmedico ADD FOREIGN KEY fk_profissionalmedico_agendaprofissional1(agendaprofissional_age_id) REFERENCES agendaprofissional (age_id);

-- -----------------------------------------------------
-- Table planosaude
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS planosaude (
  plan_id INT NOT NULL,
  convenio_con_id INT NOT NULL,
  plan_numero INT NOT NULL,
  plan_validade DATE NOT NULL,
  plan_titular VARCHAR(45) NOT NULL,
  PRIMARY KEY (plan_id, convenio_con_id),
  INDEX fk_planosaude_convenio1_idx (convenio_con_id ASC)
);

ALTER TABLE planosaude ADD FOREIGN KEY k_planosaude_convenio1(convenio_con_id) REFERENCES convenio (con_id);

-- -----------------------------------------------------
-- Table pagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pagamento (
  pag_id INT NOT NULL AUTO_INCREMENT,
  tipopagamento_tipp_id INT NOT NULL,
  cartaocredito_car_id INT NOT NULL,
  planosaude_plan_id INT NOT NULL,
  planosaude_convenio_con_id INT NOT NULL,
  pag_valor DOUBLE NOT NULL,
  pag_pago TINYINT NOT NULL,
  pag_comprovante BLOB NULL,
  PRIMARY KEY (pag_id, tipopagamento_tipp_id),
  INDEX fk_pagamento_tipopagamento1_idx (tipopagamento_tipp_id ASC),
  INDEX fk_pagamento_cartaocredito1_idx (cartaocredito_car_id ASC),
  INDEX fk_pagamento_planosaude1_idx (planosaude_plan_id ASC, planosaude_convenio_con_id ASC)
);

ALTER TABLE pagamento ADD FOREIGN KEY fk_pagamento_tipopagamento1(tipopagamento_tipp_id) REFERENCES tipopagamento (tipp_id);
ALTER TABLE pagamento ADD FOREIGN KEY fk_pagamento_cartaocredito1(cartaocredito_car_id) REFERENCES cartaocredito (car_id);
ALTER TABLE pagamento ADD FOREIGN KEY fk_pagamento_planosaude1(planosaude_plan_id, planosaude_convenio_con_id) REFERENCES planosaude (plan_id, convenio_con_id);

-- -----------------------------------------------------
-- Table consulta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS consulta (
  con_id INT NOT NULL AUTO_INCREMENT,
  tratamento_tra_id INT NOT NULL,
  paciente_pac_id INT NOT NULL,
  profissionalmedico_prof_id INT NOT NULL,
  profissionalmedico_especialidade_esp_id INT NOT NULL,
  con_data DATETIME NOT NULL,
  con_observacoes VARCHAR(255) NULL,
  con_duracao INT NULL,
  PRIMARY KEY (con_id, tratamento_tra_id, paciente_pac_id, profissionalmedico_prof_id, profissionalmedico_especialidade_esp_id),
  INDEX fk_consulta_tratamento1_idx (tratamento_tra_id ASC),
  INDEX fk_consulta_paciente1_idx (paciente_pac_id ASC),
  INDEX fk_consulta_profissionalmedico1_idx (profissionalmedico_prof_id ASC, profissionalmedico_especialidade_esp_id ASC)
);

ALTER TABLE consulta ADD FOREIGN KEY fk_consulta_tratamento1(tratamento_tra_id) REFERENCES tratamento (tra_id);
ALTER TABLE consulta ADD FOREIGN KEY fk_consulta_paciente1(paciente_pac_id) REFERENCES paciente (pac_id);
ALTER TABLE consulta ADD FOREIGN KEY fk_consulta_profissionalmedico1(profissionalmedico_prof_id, profissionalmedico_especialidade_esp_id) REFERENCES profissionalmedico (prof_id, especialidade_esp_id);