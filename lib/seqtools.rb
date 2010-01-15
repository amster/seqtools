# Sequence Mediaworks sharable toolset
#
# *Author*::    Amy Lee, amy@sequencemediaworks.com
# *Copyright*:: Copyright (c) 2010 by Amy Lee
# *License*::   Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php

require 'digest/sha1'

class Seqtools
  class Arrays
  end
  
  # =========================================================================
  
  class Strings
    # Validates an email address
    #
    # *email*:: (String) Email to check.
    # *Return*:: (String) Email (forced to String)
    def self.email_valid? (email)
      email = email.to_s

      raise ArgumentError, 'Email cannot be blank' if email.blank?
      raise ArgumentError, 'Email cannot have spaces' if email.match(/\s/)
      raise ArgumentError, 'Email is not formatted correctly' if !email.match(/^[A-Z0-9._%+-]+\@(([A-Z0-9.-]+)\.)+[A-Z]{2,4}$/i)

      email
    end

    # .......................................................................

    # Does a 1-way SHA1 hash on a stripped password w/ salt
    #
    # *password*:: (String) Password to hash---spaces will be stripped!
    # *salt*:: (String) Salt string
    def self.password_hash (password, salt)
      Digest::SHA1.hexdigest(password.to_s.strip + ':' + salt.to_s.strip)
    end
  end
end

# [end]