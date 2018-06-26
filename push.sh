set -e


function push_docker_repo() {
    local repo=$1
    local tags=$2
    local cwd=$(pwd)

    cd ${repo}

    echo "-- \x1b[32mPushing \x1b[35mnovopl/${repo}:latest\x1b[0m"
    docker push novopl/${repo}:latest

    for tag in ${tags}; do
        echo "-- \x1b[32mPushing \x1b[35mnovopl/${repo}:${tag}\x1b[0m"
        docker push novopl/${repo}:${tag}
    done

    cd ${cwd}
}

push_docker_repo python36 "dev django flask circleci"
