# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SkuleClubs_session',
  :secret      => '480a53c5c9210138823e9ac3cd7cec5a5d3bfb3719e8809c94f056ba9a3d2fd38de28e4d2956f837e3385dfecd98d974c9f873eff58b767c5f547f3fbfc9d5e4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
