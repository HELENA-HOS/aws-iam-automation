# AWS IAM Automation with Bash

Automação de provisionamento de grupos e usuários no AWS IAM utilizando Bash Script, AWS CLI e execução em ambiente Linux na AWS EC2.

---

## 📌 Objetivo

Este projeto foi desenvolvido com o objetivo de automatizar a criação de grupos e usuários no AWS IAM a partir de arquivos CSV, utilizando Bash Script e AWS CLI.

Durante o desenvolvimento, o laboratório original do curso foi evoluído com melhorias voltadas para automação mais robusta e próxima de cenários reais de infraestrutura, Cloud e DevOps.

Além da automação IAM, o projeto também foi executado em uma instância EC2 utilizando autenticação via IAM Role, eliminando a necessidade de credenciais fixas no servidor.

---

## 🚀 Funcionalidades

### ✔ Automação de grupos IAM

- Criação automática de grupos
- Associação automática de políticas IAM
- Validação de existência do grupo
- Tratamento de cabeçalho CSV
- Tratamento de erros
- Logs operacionais

### ✔ Automação de usuários IAM

- Criação automática de usuários
- Criação de senha inicial
- Obrigatoriedade de troca de senha no primeiro login
- Associação automática de usuários aos grupos
- Validação de existência do usuário
- Tratamento de erros
- Logs operacionais

### ✔ Execução em ambiente Cloud AWS

- Execução dos scripts em instância EC2 Linux
- Autenticação AWS via IAM Role
- Utilização de credenciais temporárias via STS
- Persistência de logs em `/var/log/iam-automation.log`

---

## 🛠 Tecnologias utilizadas

- Bash Script
- AWS CLI
- AWS IAM
- AWS EC2
- IAM Role
- AWS STS
- Linux
- Git
- GitHub

---

## 📂 Estrutura do projeto

```text
AWS-IAM-AUTOMATION/
│
├── Automacao_Criacao_Grupo/
│   ├── scriptIAMgrupo.sh
│   └── grupo-exemplo.csv
│
├── Automacao_Criacao_Usuarios/
│   ├── scriptIAMusuario.sh
│   └── usuarios-exemplo.csv
│
├── .gitignore
└── README.md
```

---

## 📄 Estrutura dos arquivos CSV

### Grupos

```csv
grupo;arn_politica_categoria;arn_politica_senha
GPO-AWS-DataBase;arn:aws:iam::aws:policy/AmazonRDSFullAccess;arn:aws:iam::aws:policy/IAMUserChangePassword
```

### Usuários

```csv
usuario;grupo;senha
usuario.teste;GPO-AWS-DataBase;Senha@123
```

---

## ▶ Como executar

### 1️⃣ Clonar repositório

```bash
git clone https://github.com/HELENA-HOS/aws-iam-automation.git
```

---

### 2️⃣ Acessar diretório

```bash
cd aws-iam-automation
```

---

### 3️⃣ Dar permissão de execução

```bash
chmod +x Automacao_Criacao_Grupo/scriptIAMgrupo.sh
chmod +x Automacao_Criacao_Usuarios/scriptIAMusuario.sh
```

---

### 4️⃣ Executar script de grupos

```bash
cd Automacao_Criacao_Grupo

sudo ./scriptIAMgrupo.sh grupo-exemplo.csv
```

---

### 5️⃣ Executar script de usuários

```bash
cd ../Automacao_Criacao_Usuarios

sudo ./scriptIAMusuario.sh usuarios-exemplo.csv
```

---

## 🔐 Autenticação AWS

O projeto foi executado em uma instância EC2 utilizando IAM Role para autenticação na AWS.

Dessa forma, não foi necessário utilizar Access Key ou Secret Key fixas no servidor, utilizando credenciais temporárias fornecidas automaticamente pelo AWS STS.

Exemplo de validação da identidade AWS:

```bash
aws sts get-caller-identity
```

---

## 📝 Logs operacionais

Os scripts registram logs operacionais em:

```text
/var/log/iam-automation.log
```

Exemplo:

```text
2026-05-25 20:34:37 - Criando grupo GPO-AWS-Developer...
2026-05-25 20:34:38 - Grupo GPO-AWS-Developer criado com sucesso.
2026-05-25 21:01:58 - Criando senha do usuário maria.silva...
```

---

## 🔍 Melhorias implementadas

- Tratamento de cabeçalho CSV
- Validação de existência de grupos IAM
- Validação de existência de usuários IAM
- Tratamento de erros
- Logs operacionais persistidos em arquivo
- Execução em ambiente EC2 Linux
- Autenticação segura via IAM Role
- Utilização de credenciais temporárias AWS STS
- Organização incremental do projeto
- Versionamento com Git e GitHub

---

## 📚 Aprendizados praticados

Durante o desenvolvimento deste projeto foram praticados conceitos como:

- Shell Script
- Loops e parsing de arquivos CSV
- Manipulação de variáveis em Bash
- Redirecionamento de entrada e saída
- Tratamento de erros
- Automação com AWS CLI
- IAM e IAM Role
- AWS STS
- EC2 Linux
- Logs operacionais
- Troubleshooting
- Provisionamento IAM
- Permissões Linux
- Versionamento com Git
- Fluxo GitHub + EC2

---

## 🧩 Arquitetura do projeto

Fluxo simplificado da automação:

```text
Usuário
   ↓ SSH
EC2 Linux
   ↓ IAM Role
AWS STS
   ↓
AWS IAM
   ↓
Criação de grupos e usuários
   ↓
Logs em /var/log/iam-automation.log
```

---

## 🔮 Melhorias futuras

- Validação de erros no attach de policies
- Implementação de logs rotativos
- Tratamento avançado de erros
- Rollback em caso de falha
- Modo dry-run
- Refatoração para Terraform
- Integração com CloudWatch Logs

---

## 👩‍💻 Autora

Helena Oliveira Silva

- LinkedIn: https://www.linkedin.com/in/helena-oliveira-silva/
- GitHub: https://github.com/HELENA-HOS
