/*
 * Copyright (c) 2014 Glen Fernandes
 *
 * Distributed under the Boost Software License, Version 1.0. (See
 * accompanying file LICENSE_1_0.txt or copy at
 * http://www.boost.org/LICENSE_1_0.txt)
 */

#ifndef BOOST_NONCOPYABLE_HPP
#define BOOST_NONCOPYABLE_HPP

// The header file at this path is deprecated;
// use boost/core/noncopyable.hpp instead.

#include <boost/core/noncopyable.hpp>

<<<<<<< HEAD
#endif
=======
#include <boost/config.hpp>

namespace boost {

//  Private copy constructor and copy assignment ensure classes derived from
//  class noncopyable cannot be copied.

//  Contributed by Dave Abrahams

namespace noncopyable_  // protection from unintended ADL
{
  class noncopyable
  {
   protected:
#ifndef BOOST_NO_DEFAULTED_FUNCTIONS
    BOOST_CONSTEXPR noncopyable() = default;
    ~noncopyable() = default;
#else
    noncopyable() {}
      ~noncopyable() {}
#endif
#ifndef BOOST_NO_DELETED_FUNCTIONS
        noncopyable( const noncopyable& ) = delete;
        noncopyable& operator=( const noncopyable& ) = delete;
#else
    private:  // emphasize the following members are private
      noncopyable( const noncopyable& );
      noncopyable& operator=( const noncopyable& );
#endif
  };
}

typedef noncopyable_::noncopyable noncopyable;

} // namespace boost

#endif  // BOOST_NONCOPYABLE_HPP_INCLUDED
>>>>>>> github/build-bot-2.1.x
