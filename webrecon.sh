#!/bin/bash

read -p "Digite o domínio (ex: http://exemplo.com): " url

if [ -z "$url" ]; then
    echo "Domínio não fornecido. Saindo."
    exit 1
fi

wordlist=(
    "app" "admin" "_restrito" "uploads" "login" "home" "css" "js" "prog" "acesso" "_docs" "docs" "AcessoRestrito" 
    "Proibido" "robots.txt" "senha" "passwd" "password" "passwords" "senhas" "key" "keywords" "index" 
    "bkp" "_bkp" "files" "file" "arquivos" "img" "upload" "cadastro" "adm" "rh" "intranet"
    "backup" "config" "configuracao" "configuracoes" "conf" "include" "inc" "info" "information" "database" 
    "data" "db" "sql" "mysql" "oracle" "postgres" "sqlite" "mssql" "mongodb" "web" "www" "public" "private" 
    "blog" "forum" "board" "discussion" "talk" "chat" "support" "help" "faq" "faq.php" "contact" "about" 
    "privacy" "terms" "policy" "feedback" "feedback.php" "register" "signup" "signin" "signout" "subscribe" 
    "unsubscribe" "shop" "store" "cart" "checkout" "buy" "purchase" "order" "billing" "payment" "invoice" 
    "downloads" "upload" "downloads.php" "upload.php" "images" "img" "pictures" "photos" "media" "video" 
    "audio" "press" "news" "events" "event" "calendar" "schedule" "blog" "article" "articles" "story" 
    "stories" "faq" "help" "support" "contact" "info" "about" "services" "projects" "portfolio" "clients" 
    "partners" "team" "members" "people" "jobs" "careers" "employment" "opportunities" "vacancies" 
    "resume" "cv" "signup" "register" "login" "logout" "signout" "subscribe" "unsubscribe" "shop" "store" 
    "cart" "checkout" "buy" "purchase" "order" "billing" "invoice" "downloads" "upload" "images" "img" 
    "pictures" "photos" "media" "video" "audio" "press" "news" "events" "event" "calendar" "schedule" 
    "blog" "article" "articles" "story" "stories" "faq" "help" "support" "contact" "info" "about" "services" 
    "projects" "portfolio" "clients" "partners" "team" "members" "people" "jobs" "careers" "employment" 
    "opportunities" "vacancies" "resume" "cv" "signup" "register" "login" "logout" "signout" "subscribe" 
    "unsubscribe" "membership" "signup" "register" "login" "logout" "signout" "account" "profile" "user" 
    "users" "members" "edit" "update" "change" "delete" "remove" "forgot" "reset" "password" "user" 
    "username" "email" "mail" "contact" "support" "info" "webmaster" "admin" "administrator" "root" 
    "system" "sysadmin" "sys" "manager" "management" "executive" "board" "team" "staff" "directory" 
    "members" "people" "users" "groups" "departments" "division" "section" "branch" "office" "company" 
    "organization" "corporation" "association" "foundation" "group" "org" "inc" "ltd" "llc" "partnership" 
    "team" "committee" "board" "council" "forum" "committee" "project" "projects" "task" "tasks" "plan" 
    "plans" "product" "products" "service" "services" "offer" "offers" "deal" "deals" "sale" "sales" 
    "discount" "discounts" "buy" "purchase" "order" "orders" "billing" "invoice" "pricing" "rates" "price" 
    "prices" "payment" "payments" "subscribe" "unsubscribe" "membership" "signup" "register" "login" 
    "logout" "signout" "account" "profile" "user" "users" "members" "edit" "update" "change" "delete" 
    "remove" "forgot" "reset" "password" "user"
)

subdominios_encontrados=()

# Códigos de cores ANSI
verde_claro="\033[1;32m"
vermelho="\033[0;31m"
reset_cor="\033[0m"

for palavra in "${wordlist[@]}"
do 
    tentativa="$url/$palavra/"
    resposta=$(curl -s -o /dev/null -w "%{http_code}" "$tentativa")
    
    if [ "$resposta" == "200" ]; then
        echo -e "${verde_claro}Tentando: $tentativa - Resposta HTTP: $resposta${reset_cor}"
        echo -e "${verde_claro}Diretório encontrado: $tentativa${reset_cor}"
        subdominios_encontrados+=("$tentativa")
    else
        echo -e "${vermelho}Tentando: $tentativa - Resposta HTTP: $resposta${reset_cor}"
    fi
done

# Exibindo subdomínios encontrados
echo -e "${verde_claro}SUBDOMINIOS ENCONTRADOS:${reset_cor}"
for subdominio in "${subdominios_encontrados[@]}"
do 
    echo -e "${verde_claro}$subdominio${reset_cor}"
done
