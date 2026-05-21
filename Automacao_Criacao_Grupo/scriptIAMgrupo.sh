#!/bin/bash


# Cria variável com diretório de logs
LOG_FILE="/var/log/iam-automation.log"


# Cria funcao para armazenar log em arquivo
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}


# Verifica se o argumento de entrada foi fornecido
if [ -z "$1" ]; then
    log "Por favor, forneça o arquivo CSV como argumento."
    exit 1
fi


# Armazena o nome do arquivo de entrada
INPUT="$1"


# Verifica se o arquivo de entrada existe
if [ ! -f "$INPUT" ]; then
    log "$INPUT arquivo não encontrado"
    exit 1
fi


# Verifica se o utilitário dos2unix está instalado
command -v dos2unix >/dev/null || { 
log "utilitário dos2unix não encontrado. Por favor, instale dos2unix antes de executar o script."; 
exit 1; 
}


# Converte o arquivo CSV para o formato Unix para garantir compatibilidade
dos2unix "$INPUT"


#Log iniciando processamento do arquivo
log "Iniciando processamento do arquivo $INPUT"


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
        log "Criando grupo $nome_grupo..."

        aws iam create-group --group-name "$nome_grupo"


        #Log se erro ao criar grupo    
        if [ $? -ne 0 ]; then
            log "Erro ao criar grupo $nome_grupo."
            continue
        fi


        log "Grupo $nome_grupo criado com sucesso."

    # Insere a politica referente a categoria do grupo criado
        log "Anexando políticas ao grupo $nome_grupo..."
        aws iam attach-group-policy --group-name "$nome_grupo" --policy-arn "$arn_politica_especifica"
    

    # Insere a politica que permite que usuario do grupo troque sua propria senha
        aws iam attach-group-policy --group-name "$nome_grupo" --policy-arn "$arn_politica_senha"

    else
        log "O grupo $nome_grupo já existe. Ignorando criação."
    fi



done

log "Script executado com sucesso."


