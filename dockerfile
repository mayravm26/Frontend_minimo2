# Usa una imagen base oficial de Ubuntu
FROM ubuntu:20.04

# Establece variables de entorno para que Docker no solicite interacciones del usuario
ENV DEBIAN_FRONTEND=noninteractive

# Instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
    wget \
    git \
    curl \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && apt-get clean

# Descarga Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /flutter

# Añade Flutter al PATH
ENV PATH="/flutter/bin:$PATH"

# Asegura que Flutter esté actualizado
RUN flutter doctor

# Instala los paquetes de Flutter
RUN flutter precache && \
    flutter doctor --android-licenses && \
    flutter doctor

# Crea un directorio de trabajo para la aplicación
WORKDIR /app

# Copia los archivos del proyecto a la imagen
COPY . /app

# Instala las dependencias del proyecto
RUN flutter pub get

# Construye la aplicación en modo release (puedes cambiar a debug si es necesario)
RUN flutter build apk --release

# Establece el comando por defecto al iniciar el contenedor
CMD ["flutter", "doctor"]