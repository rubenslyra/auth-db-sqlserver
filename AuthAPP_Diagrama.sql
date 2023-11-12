CREATE TABLE [usuarios] (
  [ID] INT PRIMARY KEY,
  [CL_Usuario] NVARCHAR(155) UNIQUE NOT NULL,
  [CL_Email] NVARCHAR(255) UNIQUE NOT NULL,
  [CL_Senha] VARBINARY(128) NOT NULL,
  [CL_Salt] VARBINARY(64) NOT NULL,
  [CL_Criacao] DATETIME NOT NULL,
  [CL_Alteracao] DATETIME,
  [CL_Exclusao] DATETIME,
  [AutenticacaoDoisFatores] BIT DEFAULT (0)
)
GO

CREATE TABLE [auditoria] (
  [ID_Auditoria] INT PRIMARY KEY,
  [Tabela] NVARCHAR(50) NOT NULL,
  [ID_Registro] INT NOT NULL,
  [Acao] NVARCHAR(10) NOT NULL,
  [Data] DATETIME NOT NULL,
  [Usuario] NVARCHAR(155) NOT NULL
)
GO

CREATE TABLE [funcoes] (
  [ID_Funcao] INT PRIMARY KEY,
  [Nome] NVARCHAR(50) NOT NULL,
  [Descricao] NVARCHAR(255)
)
GO

CREATE TABLE [perfil_cliente] (
  [ID_Perfil] INT PRIMARY KEY,
  [ID_Usuario] INT UNIQUE,
  [Nome] NVARCHAR(100),
  [Telefone] NVARCHAR(20),
  [Endereco] NVARCHAR(255)
)
GO

CREATE TABLE [tokens] (
  [ID_Token] INT PRIMARY KEY,
  [ID_Usuario] INT UNIQUE,
  [Token] NVARCHAR(255) NOT NULL,
  [Data_Expiracao] DATETIME NOT NULL
)
GO

CREATE TABLE [recuperacao_senha] (
  [ID_Recuperacao] INT PRIMARY KEY,
  [ID_Usuario] INT UNIQUE,
  [Token] NVARCHAR(255) NOT NULL,
  [Data_Expiracao] DATETIME NOT NULL
)
GO

CREATE INDEX [FK_ID_Registro] ON [auditoria] ("ID_Registro")
GO

CREATE INDEX [FK_ID_Usuario] ON [perfil_cliente] ("ID_Usuario")
GO

CREATE INDEX [FK_ID_Usuario] ON [tokens] ("ID_Usuario")
GO

CREATE INDEX [FK_ID_Usuario] ON [recuperacao_senha] ("ID_Usuario")
GO

ALTER TABLE [usuarios] ADD FOREIGN KEY ([ID]) REFERENCES [auditoria] ([ID_Registro])
GO

ALTER TABLE [usuarios] ADD FOREIGN KEY ([ID]) REFERENCES [perfil_cliente] ([ID_Usuario])
GO

ALTER TABLE [usuarios] ADD FOREIGN KEY ([ID]) REFERENCES [tokens] ([ID_Usuario])
GO

ALTER TABLE [usuarios] ADD FOREIGN KEY ([ID]) REFERENCES [recuperacao_senha] ([ID_Usuario])
GO
