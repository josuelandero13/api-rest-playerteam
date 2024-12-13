# Challenge Rest API

[Documentación del Proyecto](https://equatorial-spell-3b8.notion.site/Challenge-Rest-API-c72e813a931e4b89afa935c23ba9f94e)

## Descripción

Challenge Rest API es una aplicación desarrollada en Ruby on Rails que implementa una API RESTful para la
gestión de datos. Este proyecto es un desafío técnico que demuestra cómo estructurar y desarrollar una API
utilizando las mejores prácticas de Rails.

---

## Características

- **CRUD completo**: Soporte para operaciones de creación, lectura, actualización y eliminación.
- **Estructura escalable**: Utiliza serializadores para respuestas JSON personalizadas.
- **Validaciones y Seguridad**: Validaciones estrictas en modelos y manejo de errores.

---

## Requisitos

- ruby 3.3.6
- rails 8.0.1

## Instalación

1. Clona el repositorio:
   ```bash
   git clone git@github.com:josuelandero13/api-rest-playerteam.git
   cd api-rest-playerteam

## Instala las dependencias:

2. bundle install

## Configuración de la base de datos

3. ./bin/rails db:create db:migrate db:seed

## Ejecutar el servidor de desarrollo

4. ./bin/rails s