-- Criação do banco de dados se não existir
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutApp_DB_Dev')
BEGIN
  CREATE DATABASE AutApp_DB_Dev;
END;
GO

-- Uso do banco de dados
USE AutApp_DB_Dev;
GO

-- Tabela de Usuários
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'usuarios')
BEGIN
  CREATE TABLE usuarios (
    ID INT PRIMARY KEY,
    Usuario NVARCHAR(155) NOT NULL UNIQUE,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Senha VARBINARY(128) NOT NULL,
    Salt VARBINARY(64) NOT NULL,
    Criacao DATETIME NOT NULL,
    Alteracao DATETIME,
    Exclusao DATETIME,
    AutenticacaoDoisFatores BIT DEFAULT 0
  );
END;
GO

-- Tabela de Auditoria
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'auditoria')
BEGIN
  CREATE TABLE auditoria (
    ID_Auditoria INT PRIMARY KEY,
    Tabela NVARCHAR(50) NOT NULL,
    ID_Registro INT NOT NULL,
    Acao NVARCHAR(10) NOT NULL,
    Data DATETIME NOT NULL,
    Usuario NVARCHAR(155) NOT NULL,
    FOREIGN KEY (ID_Registro) REFERENCES usuarios(ID)
  );
END;
GO

-- Tabela de Funções
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'funcoes')
BEGIN
  CREATE TABLE funcoes (
    ID_Funcao INT PRIMARY KEY,
    Nome NVARCHAR(50) NOT NULL,
    Descricao NVARCHAR(255)
  );
END;
GO

-- Tabela de Perfil do Cliente
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'perfil_cliente')
BEGIN
  CREATE TABLE perfil_cliente (
    ID_Perfil INT PRIMARY KEY,
    ID_Usuario INT UNIQUE,
    Nome NVARCHAR(100),
    Telefone NVARCHAR(20),
    Endereco NVARCHAR(255),
    FOREIGN KEY (ID_Usuario) REFERENCES usuarios(ID)
  );
END;
GO

-- Tabela de Tokens
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tokens')
BEGIN
  CREATE TABLE tokens (
    ID_Token INT PRIMARY KEY,
    ID_Usuario INT UNIQUE,
    Token NVARCHAR(255) NOT NULL,
    Data_Expiracao DATETIME NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES usuarios(ID)
  );
END;
GO

-- Tabela de Recuperação de Senha
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'recuperacao_senha')
BEGIN
  CREATE TABLE recuperacao_senha (
    ID_Recuperacao INT PRIMARY KEY,
    ID_Usuario INT UNIQUE,
    Token NVARCHAR(255) NOT NULL,
    Data_Expiracao DATETIME NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES usuarios(ID)
  );
END;
GO
