# Sequence Mediaworks sharable toolset
#
# *Author*::    Amy Lee, amy@sequencemediaworks.com
# *Copyright*:: Copyright (c) 2010 by Amy Lee
# *License*::   Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php

require 'digest/sha1'

class Seqtools
  class Arrays
    def self.empty? (arr)
      arr.nil? || to_array(arr).empty?
    end
    
    def self.remove_blanks (arr)
      to_array(arr).select { |i| !i.blank? }
    end
    
    # Forces each array item to a String then strips spaces
    def self.strip (arr)
      to_array(arr).map { |i| i.to_s.strip }
    end

    # Forces each array item to a String then strips spaces
    def self.strip_and_remove_blanks (arr)
      remove_blanks(to_array(arr).map { |i| i.to_s.strip })
    end

    # Makes an array out of item_or_array if it isn't already.
    def self.to_array (item_or_array)
      item_or_array.is_a?(Array) ? item_or_array : [item_or_array]
    end
  end
  
  # =========================================================================

  class HttpRequests
    # Extract the URI from the HTTP_REFERER of an HTTP request
    def self.uri_from_referrer (request)
      request.env['HTTP_REFERER'].sub(/^[^\/]+:\/\/[^\/]+\//, '/')
    end
  end

  # =========================================================================
  
  class Strings
    # Validates an email address (stripping extra stuff), returning the email if all is OK.  Otherwise exceptions are thrown.
    def self.email_valid? (email)
      email = email.to_s.strip

      raise ArgumentError, 'Email cannot be blank' if email.blank?
      raise ArgumentError, 'Email cannot have spaces' if email.match(/\s/)
      raise ArgumentError, 'Email is not formatted correctly' if !email.match(/^[A-Z0-9._%+-]+\@(([A-Z0-9.-]+)\.)+[A-Z]{2,4}$/i)

      email
    end

    # Returns "" if str is blank, otherwise returns the original.
    def self.empty_if_blank (str)
      str.blank? ? '' : str
    end

    # Returns a nil if str is blank, otherwise returns the original.
    def self.nil_if_blank (str)
      str.blank? ? nil : str
    end

    # Does a 1-way SHA1 hash on a stripped password w/ salt
    #
    # *password*:: (String) Password to hash---spaces will be stripped!
    # *salt*:: (String) Salt string
    #
    # *Return*:: (String) Encoded password.
    def self.password_hash (password, salt)
      Digest::SHA1.hexdigest(password.to_s.strip + ':' + salt.to_s.strip)
    end

    # Converts str to a String, strips it, and returns str if not blank (otherwise returns "")
    def self.strip_or_empty (str)
      str.to_s.strip!
    end

    # Converts str to a String, strips it, and returns str if not blank (otherwise returns nil)
    def self.strip_or_nil (str)
      str.to_s.strip!
      str.blank? ? nil : str
    end
  end
end

# [end]
