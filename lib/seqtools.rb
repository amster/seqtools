# Sequence Mediaworks sharable toolset
#
# *Author*::    Amy Lee, amy@seqmedia.com
# *Copyright*:: Copyright (c) 2009 - 2010 by Amy Lee
# *License*::   Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php

require 'digest/sha1'

class Seqtools
  class Arrays
    def self.empty? (arr)
      arr.nil? || to_array(arr).empty?
    end
    
    # Returns a single random item from an array
    def self.random_item (arr)
      arr.nil? || arr.length < 1 ? nil : arr[rand(arr.length)]
    end
    
    # Returns an array without blank elements.  Always returns an Array, possibly a zero-length array.
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

  class Files
    def self.get_all_in_directory (start_dir, pattern = /^.+$/, search_subdirectories = true)
      files = []
      
      d = Dir.new(start_dir)
      if d then
        d.entries.each do |ent|
          next if ent == '.' || ent == '..'

          # Save file or dig deeper?
          full_path = "#{start_dir}/#{ent}"
          files << full_path if File.file?(full_path) && ent.match(pattern)
          files += get_all_in_directory(full_path, pattern, search_subdirectories) if search_subdirectories && File.directory?(full_path)
        end
      end
      
      files
    end
  end
  
  # =========================================================================

  class HttpRequests
    # Extract the URI from the HTTP_REFERER of an HTTP request
    def self.uri_from_referrer (request)
      request.env['HTTP_REFERER'].to_s.sub(/^[^\/]+:\/\/[^\/]+\//, '/')
    end
  end

  # =========================================================================
  
  class Strings
    def self.add_url_param (url, param_key, param_val)
      return '' if url.blank?
      return url if param_key.blank?
      
      "#{url}#{url.include?('?') ? '&' : '?'}#{CGI::escape(param_key)}=#{CGI::escape(param_val)}"
    end

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
    
    # Accepts geocodes like "37.754977,-122.446779" or "(37.754977,-122.446779)"
    def self.is_geocode? (str)
      # Force to string, remove a few extraneous spaces
      s = str.
          to_s.                 # Force to string
          gsub(/\s+/, ' ').     # Collapse space characters
          strip.                # Get rid of outside spaces
          gsub(/\(\s/, '(').    # Get rid of spaces around parens
          gsub(/\s\)/, ')').
          gsub(/\s?,\s?/, ',')  # Get rid of spaces around the comma
          
      # Now, is it?  Note: the !! just forces the result to true/false
      !!(s.match(/^-?\d+(?:\.\d+)?,-?\d+(?:\.\d+)?$/) ||       # Without parens
      s.match(/^\(-?\d+(?:\.\d+)?,-?\d+(?:\.\d+)?\)$/))      # With parens
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
