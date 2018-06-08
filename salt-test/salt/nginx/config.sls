include:
  - nginx.install

manage-index:
  file.managed:
    - name: /usr/share/nginx/html/index.html
    - user: root
    - group: root
    - mode: 100
    - require:
      - pkg: install-nginx
