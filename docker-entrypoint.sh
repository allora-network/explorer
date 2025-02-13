#!/bin/sh

# Get all environment variables starting with VITE_
env | grep '^VITE_' | while read -r line; do
    # Extract the variable name
    var_name=$(echo "$line" | cut -d= -f1)
    # Extract the variable value
    var_value=$(echo "$line" | cut -d= -f2-)
    
    # Replace the variable in all JS files
    find /usr/share/nginx/html -type f -name "*.js" -exec sed -i "s|$var_name|$var_value|g" {} \;
done

# Execute CMD
exec "$@"