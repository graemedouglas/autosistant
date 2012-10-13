################################################################################
# Author:		Graeme Douglas
# Create date:		2012/09/29
# Last Modified:	2012/09/29/17:09
##
# Configuration options for the project.
################################################################################

### Databases ##################################################################
ConfigDB = SQLite3::Database.new('sqlite/config.db')
ProductDB = SQLite3::Database.new('sqlite/product.db')
UserStoreDB = SQLite3::Database.new('sqlite/userstore.db')
# Make sure all database results are returned as hashes.
ConfigDB.results_as_hash = true
ProductDB.results_as_hash = true
UserStoreDB.results_as_hash = true
################################################################################

### Database-stored constants ##################################################
Actions = ConfigDB.execute("SELECT * FROM actions;")
ActionPhrases = ConfigDB.execute("SELECT * FROM actionphrases;")
IdentCats = ConfigDB.execute("SELECT * FROM identifiercategories;")
################################################################################

### System options #############################################################
# The resellers name.
# TODO: Get from DB.
CompanyName = "Stan's Auto Parts Incorporated"
################################################################################

### Developer options ##########################################################
DEBUG_ON = true
################################################################################
