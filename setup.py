#!/usr/bin/env python 

"""Setup script for the plots package"""

__version__ = '1'

from distutils.core import setup
import sys, os

long_description = """Plots is a package containing command-line programs for generating png images"""

# Check for gnuplot
sys.stdout.write("Checking for Gnuplot.py... ")
try:
	import Gnuplot
	sys.stdout.write("Found\n")
except ImportError:
	sys.stdout.write("Not Found. ERROR: Missing Gnuplot.py. \nInstall this dependency from gnuplot-py.sourceforge.net. Aborting.\n")
	sys.exit(1)

# Check for gsl
sys.stdout.write("Checking for required gsl programs...")
noGsl = os.system('which gsl-histogram')
if noGsl:
	sys.stdout.write("\nNot Found.  ERROR:  Missing GSL installation, or GSL programs are not in the PATH.  Aborting.\n")
	sys.exit(1)
sys.stdout.write("\nFound\n")

setup (
	# Distribution meta-data
	name = 'plots',
	version = __version__,
	description = 'Command line plotting programs.',
	long_description = long_description,
	author = 'Scott Kuehn',
	author_email = 'scott@kuehns.com'
	url = 'https://github.com/skuehn/stream-plots',
	py_modules=[],
	package_dir = {'': 'lib'},
	packages=['plots'],
	license = '',
	data_files = [('share/scripts', ['share/scripts/single-instances.sh', 'share/scripts/multi-instances.sh']),
					  ('share/data', ['share/data/2-col.2.txt', 'share/data/2-col.txt', 'share/data/medium.txt',
											'share/data/small.txt', 'share/data/title.txt', 'share/data/a.1.txt',
											'share/data/a.2.txt', 'share/data/a.3.txt', 'share/data/b.1.txt',
											'share/data/b.2.txt', 'share/data/b.3.txt', 'share/data/c.1.txt',
											'share/data/c.2.txt', 'share/data/c.3.txt']),
					  ('doc', ['doc/install.txt', 'doc/plots.txt'])],
	# Description of the scripts in the distribution
	scripts = ['src/hist', 'src/scatter', 'src/series', 'src/spark']
	)
