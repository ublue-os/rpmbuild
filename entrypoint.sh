#!/bin/bash

SPEC_FILE="$1"
rpmdev-setuptree
ls -lah /github/workspace/ /github/workspace/dist/ /github/home/rpmbuild/SOURCES/
cp /github/workspace/dist/*.tar.gz /github/home/rpmbuild/SOURCES/
ls -lah /github/workspace/dist/ /github/home/rpmbuild/SOURCES/

dnf builddep -y $SPEC_FILE
rpmbuild -ba $SPEC_FILE

RPM_NAME=
ls -lah /github/home/rpmbuild/RPMS
mkdir -p rpmbuild/SRPMS
mkdir -p rpmbuild/RPMS
cp /github/home/rpmbuild/SRPMS/* rpmbuild/SRPMS
cp -R /github/home/rpmbuild/RPMS/. rpmbuild/RPMS/
ls -la rpmbuild/SRPMS rpmbuild/RPMS

echo "source_rpm_dir_path=rpmbuild/SRPMS/" >> $GITHUB_OUTPUT
echo "source_rpm_path=rpmbuild/SRPMS/$(ls rpmbuild/SRPMS)" >> $GITHUB_OUTPUT
echo "source_rpm_name=$(ls rpmbuild/SRPMS)" >> $GITHUB_OUTPUT
echo "rpm_dir_path=rpmbuild/RPMS/" >> $GITHUB_OUTPUT
