################################################################################
# SciTE -- User configuration Makefile
# 
# This makefile helps to install the SciTEUser-properties file to your home
# directory.
################################################################################

SC_USER_PROPS			:= SciTEUser.properties
SC_USER_PROPS_DIR_NAME	:= scite
SC_USER_PROPS_DIR_DEST	:= ~/.$(SC_USER_PROPS_DIR_NAME)

default:
	@echo "NOTE: Type 'make install' to install the SciTE configuration files"\
		  "into your home directory"

install:
	cp -f $(SC_USER_PROPS) ~/.$(SC_USER_PROPS)
	rm -rf $(SC_USER_PROPS_DIR_DEST)
	cp -R $(SC_USER_PROPS_DIR_NAME) $(SC_USER_PROPS_DIR_DEST)
