#!/bin/sh -xe

echo 'travis_fold:start:yum'
yum -y install epel-release
yum -y install rpm-build rpmdevtools copr-cli yum-utils git make python-setuptools
echo 'travis_fold:end:yum'
cd /foo
make iml_copr_build
