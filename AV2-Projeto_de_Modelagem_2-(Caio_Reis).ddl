CREATE TABLE cliente (
    id          INTEGER NOT NULL,
    nome        VARCHAR2(50) NOT NULL,
    cpf         VARCHAR2(20) NOT NULL,
    contato     VARCHAR2(50) NOT NULL,
    ativo       VARCHAR2(20) NOT NULL,
    logradouro  VARCHAR2(50) NOT NULL,
    numero      VARCHAR2(20) NOT NULL,
    complemento VARCHAR2(30) NOT NULL,
    cep         VARCHAR2(20) NOT NULL,
    bairro      VARCHAR2(20) NOT NULL,
    cidade      VARCHAR2(30) NOT NULL,
    estado      VARCHAR2(30) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id );

CREATE TABLE login (
    id         INTEGER NOT NULL,
    usuario    VARCHAR2(50) NOT NULL,
    senha      VARCHAR2(50) NOT NULL,
    cliente_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX login__idx ON
    login (
        cliente_id
    ASC );

ALTER TABLE login ADD CONSTRAINT login_pk PRIMARY KEY ( id );
ALTER TABLE login ADD CONSTRAINT login_cliente_fk FOREIGN KEY ( cliente_id )
    REFERENCES cliente ( id );

CREATE TABLE administrador (
    id       INTEGER NOT NULL,
    nome     VARCHAR2(50) NOT NULL,
    login_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX administrador__idx ON
    administrador (
        login_id
    ASC );

ALTER TABLE administrador ADD CONSTRAINT administrador_pk PRIMARY KEY ( id );
ALTER TABLE administrador ADD CONSTRAINT administrador_login_fk FOREIGN KEY ( login_id )
    REFERENCES login ( id );

CREATE TABLE veterinaria (
    id       INTEGER NOT NULL,
    nome     VARCHAR2(50) NOT NULL,
    login_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX veterinaria__idx ON
    veterinaria (
        login_id
    ASC );

ALTER TABLE veterinaria ADD CONSTRAINT veterinaria_pk PRIMARY KEY ( id );
ALTER TABLE veterinaria ADD CONSTRAINT veterinaria_login_fk FOREIGN KEY ( login_id )
    REFERENCES login ( id );

CREATE TABLE animal (
    id            INTEGER NOT NULL,
    nomecliente   VARCHAR2(50) NOT NULL,
    nome          VARCHAR2(50) NOT NULL,
    raca          VARCHAR2(20) NOT NULL,
    cor           VARCHAR2(20) NOT NULL,
    idade         VARCHAR2(3) NOT NULL,
    problemasaude VARCHAR2(100) NOT NULL,
    nascimento    DATE NOT NULL,
    especie       VARCHAR2(20) NOT NULL,
    foto          VARCHAR2(50) NOT NULL,
    cliente_id    INTEGER NOT NULL
);

ALTER TABLE animal ADD CONSTRAINT animal_pk PRIMARY KEY ( id );
ALTER TABLE animal ADD CONSTRAINT animal_cliente_fk FOREIGN KEY ( cliente_id )
    REFERENCES cliente ( id );
ALTER TABLE animal ADD CONSTRAINT animal_nome_fk FOREIGN KEY ( nomecliente )
    REFERENCES cliente ( nome );

CREATE TABLE agenda (
    id                INTEGER NOT NULL,
    nomecliente       VARCHAR2(50) NOT NULL,
    nomeanimal        VARCHAR2(50) NOT NULL,
    horariodata       DATE NOT NULL,
    retirar           VARCHAR2(20) NOT NULL,
    sexo              VARCHAR2(20) NOT NULL,
    perfume           VARCHAR2(20) NOT NULL,
    contato           VARCHAR2(20) NOT NULL,
    servico           VARCHAR2(50) NOT NULL,
    descricao         VARCHAR2(30) NOT NULL,
    valor             NUMBER NOT NULL,
    animal_id         INTEGER NOT NULL,
    animal_cliente_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX agenda__idx ON
    agenda (
        animal_id
    ASC,
        animal_cliente_id
    ASC );

ALTER TABLE agenda ADD CONSTRAINT agenda_pk PRIMARY KEY ( id );
ALTER TABLE agenda ADD CONSTRAINT agenda_animal_fk FOREIGN KEY ( animal_id )
    REFERENCES animal ( id );
ALTER TABLE agenda ADD CONSTRAINT agenda_cliente_fk FOREIGN KEY ( animal_cliente_id )
    REFERENCES cliente ( id );
ALTER TABLE agenda ADD CONSTRAINT agenda_nomecliente_fk FOREIGN KEY ( nomecliente )
    REFERENCES cliente ( nome );
ALTER TABLE agenda ADD CONSTRAINT agenda_nomeanimal_fk FOREIGN KEY ( nomeanimal )
    REFERENCES animal ( id );

CREATE TABLE consulta (
    id                INTEGER NOT NULL,
    nomecliente       VARCHAR2(50) NOT NULL,
    nomeanimal        VARCHAR2(50) NOT NULL,
    contato           VARCHAR2(50) NOT NULL,
    horariodata       DATE NOT NULL,
    servico           VARCHAR2(50) NOT NULL,
    observacoes       VARCHAR2(50) NOT NULL,
    tipoatendimento   VARCHAR2(30) NOT NULL,
    exames            VARCHAR2(50) NOT NULL,
    valorconsulta     NUMBER NOT NULL,
    datavacina        DATE NOT NULL,
    dataretorno       DATE NOT NULL,
    vermifugo         VARCHAR2(30) NOT NULL,
    valorvacina       NUMBER NOT NULL,
    animal_id         INTEGER NOT NULL,
    animal_cliente_id INTEGER NOT NULL
);

ALTER TABLE consulta ADD CONSTRAINT consulta_pk PRIMARY KEY ( id );
ALTER TABLE consulta ADD CONSTRAINT consulta_animal_fk FOREIGN KEY ( animal_id )
    REFERENCES animal ( id );
ALTER TABLE consulta ADD CONSTRAINT consulta_cliente_fk FOREIGN KEY ( animal_cliente_id )
    REFERENCES cliente ( id );
ALTER TABLE consulta ADD CONSTRAINT consulta_nomecliente_fk FOREIGN KEY ( nomecliente )
    REFERENCES cliente ( nome );
ALTER TABLE consulta ADD CONSTRAINT consulta_nomeanimal_fk FOREIGN KEY ( nomeanimal )
    REFERENCES animal ( nome );

CREATE TABLE rastreio (
    id                INTEGER NOT NULL,
    idcliente         INTEGER NOT NULL,
    idanimal          INTEGER NOT NULL,
    etapa             VARCHAR2(30) NOT NULL
);

ALTER TABLE rastreio ADD CONSTRAINT rastreio_pk PRIMARY KEY ( id );
ALTER TABLE rastreio ADD CONSTRAINT rastreio_animal_fk FOREIGN KEY ( idanimal )
    REFERENCES animal ( id );
ALTER TABLE rastreio ADD CONSTRAINT rastreio_cliente_fk FOREIGN KEY ( idcliente )
    REFERENCES cliente ( id );
