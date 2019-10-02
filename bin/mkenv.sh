#! /bin/bash
# カレントディレクトリのパスを生成する。
#
# 生成されるパスは、動作環境によって下記のように生成されます。
# コンテナの場合
#  引数に指定されたコンテナ名のマウントポイントのボリューム
# コンテナ以外の場合
#  カレントディレクトリ

CONTNAME=${1:-dev}
VOLNAME=${2:-dev_home}

printf VOLHOME=
if [ ! -e /.dockerenv ]
then
    echo $(pwd)
    exit 0
fi

eval $(docker inspect --format="{{json .Mounts}}" $CONTNAME | jq  '.[] | select(.Name =="'$VOLNAME'") | {VOLPATH: .Source, MOUNTPATH: .Destination}' | grep ":" | sed -e 's/[ ]*"\([A-Z]*\)": "\(.*\)".*$/\1=\2/')
printf $VOLPATH
pwd | sed -e 's#'$MOUNTPATH'##'

