#!/bin/sh

echo "Starting environment variable replacement..."

# Get all environment variables starting with VITE_
env | grep '^VITE_' | while read -r line; do
    # Extract the variable name and value
    var_name=$(echo "$line" | cut -d= -f1)
    var_value=$(echo "$line" | cut -d= -f2-)
    
    echo "Processing: $var_name = $var_value"
    
    # Find files containing the variable
    matching_files=$(find /usr/share/nginx/html -type f -name "*.js" -exec grep -l "$var_name" {} \;)
    echo "Files containing $var_name:"
    echo "$matching_files"
    
    # Replace in all JS files
    find /usr/share/nginx/html -type f -name "*.js" -exec sed -i "s|\"$var_name\"|\"$var_value\"|g" {} \;
    find /usr/share/nginx/html -type f -name "*.js" -exec sed -i "s|'$var_name'|'$var_value'|g" {} \;
done

echo "Environment variable replacement complete"

# Execute CMD
exec "$@"