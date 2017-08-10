#!/bin/sh

#打印错误信息
errorMessage()
{
	echo  "\033[41;37m $1 \033[0m"
}

#打印操作成功信息
niceMessage()
{
        echo -e "\033[42;37m $1 \033[0m"
}

#打印警告信息
warnMessage()
{
        echo -e "\033[43;37m $1 \033[0m"
}

#验证上一步操作是否正确
verifyOperation()
{
	EXCODE=$?
        if [ "$EXCODE" != "0" ]; then
		errorMessage $1
                exit 1
        fi
	
	niceMessage $2
}


#生成新的版本号
createNewVersion()
{
	#提取版本号后缀
	suffix=`echo $version | cut -d "." -f3`
	((suffix++))
	version=$1
	newVersion=""
	for k in $( seq 1 2)
        do
                num=`echo $version | cut -d "." -f$k`
                newVersion=$newVersion$num.
        done
	echo $newVersion$suffix
}

#进入代码库
#拉取最新代码
cd ./GameLive
git pull origin master
verifyOperation "拉取GameLive代码失败！！！"

cd ../GameLiveRepo
git pull origin master
verifyOperation "拉取GameLiveRepo代码失败！！！"

#拷贝一份podspec
cd ../
cp -f ./GameLive/GameLive.podspec ./
cp -f ./GameLiveRepo/GameLiveRepo.podspec ./

#提取代码版本所在行
versionLine=`cat GameLive.podspec |grep -E 's.version(.*)='`

#提取当前版本号
version=`echo $versionLine | cut -d "\"" -f2`

#生成新版本号

newVersion=`createNewVersion $version`

niceMessage "oldVersion = $version, newVersion = $newVersion"

#替换版本号
sed -i ' ' "s/$versionLine/s.version      = \"$newVersion\"/g" ./GameLive.podspec
sed -i ' ' "s/$versionLine/s.version      = \"$newVersion\"/g" ./GameLiveRepo.podspec

cp -f ./GameLive.podspec ./GameLive
cp -f ./GameLiveRepo.podspec ./GameLiveRepo

rm ./GameLive.podspec\ 
rm ./GameLiveRepo.podspec\ 


#验证podspec
cd ./GameLive
pod lib lint --allow-warnings
verifyOperation "GameLive pod lib lint 出错！请检查podspec！！"

#将改动推到远程仓库并创建新的分支
git add .
git commit -m "auto create new branch"
git push origin master
git push origin master:$newVersion
verifyOperation "创建新的分支$newVersion 失败!!!"

#用cocoapods-packager打包
pod package GameLive.podspec --force --library
verifyOperation "生成.a文件包失败!!!" "生成.a文件成功"

#将打包好的静态库和需要暴露的头文件拷贝到源仓库
cp -f ./GameLive-$newVersion/ios/libGameLive.a ../GameLiveRepo/Release
verifyOperation "拷贝.a文件失失败"

rm ../GameLiveRepo/Classes/*.h
cp -f ./DSLXML/*.h ../GameLiveRepo/Classes

#将静态库推到远程仓库
cd ../GameLiveRepo
pod lib lint --allow-warnings
verifyOperation "GameLiveRepo pod lib lint 出错！请检查podspec！！"

git add .
git commit -m "更新静态库version ＝ $newVersion"
git push origin master
git push origin master:$newVersion
verifyOperation "更新静态库失败!!!" "更新静态库成功!!!"

#更新私有库
pod repo update MyRepos
verifyOperation "更新私有pod库失败!!!" "更新私有pod库成功!!!"

pod repo push MyRepos GameLiveRepo.podspec --verbose --allow-warnings
verifyOperation "更新私有库信息失败" "更新私有库信息成功"

pod repo update MyRepos
verifyOperation "更新私有库失败!!!" "更新私有库成功"
niceMessage "打包成功！！！"

