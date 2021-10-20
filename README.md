# umireon/texlive-ja

The Docker image of TeX Live for Japanese documents

## How to install

```bash
docker pull umireon/texlive-ja
```

## How to use

```bash
% docker run -it -v $(pwd):/workdir umireon/texlive-ja
% latexmk main.tex
```

---

Forked back from https://github.com/Paperist/texlive-ja.

Originated in https://github.com/umireon/docker-texci.
