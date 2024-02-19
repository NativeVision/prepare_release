# From @Avtrkrb:
#
# I'm a linux & cli guy, I don't use AndroidStudio so I'm assuming that you are comfortable with the terminal app & will provide you purely cli instructions for virocore. 😁 
# 
# My build environment use node 18, gradle 8.3, java 17. Kotlin version on my machine is 1.9.x, but I've had success with gradle plugin & kotlin version set to 1.8.x in the build.gradle file since quite a few dependencies need this specific version. All gradle related versions are already specified in my branch, so you should be good to pull my changes & build right off the bat.
# 
# Steps for Virocore
# 
# Pull my branch & cd into virocore/android in your terminal.
# Run the following command to build viroreact -> ./gradlew :viroreact:assembleRelease
# If you have a successful build, you should see a .aar file compiled in the location -> virocore/android/viroreact/build/outputs/aar/viroreact-release.aar
# 
# Steps for viro
# 
# Pull my branch & copy virocore/android/viroreact/build/outputs/aar/viroreact-release.aar, rename it to viro_renderer-release.aar & place it in viro/android/viro_renderer/viro_renderer-release.aar
# Build viro by running the prepare_release.sh script, line 48 of prepare_release.sh should be uncommented, or it will not take the latest viro_bridge.aar library. It will take the older one with arcore_1.26.0 library files in it.
# Once you have successfully build viro, test it out against viro-test-bed.
GREEN='\033[0;32m'
NC='\033[0m' # No Color

set -e

echo '========================================================================='
echo 'Building ViroCore'
echo '========================================================================='

cd virocore

./prepare_release.sh

echo '========================================================================='
echo 'Copying ViroRenderer to ViroReact'
echo '========================================================================='

cp android/viroreact/build/outputs/aar/viroreact-release.aar ../viro/android/viro_renderer/viro_renderer-release.aar

echo '========================================================================='
echo 'Building ViroBridge'
echo '========================================================================='
cd ../viro

./prepare_release.sh

if [ ! -f $(find . -name ./*.tgz) ]; then
    echo "viro-community-react-viro tarball not found."
    exit 1
fi

echo "${GREEN}=========================================================================${NC}"
echo "${GREEN}Viro React ready for release.${NC} 🎉🎉🎉"
echo "${GREEN}=========================================================================${NC}"