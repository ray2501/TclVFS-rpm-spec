%{!?directory:%define directory /usr}

%define buildroot %{_tmppath}/%{name}

Name:          tclvfs
Summary:       Tcl Virtual Filesystems extension
Version:       1.4.2_20231123
Release:       0
License:       TCL
Group:         Development/Libraries/Tcl
Source:        tclvfs-tclvfs.tar.gz
Patch0:        %{name}.doc.patch
URL:           https://core.tcl.tk/tclvfs/home
Buildrequires: autoconf
Buildrequires: tcl-devel >= 8.4
Requires: tcl >= 8.4
BuildRoot:     %{buildroot}

%description
The TclVfs project aims to provide an extension to the Tcl language
which allows Virtual Filesystems to be built using Tcl scripts only.
It is also a repository of such Tcl-implemented filesystems (metakit,
zip, ftp, tar, http, webdav, namespace, url).

%prep
%setup -q -n %{name}
%patch 0 -p1

%build
./configure \
	--prefix=%{directory} \
	--exec-prefix=%{directory} \
	--libdir=%{directory}/%{_lib} \
	--mandir=%{directory}/share/man \
	--with-tcl=%{directory}/%{_lib}
make 

%install
make DESTDIR=%{buildroot} pkglibdir=%{tcl_archdir}/vfs%{version} install

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%{tcl_archdir}
%{directory}/share/man/mann
