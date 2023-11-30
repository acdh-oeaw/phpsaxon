# PHP saxon

A technology demo showing how to plug in the Saxon library into the PHP.

## Installation

```bash
docker build --rm -t acdhch/phpsaxon:latest .
docker run -d --name phpsaxon --rm -p 8080:80 acdhch/phpsaxon:latest
```

## Usage

```
curl -i 'http://127.0.0.1:8080?xml=https%3A%2F%2Farche.acdh.oeaw.ac.at%2Fapi%2F110805&xslt=https%3A%2F%2Farche.acdh.oeaw.ac.at%2Fapi%2F22064'
```

xml: https://arche.acdh.oeaw.ac.at/api/110805
xslt: https://arche.acdh.oeaw.ac.at/api/22064

