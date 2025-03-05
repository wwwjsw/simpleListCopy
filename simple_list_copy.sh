#!/bin/bash
if [ "$#" -lt 2 ]; then
    echo "usage: $0 <list_files.txt> <directory>"
    exit 1
fi

LISTA="$1"
DESTINO="$2"
BASE="${3:-.}"

while IFS= read -r ARQUIVO || [ -n "$ARQUIVO" ]; do
    ARQUIVO=$(echo "$ARQUIVO" | tr -d '\r' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    CAMINHO_COMPLETO="$BASE/$ARQUIVO"
    
    if [ -f "$CAMINHO_COMPLETO" ]; then
        mkdir -p "$DESTINO/$(dirname "$ARQUIVO")"
        cp "$CAMINHO_COMPLETO" "$DESTINO/$ARQUIVO"
        echo "Copy: $ARQUIVO"
    else
        echo "file not found: '$CAMINHO_COMPLETO'"
    fi
done < "$LISTA"

echo "finish copy!"
