FROM gradle

ENV MAIN main

WORKDIR /home/gradle

COPY bin .

RUN apt update

# the cpp plugin requires a compiler
RUN apt install -y g++

# clean - remove any old build dir
# compileReleaseCpp - creates .o files
# linkRelease - links all .o files creating an executable
# there is NO run task defined
RUN gradle clean compileReleaseCpp \
    linkRelease

RUN mv /home/gradle/build/exe/$MAIN/release/gradle /home/gradle/gradle

CMD ["./gradle"]