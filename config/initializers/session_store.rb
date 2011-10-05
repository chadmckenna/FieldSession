# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_FieldSession_session',
  :secret      => '72eca7d3cee6f8461909a76e7a88bd4d3df3107835c0293fa858ff6d0a29629b4b77dc477b674fa82c70aca9e4f60d81cb7402a333cc43a27a3ed4c95dae416b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
