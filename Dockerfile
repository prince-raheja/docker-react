# production deployment
# using two FROM (last FROM is not accessible from current FROM unless saved 
# state using AS) 
FROM node:alpine AS builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# This is production ready Dockerfile
# Dont contain any node dependencies/original code
# only code that will passed to the frontend
FROM nginx
# here builder is the previous image made 
# COPY --from={name} {from_container_path} {current_container_path}
COPY --from=builder /app/build /usr/share/nginx/html