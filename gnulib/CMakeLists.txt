cmake_minimum_required(VERSION 3.7)

project(gnulib C)

##########################################################################################

# {{{ define function check_if_have_header_files(...)
function(check_if_have_header_files)
    include(CheckIncludeFiles)
    foreach(item ${ARGV})
        string(REPLACE "/" "_" item2 "${item}")
        string(REPLACE "." "_" item2 "${item2}")
        string(TOUPPER "${item2}" item2)
        check_include_files(${item} HAVE_${item2})
        if (NOT HAVE_${item2})
            set(HAVE_${item2} 0)
        endif()
        message("HAVE_${item2}=${HAVE_${item2}}")
    endforeach()
endfunction()
# }}}

##########################################################################################

# {{{ define function check_if_have_functions(...)
function(check_if_have_functions)
    include(CheckFunctionExists)
    foreach(item ${ARGV})
        string(TOUPPER ${item} item2)
        check_function_exists(${item} HAVE_${item2})
        if (NOT HAVE_${item2})
            set(HAVE_${item2} 0)
        endif()
        message("HAVE_${item2}=${HAVE_${item2}}")
    endforeach()
endfunction()
# }}}

##########################################################################################

# {{{ checking

check_if_have_header_files(alloca.h fcntl.h inttypes.h langinfo.h libintl.h fnmatch.h malloc.h minix/config.h netdb.h os.h stdint.h stdio.h stdlib.h strings.h string.h sys/param.h sys/stat.h sys/time.h sys/types.h unistd.h wchar.h)

check_if_have_functions(alloca btowc getpagesize isascii iswprint localeconv fnmatch malloc mbrtowc memchr memmove mempcpy memset nl_langinfo realloc regcomp re_comp setlocale strchr strrchr)

##########################################################################################

configure_file(config.h.in config.h @ONLY)

add_definitions(-DHAVE_CONFIG_H)
add_definitions(-D_GNU_SOURCE)

include_directories(${PROJECT_BINARY_DIR})
include_directories(${PROJECT_SOURCE_DIR})

if (NOT HAVE_REGCOMP)
    list(APPEND SRCS regex.c)
endif()

if (NOT HAVE_FNMATCH)
    list(APPEND SRCS fnmatch.c wmempcpy.c)
endif()

if (NOT HAVE_NL_LANGINFO)
    list(APPEND SRCS nl_langinfo.c)
endif()

if (NOT HAVE_MEMPCPY)
    list(APPEND SRCS mempcpy.c)
endif()

if (SRCS)
    add_library(gnu STATIC ${SRCS})
endif()
