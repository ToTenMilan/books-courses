FROM python:3.6.1
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
# run nameko instead of python app as previous
ENTRYPOINT ["nameko"]
# run service as specified in config.yml
CMD ["run", "--config",  "config.yml", "services"] 
EXPOSE 8000
