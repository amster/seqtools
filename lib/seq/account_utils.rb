# *Author*::        amy@panelfolio.com
# *Copyright*::     Sequence Mediaworks

class Pf::AccountUtils
  # Validates a password, raising an exception on error.  (See code below for rules.)
  #
  # *password*:: (String) Password to check.
  # *Return*:: (String) Password (forced to String)
  def self.password_valid? (password)
    password = password.to_s
    
    raise ArgumentError, 'Password cannot be blank' if password.blank?
    raise ArgumentError, 'Password too short (min 6 chars)' if password.length < 6
    raise ArgumentError, 'Password too long (max 32 chars)' if password.length > 32
    raise ArgumentError, 'Password cannot have spaces or tabs' if password.match(/\s/)
    raise ArgumentError, 'Password must have a number in it' if !password.match(/\d/)
    
    password
  end

  # .........................................................................
  
  # Validates a username, raising an exception on error.  (See code below for rules.)
  #
  # *username*:: (String) Username to check.
  # *Return*:: (String) Username (forced to String)
  def self.username_valid? (username)
    username = username.to_s
    
    raise ArgumentError, 'Username cannot be blank' if username.blank?
    raise ArgumentError, 'Username too short (min 4 chars)' if username.length < 4
    raise ArgumentError, 'Username too long (max 32 chars)' if username.length > 32
    raise ArgumentError, 'Username has invalid chars (only lowercase letters, numbers, and dashes allowed)' if !username.match(/^[a-z0-9\-]+$/)
    raise ArgumentError, 'Username must begin with a lowercase letter or a number' if !username.match(/^[a-z0-9]/)
    raise ArgumentError, 'Username must end with a lowercase letter or a number' if !username.match(/[a-z0-9]$/)
    raise ArgumentError, 'Username cannot have two dashes in a row' if username.match(/--/)
    
    username
  end
end
