include:
  - nginx.config

start-nginx:
  cmd.run:
    - name: nginx
    - onlyif: nginx -t
    - unless: pgrep nginx
    - require:
      - file: manage-index
