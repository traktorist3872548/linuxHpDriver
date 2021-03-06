# linuxHpDriver

https://tutorialforlinux.com/2020/04/08/step-by-step-driver-hp-laser-107w-107a-linux-mint-19-installation/3/

HP provides a downloadable "driver" for Linux for the HP 107w printer but there are NO reasonable install instructions provided, and following the "obvious" install process did not get the printer working.

The closest I found to HP install instuctions once I knew more is https://support.hp.com/in-en/document/c05588857

Since I found this annoying and wasted more time on getting this printer working under Linux, I'm sharing a summary of what did work (on Debian 10).

1. Download the driver file from https://support.hp.com/us-en/drivers/selfservice/hp-laser-100-printer-series/24494339/model/24494342    from under the "Basic Drivers" menu for when the OS is set to Linux.

The current version now is: "HP Laser 100 and HP Color Laser 150 Printer series Print Driver V1.00.39:00.12	5.9 MB	Mar 20, 2019"

At present the Download link points to https://ftp.hp.com/pub/softlib/software13/printers/CLP150/ULDLINUX_V1.00.39_00.12.zip 

2. Copy the downloaded file to /tmp/

cd /tmp
unzip ULDLINUX_V1.00.39_00.12.zip
cd ULDLINUX_V1.00.39_00.12/
tar zxvf uld.tar.gz
cd uld

# A plain run of "./install-printer.sh" fails with the message:
# **** Root privileges are required

# Continue IF you trust HP and the downloaded installer.

sudo ./install-printer.sh

3. Follow through the menus:
  * "q" to leave "more" of the license
  * "y" to accept the license
  * "n" (not installing network device)
  
Summary from install:

**** Do you agree ? [y/n] : y
**** Are you going to use network devices ? If yes, it is recommended to configure your firewall.
**** If you want to configure firewall automatically, enter 'y' or just press 'Enter'. To skip, enter 'n'. : n
**** Registering CUPS backend ...
**** CUPS restart OK.
**** Print driver has been installed successfully.
**** Install finished.

4. Note: At least for me, this did not actually "install the printer" only the "unified linux driver" software needed to support the PPD installed below.

Essentially the installer we ran will create 
  * /opt/hp/ which mainly has /opt/hp/printer/share/ppd/
  * /opt/smfp-common/ which seems to have the "real" driver code, and in particular has a directory called /opt/smfp-common/printer/bin which contains the "CUPS filter" rastertospl which the PPD found and installed below is calling.

Note: On my Debian 10 system a symbolic link was created in /usr/lib/cups/filter/ for rastertospl and pstosecps pointing to the files under /opt/smfp-common/printer/bin

5. The intaller places some PPD files in /opt/hp/printer/share/ppd/ - this is the list:
HP_Laser_10x_Series.ppd
HP_LaserJet_MFP_M436.ppd
HP_LaserJet_MFP_M433.ppd
HP_Laser_MFP_13x_Series.ppd
HP_Color_Laser_15x_Series.ppd
HP_Color_Laser_MFP_17x_Series.ppd
HP_LaserJet_MFP_M72625_72630.p
