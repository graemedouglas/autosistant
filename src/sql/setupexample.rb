# A quick script for setting up all of the databases.

require 'rubygems'
require 'sqlite3'

# Delete the databases, if they are present.
puts system('rm ../sqlite/config.db')
puts system('rm ../sqlite/product.db')
puts system('rm ../sqlite/userstore.db')

# Create the databases.
puts system('sqlite3 ../sqlite/config.db < config.sql')
puts system('sqlite3 ../sqlite/product.db < product.sql')
puts system('sqlite3 ../sqlite/userstore.db < userstore.sql')

# Run example setup scripts.
puts system('sqlite3 ../sqlite/config.db < config-example.sql')
puts system('sqlite3 ../sqlite/product.db < product-example.sql')

# Output any output.
puts $_
