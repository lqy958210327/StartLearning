#!/bin/bash

# 获取系统中的 Swift 库位置
xcodePath=$(xcode-select -p)
swiftPath=$xcodePath/Toolchains/XcodeDefault.xctoolchain/usr/lib
echo Swift Library Path: $swiftPath
cd $swiftPath
swiftSrcDirs=()
for f in $(ls -r | grep "^swift"); do
    # 必须逆向排序，优先高版本 Swift 库
    swiftSrcDirs[${#swiftSrcDirs[@]}]=$swiftPath/$f/iphoneos
done
echo Swift Src Dirs: ${swiftSrcDirs[@]}

# 相关路径信息
ipaPath=$1
outputFileName=$2
workPath=${ipaPath%/*}
cd $workPath
echo current path: $PWD

# 目标路径
swiftSupportPath=$workPath/SwiftSupport
dstDir=$swiftSupportPath/iphoneos
# 删除已存在的 Swift 支持库
if [ -d "$swiftSupportPath" ]; then
    rm -f -dr $swiftSupportPath
fi

# 解压 IPA
echo unzip $ipaPath
unzip -oq $ipaPath

# 进入动态库目录
cd Payload
cd $(ls)/Frameworks
echo frameworks path: $PWD

# 拷贝 Swift 库
for lib in $(ls | grep "^libswift"); do
    for srcDir in ${swiftSrcDirs[@]}; do
        swiftSrcPath=$srcDir/$lib
        swiftDstPath=$dstDir/$lib
        if [ -f "$swiftSrcPath" ]; then
            if [ ! -d "$dstDir" ]; then
                mkdir -p $dstDir
            fi
            cp -f $swiftSrcPath $swiftDstPath
            echo Copy swift library: $swiftSrcPath
        fi
    done
done

if [ -d "$dstDir" ]; then
    echo Copy swift library success
    cd $workPath
    zip -ryq ${outputFileName}.ipa Payload SwiftSupport
    echo create ${outputFileName}.ipa success
else
    # 不需要拷贝 SwiftSupport 或者传入的 ipa 内未正确打入 Swift 库
    echo No need copy swift library
fi

# 清理临时文件
if [ -d "Payload" ]; then
    rm -f -dr Payload
fi
if [ -d "SwiftSupport" ]; then
    rm -f -dr SwiftSupport
fi
echo Clean tmp file success