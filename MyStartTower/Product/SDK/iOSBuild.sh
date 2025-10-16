echo "Start Building"

#工程路径
project_path=$1

#IPA名称
ipa_name=$2

#build文件夹路径
build_path=${project_path}/build

#编译工程
cd $project_path
xcodebuild || exit

#打包
cd $build_path
if [ -d ./ipa ];then
	rm -rf ipa
fi
mkdir -p ipa/Payload
cp -r ./Release-iphoneos/*.app ./ipa/Payload/
cd ipa
zip -r ${ipa_name}.ipa *
rm -rf Payload

echo "ipa file is exported successfully!!!"