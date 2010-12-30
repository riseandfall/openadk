#!/usr/bin/env bash

filesystem=ext2

while getopts "f:i" option
do
	case $option in
		f)
		filesystem=$OPTARG
		;;
		i)
		initramfs=1
		;;
		*)
		printf "Option not recognized\n"
		exit 1
		;;
	esac
done
shift $(($OPTIND - 1))

if [ $(id -u) -ne 0 ];then
	printf "Installation is only possible as root\n"
	exit 1
fi

printf "Checking if mkfs is installed"
mkfs=$(which mkfs.$filesystem)

if [ ! -z $mkfs -a -x $mkfs ];then
	printf "...okay\n"
else
	printf "...failed\n"
	exit 1
fi

printf "Checking if parted is installed"
parted=$(which parted)

if [ ! -z $parted -a -x $parted ];then
	printf "...okay\n"
else
	printf "...failed\n"
	exit 1
fi

printf "Checking if qemu-img is installed"
qimg=$(which qemu-img)

if [ ! -z $qimg -a -x $qimg ];then
	printf "...okay\n"
else
	printf "...failed\n"
	exit 1
fi

if [ -z $1 ];then
	printf "Please give the name of the image file\n"
	exit 1
fi	

if [ -z $initramfs ];then
	if [ -z $2 ];then
		printf "Please give the name of the openadk archive file\n"
		exit 1
	fi	
else
	if [ -z $2 ];then
		printf "Please give the full path prefix to kernel/initramfs\n"
		exit 1
	fi
fi


printf "Generate qemu image (512 MB)\n"
$qimg create -f raw $1 512M >/dev/null

printf "Creating filesystem $filesystem\n"

printf "Create partition and filesystem\n"
$parted -s $1 mklabel msdos
$parted -s $1 mkpart primary ext2 0 98%
$parted -s $1 set 1 boot on

dd if=$1 of=mbr bs=16384 count=1 2>/dev/null
dd if=$1 skip=16384 of=$1.new 2>/dev/null

if [ "$filesystem" = "ext2" -o "$filesystem" = "ext3" -o "$filesystem" = "ext4" ];then
	mkfsopts=-F
fi

mkfs.$filesystem $mkfsopts ${1}.new >/dev/null

if [ $? -eq 0 ];then
	printf "Successfully created partition\n"
	#$parted $1 print
else
	printf "Partition creation failed, Exiting.\n"
	exit 1
fi

cat mbr ${1}.new > $1
rm ${1}.new 
rm mbr

tmp=$(mktemp -d)

mount -o loop,offset=16384 -t $filesystem $1 $tmp

if [ -z $initramfs ];then
	printf "Extracting install archive\n"
	tar -C $tmp -xzpf $2 
	printf "Fixing permissions\n"
	chmod 1777 $tmp/tmp
	chmod 4755 $tmp/bin/busybox
else
	printf "Copying kernel/initramfs\n"
	mkdir $tmp/boot $tmp/dev
	cp $2-kernel $tmp/boot/kernel
	cp $2-initramfs $tmp/boot/initramfs
fi

umount $tmp
printf "Successfully installed.\n"
printf "Be sure $1 is writable for the user which use qemu\n"
exit 0
