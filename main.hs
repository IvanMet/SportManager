import Data.List (sortOn)
import System.IO
import Text.Read (readMaybe)

-- Основной тип данных для хранения результатов
data Result = Result
    { athlete :: String
    , sport   :: String
    , date    :: String
    , score   :: Double
    } deriving (Show, Read)

-- Чистые функции для обработки данных

-- Средний результат
averageScore :: [Result] -> Double
averageScore [] = 0
averageScore results = sum (map score results) / fromIntegral (length results)

-- Фильтрация по виду спорта
filterBySport :: String -> [Result] -> [Result]
filterBySport s = filter (\r -> sport r == s)

-- Фильтрация по атлету
filterByAthlete :: String -> [Result] -> [Result]
filterByAthlete a = filter (\r -> athlete r == a)

-- Фильтрация по дате
filterByDate :: String -> [Result] -> [Result]
filterByDate d = filter (\r -> date r == d)

-- Топ N лучших результатов
topN :: Int -> [Result] -> [Result]
topN n results = take n $ reverse $ sortOn score results

-- Топ N худших результатов
bottomN :: Int -> [Result] -> [Result]
bottomN n results = take n $ sortOn score results

-- Сортировка по дате (сначала новые)
sortByDateDesc :: [Result] -> [Result]
sortByDateDesc = reverse . sortOn date

-- Сортировка по дате (сначала старые)
sortByDateAsc :: [Result] -> [Result]
sortByDateAsc = sortOn date

-- Загрузка данных из файла
loadFromFile :: FilePath -> IO [Result]
loadFromFile path = do
    contents <- readFile path
    return (read contents)

-- Сохранение данных в файл
saveToFile :: FilePath -> [Result] -> IO ()
saveToFile path results = writeFile path (show results)

-- Форматированный вывод результата
showResult :: Result -> String
showResult r = athlete r ++ " | " ++ sport r ++ " | " ++ date r ++ " | " ++ show (score r)

-- Вывод списка результатов
showResults :: [Result] -> IO ()
showResults [] = putStrLn "Нет данных для отображения."
showResults results = mapM_ (putStrLn . showResult) results

-- Меню
printMenu :: IO ()
printMenu = do
    putStrLn "\n=== Меню анализа спортивных результатов ==="
    putStrLn "1 – Подсчитать средний результат"
    putStrLn "2 – Найти лучших спортсменов/команды"
    putStrLn "3 – Найти худших спортсменов/команды"
    putStrLn "4 – Фильтровать результаты"
    putStrLn "5 – Сортировать по дате"
    putStrLn "6 – Загрузить результаты из файла"
    putStrLn "7 – Сохранить результаты в файл"
    putStrLn "8 – Показать все результаты"
    putStrLn "9 – Выход"
    putStr "Выберите опцию: "

-- Основной цикл программы
mainLoop :: [Result] -> IO ()
mainLoop results = do
    printMenu
    choice <- getLine
    case choice of
        "1" -> do
            let avg = averageScore results
            putStrLn $ "Средний результат: " ++ show avg
            mainLoop results
            
        "2" -> do
            putStr "Введите количество лучших результатов для отображения: "
            input <- getLine
            case readMaybe input of
                Just n -> do
                    let top = topN n results
                    putStrLn $ "Топ-" ++ show n ++ " лучших результатов:"
                    showResults top
                Nothing -> putStrLn "Ошибка: введите целое число."
            mainLoop results
            
        "3" -> do
            putStr "Введите количество худших результатов для отображения: "
            input <- getLine
            case readMaybe input of
                Just n -> do
                    let bottom = bottomN n results
                    putStrLn $ "Топ-" ++ show n ++ " худших результатов:"
                    showResults bottom
                Nothing -> putStrLn "Ошибка: введите целое число."
            mainLoop results
            
        "4" -> do
            putStrLn "Фильтровать по:"
            putStrLn "1 – Виду спорта"
            putStrLn "2 – Спортсмену/команде"
            putStrLn "3 – Дате"
            putStr "Выберите опцию: "
            subChoice <- getLine
            case subChoice of
                "1" -> do
                    putStr "Введите вид спорта: "
                    sportName <- getLine
                    let filtered = filterBySport sportName results
                    putStrLn $ "Результаты по виду спорта '" ++ sportName ++ "':"
                    showResults filtered
                "2" -> do
                    putStr "Введите имя спортсмена/команды: "
                    athleteName <- getLine
                    let filtered = filterByAthlete athleteName results
                    putStrLn $ "Результаты для '" ++ athleteName ++ "':"
                    showResults filtered
                "3" -> do
                    putStr "Введите дату (в формате ГГГГ-ММ-ДД): "
                    dateStr <- getLine
                    let filtered = filterByDate dateStr results
                    putStrLn $ "Результаты за " ++ dateStr ++ ":"
                    showResults filtered
                _ -> putStrLn "Неверный выбор."
            mainLoop results
            
        "5" -> do
            putStrLn "Сортировать по дате:"
            putStrLn "1 – Сначала новые"
            putStrLn "2 – Сначала старые"
            putStr "Выберите опцию: "
            subChoice <- getLine
            case subChoice of
                "1" -> do
                    let sorted = sortByDateDesc results
                    putStrLn "Результаты (сначала новые):"
                    showResults sorted
                "2" -> do
                    let sorted = sortByDateAsc results
                    putStrLn "Результаты (сначала старые):"
                    showResults sorted
                _ -> putStrLn "Неверный выбор."
            mainLoop results
            
        "6" -> do
            putStr "Введите имя файла для загрузки: "
            fileName <- getLine
            loadedResults <- loadFromFile fileName
            putStrLn $ "Загружено " ++ show (length loadedResults) ++ " записей."
            mainLoop loadedResults
            
        "7" -> do
            putStr "Введите имя файла для сохранения: "
            fileName <- getLine
            saveToFile fileName results
            putStrLn "Данные сохранены."
            mainLoop results
            
        "8" -> do
            putStrLn "Все результаты:"
            showResults results
            mainLoop results
            
        "9" -> putStrLn "Выход из программы."
            
        _ -> do
            putStrLn "Неверный выбор. Попробуйте снова."
            mainLoop results

-- Пример начальных данных для тестирования
sampleData :: [Result]
sampleData =
    [ Result "Иванов" "Плавание" "2024-05-10" 89.5
    , Result "Петров" "Бег" "2024-05-11" 92.3
    , Result "Сидоров" "Плавание" "2024-05-10" 85.0
    , Result "Кузнецов" "Прыжки" "2024-05-12" 78.9
    , Result "Иванов" "Бег" "2024-05-11" 95.7
    , Result "Смирнов" "Плавание" "2024-05-13" 88.2
    ]

-- Главная функция
main :: IO ()
main = do
    putStrLn "Анализ спортивных результатов"
    putStrLn "==============================="
    putStrLn "Загружен демонстрационный набор данных (6 записей)."
    mainLoop sampleData
