obj-$(CONFIG_SPFS) += spfs.o

ccflags-y := -Wall

spfs-y	:= main.o super.o inode.o dentry.o mmap.o file.o namei.o dax.o \
	format.o calloc.o sysfs.o extent.o \
	inode_bp.o file_bp.o dir.o \
	cceh.o cceh_namei.o cceh_extent.o migration.o

spfs-$(CONFIG_SPFS_STATS)		+= stats.o
spfs-$(CONFIG_SPFS_READDIR_RADIX_TREE)	+= readdir_index.o

ifneq ($(CONFIG_SPFS_BLOCK_BITS),12)
spfs-y	+= balloc.o cceh_cluster.o
endif


KERNELDIR := ../..
KDIR = /data/konna/share/kernel/linux-5.15
PWD:=$(shell pwd)
default:
		# make -C $(KERNELDIR) M=$(PWD) modules -j8
		make -C $(KDIR) M=$(PWD) modules -j8
clean:
		rm -rf *.o *.mod.c *.ko *.symvers .*.cmd *.order .tmp*
