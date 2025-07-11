# add_ssh_key.sh

Минималистичный Bash-скрипт для старта `ssh-agent` и добавления приватного ключа из `~/.ssh`

## Описание
- ✅ Всегда запускает `ssh-agent`, даже если он не запущен  
- 🔍 Проверяет наличие файла приватного ключа  
- ➕ Добавляет ключ в агент без лишних проверок  
- ⚡️ Не требует установки — можно сразу запускать через `curl | bash`

## Код скрипта
```bash
#!/usr/bin/env bash
set -euo pipefail

# Проверка аргумента
[[ $# -eq 1 ]] || {
  echo "Использование: $0 <имя_ключа_в_~/.ssh>" >&2
  exit 1
}

KEY="$HOME/.ssh/$1"

# Убедимся, что файл есть
[[ -f $KEY ]] || {
  echo "Ошибка: $KEY не найден" >&2
  exit 2
}

# 1) Запускаем ssh-agent
eval "$(ssh-agent -s)" >/dev/null

# 2) Добавляем ключ
ssh-add "$KEY" \
  && echo "✔ Ключ '$1' добавлен в ssh-agent"
```
Ниже в примерах `id_rsa` - это название вашего ключа. Если ваш ключ называется `github`, то поменяйте название ключа в примере на `github`.

## Пример одиночного запуска
```bash
eval "$(ssh-agent -s)"
source <(curl -sL https://raw.githubusercontent.com/mashida/linux_cmd/main/add_ssh_key.sh) id_rsa
```

## Пример «установки» в `~/bin`
```bash
curl -sL https://raw.githubusercontent.com/mashida/linux_cmd/main/add_ssh_key.sh \
  -o ~/bin/add_ssh_key.sh \
  && chmod +x ~/bin/add_ssh_key.sh

# Убедитесь, что ~/bin/ в PATH, и дальше:
add_ssh_key.sh id_rsa
```
