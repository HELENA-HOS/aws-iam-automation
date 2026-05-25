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
    usuario=$(echo "$line" | cut -d';' -f1)
    grupo=$(echo "$line" | cut -d';' -f2)
    senha=$(echo "$line" | cut -d';' -f3)

    # Valida existencia do nome do usuário
    aws iam get-user --user-name "$usuario" >/dev/null 2>&1

    # Cria um usuário no IAM
    if [ $? -ne 0 ]; then
        log "Criando usuário $usuario..."

        aws iam create-user --user-name "$usuario"

        #Log se erro ao criar usuario    
        if [ $? -ne 0 ]; then
            log "Erro ao criar usuario $usuario."
            continue
        fi

        log "Usuario $usuario criado com sucesso."

        # Define uma senha e solicita a redefinição da senha no próximo login
        log "Criando senha do usuário $usuario..."
        aws iam create-login-profile --password-reset-required --user-name "$usuario" --password "$senha"

        # Adiciona o usuário ao grupo especificado
        log "Adicionando usuário $usuario ao grupo $grupo..."
        aws iam add-user-to-group --group-name "$grupo" --user-name "$usuario"

    else
        log "O usuário $usuario já existe. Ignorando criação."
    fi


done

log "Script executado com sucesso."
