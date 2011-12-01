#!/bin/bash

count=0

if [[ $# > 0 ]]; then
  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "usage:" $0 "[-d | --drop | -h | --help]"
    echo "This scrip migrates both the application database as well as the test database."
    echo "-d, --drop"
    echo -e "\tdrop and re-create databases"
    echo "-h, --help"
    echo -e "\tprint this message"
    exit 1
  fi
  if [[ $1 == "-d" ]]; then
    rake db:drop
    if [[ $? != 0 ]]; then
      list[count]='rake db:drop'
      count=`expr $count + 1`
    fi
    rake db:drop RAILS_ENV=test
    if [[ $? != 0 ]]; then
      list[count]='rake db:drop RAILS_ENV=test'
      count=`expr $count + 1`
    fi
    rake db:create
    if [[ $? != 0 ]]; then
      list[count]='rake db:create'
      count=`expr $count + 1`
    fi
    rake db:create RAILS_ENV=test
    if [[ $? != 0 ]]; then
      list[count]='rake db:create RAILS_ENV=test'
      count=`expr $count + 1`
    fi
  fi
fi
rake db:migrate
if [[ $? != 0 ]]; then
      list[count]='rake db:migrate'
      count=`expr $count + 1`
fi
rake db:migrate RAILS_ENV=test
if [[ $? != 0 ]]; then
      list[count]='rake db:migrate RAILS_ENV=test'
      count=`expr $count + 1`
fi

if [[ $count != 0 ]]; then
  echo "Something's fishy here:"
  for (( i = 0; i < $count; i++ )); do
    echo ${list[i]}
  done
fi

