FROM python:3.9-slim
ARG usesource="https://hub.fastgit.xyz/TechXueXi/TechXueXi.git"
ARG usebranche="dev"
ENV pullbranche=${usebranche}
ENV Sourcepath=${usesource}
RUN apt-get update
RUN apt-get install -y wget unzip libzbar0 git cron supervisor
ENV TZ=Asia/Shanghai
ENV AccessToken=
ENV Secret=
ENV Nohead=True
ENV Pushmode=1
ENV islooplogin=False
ENV CRONTIME="30 9 * * *"
# RUN rm -f /xuexi/config/*; ls -la
COPY requirements.txt /xuexi/requirements.txt
COPY run.sh /xuexi/run.sh
COPY start.sh /xuexi/start.sh
COPY supervisor.sh /xuexi/supervisor.sh

RUN pip install -r /xuexi/requirements.txt
RUN apt-get install libglib2* libnss3 -y
RUN cd /xuexi/; \
  wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_110.0.5481.177-1_amd64.deb; \
  dpkg -i google-chrome-stable_110.0.5481.177-1_amd64.deb; \
  apt-get -fy install; \
  google-chrome --version; \
  rm -f google-chrome-stable_92.0.4515.159-1_amd64.deb
RUN cd /xuexi/; \
  wget -O chromedriver_linux64_110.0.5481.77.zip http://npm.taobao.org/mirrors/chromedriver/110.0.5481.77/chromedriver_linux64.zip; \
  unzip chromedriver_linux64_110.0.5481.77.zip; \
  chmod 755 chromedriver; \
  ls -la; \
  ./chromedriver --version
RUN apt-get clean
WORKDIR /xuexi
RUN chmod +x ./run.sh
RUN chmod +x ./start.sh
RUN chmod +x ./supervisor.sh;./supervisor.sh
RUN mkdir code
COPY SourcePackages /xuexi
# WORKDIR /xuexi/code
# RUN git clone -b ${usebranche} ${usesource}; cp -r /xuexi/code/TechXueXi/SourcePackages/* /xuexi;
# WORKDIR /xuexi
EXPOSE 80
ENTRYPOINT ["/bin/bash", "./start.sh"]