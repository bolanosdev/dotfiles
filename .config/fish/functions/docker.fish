alias dl="docker ps --format '{{.ID}} {{.Names}} {{.Ports}}'"

function ds # stopall
    set -l running (docker ps -q)
    if test -z "$running"
        echo "No running containers to stop."
    else
        echo "Stopping running containers..."
        docker stop $running
    end
    echo "Done!"
end

function dsd # stop and delete all 
    set -l running (docker ps -q)
    if test -z "$running"
        echo "No running containers to stop."
    else
        echo "Stopping running containers..."
        docker stop $running
    end

    set -l all_containers (docker ps -aq)
    if test -z "$all_containers"
        echo "No containers to remove."
    else
        echo "Removing all containers..."
        docker rm $all_containers
    end

    echo "Done!"
end

function dcn
    set -l search $argv[1]
    if test -z "$search"
        echo "Usage: docker_container_matching <search_string>"
        return 1
    end

    docker ps --format '{{.ID}} {{.Names}} {{.Ports}}' | \
        grep -i --color=never "$search" | \
        awk '{ 
            # Ports might have spaces, so join fields 4..N back together
            ports=""; 
            for (i=4; i<=NF; i++) ports = ports $i " "; 
            printf "ID: %s, Name: %s, Ports: %s\n", $1, $2, $3, ports
            # printf "ID: %s, Name: %s, Image: %s, Ports: %s\n", $1, $2, $3, ports

        }'
end

function dcp
    set -l port $argv[1]
    if test -z "$port"
        echo "Usage: docker_container_using_port <port>"
        return 1
    end

    docker ps --format '{{.ID}} {{.Names}} {{.Ports}}' | \
        grep -E "0\.0\.0\.0:$port->|::$port->" | \
        awk '{print "ID: " $1 ", Name: " $2}'
end

function dcsp 
    set -l port $argv[1]
    if test -z "$port"
        echo "Usage: docker_stop_by_port <port>"
        return 1
    end

    set -l container_ids (docker ps --format '{{.ID}} {{.Ports}}' | \
        grep -E "0\.0\.0\.0:$port->|::$port->" | \
        awk '{print $1}')

    if test -z "$container_ids"
        echo "No running containers found exposing port $port"
        return 1
    end

    for id in $container_ids
        echo "Stopping container: $id"
        docker stop $id
    end
end

function dcsn
    set -l search $argv[1]
    if test -z "$search"
        echo "Usage: docker_stop_matching <name_part>"
        return 1
    end

    set -l container_ids (docker ps --format '{{.ID}} {{.Names}}' | \
        grep -i --color=never "$search" | \
        awk '{print $1}')

    if test -z "$container_ids"
        echo "No matching containers found for: $search"
        return 1
    end

    for id in $container_ids
        echo "Stopping container: $id"
        docker stop $id
    end
end



