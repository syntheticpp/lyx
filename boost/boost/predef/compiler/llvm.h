/*
<<<<<<< HEAD
Copyright Rene Rivera 2008-2015
=======
Copyright Redshift Software, Inc. 2008-2013
>>>>>>> github/build-bot-2.1.x
Distributed under the Boost Software License, Version 1.0.
(See accompanying file LICENSE_1_0.txt or copy at
http://www.boost.org/LICENSE_1_0.txt)
*/

#ifndef BOOST_PREDEF_COMPILER_LLVM_H
#define BOOST_PREDEF_COMPILER_LLVM_H

<<<<<<< HEAD
/* Other compilers that emulate this one need to be detected first. */

#include <boost/predef/compiler/clang.h>

=======
>>>>>>> github/build-bot-2.1.x
#include <boost/predef/version_number.h>
#include <boost/predef/make.h>

/*`
[heading `BOOST_COMP_LLVM`]

[@http://en.wikipedia.org/wiki/LLVM LLVM] compiler.

[table
    [[__predef_symbol__] [__predef_version__]]

    [[`__llvm__`] [__predef_detection__]]
    ]
 */

#define BOOST_COMP_LLVM BOOST_VERSION_NUMBER_NOT_AVAILABLE

#if defined(__llvm__)
<<<<<<< HEAD
#   define BOOST_COMP_LLVM_DETECTION BOOST_VERSION_NUMBER_AVAILABLE
#endif

#ifdef BOOST_COMP_LLVM_DETECTION
#   if defined(BOOST_PREDEF_DETAIL_COMP_DETECTED)
#       define BOOST_COMP_LLVM_EMULATED BOOST_COMP_LLVM_DETECTION
#   else
#       undef BOOST_COMP_LLVM
#       define BOOST_COMP_LLVM BOOST_COMP_LLVM_DETECTION
#   endif
#   define BOOST_COMP_LLVM_AVAILABLE
#   include <boost/predef/detail/comp_detected.h>
=======
#   undef BOOST_COMP_LLVM
#   define BOOST_COMP_LLVM BOOST_VERSION_NUMBER_AVAILABLE
#endif

#if BOOST_COMP_LLVM
#   define BOOST_COMP_LLVM_AVAILABLE
>>>>>>> github/build-bot-2.1.x
#endif

#define BOOST_COMP_LLVM_NAME "LLVM"

<<<<<<< HEAD
#endif

#include <boost/predef/detail/test.h>
BOOST_PREDEF_DECLARE_TEST(BOOST_COMP_LLVM,BOOST_COMP_LLVM_NAME)

#ifdef BOOST_COMP_LLVM_EMULATED
#include <boost/predef/detail/test.h>
BOOST_PREDEF_DECLARE_TEST(BOOST_COMP_LLVM_EMULATED,BOOST_COMP_LLVM_NAME)
=======
#include <boost/predef/detail/test.h>
BOOST_PREDEF_DECLARE_TEST(BOOST_COMP_LLVM,BOOST_COMP_LLVM_NAME)


>>>>>>> github/build-bot-2.1.x
#endif
