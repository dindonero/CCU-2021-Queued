# Instalar software -> App
https://flutter.dev/docs/get-started/install

### 1) Adicionar o Flutter path na PATH environment variable

### 2) Configurar o pub get no projeto:
#### Primeira maneira
  1) cd Client/
  2) flutter pub get

#### Segunda maneira
  1) Abrir o projeto no Android Studio
  2) Configurar o pub get quando a mensagem de erro aparecer
    
### 3) Criar generated folders
  1) cd Client/
  2) flutter create .

# Executar a App
### Executar o main.dart no Android Studio


# Instalar software -> Server
### Install PgAdmin (optional)
### Install Postgres (IMPORTANTE: lembrar da password definida no user postgres)

### 1) Ir à pasta Server/src/main/resources
### 2) Copiar o ficheiro application.properties.example
### 3) Remover ".example" ao nome do ficheiro copiado

# Criação da Base de Dados
### 1) Executar o ficheiro db/createDB.bat

# Executar o Server
#### Primeira maneira
  1) cd Server/
  2) mvn compile spring-boot:run
  
#### Segunda maneira
  1) Executar o ficheiro ServerApplication no Intellij
  2) Executar os ficheiros da pasta test
