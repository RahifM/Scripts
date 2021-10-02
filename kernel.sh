KDIR=$PWD
TG=$HOME/telegram.sh/telegram
LOG=$KDIR/buildlog*.txt
KIMG=$KDIR/out/arch/arm64/boot/Image.gz-dtb
AK3=$HOME/AnyKernel3
ZIP=$HOME/AnyKernel3/*.zip

success() {
	cd $AK3
	rm -rf Image.gz-dtb
	rm -rf *.zip
    cp $KIMG $AK3
    zip -r9 mido-$(date +'%Y%m%d-%H%M').zip * -x .git README.md *placeholder
    $TG -f $ZIP "$(cat $KDIR/out/include/generated/uts* | cut -d " " -f 2-)"$'\n'$'\n'"$(cat $KDIR/out/include/generated/comp*h | grep gcc* | cut -d " " -f 2-)"
	rm $LOG
}

failed() {
	$TG -f $LOG "Kernel compilation failed."
	rm $LOG
	exit 1
}

echo -$(git branch --show-current) > localversion

$TG "Build started $(date +'%Y%m%d %H%M %Z')"$'\n'$'\n'"Branch: $(git branch --show-current)"$'\n'$'\n'"HEAD: $(git log -n 1 --oneline)"

make mido_defconfig
PATH="$HOME/android/gcc-arm64/bin:$HOME/android/gcc-arm32/bin:${PATH}" \
make -j$(nproc --all) CROSS_COMPILE=aarch64-elf- \
		      CROSS_COMPILE_ARM32=arm-eabi- \
		      2>&1 | tee buildlog.txt

rm localversion

[ "$(grep Image.gz-dtb $LOG | cut -d / -f 4)" == "" ] && failed || success
