# Syntax directive to enable BuildKit features
# Use a newer version if needed
FROM node:alpine AS base

# Install pnpm globally
RUN npm i -g pnpm

# Set the working directory
WORKDIR /app

# Copy the project files into the working directory
COPY . .

# ---- Build stage ----
FROM base AS build

# Use a build mount to cache the pnpm store
# This way, dependencies will be cached across builds for performance
RUN --mount=type=cache,target=/root/.pnpm-store pnpm i

# ---- Final stage ----
FROM base AS final

# Copy installed dependencies from the build stage
COPY --from=build /app/node_modules /app/node_modules

# Copy the rest of the app (if there were any changes outside of dependencies)
COPY . .

# Specify the command to run the app
ENTRYPOINT ["npm", "start"]
