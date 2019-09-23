FROM python:3.6.1 
# copy from current directory to /app dir of container
COPY . /app 
WORKDIR /app 
# bundle
RUN pip install -r requirements.txt
ENTRYPOINT ["python"] 
CMD ["app.py"] 
EXPOSE 5000 