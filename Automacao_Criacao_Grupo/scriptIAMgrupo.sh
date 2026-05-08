#!/bin/bash

# Verifica se o argumento de entrada foi fornecido
if [ -z "$1" ]; then
    echo "Por favor, forneça o arquivo CSV como argumento."
    exit 1
fi

# Armazena o nome do arquivo de entrada
INPUT="$1"

# Verifica se o arquivo de entrada existe
if [ ! -f "$INPUT" ]; then
    echo "$INPUT arquivo não encontrado"
    exit 1
fi

# Verifica se o utilitário dos2unix está instalado
command -v dos2unix >/dev/null || { echo "utilitário dos2unix não encontrado. Por favor, instale dos2unix antes de executar o script."; exit 1; }

# Converte o arquivo CSV para o formato Unix para garantir compatibilidade
dos2unix "$INPUT"

# Loop para ler cada linha do arquivo CSV e processar as informações
tail -n +2 "$INPUT" | while IFS= read -r line || [ -n "$line" ]; do
    
    # Separa as informações usando o delimitador ';' e atribui a variáveis
    nome_grupo=$(echo "$line" | cut -d';' -f1)
    arn_politica_especifica=$(echo "$line" | cut -d';' -f2)
    arn_politica_senha=$(echo "$line" | cut -d';' -f3)
    
    # Valida existência do nome do grupo
    aws iam get-group --group-name "$nome_grupo" >/dev/null 2>&1 

    # Cria o grupo de usuario no IAM
    if [ $? -ne 0 ]; then
        echo -e "\nCriando grupo $nome_grupo..."

        aws iam create-group --group-name "$nome_grupo"

        echo -e "Grupo $nome_grupo criado com sucesso.\n"

    # Insere a politica referente a categoria do grupo criado
        echo -e "Anexando políticas ao grupo $nome_grupo...\n"
        aws iam attach-group-policy --group-name "$nome_grupo" --policy-arn "$arn_politica_especifica"
    

    # Insere a politica que permite que usuario do grupo troque sua propria senha
        aws iam attach-group-policy --group-name "$nome_grupo" --policy-arn "$arn_politica_senha"

    else
        echo -e "\nO grupo $nome_grupo já existe. Ignorando criação."
    fi



done

echo "Script executado com sucesso."


