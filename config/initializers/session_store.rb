# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_seqtools_session',
  :secret      => '0f80ea4d599aa0af7f4b9d280b35bbc5104a85776615b863280f3ec8441bce900c9737bc02089ecf5af4b2f366d4ad509e1d3e0d8bead7d28db6368f91c20d17'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
