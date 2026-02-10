from flask import Flask, request, render_template_string
import random

app = Flask(__name__)

# HTML 템플릿 (입력 페이지)
INDEX_HTML = """
<!DOCTYPE html>
<html>
<head>
    <title>로또 추첨기</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding-top: 50px; }
        input { padding: 10px; font-size: 16px; }
        button { padding: 10px 20px; font-size: 16px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <h1>💰 로또 번호 추첨 💰</h1>
    <form action="/lotto" method="GET">
        <p>이름을 입력해주세요:</p>
        <input type="text" name="username" placeholder="예: 지니" required>
        <button type="submit">번호 받기</button>
    </form>
</body>
</html>
"""

# HTML 템플릿 (결과 페이지)
RESULT_HTML = """
<!DOCTYPE html>
<html>
<head>
    <title>추첨 결과</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding-top: 50px; }
        .numbers { font-size: 24px; font-weight: bold; color: #333; margin: 20px 0; }
        .ball { display: inline-block; width: 40px; height: 40px; line-height: 40px; background-color: #ff9800; color: white; border-radius: 50%; margin: 5px; }
        a { text-decoration: none; color: #2196F3; font-weight: bold; }
    </style>
</head>
<body>
    <h1>🎰 {{ username }}님의 추천 번호 🎰</h1>
    <div class="numbers">
        {% for num in numbers %}
            <span class="ball">{{ num }}</span>
        {% endfor %}
    </div>
    <p><a href="/">다시 추첨하기</a></p>
</body>
</html>
"""

@app.route('/')
def index():
    return render_template_string(INDEX_HTML)

@app.route('/lotto')
def lotto():
    username = request.args.get('username', '방문자')
    # 1부터 45까지의 숫자 중 6개를 중복 없이 추출하고 정렬
    lotto_numbers = sorted(random.sample(range(1, 46), 6))
    return render_template_string(RESULT_HTML, username=username, numbers=lotto_numbers)

if __name__ == '__main__':
    app.run(debug=True, port=5001)
