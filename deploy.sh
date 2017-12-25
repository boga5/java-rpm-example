#!/bin/bash

yum clean all
yum repolist all
yum install $1
