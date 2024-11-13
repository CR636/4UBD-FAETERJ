
CREATE TABLE empregado (
    nome          VARCHAR2(50) NOT NULL,
    rg            INTEGER NOT NULL,
    cic           INTEGER NOT NULL,
    depto         INTEGER NOT NULL,
    rg_supervisor INTEGER,
    salario       FLOAT NOT NULL
);

ALTER TABLE empregado ADD CONSTRAINT empregado_pk PRIMARY KEY ( rg );

CREATE TABLE departamento (
    nome       VARCHAR2(50) NOT NULL,
    numero     INTEGER NOT NULL,
    rg_gerente INTEGER NOT NULL
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( numero );

CREATE TABLE projeto (
    nome        VARCHAR2(50) NOT NULL,
    numero      INTEGER NOT NULL,
    localizacao VARCHAR2(50) NOT NULL
);

ALTER TABLE projeto ADD CONSTRAINT projeto_pk PRIMARY KEY ( numero );

CREATE TABLE depto_projeto (
    num_depto   INTEGER NOT NULL,
    num_projeto INTEGER NOT NULL
);

ALTER TABLE depto_projeto ADD CONSTRAINT departamento_projeto_pk PRIMARY KEY ( num_depto, num_projeto );

CREATE TABLE dependentes (
    rg_responsavel  INTEGER NOT NULL,
    nome_dependente VARCHAR2(50) NOT NULL,
    nascimento      DATE NOT NULL,
    relacao         VARCHAR2(20) NOT NULL,
    sexo            VARCHAR2(20) NOT NULL
);

ALTER TABLE dependentes ADD CONSTRAINT dependentes_pk PRIMARY KEY ( rg_responsavel, nome_dependente );

CREATE TABLE empregado_projeto (
    rg_empregado INTEGER NOT NULL,
    num_projeto  INTEGER NOT NULL,
    horas        INTEGER NOT NULL
);

ALTER TABLE empregado_projeto ADD CONSTRAINT empregado_projeto_pk PRIMARY KEY ( rg_empregado, num_projeto );

INSERT INTO empregado (Nome, RG, CIC, Depto, RG_Supervisor, Salario) VALUES ('João Luiz', '10101010', '11111111', 1, NULL, 3000.00);
INSERT INTO empregado (Nome, RG, CIC, Depto, RG_Supervisor, Salario) VALUES ('Fernando', '20202020', '22222222', 2, '10101010', 2500.00);
INSERT INTO empregado (Nome, RG, CIC, Depto, RG_Supervisor, Salario) VALUES ('Ricardo', '30303030', '33333333', 2, '10101010', 2300.00);
INSERT INTO empregado (Nome, RG, CIC, Depto, RG_Supervisor, Salario) VALUES ('Jorge', '40404040', '44444444', 2, '20202020', 4200.00);
INSERT INTO empregado (Nome, RG, CIC, Depto, RG_Supervisor, Salario) VALUES ('Renato', '50505050', '55555555', 3, '20202020', 1300.00);

INSERT INTO departamento (Nome, Numero, RG_Gerente) VALUES ('Contabilidade', 1, '10101010');
INSERT INTO departamento (Nome, Numero, RG_Gerente) VALUES ('Engenharia Civil', 2, '30303030');
INSERT INTO departamento (Nome, Numero, RG_Gerente) VALUES ('Engenharia Mecânica', 3, '20202020');

INSERT INTO projeto (Nome, Numero, Localizacao) VALUES ('Financeiro', 5, 'São Paulo');
INSERT INTO projeto (Nome, Numero, Localizacao) VALUES ('Motor', 10, 'Rio Claro');
INSERT INTO projeto (Nome, Numero, Localizacao) VALUES ('Prédio Central', 20, 'Campinas');

INSERT INTO dependentes (RG_Responsavel, Nome_Dependente, Nascimento, Relacao, Sexo) VALUES (10101010, 'Jorge', TO_DATE('27/12/1986', 'DD/MM/YYYY'), 'Filho', 'Masculino');
INSERT INTO dependentes (RG_Responsavel, Nome_Dependente, Nascimento, Relacao, Sexo) VALUES (10101010, 'Luiz', TO_DATE('18/11/1979', 'DD/MM/YYYY'), 'Filho', 'Masculino');
INSERT INTO dependentes (RG_Responsavel, Nome_Dependente, Nascimento, Relacao, Sexo) VALUES (20202020, 'Fernanda', TO_DATE('14/02/1969', 'DD/MM/YYYY'), 'Cônjuge', 'Feminino');
INSERT INTO dependentes (RG_Responsavel, Nome_Dependente, Nascimento, Relacao, Sexo) VALUES (20202020, 'Ângelo', TO_DATE('10/02/1995', 'DD/MM/YYYY'), 'Filho', 'Masculino');
INSERT INTO dependentes (RG_Responsavel, Nome_Dependente, Nascimento, Relacao, Sexo) VALUES (30303030, 'Adreia', TO_DATE('01/05/1990', 'DD/MM/YYYY'), 'Filho', 'Feminino');

INSERT INTO depto_projeto (Num_Depto, Num_Projeto) VALUES (2, 5);
INSERT INTO depto_projeto (Num_Depto, Num_Projeto) VALUES (3, 10);
INSERT INTO depto_projeto (Num_Depto, Num_Projeto) VALUES (2, 20);

INSERT INTO empregado_projeto (RG_Empregado, Num_Projeto, Horas) VALUES ('20202020', 5, 10);
INSERT INTO empregado_projeto (RG_Empregado, Num_Projeto, Horas) VALUES ('20202020', 10, 25);
INSERT INTO empregado_projeto (RG_Empregado, Num_Projeto, Horas) VALUES ('30303030', 5, 35);
INSERT INTO empregado_projeto (RG_Empregado, Num_Projeto, Horas) VALUES ('40404040', 20, 50);
INSERT INTO empregado_projeto (RG_Empregado, Num_Projeto, Horas) VALUES ('50505050', 20, 35);

ALTER TABLE empregado
ADD CONSTRAINT empregado_depto_fk FOREIGN KEY (depto) REFERENCES departamento (numero);

ALTER TABLE empregado
ADD CONSTRAINT empregado_supervisor_fk FOREIGN KEY (rg_supervisor) REFERENCES empregado (rg);

ALTER TABLE departamento
ADD CONSTRAINT departamento_gerente_fk FOREIGN KEY (rg_gerente) REFERENCES empregado (rg);

ALTER TABLE depto_projeto
ADD CONSTRAINT departamento_fk FOREIGN KEY (num_depto) REFERENCES departamento (numero);

ALTER TABLE depto_projeto
ADD CONSTRAINT projeto_fk FOREIGN KEY (num_projeto) REFERENCES projeto (numero);

ALTER TABLE dependentes
ADD CONSTRAINT dependentes_empregado_fk FOREIGN KEY (rg_responsavel) REFERENCES empregado (rg);

ALTER TABLE empregado_projeto
ADD CONSTRAINT empregado_fk FOREIGN KEY (rg_empregado) REFERENCES empregado (rg);

ALTER TABLE empregado_projeto
ADD CONSTRAINT empregado_projeto_projeto_fk FOREIGN KEY (num_projeto) REFERENCES projeto (numero);

