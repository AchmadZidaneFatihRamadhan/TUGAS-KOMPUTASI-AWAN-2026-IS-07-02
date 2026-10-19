FROM python:3.10-slim
WORKDIR /app
RUN echo "Halo dari Modul 2 Jenkins Docker" > index.html
EXPOSE 5000
CMD ["python", "-m", "http.server", "5000"]
