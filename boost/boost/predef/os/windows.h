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

#ifndef BOOST_PREDEF_OS_WINDOWS_H
#define BOOST_PREDEF_OS_WINDOWS_H

#include <boost/predef/version_number.h>
#include <boost/predef/make.h>

/*`
[heading `BOOST_OS_WINDOWS`]

[@http://en.wikipedia.org/wiki/Category:Microsoft_Windows Microsoft Windows] operating system.

[table
    [[__predef_symbol__] [__predef_version__]]

    [[`_WIN32`] [__predef_detection__]]
    [[`_WIN64`] [__predef_detection__]]
    [[`__WIN32__`] [__predef_detection__]]
    [[`__TOS_WIN__`] [__predef_detection__]]
    [[`__WINDOWS__`] [__predef_detection__]]
    ]
 */

#define BOOST_OS_WINDOWS BOOST_VERSION_NUMBER_NOT_AVAILABLE

<<<<<<< HEAD
#if !defined(BOOST_PREDEF_DETAIL_OS_DETECTED) && ( \
=======
#if !BOOST_PREDEF_DETAIL_OS_DETECTED && ( \
>>>>>>> github/build-bot-2.1.x
    defined(_WIN32) || defined(_WIN64) || \
    defined(__WIN32__) || defined(__TOS_WIN__) || \
    defined(__WINDOWS__) \
    )
#   undef BOOST_OS_WINDOWS
#   define BOOST_OS_WINDOWS BOOST_VERSION_NUMBER_AVAILABLE
#endif

#if BOOST_OS_WINDOWS
#   define BOOST_OS_WINDOWS_AVAILABLE
#   include <boost/predef/detail/os_detected.h>
#endif

#define BOOST_OS_WINDOWS_NAME "Microsoft Windows"

<<<<<<< HEAD
#endif

#include <boost/predef/detail/test.h>
BOOST_PREDEF_DECLARE_TEST(BOOST_OS_WINDOWS,BOOST_OS_WINDOWS_NAME)
=======
#include <boost/predef/detail/test.h>
BOOST_PREDEF_DECLARE_TEST(BOOST_OS_WINDOWS,BOOST_OS_WINDOWS_NAME)

#endif
>>>>>>> github/build-bot-2.1.x
