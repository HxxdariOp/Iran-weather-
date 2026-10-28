import SwiftUI
import MapKit
import Charts

// MARK: - Shared UI

struct Card<Content: View>: View {
    let title: String?
    let icon: String?
    let content: Content

    init(_ title: String? = nil, icon: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let title {
                HStack(spacing: 6) {
                    if let icon { Image(systemName: icon) }
                    Text(title)
                }
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
            }
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct AQIBadge: View {
    let value: Double?
    var body: some View {
        Text(fnum(value))
            .font(.caption.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 3)
            .background(aqiLevel(value).color)
            .clipShape(Capsule())
    }
}

struct InfoTile: View {
    let icon: String
    let title: String
    let value: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon).foregroundStyle(.tint).frame(width: 26)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption).foregroundStyle(.secondary)
                Text(value).font(.subheadline.bold())
            }
            Spacer(minLength: 0)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color(.tertiarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ErrorBanner: View {
    let text: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(text).font(.footnote)
            Spacer(minLength: 0)
        }
        .foregroundColor(.orange)
        .padding(10)
        .background(Color.orange.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct HPoint: Identifiable {
    let id: Int
    let label: String
    let value: Double
}

func hourlyPoints(times: [String], values: [Double?], now: String?, count: Int = 24) -> [HPoint] {
    let key = String((now ?? "").prefix(13))
    let start = times.firstIndex(where: { String($0.prefix(13)) >= key }) ?? 0
    var out: [HPoint] = []
    let end = min(times.count, start + count)
    var n = 0
    for i in start..<end {
        if let v = at(values, i) {
            let label = String(times[i].dropFirst(11).prefix(5)).fa
            out.append(HPoint(id: n, label: label, value: v))
        }
        n += 1
    }
    return out
}

struct HourlyChart: View {
    let points: [HPoint]
    let color: Color
    let bars: Bool

    var body: some View {
        let ticks = Array(stride(from: 0, to: max(points.count, 1), by: 6))
        Chart(points) { p in
            if bars {
                BarMark(x: .value("t", p.id), y: .value("v", p.value))
                    .foregroundStyle(aqiLevel(p.value).color)
            } else {
                LineMark(x: .value("t", p.id), y: .value("v", p.value))
                    .foregroundStyle(color)
                    .interpolationMethod(.catmullRom)
                AreaMark(x: .value("t", p.id), y: .value("v", p.value))
                    .foregroundStyle(LinearGradient(colors: [color.opacity(0.3), .clear], startPoint: .top, endPoint: .bottom))
                    .interpolationMethod(.catmullRom)
            }
        }
        .chartXAxis {
            AxisMarks(values: ticks) { v in
                AxisGridLine()
                AxisValueLabel {
                    if let i = v.as(Int.self), i < points.count {
                        Text(points[i].label).font(.caption2)
                    }
                }
            }
        }
        .frame(height: 150)
    }
}

// MARK: - Cities list

struct CityRow: View {
    let city: City
    let row: SummaryVM.Row?
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: weatherInfo(row?.code ?? 0, day: row?.isDay ?? true).1)
                .symbolRenderingMode(.multicolor)
                .font(.title2)
                .frame(width: 36)
            VStack(alignment: .leading, spacing: 2) {
                Text(city.name).font(.headline)
                Text(city.province).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            if let t = row?.temp {
                Text("\(fnum(t))°").font(.title3)
            }
            AQIBadge(value: row?.aqi)
        }
        .padding(.vertical, 2)
    }
}

struct CitiesView: View {
    @EnvironmentObject var settings: Settings
    @StateObject private var vm = SummaryVM()
    @State private var search = ""
    @State private var sort: Sort = .name

    enum Sort: String, CaseIterable, Identifiable {
        case name = "نام"
        case aqi = "آلودگی"
        case temp = "دما"
        var id: String { rawValue }
    }

    var filtered: [City] {
        var list = Cities.all.filter {
            search.isEmpty || $0.name.contains(search) || $0.province.contains(search)
                || $0.id.localizedCaseInsensitiveContains(search)
        }
        switch sort {
        case .name: list.sort { $0.name < $1.name }
        case .aqi: list.sort { (vm.rows[$0.id]?.aqi ?? -1) > (vm.rows[$1.id]?.aqi ?? -1) }
        case .temp: list.sort { (vm.rows[$0.id]?.temp ?? -99) > (vm.rows[$1.id]?.temp ?? -99) }
        }
        return list
    }

    func row(_ c: City) -> some View {
        NavigationLink(value: c) { CityRow(city: c, row: vm.rows[c.id]) }
    }

    var body: some View {
        NavigationStack {
            List {
                if let e = vm.error { ErrorBanner(text: e).listRowBackground(Color.clear) }
                let favs = Cities.all.filter { settings.favorites.contains($0.id) }
                if !favs.isEmpty && search.isEmpty {
                    Section("علاقه‌مندی‌ها") {
                        ForEach(favs) { row($0) }
                    }
                }
                Section("همه شهرها (\(String(filtered.count).fa))") {
                    ForEach(filtered) { row($0) }
                }
            }
            .searchable(text: $search, prompt: "جستجوی شهر یا استان")
            .navigationTitle("هوای ایران")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("مرتب‌سازی", selection: $sort) {
                            ForEach(Sort.allCases) { Text($0.rawValue).tag($0) }
                        }
                    } label: { Image(systemName: "arrow.up.arrow.down") }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if vm.loading { ProgressView() }
                }
            }
            .refreshable { await vm.load() }
            .task { await vm.load() }
            .navigationDestination(for: City.self) { CityDetailView(city: $0) }
        }
    }
}

// MARK: - City detail

struct CityDetailView: View {
    let city: City
    @EnvironmentObject var settings: Settings
    @StateObject private var vm = CityVM()

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                if let e = vm.error { ErrorBanner(text: e) }
                if let w = vm.weather {
                    header(w)
                    details(w)
                    hourly(w)
                    daily(w)
                } else if vm.loading {
                    ProgressView().padding(40)
                }
                if let a = vm.aq {
                    airCard(a)
                    pollutants(a)
                    aqiChart(a)
                }
                stationsCard
                Text("منابع: Open-Meteo (آب‌وهوا و مدل CAMS) و WAQI (ایستگاه‌ها)")
                    .font(.caption2).foregroundStyle(.secondary)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { settings.toggle(city) } label: {
                    Image(systemName: settings.isFav(city) ? "star.fill" : "star")
                }
            }
        }
        .refreshable { await vm.load(city: city, token: settings.token) }
        .task { await vm.load(city: city, token: settings.token) }
        .navigationDestination(for: WAQIStationPoint.self) {
            StationDetailView(uid: $0.uid, fallbackName: $0.station.name)
        }
    }

    @ViewBuilder func header(_ w: ForecastResponse) -> some View {
        let c = w.current
        let info = weatherInfo(c.weather_code ?? 0, day: (c.is_day ?? 1) == 1)
        Card {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(fnum(c.temperature_2m))°").font(.system(size: 60, weight: .thin))
                    Text(info.0).font(.title3)
                    Text("احساس واقعی: \(fnum(c.apparent_temperature))°")
                        .font(.footnote).foregroundStyle(.secondary)
                    Text("بیشینه \(fnum(at(w.daily.temperature_2m_max, 0)))°  ·  کمینه \(fnum(at(w.daily.temperature_2m_min, 0)))°")
                        .font(.footnote).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: info.1)
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 64))
            }
        }
    }

    @ViewBuilder func details(_ w: ForecastResponse) -> some View {
        let c = w.current
        let sunrise = at(w.daily.sunrise, 0) ?? nil
        let sunset = at(w.daily.sunset, 0) ?? nil
        Card("جزئیات", icon: "list.bullet") {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                InfoTile(icon: "humidity", title: "رطوبت", value: "\(fnum(c.relative_humidity_2m))٪")
                InfoTile(icon: "wind", title: "باد", value: "\(fnum(c.wind_speed_10m)) km/h")
                InfoTile(icon: "gauge", title: "فشار", value: "\(fnum(c.pressure_msl)) hPa")
                InfoTile(icon: "cloud", title: "پوشش ابر", value: "\(fnum(c.cloud_cover))٪")
                InfoTile(icon: "drop", title: "بارش", value: "\(fnum(c.precipitation, 1)) mm")
                InfoTile(icon: "sun.max", title: "شاخص UV", value: fnum(at(w.daily.uv_index_max, 0), 1))
                InfoTile(icon: "sunrise", title: "طلوع", value: String((sunrise ?? "—").suffix(5)).fa)
                InfoTile(icon: "sunset", title: "غروب", value: String((sunset ?? "—").suffix(5)).fa)
            }
        }
    }

    @ViewBuilder func hourly(_ w: ForecastResponse) -> some View {
        let pts = hourlyPoints(times: w.hourly.time, values: w.hourly.temperature_2m, now: w.current.time)
        if !pts.isEmpty {
            Card("دمای ۲۴ ساعت آینده", icon: "clock") {
                HourlyChart(points: pts, color: .orange, bars: false)
            }
        }
    }

    @ViewBuilder func daily(_ w: ForecastResponse) -> some View {
        Card("پیش‌بینی ۷ روز", icon: "calendar") {
            ForEach(0..<min(7, w.daily.time.count), id: \.self) { i in
                let info = weatherInfo(at(w.daily.weather_code, i) ?? 0)
                HStack {
                    Text(dayName(w.daily.time[i], index: i)).frame(width: 110, alignment: .leading)
                    Image(systemName: info.1).symbolRenderingMode(.multicolor)
                    Text(info.0).font(.footnote).foregroundStyle(.secondary)
                    Spacer()
                    Text("\(fnum(at(w.daily.temperature_2m_min, i)))°").foregroundStyle(.secondary)
                    Text("\(fnum(at(w.daily.temperature_2m_max, i)))°").bold()
                }
                .font(.subheadline)
                if i < min(7, w.daily.time.count) - 1 { Divider() }
            }
        }
    }

    @ViewBuilder func airCard(_ a: AQResponse) -> some View {
        let v = a.current.us_aqi
        let l = aqiLevel(v)
        Card("کیفیت هوا (مدل ماهواره‌ای CAMS)", icon: "wind") {
            HStack(spacing: 14) {
                ZStack {
                    Circle().fill(l.color.gradient)
                    Text(fnum(v)).font(.title.bold()).foregroundColor(.white)
                }
                .frame(width: 84, height: 84)
                VStack(alignment: .leading, spacing: 4) {
                    Text(l.label).font(.title3.bold())
                    Text(l.advice).font(.footnote).foregroundStyle(.secondary)
                }
            }
        }
    }

    @ViewBuilder func pollutants(_ a: AQResponse) -> some View {
        let c = a.current
        Card("آلاینده‌ها (µg/m³)", icon: "aqi.medium") {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                InfoTile(icon: "circle.grid.2x2", title: "PM2.5", value: fnum(c.pm2_5, 1))
                InfoTile(icon: "circle.grid.3x3", title: "PM10", value: fnum(c.pm10, 1))
                InfoTile(icon: "sun.dust", title: "گرد و غبار", value: fnum(c.dust, 1))
                InfoTile(icon: "smoke", title: "CO", value: fnum(c.carbon_monoxide, 0))
                InfoTile(icon: "car", title: "NO₂", value: fnum(c.nitrogen_dioxide, 1))
                InfoTile(icon: "factory", title: "SO₂", value: fnum(c.sulphur_dioxide, 1))
                InfoTile(icon: "sun.max.trianglebadge.exclamationmark", title: "O₃", value: fnum(c.ozone, 1))
                InfoTile(icon: "globe.europe.africa", title: "AQI اروپا", value: fnum(c.european_aqi))
            }
        }
    }

    @ViewBuilder func aqiChart(_ a: AQResponse) -> some View {
        let pts = hourlyPoints(times: a.hourly.time, values: a.hourly.us_aqi, now: a.current.time)
        if !pts.isEmpty {
            Card("پیش‌بینی شاخص آلودگی ۲۴ ساعت آینده", icon: "chart.bar") {
                HourlyChart(points: pts, color: .red, bars: true)
            }
        }
    }

    @ViewBuilder var stationsCard: some View {
        Card("ایستگاه‌های پایش اطراف", icon: "antenna.radiowaves.left.and.right") {
            if settings.token.isEmpty {
                Text("برای نمایش ایستگاه‌های واقعی، توکن رایگان WAQI را در تب تنظیمات وارد کنید.")
                    .font(.footnote).foregroundStyle(.secondary)
            } else if let e = vm.stationError {
                Text(e).font(.footnote).foregroundColor(.orange)
            } else if vm.stations.isEmpty {
                Text(vm.loading ? "در حال بارگذاری…" : "ایستگاهی در این محدوده یافت نشد.")
                    .font(.footnote).foregroundStyle(.secondary)
            } else {
                let sorted = vm.stations.sorted {
                    pow($0.lat - city.lat, 2) + pow($0.lon - city.lon, 2)
                        < pow($1.lat - city.lat, 2) + pow($1.lon - city.lon, 2)
                }
                ForEach(sorted) { s in
                    NavigationLink(value: s) {
                        HStack {
                            Text(s.station.name).font(.subheadline).lineLimit(2).multilineTextAlignment(.leading)
                            Spacer()
                            AQIBadge(value: s.aqiValue)
                            Image(systemName: "chevron.left").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                    Divider()
                }
            }
        }
    }
}

// MARK: - Station detail

struct StationDetailView: View {
    let uid: Int
    let fallbackName: String
    @EnvironmentObject var settings: Settings
    @State private var feed: WAQIFeedResponse.Payload?
    @State private var error: String?
    @State private var loading = true

    let pollutantKeys = ["pm25", "pm10", "o3", "no2", "so2", "co"]
    let weatherKeys = ["t", "h", "p", "w"]

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                if let e = error { ErrorBanner(text: e) }
                if loading { ProgressView().padding(40) }
                if let f = feed {
                    let aqi = f.aqi?.value
                    let l = aqiLevel(aqi)
                    Card(f.city.name, icon: "mappin.and.ellipse") {
                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(l.color.gradient)
                                Text(fnum(aqi)).font(.title.bold()).foregroundColor(.white)
                            }
                            .frame(width: 84, height: 84)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(l.label).font(.title3.bold())
                                if let d = f.dominentpol {
                                    Text("آلاینده غالب: \(pollutantName(d))").font(.footnote)
                                }
                                if let t = f.time?.s {
                                    Text("به‌روزرسانی: \(t.fa)").font(.caption2).foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    let polls = pollutantKeys.filter { f.iaqi?[$0]?.v != nil }
                    if !polls.isEmpty {
                        Card("زیرشاخص آلاینده‌ها (AQI)", icon: "aqi.medium") {
                            ForEach(polls, id: \.self) { k in
                                HStack {
                                    Text(pollutantName(k))
                                    Spacer()
                                    AQIBadge(value: f.iaqi?[k]?.v)
                                }
                                .font(.subheadline)
                            }
                        }
                    }
                    let ws = weatherKeys.filter { f.iaqi?[$0]?.v != nil }
                    if !ws.isEmpty {
                        Card("شرایط محیطی ایستگاه", icon: "thermometer.medium") {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                ForEach(ws, id: \.self) { k in
                                    InfoTile(icon: "circle.fill", title: pollutantName(k), value: fnum(f.iaqi?[k]?.v, 1))
                                }
                            }
                        }
                    }
                    if let u = f.city.url, let url = URL(string: u) {
                        Link("مشاهده صفحه ایستگاه", destination: url).font(.footnote)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(fallbackName)
        .navigationBarTitleDisplayMode(.inline)
        .task { await load() }
        .refreshable { await load() }
    }

    func load() async {
        loading = true
        error = nil
        do { feed = try await API.feed(uid: uid, token: settings.token) }
        catch { self.error = error.localizedDescription }
        loading = false
    }
}

// MARK: - Stations tab

struct TokenPrompt: View {
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "key.fill").font(.system(size: 44)).foregroundStyle(.tint)
            Text("برای دسترسی به ایستگاه‌های پایش کیفی هوا، یک توکن رایگان WAQI لازم است.")
                .multilineTextAlignment(.center)
            Text("آن را بگیرید و در تب «تنظیمات» وارد کنید.")
                .font(.footnote).foregroundStyle(.secondary)
            if let url = URL(string: "https://aqicn.org/data-platform/token/") {
                Link("دریافت توکن رایگان", destination: url).buttonStyle(.borderedProminent)
            }
        }
        .padding(30)
    }
}

struct StationsView: View {
    @EnvironmentObject var settings: Settings
    @StateObject private var vm = StationsVM()
    @State private var mode = 0
    @State private var search = ""
    @State private var selected: WAQIStationPoint?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.5, longitude: 54.3),
        span: MKCoordinateSpan(latitudeDelta: 14, longitudeDelta: 18))

    var filtered: [WAQIStationPoint] {
        let l = vm.stations.filter { search.isEmpty || $0.station.name.localizedCaseInsensitiveContains(search) }
        return l.sorted { ($0.aqiValue ?? -1) > ($1.aqiValue ?? -1) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if settings.token.isEmpty {
                    TokenPrompt()
                } else {
                    VStack(spacing: 0) {
                        Picker("", selection: $mode) {
                            Text("نقشه").tag(0)
                            Text("فهرست").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        if let e = vm.error { ErrorBanner(text: e).padding(.horizontal) }
                        if mode == 0 { mapView } else { listView }
                    }
                }
            }
            .navigationTitle("ایستگاه‌های پایش")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if vm.loading { ProgressView() }
                    else if !vm.stations.isEmpty {
                        Text("\(String(vm.stations.count).fa) ایستگاه").font(.caption).foregroundStyle(.secondary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { Task { await vm.load(token: settings.token) } } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .disabled(settings.token.isEmpty)
                }
            }
            .task(id: settings.token) {
                if !settings.token.isEmpty { await vm.load(token: settings.token) }
            }
            .navigationDestination(for: WAQIStationPoint.self) {
                StationDetailView(uid: $0.uid, fallbackName: $0.station.name)
            }
            .sheet(item: $selected) { s in
                NavigationStack {
                    StationDetailView(uid: s.uid, fallbackName: s.station.name)
                }
            }
        }
    }

    var mapView: some View {
        Map(coordinateRegion: $region, annotationItems: vm.stations) { s in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: s.lat, longitude: s.lon)) {
                Button { selected = s } label: {
                    Text(fnum(s.aqiValue))
                        .font(.caption2.bold())
                        .foregroundColor(.white)
                        .padding(5)
                        .frame(minWidth: 26)
                        .background(aqiLevel(s.aqiValue).color)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white, lineWidth: 1.5))
                }
            }
        }
    }

    var listView: some View {
        List {
            ForEach(filtered) { s in
                NavigationLink(value: s) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(s.station.name).font(.subheadline).lineLimit(2)
                            Text(aqiLevel(s.aqiValue).label).font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        AQIBadge(value: s.aqiValue)
                    }
                }
            }
        }
        .searchable(text: $search, prompt: "جستجوی ایستگاه")
    }
}

// MARK: - Settings

struct SettingsView: View {
    @EnvironmentObject var settings: Settings

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("توکن WAQI", text: $settings.token)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .environment(\.layoutDirection, .leftToRight)
                    if let url = URL(string: "https://aqicn.org/data-platform/token/") {
                        Link("دریافت توکن رایگان", destination: url)
                    }
                } header: {
                    Text("ایستگاه‌های پایش کیفی هوا")
                } footer: {
                    Text("داده ایستگاه‌ها از شبکه WAQI/aqicn.org می‌آید که شامل ایستگاه‌های سازمان محیط زیست و شهرداری‌ها در بخشی از شهرهای ایران است.")
                }

                Section("علاقه‌مندی‌ها") {
                    Button("پاک کردن همه", role: .destructive) { settings.favorites = [] }
                }

                Section("درباره") {
                    LabeledContent("آب‌وهوا", value: "Open-Meteo")
                    LabeledContent("آلودگی (مدل)", value: "Open-Meteo / CAMS")
                    LabeledContent("ایستگاه‌ها", value: "WAQI")
                    LabeledContent("نسخه", value: "۱٫۰")
                }
            }
            .navigationTitle("تنظیمات")
        }
    }
}
