##############################################################################
##  This file is part of the HCAN tools suite.
##
##  HCAN is free software; you can redistribute it and/or modify it under
##  the terms of the GNU General Public License as published by the Free
##  Software Foundation; either version 2 of the License, or (at your
##  option) any later version.
##
##  HCAN is distributed in the hope that it will be useful, but WITHOUT
##  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
##  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
##  for more details.
##
##  You should have received a copy of the GNU General Public License along
##  with HCAN; if not, write to the Free Software Foundation, Inc., 51
##  Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
##
##  (c) 2010 by Martin Kramer and Ingo Lages, i (dot) lages (at) gmx (dot) de
##############################################################################


clean:
	make firmwareOhneEds xx=clean
	cd hcanweb; sudo make clean

all:
	make hcanweb_client
	make hcanweb_server

cDienste: 
	#@ per Datei ./ARCH.inc   echo "export ARCH = i386" > ARCH.inc #i386 statt arm
	cd hcanhid/; sudo make $(xx)
	cd hcan4mqttpc/; sudo make $(xx)
	
hcanweb_client: 
	cd hcanweb; sudo make zip ver=unlabeled

hcanweb_server:
	cd hcanweb/server/C1612server; sudo make clean; sudo make all

firmwareOhneEds:	
	cd firmwares/hostinterface-v02; sudo make $(xx)

release: 
	cd firmwares/hostinterface-v02; sudo make release	
