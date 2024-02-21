function temp --description "Create a temporary directory and switch to it."
    set temp_name temp-(openssl rand -base64 21 | tr -dc 'a-zA-Z0-9' | cut -c-8)
    command mkdir "/private/tmp/$temp_name"
    cd "/private/tmp/$temp_name"
end
