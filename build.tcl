#!/usr/bin/tclsh

set arch "x86_64"
set base "tclvfs-tclvfs"
set fileurl "https://core.tcl-lang.org/tclvfs/tarball/8cdab08997/tclvfs-8cdab08997.tar.gz"

set var [list wget2 $fileurl -O tclvfs.tar.gz]
exec >@stdout 2>@stderr {*}$var

set var [list tar xzvf tclvfs.tar.gz]
exec >@stdout 2>@stderr {*}$var

file delete tclvfs.tar.gz

set var [list mv tclvfs-8cdab08997 tclvfs]
exec >@stdout 2>@stderr {*}$var

set var [list tar czvf tclvfs-tclvfs.tar.gz tclvfs]
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
file delete -force tclvfs
file delete $base.tar.gz
