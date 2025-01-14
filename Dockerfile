# 使用 Alpine 为基础镜像，该镜像体积较小
FROM node:14-alpine as builder

WORKDIR /app

# 克隆 CORS Anywhere 的代码
RUN apk add --no-cache git && \
    git clone https://github.com/delong1998/cors-anywhere.git . && \
    npm config set registry https://registry.npmmirror.com && \
    npm install 


FROM node:14-alpine

WORKDIR /app

# # 从上一个阶段拷贝构建好的 node_modules 目录和必要的文件
COPY --from=builder /app/node_modules ./node_modules/
COPY --from=builder /app/lib/ ./lib/
COPY --from=builder /app/server.js ./server.js

# 设置服务运行的端口
EXPOSE 8080

# 启动服务
CMD ["node", "server.js"]
