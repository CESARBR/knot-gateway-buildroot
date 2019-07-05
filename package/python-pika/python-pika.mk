################################################################################
#
# python-pika
#
################################################################################

PYTHON_PIKA_VERSION = 1.0.1
PYTHON_PIKA_SOURCE = pika-$(PYTHON_PIKA_VERSION).tar.gz
PYTHON_PIKA_SITE = https://files.pythonhosted.org/packages/ca/82/bb0e6c255575cbd8f57a8bd47aa2f29a2aa24f1363408abccd0690a3a244
PYTHON_PIKA_LICENSE = BSD
PYTHON_PIKA_LICENSE_FILES = LICENSE
PYTHON_PIKA_SETUP_TYPE = setuptools

$(eval $(python-package))
