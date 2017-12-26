#!/bin/bash

sudo createrepo --update $1
#createrepo --update <repo_path>
# $1 refers to the path of YUM repo
