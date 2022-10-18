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
        "template <typename T> std::vector<T> read_matrix(int m, int n) {",
        "  std::vector<std::vector<T>> vec(m, std::vector<T>(n));",
        "  for (int i = 0; i < m; ++i) {",
        "    for (int j = 0; j < n; ++j) {",
        "      std::cin >> vec[i][j];",
        "    }",
        "  }",
        "  return vec;",
        "}",
        "",
        "using ll = long long;",
        "",
        "int main() {",
        "  auto t = read<int>();",
        "  while (t--) {",
        "  }",
        "}",
      },
    },
  }
)
