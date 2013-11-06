################################################################################
# SciTE -- User configuration Makefile
# 
# This makefile helps to install the SciTEUser-properties file to your home
# directory.
################################################################################

SC_USER_PROPS		:= SciTEUser.properties
SC_USER_PROPS_DIR	:= scite

default:
	@echo "NOTE: Type 'make install' to install the SciTE configuration files"\
		  "into your home directory"

install:
	cp $(SC_USER_PROPS) ~/.$(SC_USER_PROPS)
	cp -R $(SC_USER_PROPS_DIR) ~/.$(SC_USER_PROPS_DIR)
