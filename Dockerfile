FROM alpine:latest

RUN apk add --no-cache \
    bash \
    curl \
    jq

WORKDIR /abdur_rahim_home

COPY github_specific_repo_commit_fetcher.sh .
RUN chmod +x github_specific_repo_commit_fetcher.sh

ENTRYPOINT ["/abdur_rahim_home/github_specific_repo_commit_fetcher.sh"]
