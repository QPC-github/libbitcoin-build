.template 0
###############################################################################
# Copyright (c) 2014-2015 libbitcoin developers (see COPYING).
#
# GSL generate bindings.sh.
#
# This is a code generator built using the iMatix GSL code generation
# language. See https://github.com/imatix/gsl for details.
###############################################################################
# Macros
###############################################################################
.endtemplate
.template 1
.
.macro bindings_content_sh(interface)
# Script to build language bindings for $(my.interface) c++ public interfaces.
# This script requires SWIG - "Simplified Wrapper and Interface Generator".
# SWIG is a simple tool available for most platforms at http://www.swig.org
# Add the path to swig.exe to the path of this process or your global path.

# Exit this script on the first error.
set -e

echo Generating $(my.interface) bindings...

# Do everything relative to this file location.
PWD="`dirname "$0"`"
pushd `cd "${PWD}" && pwd`

# Clean and make required directories.
rm -rf "bindings/java/wrap"
rm -rf "bindings/java/proxy/org/libbitcoin/$(my.interface)"
rm -rf "bindings/python/wrap"
rm -rf "bindings/python/proxy"

mkdir -p "bindings/java/wrap"
mkdir -p "bindings/java/proxy/org/libbitcoin/$(my.interface)"
mkdir -p "bindings/python/wrap"
mkdir -p "bindings/python/proxy"

# Generate bindings.
swig -c++ -java -outdir "bindings/java/proxy/org/libbitcoin/$(my.interface)" -o "bindings/java/wrap/$(my.interface).cpp" "bindings/$(my.interface).swg"
swig -c++ -python -outdir "bindings/python/proxy" -o "bindings/python/wrap/$(my.interface).cpp" "bindings/$(my.interface).swg"

# Restore directory.
popd
.
.endmacro # bindings_content_sh
.
.endtemplate
.template 0
###############################################################################
# Generation
###############################################################################
function generate_bindings_sh()
for generate.repository by name as _repository
    define my.out_file = "$(_repository.name)/bindings.sh"
    notify(my.out_file)
    output(my.out_file)
    
    shebang("bash")
    copyleft(_repository.name)
    define my.interface = bitcoin_to_include(_repository.name)
    bindings_content_sh(my.interface)

    close
endfor _repository
endfunction # generate_bindings_sh
.endtemplate




