# server.py

from flask import Flask

app = Flask(__name__)

@app.route("/")
def main():
    # 응답
    return "<p>Hello, World!</p>"

## 슬래시 뒤가 url 파트임. 서버는 url을 통해서 요청을 받는다. 받을 수 있는것은 개수가 한정되어 있음
@app.route("/qwer")
def about():
    # 응답
    return "<p>안녕 세상아</p>"



if __name__ == '__main__':
    app.run(port=3000, debug=True)


