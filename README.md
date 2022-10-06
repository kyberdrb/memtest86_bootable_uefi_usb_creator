# MemTest86 UEFI-Bootable USB

## Usage

1. Prepare USB for UEFI booting. `sdb` is the device name of my USB stick. Your device name may vary, so make sure with `lsblk` before and after inserting the USB stick that the name of the device corresponds to the name you enter as an argument. **THIS IS A DESTRUCTIVE OPERATION! ALL DATA ON THE USB STICK WILL BE ERASED WITH THIS SCRIPT!**

        ./make_memtest86_usb.sh <ENTER_USB_DEVICE_NAME>

    e. g.

        ./make_memtest86_usb.sh sdb

    where `sdb` is the device name of the USB drive given by `lsblk` command.

1. List USB devices before and after inserting the USB stick to determine the device name. Then choose this device for the MemTest86 installation.

    quick and sufficiently detailed listing

        $ lsblk -o NAME,FSTYPE,FSVER,UUID,MOUNTPOINT
        NAME   FSTYPE FSVER UUID                                 MOUNTPOINT
        sda                                                      
        ├─sda1 vfat   FAT32 220C-B8F7                            /boot
        └─sda2 ext4   1.0   cb217b7c-f7c0-4dae-b9a6-412e68b52408 /
        sdb                                                      
        └─sdb1 vfat   FAT32 B0F1-03FD                            


    or quick listing

        $ lsblk
        NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
        sda      8:0    0 238.5G  0 disk 
        ├─sda1   8:1    0   600M  0 part /boot
        └─sda2   8:2    0   220G  0 part /
        sdb      8:16   1   1.9G  0 disk 
        └─sdb1   8:17   1   1.9G  0 part

    or for another type of output

        $ lsblk --fs
        NAME   FSTYPE FSVER LABEL      UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
        sda                                                                                
        ├─sda1 vfat   FAT32            220C-B8F7                             356.3M    41% /boot
        └─sda2 ext4   1.0              cb217b7c-f7c0-4dae-b9a6-412e68b52408    7.5G    91% /
        sdb                                                                                
        └─sdb1 vfat   FAT32 MEMTEST86 B0F1-03FD

    In my case the USB stick I inserted has the name `sdb`

---

The order of the operations matters.

I made this guide for MemTest86, but this can apply for any other UEFI bootable USB drive creation:

1. partition usb drive as gpt with one fat32 partition
2. download latest memtest86 in alternative, i.e. Ubuntu, version
3. extract the archive onto the usb drive
4. at the end, set the flags `boot` and `esp` for the fat32 partition on the USB drive; If you'd set the mentioned flags before mounting the USB in order to extract the memtest86 archive to the fat32 partition, the partition will not mount and the extraction fails, even when mounted as the root user into `/mnt/` - the extraction succeeds when the fat32 partition is not flagged or flagged as `msftdata`

## Sources

- Sources - `prepare_usb_for_memtest86_uefi_booting.sh`
    - https://www.unixmen.com/how-to-format-usb-drive-in-the-terminal/
    - https://duckduckgo.com/?q=mkfs+fat32&ia=web
    - https://www.redips.net/linux/create-fat32-usb-drive/
    - https://duckduckgo.com/?q=mkfs+fat32+noninteractive&ia=web
    - https://serverfault.com/questions/320590/non-interactively-create-one-partition-with-all-available-disk-size
    - https://www.gnu.org/software/parted/manual/html_chapter/parted_2.html
    - https://duckduckgo.com/?q=parted+mkpart+gpt&ia=web
    - https://www.gnu.org/software/parted/manual/html_node/mkpart.html
    - https://www.systutorials.com/making-gpt-partition-table-and-creating-partitions-with-parted-on-linux/
    - https://askubuntu.com/questions/1074515/create-one-partition-occupying-all-the-space-on-the-drive-with-gparted/1287643#1287643
    - https://rainbow.chard.org/2013/01/30/how-to-align-partitions-for-best-performance-using-parted/
    - https://unix.stackexchange.com/questions/174157/parted-3-2-says-1024mib-is-outside-of-the-device-of-size-1024mib/174169#174169
    - Simply leave the calculation [of partition boundaries] to parted using percents as units - https://askubuntu.com/questions/701729/partition-alignment-parted-shows-warning/1145451#1145451
    - https://www.thegeekdiary.com/how-to-delete-disk-partition-using-parted-command/
    - https://www.tecmint.com/create-new-ext4-file-system-partition-in-linux/
    - https://serverfault.com/questions/614019/list-linux-partition-names-only-in-bash/614160#614160
    - https://linuxhint.com/uuid_storage_devices_linux/
    - https://devconnected.com/how-to-mount-and-unmount-drives-on-linux/#Unmounting_drives_on_Linux_using_umount
    - https://duckduckgo.com/?q=add+label+to+partition+parted+fat32&ia=web
    - https://www.preshweb.co.uk/2008/10/labelling-fatfat32-partitions-in-linux/
    - https://duckduckgo.com/?q=parted+change+fat+partition+name&ia=web
    - https://unix.stackexchange.com/questions/44095/how-to-change-the-volume-name-of-a-fat32-filesystem
    - **https://askubuntu.com/questions/1103569/how-do-i-change-the-label-reported-by-lsblk/1103592#1103592**
    - https://www.gnu.org/software/parted/manual/html_node/name.html
    - https://www.thegeekdiary.com/how-to-delete-disk-partition-using-parted-command/
    - ---
    - https://stackoverflow.com/questions/6901171/is-d-not-supported-by-greps-basic-expressions
    - https://stackoverflow.com/questions/11234858/how-do-you-grep-for-a-string-containing-a-slash
    - https://stackoverflow.com/questions/48131243/remove-digits-from-end-of-string
    - Use of xargs commands in Linux - https://www.programmerall.com/article/54662124051/
    - ---
    - https://duckduckgo.com/?q=find+exclude+directory&ia=web
    - https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command
    - https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command/4210072#4210072
    - https://duckduckgo.com/?q=find+ommit+the+dot+directory&ia=web
    - https://duckduckgo.com/?q=find+.+-path+.%2F.git+-prune+-o+-print&ia=web
    - https://duckduckgo.com/?q=find+.+-mindepth+1+-path+.%2F.git+-prune+-o+-type+f+-print&ia=web
    - https://duckduckgo.com/?q=find+.+-mindepth+1+-path+.%2F.git+-prune+-o+-type+f+-print+-exec+sh+-c+%22sed+--in-place+%27s%2FCLONEZILLA%2FMEMTEST86%2Fg%27+%22%7B%7D%22%22+%5C%3B&ia=web
    - https://duckduckgo.com/?q=find+.+-mindepth+1+-path+.%2F.git+-prune+-o+-type+f+-print+-exec+sh+-c+%22%3CLinux_utils_and_gists-REPO_PATH%3E%2Frename_file.sh+%22%7B%7D%22+%22clonezilla%22+%22memtest86%22%22+%5C%3B&ia=web
    - https://duckduckgo.com/?q=sed+case+sensitive&ia=web&iax=qa
    - https://duckduckgo.com/?q=sed+is+case+sensitive+by+default&ia=web

- Sources - `install_memtest86_to_prepared_usb.sh`
  - https://www.memtest86.com/download.htm
  - https://duckduckgo.com/?q=memtest86&ia=web
  - https://www.reddit.com/r/techsupport/comments/1rpmcd/how_long_does_memtest86_usually_take/

- Sources: `make_memtest86_usb.sh`
  - https://forums.linuxmint.com/viewtopic.php?p=1891954#p1891954
  - https://duckduckgo.com/?q=bash+set+unset&ia=web
  - https://towardsdev.com/what-does-set-u-mean-in-a-bash-script-52b048271741

