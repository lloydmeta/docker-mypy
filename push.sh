#!/usr/bin/env bash

set -e;

BASE_TAG="lloydmeta/mypy:python";
VERSION="";
PYTHON_VERSION="";

while getopts v:p: OPT
do
    case $OPT in
      "v") VERSION=${OPTARG};;
      "p") PYTHON_VERSION=${OPTARG};;
    esac
done

if [ -z "${VERSION}" ] || [ -z "${PYTHON_VERSION}" ]; then
    echo "[ERROR] Both version (-v) and Python version (-p) need to be passed.";
    exit 1;
fi

VERSIONED_TAG="${BASE_TAG}-${PYTHON_VERSION}_${VERSION}";
LATEST_TAG="${BASE_TAG}-${PYTHON_VERSION}_latest";
echo "Building for Python ${PYTHON_VERSION} as ${VERSIONED_TAG} and ${LATEST_TAG}";
docker build --build-arg PYTHON_VERSION=${PYTHON_VERSION} . -t ${VERSIONED_TAG} -t ${LATEST_TAG};
echo "Pushing ...";
docker push ${VERSIONED_TAG};
docker push ${LATEST_TAG};

set +e;