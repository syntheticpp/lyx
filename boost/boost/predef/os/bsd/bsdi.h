/*
<<<<<<< HEAD
Copyright Rene Rivera 2012-2015
=======
Copyright Redshift Software, Inc. 2012-2013
>>>>>>> github/build-bot-2.1.x
Distributed under the Boost Software License, Version 1.0.
(See accompanying file LICENSE_1_0.txt or copy at
http://www.boost.org/LICENSE_1_0.txt)
*/

#ifndef BOOST_PREDEF_OS_BSD_BSDI_H
#define BOOST_PREDEF_OS_BSD_BSDI_H

#include <boost/predef/os/bsd.h>

/*`
[heading `BOOST_OS_BSD_BSDI`]

[@http://en.wikipedia.org/wiki/BSD/OS BSDi BSD/OS] operating system.

[table
    [[__predef_symbol__] [__predef_version__]]

    [[`__bsdi__`] [__predef_detection__]]
    ]
 */

#define BOOST_OS_BSD_BSDI BOOST_VERSION_NUMBER_NOT_AVAILABLE

<<<<<<< HEAD
#if !defined(BOOST_PREDEF_DETAIL_OS_DETECTED) && ( \
=======
#if !BOOST_PREDEF_DETAIL_OS_DETECTED && ( \
>>>>>>> github/build-bot-2.1.x
    defined(__bsdi__) \
    )
#   ifndef BOOST_OS_BSD_AVAILABLE
#       define BOOST_OS_BSD BOOST_VERSION_NUMBER_AVAILABLE
#       define BOOST_OS_BSD_AVAILABLE
#   endif
#   undef BOOST_OS_BSD_BSDI
#   define BOOST_OS_BSD_BSDI BOOST_VERSION_NUMBER_AVAILABLE
#endif

#if BOOST_OS_BSD_BSDI
#   define BOOST_OS_BSD_BSDI_AVAILABLE
#   include <boost/predef/detail/os_detected.h>
#endif

#define BOOST_OS_BSD_BSDI_NAME "BSDi BSD/OS"

<<<<<<< HEAD
#endif

#include <boost/predef/detail/test.h>
BOOST_PREDEF_DECLARE_TEST(BOOST_OS_BSD_BSDI,BOOST_OS_BSD_BSDI_NAME)
=======
#include <boost/predef/detail/test.h>
BOOST_PREDEF_DECLARE_TEST(BOOST_OS_BSD_BSDI,BOOST_OS_BSD_BSDI_NAME)

#endif
>>>>>>> github/build-bot-2.1.x
