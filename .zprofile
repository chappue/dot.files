# .zprofile -*- mode: shell-script; coding: euc-jp -*-

#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# Select OS type

case $OSTYPE {
  sunos*)	export SYSTEM=sun ;;
  solaris*)	export SYSTEM=sol ;;
  irix*)	export SYSTEM=sgi ;;
  osf*)		export SYSTEM=dec ;;
  linux*)	export SYSTEM=gnu ;;
  freebsd*)	export SYSTEM=bsd ;;
  darwin*)	export SYSTEM=darwin ;;    # MacOSX
}

