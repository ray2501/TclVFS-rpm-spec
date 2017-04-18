#!/usr/bin/tclsh

set arch "x86_64"
set base "tclvfs-tclvfs"
set fileurl "http://tclvfs.cvs.sourceforge.net/viewvc/tclvfs/tclvfs/?view=tar"

set var [list wget $fileurl -O $base.tar.gz]
exec >@stdout 2>@stderr {*}$var

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES
file copy -force tclvfs.doc.patch build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tclvfs.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete $base.tar.gz

