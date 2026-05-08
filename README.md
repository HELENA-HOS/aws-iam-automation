# AWS IAM Automation with Bash

Automação de provisionamento de grupos e usuários no AWS IAM utilizando Bash Script e AWS CLI.

## 📌 Objetivo

Este projeto foi desenvolvido com o objetivo de automatizar a criação de grupos e usuários no AWS IAM a partir de arquivos CSV, utilizando Bash Script e AWS CLI.

Durante o desenvolvimento, o laboratório original do curso foi evoluído com melhorias voltadas para automação mais robusta e próxima de cenários reais de infraestrutura e DevOps.

---

## 🚀 Funcionalidades

### ✔ Automação de grupos IAM

- Criação automática de grupos
- Associação automática de políticas IAM
- Validação de existência do grupo
- Tratamento de cabeçalho CSV
- Logs de execução no terminal

### ✔ Automação de usuários IAM

- Criação automática de usuários
- Criação de senha inicial
- Obrigatoriedade de troca de senha no primeiro login
- Associação automática de usuários aos grupos
- Validação de existência do usuário
- Logs de execução no terminal

---

## 🛠 Tecnologias utilizadas

- Bash Script
- AWS CLI
- AWS IAM
- Linux

---

## 📂 Estrutura do projeto

```text
AWS-IAM-AUTOMATION/
│
├── Automacao_Criacao_Grupo/
│   ├── scriptIAMgrupo.sh
│   ├── grupo.csv
│   └── README.md
│
├── Automacao_Criacao_Usuarios/
│   ├── scriptIAMusuario.sh
│   └── usuarios.csv
│
└── .gitignore
```

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
git clone https://github.com/HELENA-HOS/aws-iam-group-automation.git
```

### 2️⃣ Acessar diretório

```bash
cd aws-iam-group-automation
```

### 3️⃣ Dar permissão de execução

```bash
chmod +x scriptIAMgrupo.sh
chmod +x scriptIAMusuario.sh
```

### 4️⃣ Executar script de grupos

```bash
./scriptIAMgrupo.sh grupo-exemplo.csv
```

### 5️⃣ Executar script de usuários

```bash
./scriptIAMusuario.sh usuarios-exemplo.csv
```

---

## 🔍 Melhorias implementadas

- Tratamento de cabeçalho CSV
- Validação de existência de grupos IAM
- Validação de existência de usuários IAM
- Logs operacionais no terminal
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
- Troubleshooting
- Provisionamento IAM
- Versionamento com Git

---

## 🔮 Melhorias futuras

- Implementação de logs em arquivo
- Tratamento avançado de erros
- Rollback em caso de falha
- Modo dry-run
- Refatoração para Terraform

---

## 👩‍💻 Autora

Helena Oliveira Silva

- LinkedIn: https://www.linkedin.com/in/helena-oliveira-silva/
- GitHub: https://github.com/HELENA-HOS