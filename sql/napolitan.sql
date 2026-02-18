CREATE TABLE inventory (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    count INTEGER NOT NULL CHECK (count >= 0)
);

SELECT * FROM inventory

INSERT INTO inventory (name, count) VALUES
('sealed_food_pack', 2),        -- 밀봉된 음식 (안전해 보이지만 인식 시 위험)
('warm_liquid', 1),             -- 따뜻한 액체
('unlabeled_snack', 3),         -- 표기 없는 간식
('leftover_meal', 1),           -- 이전에 먹다 남은 음식
('thin_blanket', 1),            -- 얇은 담요
('earplugs', 2),                -- 귀마개
('dim_light_source', 1),        -- 약한 조명
('hard_floor_space', 1),        -- 바닥 휴식 공간
('hand_drawn_map', 1),          -- 손으로 그린 지도
('direction_marker', 2),        -- 방향 표시 도구
('temporary_pass', 1),          -- 일시 통행 허가
('footwear', 1),                -- 신발 (이미 신고 있을 가능성 있음)
('written_note', 2),            -- 메모지
('predefined_phrase', 3),       -- 미리 정해진 문장
('voice_recorder', 1),          -- 음성 기록 장치
('question_token', 1),          -- 질문 허용 토큰
('time_buffer', 1),             -- 시간을 벌어주는 것처럼 보이는 여유
('observation_log', 1),         -- 관찰 기록물
('confirmation_object', 0),     -- 확신을 주는 물건 (항상 소진 상태)
('instruction_sheet', 0);    