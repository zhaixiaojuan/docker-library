FROM lcr.loongnix.cn/library/golang:1.21-alpine AS release
LABEL maintainer="yangzewei@loongson.cn"
LABEL moby.buildkit.frontend.network.none="true"
LABEL moby.buildkit.frontend.caps="moby.buildkit.frontend.inputs,moby.buildkit.frontend.subrequests,moby.buildkit.frontend.contexts"
#RUN wget http://cloud.loongnix.xa/moby/buildkit%2Ffronted%2F0.12.3/dockerfile-frontend -O /bin/dockerfile-frontend && chmod +x /bin/dockerfile-frontend
COPY dockerfile-frontend /bin/dockerfile-frontend 
RUN chmod +x /bin/dockerfile-frontend
ENTRYPOINT ["bin/dockerfile-fronted"]
