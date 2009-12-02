# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_coolpur_session',
  :secret      => '49087b5ed2c317be676b462257520d1b0c183037d9efea7e3f31c8dde73ac65aabe9d60535a25b961faf87a734263a8a4da41c58b7042e78f1e99bf4358fdb2e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
