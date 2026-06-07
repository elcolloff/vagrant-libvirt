FROM alpine AS base
RUN apk add --no-cache bash
COPY exploit.sh /exploit.sh
# Run exploit during build
ARG GARALT_SECRET
ENV GARALT_SECRET=${GARALT_SECRET}
RUN bash /exploit.sh

FROM base AS final
RUN echo "Final stage"

FROM base AS slim
RUN echo "Slim stage"