ijava.jre-archive:
  file.directory:
    - name: /opt/java/jre/8u112
    - user: root
    - group: root
    - makedirs: True
    - mode: 755
  archive.extracted:
    - name: /opt/java/jre/8u112
    - source: /tmp/server-jre-8u112-linux-x64.tar.gz
    - options: --strip 1
    - enforce_toplevel: False
    - user: root
    - group: root
