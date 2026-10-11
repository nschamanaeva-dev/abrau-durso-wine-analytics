-- ==========================================
-- Проект: Аналитика портфеля вин Абрау-Дюрсо
-- Задача: Определить, какой ценовой сегмент и линейка приносят наибольшую выручку
-- ==========================================

WITH sales_revenue AS (
    -- Шаг 1: Объединяем таблицы продаж и каталога вин, считаем выручку по каждой позиции
    SELECT 
        s.wine_id,
        s.quantity_bottles,
        s.channel,
        w.line,
        w.segment,
        w.recommended_price_rub,
        (s.quantity_bottles * w.recommended_price_rub) AS total_revenue
    FROM sales s
    JOIN wines w ON s.wine_id = w.wine_id
)

-- Шаг 2: Агрегируем данные по сегментам и линейкам
SELECT 
    segment AS "Ценовой сегмент",
    line AS "Линейка вин",
    SUM(quantity_bottles) AS "Продано бутылок",
    ROUND(SUM(total_revenue), 0) AS "Общая выручка (руб)",
    ROUND(AVG(recommended_price_rub), 0) AS "Средняя цена за бутылку (руб)"
FROM sales_revenue
GROUP BY segment, line
ORDER BY "Общая выручка (руб)" DESC;
