
check()
{
	versionLine=`cat ./$1/$1.podspec |grep -E 's.version(.*)='`
	echo -e "$1:\n      $versionLine"
}

check "GameLive"
check "GameLiveRepo"
