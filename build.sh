set -e


function build_docker_repo() {
    local repo=$1
    local tags=$2
    local cwd=$(pwd)

    cd ${repo}

    echo "-- \x1b[32mBuilding \x1b[35mnovopl/${repo}\x1b[0m"
    docker build . -t novopl/${repo} -f Dockerfile

    for tag in ${tags}; do
        echo "-- \x1b[32mBuilding \x1b[35mnovopl/${repo}:${tag}\x1b[0m"
        docker build . -t novopl/${repo}:${tag} -f Dockerfile.${tag}
    done

    cd ${cwd}
}

build_docker_repo python36 "dev django flask circleci"

