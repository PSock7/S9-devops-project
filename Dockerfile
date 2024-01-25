# Utilise une image de base légère d'Alpine Linux
FROM golang:1.16-alpine AS builder

# Installation de git
RUN apk --no-cache add git

# Crée un répertoire de travail dans l'image
WORKDIR /app

# Copie le code source
COPY . .

# Compile l'application
RUN go build -o app

# Utilise une image Alpine Linux minimale pour réduire la taille
FROM alpine:3.14

# Définit le répertoire de travail dans l'image finale
WORKDIR /usr/local/bin

# Copie l'exécutable de l'application à partir de l'étape de construction
COPY --from=builder /app/app .

# Expose le port sur lequel l'application écoute
EXPOSE 8181

# Démarre l'application
CMD ["app"]
