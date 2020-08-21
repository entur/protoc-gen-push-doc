# protoc-gen-push-doc
Docker image for generating documentation from protobuf files and pushing them using git. It is made to be used with Circle CI, but should also work with other tools for continuous integration.

## Features
This image features [protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc) and `git` commands. Refer mainly to the documentation on [protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc).

## Usage
**Non-Entur?** Clone repo or download [Dockerfile](./Dockerfile) to build your own image.

**Entur?**   
1. Define executor (or use image directly in job) in Circle CI config.yml:

    ```config.yml
    executors:
    protoc-gen-push-doc:
        docker:
        - image: "url to gcr docker registry"/protoc-gen-push-doc
            auth:
            username: _json_key
            password: $DOCKER_PASSWORD

    ```

2. Create job that uses the previously defined executor, generates docs using `protoc` (see [protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc)) and pushes the docs back to the branch.
    ```config.yml
    protoc-gen-push-doc:
    executor: protoc-gen-push-doc
    steps:
      - checkout
      - run:
          command: protoc --doc_out=docs --doc_opt=docs/templates/custom-markdown.tmpl,api.mdx --proto_path=src/main/proto/  src/main/proto/*.proto
      - run:
          command: |
            git config --global user.email "circleci@entur.no"
            git config --global user.name "EnturCircleCi"
            if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
              echo "Updating api.mdx in repo"
              git add docs/api.mdx
              git commit -m "Updated generated api.mdx [ci skip]"
              git pull --rebase && git push
            fi
    ```

3. Include the job in the workflow

4. Optionally: Persist files to workspace and push them to [developer.entur.org](developer.entur.org) using [https://github.com/entur/docs-orb](https://github.com/entur/docs-orb)