import re
import os

CAMINHO_MODELS_ORIGEM = "../models/models.py"
CAMINHO_MODELS_SIMPLES = "../models/psycopg_models.py"


def extrair_classes(code):
    # Regex para encontrar cada classe com seu corpo
    padrao_classe = r"class\s+(\w+)\(Base\):.*?__tablename__.*?\n(.*?)(?=\nclass|\Z)"
    classes = re.findall(padrao_classe, code, re.DOTALL)

    resultado = []

    for nome_classe, corpo in classes:
        # Captura os atributos e tipos dentro de mapped_column
        atributos = re.findall(r"(\w+):\s+Mapped\[(.*?)\]\s*=\s*mapped_column", corpo)
        if not atributos:
            continue

        # Construtor __init__ com tipos e valores padrão None
        parametros = ", ".join([f"{nome}: {tipo} = None" for nome, tipo in atributos])
        construtor = f"    def __init__(self, {parametros}):\n"
        for nome, tipo in atributos:
            construtor += f"        self.{nome}: {tipo} = {nome}\n"

        # Monta a classe final
        classe_formatada = f"class {nome_classe}:\n{construtor}\n"
        resultado.append(classe_formatada)

    return "\n".join(resultado)


def converter():
    if not os.path.exists(CAMINHO_MODELS_ORIGEM):
        print("❌ Arquivo models.py não encontrado.")
        return

    with open(CAMINHO_MODELS_ORIGEM, "r") as f:
        codigo = f.read()

    resultado = extrair_classes(codigo)

    if not resultado.strip():
        print("⚠️ Nenhuma classe foi convertida. Verifique o conteúdo do models.py.")
        return

    with open(CAMINHO_MODELS_SIMPLES, "w") as f:
        f.write("# Modelos adaptados para uso com psycopg (sem ORM)\n\n")
        f.write("from typing import Optional\nimport datetime\nimport decimal\n\n")
        f.write(resultado)

    print(f"✅ Modelos simplificados gerados em: {CAMINHO_MODELS_SIMPLES}")


if __name__ == "__main__":
    converter()
