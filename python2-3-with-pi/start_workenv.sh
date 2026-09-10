# put this script in your repo root.
# running it will start the docker, mirroring the REPO & your ~/.pi dir

REPO_DIR=$(dirname "${BASH_SOURCE[0]}" | xargs realpath)

# mirror REPO into docker
# mirror the .pi directory so settings & extensions carry over
# currently removed the "--rm" flag; dockers will persist after closing
docker run \
	-it \
	-v "$REPO_DIR":/workdir \
	-v ~/.pi:/settings/.pi \
	-w /workdir \
	python2-3-with-pi:latest \
	bash
