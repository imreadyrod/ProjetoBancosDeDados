CREATE TABLE Ocorrencia(

codOcorrencia int not null,
codOcorrenciaAnterior int not null,
latitude varchar(50),
longitude varchar(50),
tipoOcorrencia varchar(16),
interdicao char(3),
oficio varchar(MAX) not null,
monitoramento char(3),
dataOcorrido date not null,
dataPlanejadaMonitoramento date,
pessoasEnvolvidas varchar(MAX),
riscoFato varchar(5),
linkLocalizacao varchar(MAX),
obs varchar(MAX),
codCPF char(11) not null,
nomeRegional varchar(50) not null,
nomeOrgao varchar(50) not null,
nomeEquipe varchar(50) not null,
constraint PK_Ocorrencia primary key (codOcorrencia)
constraint FK_OcorrenciaRecursiva foreign key (codOcorrenciaAnterior) references Ocorrencia(codOcorrencia)
);


CREATE TABLE EquipeTecnica(
nome varchar(50) not null,
constraint UN_NomeEquipe UNIQUE (nome),
constraint PK_EquipeTecnica primary key (nome) 

);

CREATE TABLE nomesEquipe(
codNome int not null,
nomeEquipe varchar(50) not null,
nomeTecnico varchar(50) not null,
constraint PK_NomeEquipe primary key (codNome),
constraint FK_nomesEquipeEquipeTecnica foreign key (nomeEquipe) references EquipeTecnica(nome) on delete cascade on update cascade
);

ALTER TABLE Ocorrencia
ADD CONSTRAINT FK_Ocorrencia_EquipeTecnica foreign key (nomeEquipe) references EquipeTecnica(nome);


CREATE TABLE Regional(
nomeRegional varchar(50),
constraint PK_Regional primary key (nomeRegional)
);

ALTER TABLE Ocorrencia
ADD CONSTRAINT FK_Ocorrencia_Regional foreign key (nomeRegional) references Regional(nomeRegional);


CREATE TABLE OrgaoDestino(
nomeOrgao varchar(50) not null,
constraint PK_OrgaoDestino primary key (nomeOrgao)
);

ALTER TABLE Ocorrencia
ADD CONSTRAINT FK_Ocorrencia_OrgaoDestino foreign key (nomeOrgao) references OrgaoDestino(nomeOrgao);

CREATE TABLE Morador(
CPF varchar(11) not null,
RG varchar(11) not null,
nome varchar(50) not null,
sobrenome varchar(50),
rua varchar(50),
numero int,
bairro varchar(50),
complemento varchar(50),
constraint PK_Morador primary key (CPF),
constraint UN_RGMorador unique (RG)
);

CREATE TABLE Telefone(
codTelefone int not null,
codCPF varchar(11) not null,
telefoneMorador varchar(15) not null,
constraint PK_Telefone primary key (codTelefone),
constraint FK_TelefoneMorador foreign key (codCPF) references Morador(CPF)
);

ALTER TABLE Ocorrencia
ADD CONSTRAINT FK_Ocorrencia_Morador foreign key (codCPF) references Morador(CPF);


-- Inserção de valores na tabela Ocorrencia
INSERT INTO Ocorrencia (
    codOcorrencia,
    codOcorrenciaAnterior,
    latitude,
    longitude,
    tipoOcorrencia,
    interdicao,
    oficio,
    monitoramento,
    dataOcorrido,
    dataPlanejadaMonitoramento,
    pessoasEnvolvidas,
    riscoFato,
    linkLocalizacao,
    obs,
    codCPF,
    nomeRegional,
    nomeOrgao,
    nomeEquipe
) VALUES


(1, NULL, '40.7128', '-74.0060', '1.2.1.0.0', 'Sim', 'Oficio123', 'Sim', '2023-01-01', '2023-01-10', 'João Silva, Maria Souza', 'Fato', 'http://maps.google.com', 'Observação sobre a ocorrência', '12345678901', 'Regional Norte', 'Orgao1', 'Equipe1'),

(2, 1, '34.0522', '-118.2437', '1.2.2.0.0', 'Não', 'Oficio456', 'Não', '2023-02-15', '2023-02-20', 'Carlos Oliveira, Ana Santos', 'Fato', 'http://maps.google.com', 'Outra observação sobre a ocorrência', '98765432102', 'Regional Sul', 'Orgao2', 'Equipe2'),

(3, 2, '51.5074', '-0.1278', '1.2.2.0.0', 'Sim', 'Oficio789', 'Sim', '2023-03-20', '2023-03-25', 'Paula Rocha, Roberto Lima', 'Risco', 'http://maps.google.com', 'Observação adicional', '45678901234', 'Regional Leste', 'Orgao3', 'Equipe3'),

(4, 3, '35.6895', '139.6917', '1.4.1.3.1', 'Sim', 'OficioABC', 'Sim', '2023-04-10', '2023-04-15', 'Fernanda Oliveira, Ricardo Souza', 'Risco', 'http://maps.google.com', 'Comentário sobre a ocorrência', '23456789012', 'Regional Oeste', 'Orgao4', 'Equipe4'),

(5, 4, '55.7558', '37.6176', '1.5.2.1.0', 'Sim', 'OficioXYZ', 'Não', '2023-05-05', '2023-05-10', 'Camila Silva, Thiago Lima', 'Fato', 'http://maps.google.com', 'Observação final', '34567890123', 'Regional Central', 'Orgao5', 'Equipe5');


-- Inserção de valores na tabela EquipeTecnica
INSERT INTO EquipeTecnica (nome) VALUES
('Equipe1'),
('Equipe2'),
('Equipe3'),
('Equipe4'),
('Equipe5');

-- Inserção de valores na tabela nomesEquipe
INSERT INTO nomesEquipe (codNome, nomeEquipe, nomeTecnico) VALUES
(1, 'Equipe1', 'Tecnico1'),
(2, 'Equipe2', 'Tecnico2'),
(3, 'Equipe3', 'Tecnico3'),
(4, 'Equipe4', 'Tecnico4'),
(5, 'Equipe5', 'Tecnico5');


-- Inserção de valores na tabela Regional
INSERT INTO Regional (nomeRegional) VALUES
('Regional Norte'),
('Regional Sul'),
('Regional Leste'),
('Regional Oeste'),
('Regional Central');


-- Inserção de valores na tabela OrgaoDestino
INSERT INTO OrgaoDestino (nomeOrgao) VALUES
('Orgao1'),
('Orgao2'),
('Orgao3'),
('Orgao4'),
('Orgao5');

-- Inserção de valores na tabela Morador
INSERT INTO Morador (CPF, RG, nome, sobrenome, rua, numero, bairro, complemento) VALUES
('12345678901', 'ABC123456', 'João', 'Silva', 'Rua A', 123, 'Bairro X', 'Apto 101'),
('98765432102', 'XYZ789012', 'Maria', 'Santos', 'Rua B', 456, 'Bairro Y', 'Casa 202'),
('45678901234', 'DEF567890', 'Carlos', 'Oliveira', 'Rua C', 789, 'Bairro Z', 'Apto 303'),
('23456789012', 'GHI234567', 'Ana', 'Lima', 'Rua D', 101, 'Bairro W', 'Casa 404'),
('34567890123', 'JKL345678', 'Pedro', 'Ferreira', 'Rua E', 567, 'Bairro V', 'Apto 505');

-- Inserção de valores na tabela Telefone
INSERT INTO Telefone (codTelefone, codCPF, telefoneMorador) VALUES
(1, '12345678901', '(123) 456-7890'),
(2, '98765432102', '(987) 654-3210'),
(3, '45678901234', '(456) 789-0123'),
(4, '23456789012', '(234) 567-8901'),
(5, '34567890123', '(345) 678-9012');

