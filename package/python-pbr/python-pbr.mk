################################################################################
#
# python-pbr
#
################################################################################

PYTHON_PBR_VERSION = 5.1.3
PYTHON_PBR_SOURCE = pbr-$(PYTHON_PBR_VERSION).tar.gz
PYTHON_PBR_SITE = https://files.pythonhosted.org/packages/97/76/c151aa4a3054ce63bb6bbd32f3541e4ae068534ed8b74ee2687f6773b013
PYTHON_PBR_LICENSE = Apache-2.0
PYTHON_PBR_LICENSE_FILES = LICENSE
PYTHON_PBR_SETUP_TYPE = setuptools

$(eval $(host-python-package))
