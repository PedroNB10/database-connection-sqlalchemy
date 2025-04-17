# Projeto Database Connection - Flask, Psycopg & SQLAlchemy

Este projeto foi desenvolvido utilizando o framework Flask para criação de APIs REST, com conexões a banco de dados PostgreSQL através de duas abordagens distintas:

- **backend_psycopg**: Utilizando o driver psycopg para comunicação direta com PostgreSQL.
- **backend_sqlalchemy**: Utilizando o ORM SQLAlchemy para uma abordagem mais abstrata e orientada a objetos.

Ambas as versões seguem a arquitetura MVC (Model-View-Controller), empregando DAOs (Data Access Objects) para acesso aos dados.

---

## 📂 Estrutura dos Projetos

```
database-connection-sqlalchemy
│
├── backend_psycopg
│   ├── app
│   │   ├── controllers
│   │   ├── daos
│   │   ├── models
│   │   ├── routes
│   │   ├── static
│   │   ├── templates
│   │   └── utils
│   ├── backup
│   ├── scripts
│   ├── .env
│   ├── app.py
│   ├── compose.yaml
│   ├── config.py
│   ├── db.py
│   └── exceptions.py
│
├── backend_sqlalchemy
│   ├── app
│   │   ├── controllers
│   │   ├── daos
│   │   ├── models
│   │   ├── routes
│   │   ├── scripts
│   │   ├── static
│   │   ├── templates
│   │   └── serialize.py
│   ├── backup
│   ├── scripts
│   ├── .env
│   ├── app.py
│   ├── compose.yaml
│   ├── config.py
│   ├── db.py
│   └── exceptions.py
├── requirements.txt
├── .gitignore
└── README.md
```

---

## 🛠️ Requisitos para Execução

- Docker instalado
- Python 3.12+

---

## 🚀 Como executar os projetos

-- Observação: Para executar o projeto é preciso ter o docker instalado, pois o script em python irá executar o docker-compose para criar o banco de dados.

### 🔸 Instalação das dependências do projeto

```bash
pip install -r requirements.txt
```

### 🔸 backend_psycopg

```bash
cd backend_psycopg
python app.py
```

### 🔸 backend_sqlalchemy

```bash
cd backend_sqlalchemy
python app.py
```

Ambas as aplicações iniciam um ambiente Docker automaticamente, assegurando que o banco de dados PostgreSQL seja iniciado corretamente.

---

## 🗃️ Arquitetura MVC e DAO

- **Models**: Definem as entidades e tabelas no banco.
- **Views (templates)**: HTML, CSS e JavaScript para interfaces gráficas.
- **Controllers**: Regras de negócio e coordenação entre modelos e views.
- **DAOs**: Camada de abstração para acesso ao banco, garantindo segurança e organização.

---

## 🔐 Segurança contra SQL Injection

O projeto utiliza práticas seguras para evitar SQL injection, empregando placeholders para consultas SQL em todas as operações com o banco de dados.

---

## 🌐 Tecnologias Utilizadas

- Flask (backend)
- PostgreSQL
- Psycopg (driver direto)
- SQLAlchemy (ORM)
- Docker
- HTML, CSS, JavaScript (frontend)

---
