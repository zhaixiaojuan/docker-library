#!/bin/bash

ORGANIZATION=$1
REPOSITORY=$2
TAG=$3

NEW_PATH="$ORGANIZATION/$REPOSITORY/$TAG"
mkdir -pv $NEW_PATH
cp Makefile.buildx-template $NEW_PATH/Makefile
cp docker-bake.hcl $NEW_PATH/docker-bake.hcl

pushd $NEW_PATH
sed -i "s/T_REGISTRY/cr.loongnix.cn/g" Makefile
sed -i "s/T_ORGANIZATION/$ORGANIZATION/g" Makefile
sed -i "s/T_REPOSITORY/$REPOSITORY/g" Makefile
sed -i "s/T_TAG/$TAG/g" Makefile
popd

pushd $NEW_PATH
sed -i "s/T_REGISTRY/cr.loongnix.cn/g" docker-bake.hcl
sed -i "s/T_ORGANIZATION/$ORGANIZATION/g" docker-bake.hcl
sed -i "s/T_REPOSITORY/$REPOSITORY/g" docker-bake.hcl
sed -i "s/T_TAG/$TAG/g" docker-bake.hcl
popd
