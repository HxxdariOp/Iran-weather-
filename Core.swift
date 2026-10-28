import SwiftUI

// MARK: - Cities

struct City: Identifiable, Hashable {
    let id: String
    let name: String
    let province: String
    let lat: Double
    let lon: Double
}

enum Cities {
    static let all: [City] = [
        City(id: "tehran", name: "تهران", province: "تهران", lat: 35.6892, lon: 51.3890),
        City(id: "karaj", name: "کرج", province: "البرز", lat: 35.8400, lon: 50.9391),
        City(id: "mashhad", name: "مشهد", province: "خراسان رضوی", lat: 36.2605, lon: 59.6168),
        City(id: "isfahan", name: "اصفهان", province: "اصفهان", lat: 32.6546, lon: 51.6680),
        City(id: "shiraz", name: "شیراز", province: "فارس", lat: 29.5918, lon: 52.5837),
        City(id: "tabriz", name: "تبریز", province: "آذربایجان شرقی", lat: 38.0962, lon: 46.2738),
        City(id: "qom", name: "قم", province: "قم", lat: 34.6399, lon: 50.8759),
        City(id: "ahvaz", name: "اهواز", province: "خوزستان", lat: 31.3183, lon: 48.6706),
        City(id: "kermanshah", name: "کرمانشاه", province: "کرمانشاه", lat: 34.3277, lon: 47.0778),
        City(id: "urmia", name: "ارومیه", province: "آذربایجان غربی", lat: 37.5527, lon: 45.0760),
        City(id: "rasht", name: "رشت", province: "گیلان", lat: 37.2808, lon: 49.5832),
        City(id: "zahedan", name: "زاهدان", province: "سیستان و بلوچستان", lat: 29.4963, lon: 60.8629),
        City(id: "kerman", name: "کرمان", province: "کرمان", lat: 30.2839, lon: 57.0834),
        City(id: "arak", name: "اراک", province: "مرکزی", lat: 34.0954, lon: 49.6892),
        City(id: "yazd", name: "یزد", province: "یزد", lat: 31.8974, lon: 54.3569),
        City(id: "ardabil", name: "اردبیل", province: "اردبیل", lat: 38.2498, lon: 48.2933),
        City(id: "bandarabbas", name: "بندرعباس", province: "هرمزگان", lat: 27.1865, lon: 56.2808),
        City(id: "hamadan", name: "همدان", province: "همدان", lat: 34.7983, lon: 48.5148),
        City(id: "qazvin", name: "قزوین", province: "قزوین", lat: 36.2797, lon: 50.0049),
        City(id: "sanandaj", name: "سنندج", province: "کردستان", lat: 35.3219, lon: 46.9862),
        City(id: "khorramabad", name: "خرم‌آباد", province: "لرستان", lat: 33.4878, lon: 48.3558),
        City(id: "gorgan", name: "گرگان", province: "گلستان", lat: 36.8427, lon: 54.4439),
        City(id: "sari", name: "ساری", province: "مازندران", lat: 36.5633, lon: 53.0601),
        City(id: "zanjan", name: "زنجان", province: "زنجان", lat: 36.6736, lon: 48.4787),
        City(id: "bojnord", name: "بجنورد", province: "خراسان شمالی", lat: 37.4747, lon: 57.3290),
        City(id: "birjand", name: "بیرجند", province: "خراسان جنوبی", lat: 32.8649, lon: 59.2262),
        City(id: "ilam", name: "ایلام", province: "ایلام", lat: 33.6374, lon: 46.4227),
        City(id: "bushehr", name: "بوشهر", province: "بوشهر", lat: 28.9684, lon: 50.8385),
        City(id: "semnan", name: "سمنان", province: "سمنان", lat: 35.5769, lon: 53.3920),
        City(id: "shahrekord", name: "شهرکرد", province: "چهارمحال و بختیاری", lat: 32.3256, lon: 50.8644),
        City(id: "yasuj", name: "یاسوج", province: "کهگیلویه و بویراحمد", lat: 30.6682, lon: 51.5880),
        City(id: "kish", name: "کیش", province: "هرمزگان", lat: 26.5579, lon: 54.0194),
        City(id: "qeshm", name: "قشم", province: "هرمزگان", lat: 26.9580, lon: 56.2710),
        City(id: "abadan", name: "آبادان", province: "خوزستان", lat: 30.3392, lon: 48.3043),
        City(id: "dezful", name: "دزفول", province: "خوزستان", lat: 32.3830, lon: 48.4010),
        City(id: "sabzevar", name: "سبزوار", province: "خراسان رضوی", lat: 36.2126, lon: 57.6819),
        City(id: "neyshabur", name: "نیشابور", province: "خراسان رضوی", lat: 36.2140, lon: 58.7961),
        City(id: "torbat", name: "تربت حیدریه", province: "خراسان رضوی", lat: 35.2740, lon: 59.2190),
        City(id: "khoy", name: "خوی", province: "آذربایجان غربی", lat: 38.5503, lon: 44.9521),
        City(id: "mahabad", name: "مهاباد", province: "آذربایجان غربی", lat: 36.7631, lon: 45.7222),
        City(id: "maragheh", name: "مراغه", province: "آذربایجان شرقی", lat: 37.3891, lon: 46.2387),
        City(id: "saveh", name: "ساوه", province: "مرکزی", lat: 35.0213, lon: 50.3566),
        City(id: "varamin", name: "ورامین", province: "تهران", lat: 35.3250, lon: 51.6472),
        City(id: "chabahar", name: "چابهار", province: "سیستان و بلوچستان", lat: 25.2919, lon: 60.6430),
        City(id: "iranshahr", name: "ایرانشهر", province: "سیستان و بلوچستان", lat: 27.2025, lon: 60.6848),
        City(id: "jahrom", name: "جهرم", province: "فارس", lat: 28.5000, lon: 53.5610),
        City(id: "lar", name: "لار", province: "فارس", lat: 27.6827, lon: 54.3400),
        City(id: "kashan", name: "کاشان", province: "اصفهان", lat: 33.9850, lon: 51.4100),
        City(id: "najafabad", name: "نجف‌آباد", province: "اصفهان", lat: 32.6344, lon: 51.3669),
        City(id: "borujerd", name: "بروجرد", province: "لرستان", lat: 33.8972, lon: 48.7517),
        City(id: "amol", name: "آمل", province: "مازندران", lat: 36.4696, lon: 52.3507),
        City(id: "babol", name: "بابل", province: "مازندران", lat: 36.5513, lon: 52.6788),
        City(id: "lahijan", name: "لاهیجان", province: "گیلان", lat: 37.2070, lon: 50.0040),
        City(id: "anzali", name: "بندر انزلی", province: "گیلان", lat: 37.4710, lon: 49.4630),
        City(id: "bam", name: "بم", province: "کرمان", lat: 29.1060, lon: 58.3570),
        City(id: "sirjan", name: "سیرجان", province: "کرمان", lat: 29.4500, lon: 55.6800),
        City(id: "shahroud", name: "شاهرود", province: "سمنان", lat: 36.4180, lon: 54.9760),
        City(id: "asaluyeh", name: "عسلویه", province: "بوشهر", lat: 27.4767, lon: 52.6136)
    ]
}

// MARK: - Helpers

extension String {
    var fa: String {
        let m: [Character: Character] = ["0": "۰", "1": "۱", "2": "۲", "3": "۳", "4": "۴",
                                          "5": "۵", "6": "۶", "7": "۷", "8": "۸", "9": "۹"]
        return String(self.map { m[$0] ?? $0 })
    }
}

func fnum(_ v: Double?, _ decimals: Int = 0) -> String {
    guard let v else { return "—" }
    return String(format: "%.\(decimals)f", v).fa
}

func at<T>(_ a: [T?], _ i: Int) -> T? {
    i >= 0 && i < a.count ? a[i] : nil
}

struct AQILevel {
    let label: String
    let color: Color
    let advice: String
}

func aqiLevel(_ v: Double?) -> AQILevel {
    guard let v else { return AQILevel(label: "نامشخص", color: .gray, advice: "") }
    switch v {
    case ..<51:
        return AQILevel(label: "پاک", color: .green, advice: "هوا سالم است؛ فعالیت در فضای باز مشکلی ندارد.")
    case ..<101:
        return AQILevel(label: "قابل قبول", color: .yellow, advice: "افراد بسیار حساس فعالیت سنگین طولانی را محدود کنند.")
    case ..<151:
        return AQILevel(label: "ناسالم برای گروه‌های حساس", color: .orange, advice: "کودکان، سالمندان و بیماران قلبی/تنفسی فعالیت بیرون را کم کنند.")
    case ..<201:
        return AQILevel(label: "ناسالم", color: .red, advice: "همه از فعالیت سنگین در فضای باز پرهیز کنند.")
    case ..<301:
        return AQILevel(label: "بسیار ناسالم", color: .purple, advice: "ماندن در محیط بسته و استفاده از ماسک N95 توصیه می‌شود.")
    default:
        return AQILevel(label: "خطرناک", color: Color(red: 0.5, green: 0, blue: 0.13), advice: "وضعیت اضطراری؛ از خانه خارج نشوید.")
    }
}

func weatherInfo(_ code: Int, day: Bool = true) -> (String, String) {
    switch code {
    case 0: return ("صاف", day ? "sun.max.fill" : "moon.stars.fill")
    case 1, 2: return ("نیمه‌ابری", day ? "cloud.sun.fill" : "cloud.moon.fill")
    case 3: return ("ابری", "cloud.fill")
    case 45, 48: return ("مه‌آلود", "cloud.fog.fill")
    case 51, 53, 55: return ("نم‌نم باران", "cloud.drizzle.fill")
    case 56, 57, 66, 67: return ("باران یخ‌زده", "cloud.sleet.fill")
    case 61, 63, 65: return ("باران", "cloud.rain.fill")
    case 71, 73, 75, 77, 85, 86: return ("برف", "cloud.snow.fill")
    case 80, 81, 82: return ("رگبار", "cloud.heavyrain.fill")
    case 95: return ("رعد و برق", "cloud.bolt.fill")
    case 96, 99: return ("رعد و برق و تگرگ", "cloud.bolt.rain.fill")
    default: return ("نامشخص", "questionmark.circle")
    }
}

func dayName(_ s: String, index: Int) -> String {
    if index == 0 { return "امروز" }
    let utc = TimeZone(identifier: "UTC")
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd"
    f.timeZone = utc
    f.locale = Locale(identifier: "en_US_POSIX")
    guard let d = f.date(from: s) else { return s }
    let o = DateFormatter()
    o.locale = Locale(identifier: "fa_IR")
    o.calendar = Calendar(identifier: .persian)
    o.timeZone = utc
    o.dateFormat = "EEEE d MMMM"
    return o.string(from: d)
}

func pollutantName(_ key: String) -> String {
    switch key {
    case "pm25": return "ذرات PM2.5"
    case "pm10": return "ذرات PM10"
    case "o3": return "ازن (O₃)"
    case "no2": return "دی‌اکسید نیتروژن (NO₂)"
    case "so2": return "دی‌اکسید گوگرد (SO₂)"
    case "co": return "مونوکسید کربن (CO)"
    case "t": return "دما"
    case "h": return "رطوبت"
    case "p": return "فشار"
    case "w": return "باد"
    default: return key
    }
}

// MARK: - Open-Meteo models

struct ForecastResponse: Decodable {
    struct Current: Decodable {
        let time: String?
        let temperature_2m: Double?
        let relative_humidity_2m: Double?
        let apparent_temperature: Double?
        let weather_code: Int?
        let wind_speed_10m: Double?
        let wind_direction_10m: Double?
        let pressure_msl: Double?
        let precipitation: Double?
        let cloud_cover: Double?
        let is_day: Int?
    }
    struct Hourly: Decodable {
        let time: [String]
        let temperature_2m: [Double?]
        let precipitation_probability: [Double?]
        let weather_code: [Int?]
    }
    struct Daily: Decodable {
        let time: [String]
        let weather_code: [Int?]
        let temperature_2m_max: [Double?]
        let temperature_2m_min: [Double?]
        let precipitation_sum: [Double?]
        let sunrise: [String?]
        let sunset: [String?]
        let uv_index_max: [Double?]
        let wind_speed_10m_max: [Double?]
    }
    let current: Current
    let hourly: Hourly
    let daily: Daily
}

struct AQResponse: Decodable {
    struct Current: Decodable {
        let time: String?
        let us_aqi: Double?
        let european_aqi: Double?
        let pm10: Double?
        let pm2_5: Double?
        let carbon_monoxide: Double?
        let nitrogen_dioxide: Double?
        let sulphur_dioxide: Double?
        let ozone: Double?
        let dust: Double?
    }
    struct Hourly: Decodable {
        let time: [String]
        let us_aqi: [Double?]
        let pm2_5: [Double?]
    }
    let current: Current
    let hourly: Hourly
}

struct MultiForecast: Decodable {
    struct Cur: Decodable {
        let temperature_2m: Double?
        let weather_code: Int?
        let is_day: Int?
    }
    let current: Cur
}

struct MultiAQ: Decodable {
    struct Cur: Decodable {
        let us_aqi: Double?
        let pm2_5: Double?
    }
    let current: Cur
}

// MARK: - WAQI models

struct WAQIStationPoint: Decodable, Identifiable, Hashable {
    struct Info: Decodable, Hashable {
        let name: String
        let time: String?
    }
    let uid: Int
    let lat: Double
    let lon: Double
    let aqi: String
    let station: Info
    var id: Int { uid }
    var aqiValue: Double? { Double(aqi) }
}

struct WAQIMapResponse: Decodable {
    let status: String
    let data: [WAQIStationPoint]
    enum K: String, CodingKey { case status, data }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: K.self)
        status = try c.decode(String.self, forKey: .status)
        data = (try? c.decode([WAQIStationPoint].self, forKey: .data)) ?? []
    }
}

struct FlexNum: Decodable {
    let value: Double?
    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if let d = try? c.decode(Double.self) { value = d }
        else if let s = try? c.decode(String.self) { value = Double(s) }
        else { value = nil }
    }
}

struct WAQIFeedResponse: Decodable {
    struct CityInfo: Decodable { let name: String; let url: String? }
    struct Val: Decodable { let v: Double? }
    struct TimeInfo: Decodable { let s: String? }
    struct Payload: Decodable {
        let aqi: FlexNum?
        let dominentpol: String?
        let city: CityInfo
        let iaqi: [String: Val]?
        let time: TimeInfo?
    }
    let status: String
    let data: Payload?
    enum K: String, CodingKey { case status, data }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: K.self)
        status = try c.decode(String.self, forKey: .status)
        data = try? c.decode(Payload.self, forKey: .data)
    }
}

// MARK: - API

enum APIError: LocalizedError {
    case badURL, http(Int), api(String)
    var errorDescription: String? {
        switch self {
        case .badURL: return "آدرس نامعتبر"
        case .http(let c): return "خطای سرور (\(c))"
        case .api(let m): return m
        }
    }
}

enum API {
    static let session: URLSession = {
        let c = URLSessionConfiguration.default
        c.timeoutIntervalForRequest = 20
        c.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: c)
    }()

    static func get<T: Decodable>(_ s: String) async throws -> T {
        guard let url = URL(string: s) else { throw APIError.badURL }
        let (data, resp) = try await session.data(from: url)
        if let h = resp as? HTTPURLResponse, !(200..<300).contains(h.statusCode) {
            throw APIError.http(h.statusCode)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    static func forecast(lat: Double, lon: Double) async throws -> ForecastResponse {
        try await get("https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)"
            + "&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,weather_code,cloud_cover,pressure_msl,wind_speed_10m,wind_direction_10m"
            + "&hourly=temperature_2m,precipitation_probability,weather_code"
            + "&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max,precipitation_sum,wind_speed_10m_max"
            + "&timezone=Asia%2FTehran&forecast_days=7")
    }

    static func airQuality(lat: Double, lon: Double) async throws -> AQResponse {
        try await get("https://air-quality-api.open-meteo.com/v1/air-quality?latitude=\(lat)&longitude=\(lon)"
            + "&current=us_aqi,european_aqi,pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone,dust"
            + "&hourly=us_aqi,pm2_5&timezone=Asia%2FTehran&forecast_days=3")
    }

    static func batchWeather(_ cities: [City]) async throws -> [MultiForecast] {
        let lats = cities.map { String($0.lat) }.joined(separator: ",")
        let lons = cities.map { String($0.lon) }.joined(separator: ",")
        return try await get("https://api.open-meteo.com/v1/forecast?latitude=\(lats)&longitude=\(lons)&current=temperature_2m,weather_code,is_day&timezone=Asia%2FTehran")
    }

    static func batchAQ(_ cities: [City]) async throws -> [MultiAQ] {
        let lats = cities.map { String($0.lat) }.joined(separator: ",")
        let lons = cities.map { String($0.lon) }.joined(separator: ",")
        return try await get("https://air-quality-api.open-meteo.com/v1/air-quality?latitude=\(lats)&longitude=\(lons)&current=us_aqi,pm2_5&timezone=Asia%2FTehran")
    }

    static func stations(south: Double, west: Double, north: Double, east: Double, token: String) async throws -> [WAQIStationPoint] {
        let t = token.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? token
        let r: WAQIMapResponse = try await get("https://api.waqi.info/map/bounds/?latlng=\(south),\(west),\(north),\(east)&networks=all&token=\(t)")
        guard r.status == "ok" else { throw APIError.api("پاسخ نامعتبر از WAQI؛ توکن را بررسی کنید.") }
        return r.data
    }

    static func feed(uid: Int, token: String) async throws -> WAQIFeedResponse.Payload {
        let t = token.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? token
        let r: WAQIFeedResponse = try await get("https://api.waqi.info/feed/@\(uid)/?token=\(t)")
        guard r.status == "ok", let d = r.data else { throw APIError.api("داده‌ای برای این ایستگاه در دسترس نیست.") }
        return d
    }
}

// MARK: - Settings

final class Settings: ObservableObject {
    @Published var token: String {
        didSet { UserDefaults.standard.set(token, forKey: "waqi_token") }
    }
    @Published var favorites: [String] {
        didSet { UserDefaults.standard.set(favorites, forKey: "favorites") }
    }

    init() {
        token = UserDefaults.standard.string(forKey: "waqi_token") ?? ""
        favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? ["tehran"]
    }

    func isFav(_ c: City) -> Bool { favorites.contains(c.id) }

    func toggle(_ c: City) {
        if let i = favorites.firstIndex(of: c.id) { favorites.remove(at: i) }
        else { favorites.append(c.id) }
    }
}

// MARK: - View models

@MainActor
final class SummaryVM: ObservableObject {
    struct Row {
        var temp: Double?
        var code: Int?
        var isDay: Bool
        var aqi: Double?
    }
    @Published var rows: [String: Row] = [:]
    @Published var loading = false
    @Published var error: String?

    func load() async {
        loading = true
        error = nil
        let cities = Cities.all
        var result: [String: Row] = [:]
        do {
            let w = try await API.batchWeather(cities)
            for (c, x) in zip(cities, w) {
                result[c.id] = Row(temp: x.current.temperature_2m, code: x.current.weather_code,
                                   isDay: (x.current.is_day ?? 1) == 1, aqi: nil)
            }
        } catch {
            self.error = "دریافت آب‌وهوا ناموفق بود: \(error.localizedDescription)"
        }
        do {
            let a = try await API.batchAQ(cities)
            for (c, x) in zip(cities, a) {
                var r = result[c.id] ?? Row(temp: nil, code: nil, isDay: true, aqi: nil)
                r.aqi = x.current.us_aqi
                result[c.id] = r
            }
        } catch {
            if self.error == nil { self.error = "دریافت کیفیت هوا ناموفق بود: \(error.localizedDescription)" }
        }
        rows = result
        loading = false
    }
}

@MainActor
final class CityVM: ObservableObject {
    @Published var weather: ForecastResponse?
    @Published var aq: AQResponse?
    @Published var stations: [WAQIStationPoint] = []
    @Published var loading = false
    @Published var error: String?
    @Published var stationError: String?

    func load(city: City, token: String) async {
        loading = true
        error = nil
        stationError = nil
        do { weather = try await API.forecast(lat: city.lat, lon: city.lon) }
        catch { self.error = "آب‌وهوا: \(error.localizedDescription)" }
        do { aq = try await API.airQuality(lat: city.lat, lon: city.lon) }
        catch { if self.error == nil { self.error = "کیفیت هوا: \(error.localizedDescription)" } }
        if !token.isEmpty {
            do {
                stations = try await API.stations(south: city.lat - 0.35, west: city.lon - 0.45,
                                                  north: city.lat + 0.35, east: city.lon + 0.45, token: token)
            } catch { stationError = error.localizedDescription }
        }
        loading = false
    }
}

@MainActor
final class StationsVM: ObservableObject {
    @Published var stations: [WAQIStationPoint] = []
    @Published var loading = false
    @Published var error: String?

    func load(token: String) async {
        loading = true
        error = nil
        do {
            stations = try await API.stations(south: 25.0, west: 44.0, north: 39.8, east: 63.5, token: token)
        } catch {
            self.error = error.localizedDescription
        }
        loading = false
    }
}
