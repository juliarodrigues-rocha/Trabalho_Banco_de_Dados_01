create table Bandeira (
id_bandeira int auto_increment primary key,
nome varchar (50),
url varchar (100)
);

-- Cidade (nome,estado,latitude,longitude)
CREATE TABLE Cidade (
    id_cidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,  -- Apenas um campo para UF (sigla)
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8)
);

-- Bairro (nome)
create table Bairro (
id_bairro int auto_increment primary key,
nome varchar(50) not null,
id_cidade int,
FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade)
);

-- Posto (cnpj, razao_social, nome_fantasia, latitude, longitude, endereco e telefone) 
create table Posto (
id_posto int auto_increment primary key,
cnpj varchar (18) not null,
razao_social varchar (50),
nome_fantasia varchar (50),
latitude decimal(10,8),
longitude decimal(11,8),
endereco varchar (35),
telefone varchar (20),
id_bairro int,
id_bandeira int,
FOREIGN KEY (id_bairro) REFERENCES Bairro(id_bairro),
FOREIGN KEY (id_bandeira) REFERENCES Bandeira(id_bandeira)
);

-- tipo_usuario (nome)
create table Tipo_Usuario (
    id_tipo_user INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(20)not null
);

-- usuario (login,senha) 
create table Usuario (
    login varchar(50) primary key not null,
    senha VARCHAR(20) not null,
    id_tipo_usuario int,
    FOREIGN KEY (id_tipo_usuario) REFERENCES Tipo_Usuario(id_tipo_user)
);


-- pessoa (login,nome,endereco)
create table Pessoa (
    login VARCHAR(35),
    nome VARCHAR(35),
    endereco VARCHAR(30),
    bairro int,
    foreign key (bairro) references Bairro(id_bairro),
    PRIMARY KEY (login),
    FOREIGN KEY (login) REFERENCES Usuario(login)
);

-- veiculo (placa,marca,modelo)
create table Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    login_usuario VARCHAR(50),
    FOREIGN KEY (login_usuario) REFERENCES Usuario(login)
);

-- combustivel (nome)
CREATE TABLE Combustivel (
    id_combustivel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- posto_combustivel (relação entre combustível e posto) 
CREATE TABLE Posto_Combustivel (
    id_posto_combustivel INT AUTO_INCREMENT PRIMARY KEY,
    id_posto INT,
    id_combustivel INT,
    FOREIGN KEY (id_posto) REFERENCES Posto(id_posto),
    FOREIGN KEY (id_combustivel) REFERENCES Combustivel(id_combustivel)
);

-- preco (valor,momento) 
CREATE TABLE Preco (
    id_preco INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(6,3) NOT NULL,
    momento DATETIME NOT NULL,
    id_posto_combustivel INT,
    FOREIGN KEY (id_posto_combustivel) REFERENCES Posto_Combustivel(id_posto_combustivel)
);



-- Etapa 2 - inserindo dados fictícios nessas tabelas --

-- Bandeiras
INSERT INTO Bandeira (nome, url) VALUES
('Petrobras', 'https://logo.com/petrobras.png'),
('Shell', 'https://logo.com/shell.png'),
('Ipiranga', 'https://logo.com/ipiranga.png'),
('Jet Oil', 'https://logo.com/jetoil.png'),
('Estados Unidos', 'https://logo.com/eua.png');

-- Cidades
INSERT INTO Cidade (nome, estado, latitude, longitude) VALUES
('Campinas', 'SP', -22.9099, -47.0626),
('Valinhos', 'SP', -22.9698, -46.9959),
('Paulínia', 'SP', -22.758, -47.153),
('Maceió','AL', -9.666,-35.7352);


-- Bairros
INSERT INTO Bairro (nome, id_cidade) VALUES
('Cambuí', 1),
('Centro', 2),
('João Aranha', 3),
('Pajuçara', 4);

-- Postos
INSERT INTO Posto (cnpj, razao_social, nome_fantasia, latitude, longitude, endereco, telefone, id_bairro, id_bandeira) VALUES
('10.101.101/1011-00', 'Petrobras Campinas LTDA', 'Posto Petrobras Cambuí', -22.9101, -47.0630, 'Rua 1, 100', '(19) 3000-0001', 1, 1),
('21.212.121/2009-92', 'Shell Valinhos S/A', 'Shell Centro', -22.9700, -46.9960, 'Av. 2, 200', '(19) 3000-0002', 2, 2),
('33.821.128/0031-34', 'Ipiranga Paulínia LTDA', 'Ipiranga João Aranha', -22.7585, -47.1535, 'Rua 3, 300', '(19) 3000-0003', 3, 3),
('46.466.667/0091-47', 'Jet Oil Maceió', 'Jet Oil Premium', -22.7588, -47.1540, 'Rua 4, 400', '(19) 3000-0004', 3, 4),
('58.268.505/0081-52', 'Posto EUA Campinas', 'Estados Unidos Combustíveis', -22.9110, -47.0640, 'Rua 5, 500', '(19) 3000-0005', 1, 5);

-- Tipo de Usuário
INSERT INTO Tipo_Usuario (nome) VALUES
('Administrador'),
('Usuário Comum');

-- Usuários
INSERT INTO Usuario (login, senha, id_tipo_usuario) VALUES
('julia', '123julia', 2),
('rafael', '123456', 2),
('giovana', '123456', 2),
('bruno', '123456', 2),
('leonardo', '123456', 1); --  admin

-- Pessoas
INSERT INTO Pessoa (login, nome, endereco, bairro) VALUES
('julia', 'Júlia Rodrigues', 'Rua Descampado, 15', 1),
('rafael', 'Rafael Ferreira', 'Rua das Dálias, 20', 1),
('giovana', 'Giovana Budri', 'Rua Carmono, 360', 2),
('bruno', 'Bruno Kimura', 'Rua Timburi, 1361', 3),
('leonardo', 'Leonardo Rodrigues', 'Rua Sete Quedas, 7', 4);


-- Veículos
INSERT INTO Veiculo (placa, marca, modelo, login_usuario) VALUES
('CDE1D23', 'Toyota', 'Corolla Cross', 'julia'),
('JAB9M87', 'Chevrolet', 'Onix', 'rafael'),
('BAJ3H45', 'Volkswagen', 'T-CROSS', 'giovana'),
('LOR7P65', 'Ford', 'Fiesta', 'bruno'),
('GNP5W89', 'Toyota', 'Yaris', 'leonardo');

-- combustíveis 
INSERT INTO Combustivel (nome) VALUES
('Gasolina'),
('Etanol'),
('Diesel'),
('GNV');

INSERT INTO Posto_Combustivel (id_posto, id_combustivel) VALUES
(1, 1),  -- Posto Cambuí → Gasolina
(1, 2),  -- Posto Cambuí → Etanol
(2, 3),  -- Shell Centro → Diesel
(2, 4),  -- Shell Centro → GNV
(3, 1),  -- Ipiranga Planalto → Gasolina
(3, 2),  -- Ipiranga Planalto → Etanol
(4, 4),  -- jet oil → GNV
(4,2),  -- jet oil → Etanol
(5,4), -- Posto EUA → GNV
(5,3); -- Posto EUA → Diesel


INSERT INTO Preco (id_posto_combustivel, valor, momento) VALUES
-- Gasolina no posto 1
(1, 5.79, '2025-05-15 12:40:00'),
-- Etanol no posto 1
(2, 4.39, '2025-05-16 15:40:00'),
-- Diesel no posto 2
(3, 5.89, '2025-03-20 09:33:00'),
-- GNV no posto 2
(4, 4.99, '2025-04-01 08:00:00'),
-- Gasolina no posto 3
(5, 5.69, '2025-02-10 21:55:00'),
-- Etanol no posto 3
(6, 4.29, '2025-01-26 07:11:00'),
-- GNV no Posto 4
(7, 4.95, '2025-02-11 09:00:00'),
-- Etanol no Posto 4
(8, 4.49, '2025-03-21 13:20:00'),
-- GNV no Posto 5
(9, 5.05, '2025-01-27 10:49:00'),
-- Diesel no Posto 5
(10, 6.29, '2025-04-02 22:50:00');

SELECT Bairro.nome as Bairro , c.nome as Cidade, c.estado from Bairro
inner join Cidade as c on c.id_cidade = Bairro.id_cidade
where c.nome = 'Maceió';

SELECT ban.nome, p.razao_social, b.nome from Bandeira as ban
inner join Posto as p on p.id_bandeira = ban.id_bandeira
inner join Bairro as b on b.id_bairro = p.id_bairro
where b.nome = 'Cambuí';

SELECT p.razao_social, cb.nome, pr.valor from Posto as p
inner join Posto_Combustivel as pc on pc.id_posto = p.id_posto
inner join Preco as pr on pr.id_posto_combustivel = pc.id_posto_combustivel
inner join Combustivel as cb on cb.id_combustivel = pc.id_combustivel
order by p.razao_social;

SELECT u.login, v.marca, v.modelo from Usuario as u
inner join Veiculo as v on v.login_usuario = u.login
inner join Pessoa as p on p.login = u.login
order by u.login;

SELECT p.login as Nome, p.endereco, b.nome as Bairro, c.nome as Cidade from Bairro as b
inner join Pessoa as p on p.bairro = b.id_bairro
inner join Cidade as c on c.id_cidade = b.id_cidade
order by p.login, c.nome;
