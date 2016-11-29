FROM java:latest

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y install build-essential gcc-multilib rpm libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386

# install SDK, NDK & gradle
WORKDIR /opt
RUN curl https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xzv -C /opt && \
    curl https://downloads.gradle.org/distributions/gradle-3.1-bin.zip -o gradle-3.1-bin.zip && \
    unzip -o gradle-3.1-bin.zip -d /opt && \
    rm -f gradle-3.1-bin.zip && \
    curl http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin -o android-ndk-r10e-linux-x86_64.bin && \
    chmod +x android-ndk-r10e-linux-x86_64.bin && \
    ./android-ndk-r10e-linux-x86_64.bin && \
    rm -f android-ndk-r10e-linux-x86_64.bin

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV GRADLE_HOME=/opt/gradle-3.1
ENV PATH=$GRADLE_HOME/bin:$PATH

# install SDK components
WORKDIR $ANDROID_HOME/tools
RUN echo "y" | ./android update sdk -u -a -t build-tools-23.1.1 && \
    echo "y" | ./android update sdk -u -a -t build-tools-23.0.3 && \
    echo "y" | ./android update sdk -u -a -t build-tools-24.0.3 && \
    echo "y" | ./android update sdk -u -a -t build-tools-25.0.0 && \
    echo "y" | ./android update sdk -u -a -t tools && \
    echo "y" | ./android update sdk -u -a -t android-24 && \
    echo "y" | ./android update sdk -u -a -t android-23 && \
    echo "y" | ./android update sdk -u -a -t android-25 && \
    echo "y" | ./android update sdk -u -a -t extra-android-m2repository && \
    echo "y" | ./android update sdk -u -a -t extra-google-m2repository && \
    echo "y" | ./android update sdk -u -a -t extra-android-support && \
    echo "y" | ./android update sdk -u -a -t extra-google-analytics_sdk_v2 && \
    echo "y" | ./android update sdk -u -a -t extra-google-google_play_services \

