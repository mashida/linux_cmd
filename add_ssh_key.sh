#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Использование: $0 <имя_ключа_в_~/.ssh>" >&2
  exit 1
fi

KEY="$HOME/.ssh/$1"

[[ -f $KEY ]] || { echo "Ошибка: $KEY не найден"; exit 2; }

# 1) всегда стартуем агент  
eval "$(ssh-agent -s)" >/dev/null

# 2) сразу добавляем ключ  
ssh-add "$KEY" && echo "Ключ $1 добавлен"
