local ls = require "luasnip"
local api = require "rd.snippets.api"
local make = api.make
local t = api.t
local c = api.ch

ls.add_snippets(
  "cpp",
  make {
    inc = {
      desc = "Include for competitive programming",
      c {
        t {
          "#include <optional>",
          "#include <bitset>",
          "#include <unordered_map>",
          "#include <unordered_set>",
          "#include <map>",
          "#include <set>",
          "#include <queue>",
          "#include <deque>",
          "#include <stack>",
          "#include <cmath>",
          "#include <iostream>",
          "#include <limits>",
          "#include <algorithm>",
          "#include <iterator>",
          "#include <limits>",
          "#include <numeric>",
          "#include <vector>",
          "#include <array>",
          "",
          -- "using namespace std;",
          "using ll = long long;",
          "",
          "",
        },
        t {
          "#include <optional>",
          "#include <bitset>",
          "#include <unordered_map>",
          "#include <unordered_set>",
          "#include <map>",
          "#include <set>",
          "#include <queue>",
          "#include <deque>",
          "#include <stack>",
          "#include <cmath>",
          "#include <iostream>",
          "#include <limits>",
          "#include <algorithm>",
          "#include <iterator>",
          "#include <limits>",
          "#include <numeric>",
          "#include <vector>",
          "#include <array>",
          "",
          "using namespace std;",
          "using ll = long long;",
          "",
          "template <typename T> concept is_container = requires(T a) {",
          "  a.begin();",
          "  a.end();",
          "};",
          "",
          "template <is_container T>requires (!std::same_as<T, std::string>)",
          "std::ostream &operator<<(std::ostream &os, const T &cont) {",
          "  os << '{';",
          "  for (const auto &x : cont) {",
          "    os << x;",
          "    os << ' ';",
          "  }",
          "  os << '}';",
          "  return os;",
          "}",
          "",
          "void printMatrix(const is_container auto &cont) {",
          "  for (const auto &x : cont) {",
          "    cout << x;",
          "    cout << '\\n';",
          "  }",
          "}",
          "",
          "template <typename T, std::size_t... Is>",
          "constexpr std::array<T, sizeof...(Is)>",
          "create_array(T value, std::index_sequence<Is...>) {",
          "  return {{(static_cast<void>(Is), value)...}};",
          "}",
          "",
          "template <std::size_t N, typename T>",
          "constexpr std::array<T, N> create_array(const T &value) {",
          "  return create_array(value, std::make_index_sequence<N>());",
          "}",

          "template <typename T>",
          "constexpr auto accessor(T& t){",
          "  return [&](int i) -> typename T::reference{",
          "    return t.at(i);",
          "  };",
          "}",
          "",
          "template <typename T>",
          "constexpr auto accessor(const T& t){",
          "  return [&](int i){",
          "    return t.at(i);",
          "  };",
          "}",
          "",
          "template <typename T>",
          "constexpr auto const_accessor(T& t){",
          "  return [&](int i){",
          "    return t.at(i);",
          "  };",
          "}",
          "",
          "template <typename T>",
          "constexpr auto matrix_accessor(T& t){",
          "  return [&](int i, int j) -> typename T::value_type::reference{",
          "    return t.at(i).at(j);",
          "  };",
          "}",
          "",
          "template <typename T>",
          "constexpr auto matrix_accessor(const T& t){",
          "  return [&](int i, int j) {",
          "    return t.at(i).at(j);",
          "  };",
          "}",
          "",
          "template <typename T>",
          "constexpr auto const_matrix_accessor(T& t){",
          "  return [&](int i, int j) {",
          "    return t.at(i).at(j);",
          "  };",
          "}",
          "",
          "template <typename T>",
          "using lmt = std::numeric_limits<T>;",
          "",
          "template <typename T, std::size_t N>",
          "constexpr std::size_t array_size(const T (&)[N]) noexcept{",
          "  return N;",
          "}",
          "",
          "",
        },
      },
    },
    main = {
      c {
        t {
          "int main(){",
          "}",
        },
        t {
          "int main(int argc, char** argv){",
          "}",
        },
      },
    },
    dsu = {
      t {
        "class dsu {",
        " private:",
        "  using ll = long long;",
        "  std::vector<ll> parent_;",
        "  std::vector<ll> size_;",
        "",
        " public:",
        "  dsu(ll n) : parent_(n), size_(n, 1) {",
        "    std::iota(std::begin(parent_), std::end(parent_), 0);",
        "  }",
        "",
        "  ll find(ll n) {",
        "    if (parent_[n] == n) return n;",
        "    return parent_[n] = find(parent_[n]);",
        "  }",
        "",
        "  void combine(ll x, ll y) {",
        "    auto const px = find(x);",
        "    auto const py = find(y);",
        "    if (px == py) return;",
        "    if (size_[px] >= size_[py]) {",
        "      size_[px] += size_[py];",
        "      parent_[py] = px;",
        "    } else {",
        "      size_[py] += size_[px];",
        "      parent_[px] = py;",
        "    }",
        "  }",
        "",
        "  auto size(ll n) { return size_[find(n)]; }",
        "};",
      },
    },
    cf = {
      t {
        "#include <algorithm>",
        "#include <array>",
        "#include <bitset>",
        "#include <chrono>",
        "#include <cmath>",
        "#include <deque>",
        "#include <iostream>",
        "#include <iterator>",
        "#include <limits>",
        "#include <map>",
        "#include <numeric>",
        "#include <optional>",
        "#include <queue>",
        "#include <set>",
        "#include <stack>",
        "#include <unordered_map>",
        "#include <unordered_set>",
        "#include <vector>",
        "",
        "struct custom_hash {",
        "  static uint64_t splitmix64(uint64_t x) {",
        "    x += 0x9e3779b97f4a7c15;",
        "    x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;",
        "    x = (x ^ (x >> 27)) * 0x94d049bb133111eb;",
        "    return x ^ (x >> 31);",
        "  }",
        "",
        "  size_t operator()(uint64_t x) const {",
        "    static const uint64_t FIXED_RANDOM =",
        "        std::chrono::steady_clock::now().time_since_epoch().count();",
        "    return splitmix64(x + FIXED_RANDOM);",
        "  }",
        "};",
        "",
        "using ll = long long;",
        "constexpr ll mod = 1e9 + 7;",
        "",
        "using safe_set = std::unordered_set<ll, custom_hash>;",
        "",
        "template <typename T> using safe_map = std::unordered_map<ll, T>;",
        "",
        "template <typename T> T read() {",
        "  T t;",
        "  std::cin >> t;",
        "  return t;",
        "}",
        "",
        "template <typename T> std::vector<T> read_vec(int n) {",
        "  std::vector<T> vec(n);",
        "  for (auto &ele : vec)",
        "    std::cin >> ele;",
        "  return vec;",
        "}",
        "",
        "template <typename T> auto read_matrix(int m, int n) {",
        "  std::vector<std::vector<T>> vec(m, std::vector<T>(n));",
        "  for (int i = 0; i < m; ++i) {",
        "    for (int j = 0; j < n; ++j) {",
        "      std::cin >> vec[i][j];",
        "    }",
        "  }",
        "  return vec;",
        "}",
        "",
        "auto solve() {}",
        "",
        "int main() {",
        "  auto t = read<ll>();",
        "  while (t--) {",
        "  }",
        "}",
      },
    },
    rng = {
      t {
        "template <typename T, typename AssociativeFunc>",
        "auto range_query(std::vector<T> const &nums, AssociativeFunc &&func,",
        "                 T const &init) {",
        "  constexpr static auto const k = 25;",
        "  auto const n = std::size(nums);",
        "  std::vector rng(k + 1, std::vector(n, init));",
        "  rng[0] = nums;",
        "  for (ll i = 1; i <= k; ++i) {",
        "    auto const len = 1 << i;",
        "    auto const prev_len = 1 << (i - 1);",
        "    for (ll j = 0; j + len - 1 < n; ++j) {",
        "      rng[i][j] = func(rng[i - 1][j], rng[i - 1][j + prev_len]);",
        "    }",
        "  }",
        "  return [rng = std::move(rng), func = std::forward<AssociativeFunc>(func),",
        "          init](ll a, ll b) {",
        "    auto const len = (b - a + 1);",
        "    std::bitset<k + 1> bs(len);",
        "    auto res = init;",
        "    auto pos = a;",
        "    for (ll i = 0; i <= k; ++i) {",
        "      if (bs[i]) {",
        "        res = func(res, rng[i][pos]);",
        "        pos += (1 << i);",
        "      }",
        "    }",
        "    return res;",
        "  };",
        "}",
      },
    },
    rng_i = {
      t {
        "auto calc_log2(ll n) { return __builtin_clzll(1) - __builtin_clzll(n); }",
        "",
        "template <typename T, typename AssociativeFunc>",
        "auto range_query_idempotent(std::vector<T> const &nums,",
        "                            AssociativeFunc &&func) {",
        "  constexpr static auto const k = 25;",
        "  auto const n = std::size(nums);",
        "  std::vector rng(k + 1, std::vector<T>(n));",
        "  rng[0] = nums;",
        "  for (ll i = 1; i <= k; ++i) {",
        "    auto const len = 1 << i;",
        "    auto const prev_len = 1 << (i - 1);",
        "    for (ll j = 0; j + len - 1 < n; ++j) {",
        "      rng[i][j] = func(rng[i - 1][j], rng[i - 1][j + prev_len]);",
        "    }",
        "  }",
        "  return [rng = std::move(rng),",
        "          func = std::forward<AssociativeFunc>(func)](ll a, ll b) {",
        "    auto const len = (b - a + 1);",
        "    auto const i = calc_log2(len);",
        "    return func(rng[i][a], rng[i][b - (1 << i) + 1]);",
        "  };",
        "}",
      },
    },
    compute_time = {
      t {

        "template <typename F> auto computeTime(F &&f) {",
        "  using namespace std::chrono;",
        "  auto start = high_resolution_clock::now();",
        "  f();",
        "  auto stop = high_resolution_clock::now();",
        "  return (stop - start).count();",
        "}",
      },
    },
    fenwick_tree = {
      t {
        "struct fenwick_tree {",
        "  std::vector<ll> bit;",
        "  ll n;",
        "",
        "  fenwick_tree(ll n) : bit(n), n(n) {}",
        "",
        "  fenwick_tree(std::vector<ll> a) : fenwick_tree(a.size()) {",
        "    for (size_t i = 0; i < a.size(); i++)",
        "      add(i, a[i]);",
        "  }",
        "",
        "  ll sum(ll r) {",
        "    ll ret = 0;",
        "    for (; r >= 0; r = (r & (r + 1)) - 1)",
        "      ret += bit[r];",
        "    return ret;",
        "  }",
        "",
        "  ll sum(ll l, ll r) { return sum(r) - sum(l - 1); }",
        "",
        "  void add(ll idx, ll delta) {",
        "    for (; idx < n; idx = idx | (idx + 1))",
        "      bit[idx] += delta;",
        "  }",
        "};",
      },
    },
    fenwick_tree_2d = {
      t {
        "struct fenwick_tree_2d {",
        "  std::vector<std::vector<ll>> bit;",
        "",
        "  fenwick_tree_2d(std::vector<std::vector<ll>> const &a)",
        "      : bit(a.size(), std::vector<ll>(a[0].size())) {",
        "    auto const m = a.size();",
        "    auto const n = a.size();",
        "    for (ll i = 0; i < m; ++i) {",
        "      for (ll j = 0; j < n; ++j) {",
        "        add(i, j, a[i][j]);",
        "      }",
        "    }",
        "  }",
        "",
        "  ll sum(ll x, ll y) {",
        "    ll ret = 0;",
        "    for (ll i = x; i >= 0; i = (i & (i + 1)) - 1)",
        "      for (ll j = y; j >= 0; j = (j & (j + 1)) - 1)",
        "        ret += bit[i][j];",
        "    return ret;",
        "  }",
        "",
        "  void add(ll x, ll y, char value) {",
        "    auto const m = bit.size();",
        "    auto const n = bit[0].size();",
        "    for (ll i = x; i < m; i = i | (i + 1))",
        "      for (ll j = y; j < n; j = j | (j + 1))",
        "        bit[i][j] += value;",
        "  }",
        "};",
      },
    },
    segment_tree = {
      t {
        "template <typename T, typename GroupFunc> class segment_tree {",
        "  GroupFunc func;",
        "  ll n;",
        "  std::vector<T> arr;",
        "",
        "public:",
        "  segment_tree(std::vector<T> const &arr, GroupFunc func)",
        "      : func(std::move(func)), n(std::size(arr)), arr(n * 4) {",
        "    build(1, 0, n - 1, arr);",
        "  }",
        "",
        "  T query(ll tl, ll tr) { return query(1, 0, n - 1, tl, tr); }",
        "",
        "  void update(ll i, T const &val) {",
        "    update(i, [val](auto e) { return val; });",
        "  }",
        "",
        "  template <typename F> void update(ll i, F &&f) { update(1, 0, n - 1, i, f); }",
        "",
        "private:",
        "  void build(ll i, ll l, ll r, std::vector<T> const &vec) {",
        "    if (l == r) {",
        "      arr[i] = vec[l];",
        "    } else {",
        "      auto const m = l + ((r - l) / 2);",
        "      build(2 * i, l, m, vec);",
        "      build(2 * i + 1, m + 1, r, vec);",
        "      arr[i] = func(arr[2 * i], arr[2 * i + 1]);",
        "    }",
        "  }",
        "",
        "  T query(ll i, ll l, ll r, ll tl, ll tr) {",
        "    if (l == tl && r == tr)",
        "      return arr[i];",
        "    auto const m = l + ((r - l) / 2);",
        "    if (tl >= l and tr <= m) {",
        "      return query(2 * i, l, m, tl, tr);",
        "    } else if (tl >= (m + 1) and tr <= r) {",
        "      return query(2 * i + 1, m + 1, r, tl, tr);",
        "    } else {",
        "      auto const left = query(2 * i, l, m, tl, m);",
        "      auto const right = query(2 * i + 1, m + 1, r, m + 1, tr);",
        "      return func(left, right);",
        "    }",
        "  }",
        "",
        "  template <typename F> void update(ll i, ll l, ll r, ll idx, F &&f) {",
        "    if (l == r) {",
        "      arr[i] = f(arr[i]);",
        "      return;",
        "    }",
        "    auto const m = l + ((r - l) / 2);",
        "    if (idx <= m) {",
        "      update(2 * i, l, m, idx, f);",
        "    } else {",
        "      update(2 * i + 1, m + 1, r, idx, f);",
        "    }",
        "    arr[i] = func(arr[2 * i], arr[2 * i + 1]);",
        "  }",
        "};",
        "",
        "template <typename T, typename GroupFunc>",
        "segment_tree(std::vector<T> const &, GroupFunc) -> segment_tree<T, GroupFunc>;",
      },
    },
    binary_search = {
      t {
        "template <typename Predicate>",
        "ll binary_search(ll low, ll high, Predicate &&predicate) {",
        "  if (low >= high)",
        "    return low;",
        "  auto const mid = low + (high - low) / 2;",
        "  if (predicate(mid)) {",
        "    return binary_search(mid + 1, high, predicate);",
        "  } else {",
        "    return binary_search(low, mid, predicate);",
        "  }",
        "}",
      },
    },
    power = {
      t {
        "ll power(ll n, ll x) {",
        "  if (x == 0)",
        "    return 1;",
        "  auto ans = power(n, x / 2);",
        "  ans = (ans * ans) % mod;",
        "  if (x % 2)",
        "    ans = (ans * n) % mod;",
        "  return ans;",
        "}",
      },
    },
    mod_power = {
      t {
        "ll mod_power(ll n, ll x, ll mod) {",
        "  if (x == 0)",
        "    return 1;",
        "  auto ans = mod_power(n, x / 2, mod);",
        "  ans = (ans * ans) % mod;",
        "  if (x % 2)",
        "    ans = (ans * n) % mod;",
        "  return ans;",
        "}",
      },
    },
    inv = {
      t {
        "ll inv(ll n, ll mod) { return mod_power(n, mod - 2, mod); }",
      },
    },
    gen_power = {
      t {
        "template <typename T, typename Op> T gen_power(T n, ll x, T unit, Op &&op) {",
        "  if (x == 0)",
        "    return unit;",
        "  auto ans = gen_power(n, x / 2, unit, op);",
        "  ans = op(ans, ans);",
        "  if (x % 2)",
        "    ans = op(n, ans);",
        "  return ans;",
        "}",
      },
    },
    print_matrix = {
      t {
        "void print_matrix(std::vector<std::vector<ll>> const &matrix) {",
        "  for (ll i = 0; i < matrix.size(); ++i) {",
        "    for (ll j = 0; j < matrix[0].size(); ++j) {",
        "      std::cout << matrix[i][j] << ' ';",
        "    }",
        "    std::cout << std::endl;",
        "  }",
        "}",
      },
    },
    mod_op = {
      t {
        "auto make_mod_plus(ll mod) {",
        "  return [mod](ll a, ll b) { return (a + b) % mod; };",
        "}",
        "",
        "auto make_mod_minus(ll mod) {",
        "  return [mod](ll a, ll b) { return (a - b + mod) % mod; };",
        "}",
        "",
        "auto make_mod_multiply(ll mod) {",
        "  return [mod](ll a, ll b) { return (a * b) % mod; };",
        "}",
        "",
        "// TODO: find out why this is more efficient than calling make_mod_plus",
        "auto mod_plus(ll a, ll b) { return (a + b) % mod; }",
        "auto mod_minus(ll a, ll b) { return (a - b + mod) % mod; }",
        "auto mod_multiply(ll a, ll b) { return (a * b) % mod; }",
      },
    },
    matrix_multiply = {
      t {
        "template <typename T = ll, typename BiOp = std::multiplies<>,",
        "          typename FoldOp = std::plus<>>",
        "auto matrix_multiply(std::vector<std::vector<T>> const &a,",
        "                     std::vector<std::vector<T>> const &b, T const &init = 0,",
        "                     BiOp &&biop = std::multiplies<>{},",
        "                     FoldOp &&foldop = std::plus<>{}) {",
        "  auto const n = std::size(a);",
        "  std::vector<std::vector<T>> matrix(n, std::vector<T>(n, init));",
        "  for (ll i = 0; i < n; ++i) {",
        "    for (ll j = 0; j < n; ++j) {",
        "      for (ll k = 0; k < n; ++k) {",
        "        matrix[i][j] = foldop(matrix[i][j], biop(a[i][k], b[k][j]));",
        "      }",
        "    }",
        "  }",
        "  return matrix;",
        "}",
        "",
        "template <typename T = ll, typename BiOp = std::multiplies<>,",
        "          typename FoldOp = std::plus<>>",
        "auto make_matrix_multiply(T init = 0, BiOp &&biop = std::multiplies<>{},",
        "                          FoldOp &&foldop = std::plus<>{}) {",
        "  return [biop, foldop, init](std::vector<std::vector<T>> const &a,",
        "                              std::vector<std::vector<T>> const &b) {",
        "    return matrix_multiply(a, b, init, biop, foldop);",
        "  };",
        "}",
      },
    },
    make_unit_matrix = {
      t {
        "auto make_unit_matrix(ll n) {",
        "  std::vector matrix(n, std::vector(n, 0ll));",
        "  for (ll i = 0; i < n; ++i)",
        "    matrix[i][i] = 1;",
        "  return matrix;",
        "}",
      },
    },
    gen_power_without_0 = {
      t {
        "template <typename T, typename Op> T gen_power_w0(T n, ll x, Op &&op) {",
        "  if (x == 1)",
        "    return n;",
        "  auto ans = gen_power_w0(n, x / 2, op);",
        "  ans = op(ans, ans);",
        "  if (x % 2)",
        "    ans = op(n, ans);",
        "  return ans;",
        "}",
      },
    },
    gcd_with_sign = {
      t {
        "ll gcd_with_sign(ll a, ll b) {",
        "  if (b == 0)",
        "    return a;",
        "  a %= b;",
        "  return gcd(b, a);",
        "}",
      },
    },
  }
)
