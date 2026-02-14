"""
batch_reels_library.py

Modo automático: processa múltiplos grupos de Instagram Saved, até um limite total de posts,
salvando cada grupo em seu próprio arquivo markdown, com tags automáticas.

- Grupos viram tags: "London - travel" → #london #travel
- Arquivo: links/london - travel.md (exceto AR, AI, NYC)
- Ordem: começa pelo grupo escolhido, depois mais recentes
- Limite: pode cortar no meio do grupo, continua depois
- Grupos vazios são pulados
"""

import undetected_chromedriver as uc
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import os
import re
from login import login_to_instagram

EXCEPTIONS = {"AR", "AI", "NYC"}

def group_to_tags_and_filename(group_name):
    group = group_name.strip()
    if group in EXCEPTIONS:
        tags = [f"#{group}"]
        filename = f"{group}.md"
    else:
        parts = [p.strip() for p in group.replace('-', ' ').split()]
        tags = [f"#{p.lower()}" for p in parts if p]
        filename = f"{group}.md"
    return tags, filename

def main():
    # 1. Abre navegador e login manual
    browser = uc.Chrome()
    login_to_instagram(browser)
    print("Login realizado. Aguarde carregamento dos grupos...")

    # 2. Lê todos os grupos (collections)
    groups = get_instagram_collections(browser)
    if not groups:
        print("Nenhum grupo encontrado.")
        return

    # 3. Mostra lista e pergunta grupo inicial
    print("Grupos disponíveis:")
    for idx, g in enumerate(groups):
        print(f"{idx+1}. {g['name']} ({g['count']} posts)")
    start_idx = int(input("Escolha o número do grupo para começar: ")) - 1
    limit = int(input("Limite total de posts a processar: "))

    processed = 0
    group_idx = start_idx
    while processed < limit and group_idx < len(groups):
        group = groups[group_idx]
        group_name = group['name']
        tags, filename = group_to_tags_and_filename(group_name)
        print(f"Processando grupo: {group_name} → {filename} ({tags})")

        posts = get_posts_from_group(browser, group)
        if not posts:
            print("Grupo vazio, pulando.")
            group_idx += 1
            continue

        to_process = min(len(posts), limit - processed)
        posts_to_save = posts[:to_process]
        save_posts_to_md(posts_to_save, tags, filename)
        untag_posts(browser, posts_to_save)
        processed += to_process
        print(f"Processados {processed}/{limit} posts.")

        group_idx += 1

    print("Batch finalizado.")

def get_instagram_collections(browser):
    # TODO: Implementar scraping das collections (grupos) do Instagram Saved
    # Retornar lista de dicts: [{'name': 'London - travel', 'count': 123, ...}, ...]
    pass

def get_posts_from_group(browser, group):
    # TODO: Scrape posts do grupo (collection)
    # Retornar lista de dicts: [{'url': ..., 'caption': ..., ...}, ...]
    pass

def save_posts_to_md(posts, tags, filename):
    # TODO: Salvar posts no arquivo markdown correto, com tags
    # Exemplo de linha: - [title](url) @author #tag1 #tag2 #date
    pass

def untag_posts(browser, posts):
    # TODO: Remover posts do Instagram Saved (untag)
    pass

if __name__ == "__main__":
    main()
