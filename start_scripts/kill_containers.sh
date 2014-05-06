docker ps | awk '{print $1}' | grep -v CONTAINER | xargs docker kill
