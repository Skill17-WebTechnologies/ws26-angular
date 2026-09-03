FROM node:24.1.0-bookworm
ARG NPM_REGISTRY=https://registry.npmjs.org/
RUN npm config set registry "$NPM_REGISTRY"
RUN npm install -g npm@11.5.0
WORKDIR /app
COPY package*.json ./
# --legacy-peer-deps is not a style preference: without it this build fails.
#
# npm 11.5.0 — the version the WSC2026 spec pins, installed just above — crashes
# resolving this project's peer-dependency graph:
#
#   TypeError: Cannot read properties of null (reading 'edgesOut')
#       at #loadPeerSet (.../arborist/lib/arborist/build-ideal-tree.js:1300)
#
# It is a bug in npm's own resolver, not a conflict in this project. The flag
# takes the legacy resolution path and sidesteps it. npm 11.19.1 resolves the
# same tree without the flag, so this line can go once the pinned npm moves.
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 80
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--port", "80"]
