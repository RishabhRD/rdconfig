using ll = long long;

// codeforces template  {{{
// vim: foldmethod=marker
#include <algorithm>
#include <array>
#include <bitset>
#include <chrono>
#include <cmath>
#include <deque>
#include <iomanip>
#include <iostream>
#include <iterator>
#include <limits>
#include <map>
#include <numeric>
#include <optional>
#include <queue>
#include <ranges>
#include <set>
#include <sstream>
#include <stack>
#include <unordered_map>
#include <unordered_set>
#include <vector>

// hashing {{{
struct custom_hash {
  static uint64_t splitmix64(uint64_t x) {
    x += 0x9e3779b97f4a7c15;
    x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;
    x = (x ^ (x >> 27)) * 0x94d049bb133111eb;
    return x ^ (x >> 31);
  }

  size_t operator()(uint64_t x) const {
    static const uint64_t FIXED_RANDOM =
        std::chrono::steady_clock::now().time_since_epoch().count();
    return splitmix64(x + FIXED_RANDOM);
  }
};

using safe_set = std::unordered_set<ll, custom_hash>;

template <typename T> using safe_map = std::unordered_map<ll, T>;
// }}}

// ModInt {{{
namespace ModInt {
template <ll mod> class mod_int_t {
public:
  ll n;

  constexpr mod_int_t(ll n_arg = 0) noexcept : n((n_arg + mod) % mod) {}

  constexpr mod_int_t power(ll x) const noexcept {
    if (x == 0)
      return 1;
    auto ans = power(x / 2);
    ans.n = (ans.n * ans.n) % mod;
    if (x % 2)
      ans.n = (ans.n * n) % mod;
    return ans;
  }

  constexpr mod_int_t inv() const noexcept { return power(mod - 2); }
};

template <ll mod>
constexpr mod_int_t<mod> &operator++(mod_int_t<mod> &a) noexcept {
  a.n = (a.n + 1) % mod;
  return a;
}

template <ll mod>
constexpr mod_int_t<mod> operator++(mod_int_t<mod> &a, int) noexcept {
  auto ans = a;
  a.n = (a.n + 1) % mod;
  return ans;
}

template <ll mod>
constexpr mod_int_t<mod> &operator--(mod_int_t<mod> &a) noexcept {
  a.n = (a.n - 1 + mod) % mod;
  return a;
}

template <ll mod>
constexpr mod_int_t<mod> operator--(mod_int_t<mod> &a, int) noexcept {
  auto ans = a;
  a.n = (a.n - 1 + mod) % mod;
  return ans;
}

template <ll mod>
constexpr mod_int_t<mod> operator+(mod_int_t<mod> a,
                                   mod_int_t<mod> b) noexcept {
  return (a.n + b.n) % mod;
}

template <ll mod>
constexpr mod_int_t<mod> &operator+=(mod_int_t<mod> &a,
                                     mod_int_t<mod> b) noexcept {
  a = a + b;
  return a;
}

template <ll mod>
constexpr mod_int_t<mod> operator-(mod_int_t<mod> a,
                                   mod_int_t<mod> b) noexcept {
  return (a.n - b.n + mod) % mod;
}

template <ll mod>
constexpr mod_int_t<mod> &operator-=(mod_int_t<mod> &a,
                                     mod_int_t<mod> b) noexcept {
  a = a - b;
  return a;
}

template <ll mod>
constexpr mod_int_t<mod> operator*(mod_int_t<mod> a,
                                   mod_int_t<mod> b) noexcept {
  return (a.n * b.n) % mod;
}

template <ll mod>
constexpr mod_int_t<mod> &operator*=(mod_int_t<mod> &a,
                                     mod_int_t<mod> b) noexcept {
  a = a * b;
  return a;
}

template <ll mod>
constexpr mod_int_t<mod> operator/(mod_int_t<mod> a,
                                   mod_int_t<mod> b) noexcept {
  return a * b.inv();
}

template <ll mod>
constexpr mod_int_t<mod> &operator/=(mod_int_t<mod> &a,
                                     mod_int_t<mod> b) noexcept {
  a = a / b;
  return a;
}

template <ll mod>
constexpr std::ostream &operator<<(std::ostream &os,
                                   mod_int_t<mod> b) noexcept {
  os << b.n;
  return os;
}

template <ll mod>
constexpr std::istream &operator>>(std::istream &in,
                                   mod_int_t<mod> &b) noexcept {
  in >> b.n;
  b.n = (b.n + mod) % mod;
  return in;
}
} // namespace ModInt
// }}}

constexpr char endl = '\n';
template <typename T> using limits = std::numeric_limits<T>;

template <typename T> using matrix_t = std::vector<std::vector<T>>;
template <typename T> using cuboid_t = std::vector<std::vector<std::vector<T>>>;

// IO {{{
template <typename T> T read() {
  T t;
  std::cin >> t;
  return t;
}

template <typename T> std::vector<T> read_vec(int n) {
  std::vector<T> vec(n);
  for (auto &ele : vec)
    std::cin >> ele;
  return vec;
}

template <typename T> auto read_matrix(int m, int n) {
  std::vector<std::vector<T>> vec(m, std::vector<T>(n));
  for (int i = 0; i < m; ++i) {
    for (int j = 0; j < n; ++j) {
      std::cin >> vec[i][j];
    }
  }
  return vec;
}

bool log_enabled = true;

class log_t {};

template <typename T> auto operator<<(log_t const &self, T const &ele) {
  if (log_enabled) {
    std::cerr << ele;
  }
  return self;
};

auto operator<<(log_t const &self, std::ostream &(*f)(std::ostream &)) {
  if (log_enabled) {
    std::cerr << f;
  }
  return self;
};

constexpr log_t slog{};
// }}}

namespace rng = std::ranges; // NOLINT
namespace vw = std::views;   // NOLINT

template <typename T> struct cast_to {
  auto operator()(auto &&e) { return static_cast<T>(e); }
};

// functional {{{
namespace rd {
#define lift(func)                                                             \
  [](auto &&...args) noexcept(noexcept(func(std::forward<decltype(args)>(      \
      args)...))) -> decltype(func(std::forward<decltype(args)>(args)...)) {   \
    return func(std::forward<decltype(args)>(args)...);                        \
  }
template <class F, class... Args>
constexpr auto bind_back(F &&f, Args &&...args) {
  return [ f_ = std::forward<F>(f),
           ... args_ = std::forward<Args>(args) ](auto &&...other_args)
    requires std::invocable<F &, decltype(other_args)..., Args &...>
  {
    return std::invoke(f_, std::forward<decltype(other_args)>(other_args)...,
                       args_...);
  };
}
} // namespace rd

namespace rd {
template <class F, class G> struct compose_fn {
  [[no_unique_address]] F f;
  [[no_unique_address]] G g;

  template <class A, class B>
  compose_fn(A &&a, B &&b) : f(std::forward<A>(a)), g(std::forward<B>(b)) {}

  template <class A, class B, class... Args>
  static constexpr auto call(A &&a, B &&b, Args &&...args) {
    if constexpr (std::is_void_v<std::invoke_result_t<G, Args...>>) {
      std::invoke(std::forward<B>(b), std::forward<Args>(args)...);
      return std::invoke(std::forward<A>(a));
    } else {
      return std::invoke(
          std::forward<A>(a),
          std::invoke(std::forward<B>(b), std::forward<Args>(args)...));
    }
  }

  template <class... Args> constexpr auto operator()(Args &&...args) & {
    return call(f, g, std::forward<Args>(args)...);
  }

  template <class... Args> constexpr auto operator()(Args &&...args) const & {
    return call(f, g, std::forward<Args>(args)...);
  }

  template <class... Args> constexpr auto operator()(Args &&...args) && {
    return call(std::move(f), std::move(g), std::forward<Args>(args)...);
  }

  template <class... Args> constexpr auto operator()(Args &&...args) const && {
    return call(std::move(f), std::move(g), std::forward<Args>(args)...);
  }
};

template <class F, class G> constexpr auto compose(F &&f, G &&g) {
  return compose_fn<std::remove_cvref_t<F>, std::remove_cvref_t<G>>(
      std::forward<F>(f), std::forward<G>(g));
}

template <typename F> struct pipeable {
private:
  F f;

public:
  constexpr explicit pipeable(F &&f_p) noexcept : f(std::forward<F>(f_p)) {}

  template <typename... Xs>
    requires std::invocable<F, Xs...>
  constexpr auto operator()(Xs &&...xs) const {
    return std::invoke(f, std::forward<Xs>(xs)...);
  }

  template <typename... Xs> constexpr auto operator()(Xs &&...xs) const {
    using FType = decltype(rd::bind_back(f, std::forward<Xs>(xs)...));
    return pipeable<FType>{rd::bind_back(f, std::forward<Xs>(xs)...)};
  }

  template <typename F1, typename F2>
  friend constexpr auto operator|(pipeable<F1> p1, pipeable<F2> p2);
};

template <typename Arg, typename F>
constexpr auto operator|(Arg &&arg, pipeable<F> const &p)
  requires std::invocable<F, Arg &&>
{
  return std::invoke(p, std::forward<Arg>(arg));
}

template <typename F1, typename F2>
constexpr auto operator|(pipeable<F1> p1, pipeable<F2> p2) {
  return pipeable{rd::compose(p2.f, p1.f)};
}

template <typename F> struct curried {
private:
  F f;

public:
  constexpr explicit curried(F &&f_p) noexcept : f(std::forward<F>(f_p)) {}

  template <typename... Xs>
    requires std::invocable<F, Xs...>
  constexpr auto operator()(Xs &&...xs) const {
    return std::invoke(f, std::forward<Xs>(xs)...);
  }

  template <typename... Xs> constexpr auto operator()(Xs &&...xs) const {
    using FType = decltype(std::bind_front(f, std::forward<Xs>(xs)...));
    return curried<FType>{std::bind_front(f, std::forward<Xs>(xs)...)};
  }
};

auto s_comb = rd::curried(
    [](auto &&f, auto ele) requires std::invocable<decltype(f), decltype(ele)> {
      return std::pair{ele, std::invoke(f, ele)};
    });
} // namespace rd

// }}}

// rd::to {{{
namespace rd {
namespace detail {
template <class C, class R>
concept reservable = std::ranges::sized_range<R> && requires(C &c, R &&rng) {
  { c.capacity() } -> std::same_as<std::ranges::range_size_t<C>>;
  { c.reserve(std::ranges::range_size_t<R>(0)) };
};

template <class C>
concept insertable = requires(C c) { std::inserter(c, std::ranges::end(c)); };

template <class> constexpr inline bool always_false = false;

// R is a nested range that can be converted to the nested container C
template <class C, class R>
concept matroshkable =
    std::ranges::input_range<C> && std::ranges::input_range<R> &&
    std::ranges::input_range<std::ranges::range_value_t<C>> &&
    std::ranges::input_range<std::ranges::range_value_t<R>> &&
    !std::ranges::view<std::ranges::range_value_t<C>> &&
    std::indirectly_copyable<
        std::ranges::iterator_t<std::ranges::range_value_t<R>>,
        std::ranges::iterator_t<std::ranges::range_value_t<C>>> &&
    detail::insertable<C>;

template <std::ranges::input_range R> struct fake_input_iterator {
  using iterator_category = std::input_iterator_tag;
  using value_type = std::ranges::range_value_t<R>;
  using difference_type = std::ranges::range_difference_t<R>;
  using pointer = std::ranges::range_value_t<R> *;
  using reference = std::ranges::range_reference_t<R>;
  reference operator*();
  fake_input_iterator &operator++();
  fake_input_iterator operator++(int);
  fake_input_iterator() = default;
  friend bool operator==(fake_input_iterator a, fake_input_iterator b) {
    return false;
  }
};

template <template <typename...> typename C, std::ranges::input_range R,
          typename... Args>
struct ctad_container {
  template <class V = R>
  static auto deduce(int)
      -> decltype(C(std::declval<V>(), std::declval<Args>()...));

  template <class Iter = fake_input_iterator<R>>
  static auto deduce(...)
      -> decltype(C(std::declval<Iter>(), std::declval<Iter>(),
                    std::declval<Args>()...));

  using type = decltype(deduce(0));
};
} // namespace detail

template <std::ranges::input_range C, std::ranges::input_range R,
          typename... Args>
  requires(!std::ranges::view<C>)
constexpr C to(R &&r, Args &&...args) {
  // Construct from range
  if constexpr (std::constructible_from<C, R, Args...>) {
    return C(std::forward<R>(r), std::forward<Args>(args)...);
  }
  // Construct and copy (potentially reserving memory)
  else if constexpr (std::constructible_from<C, Args...> &&
                     std::indirectly_copyable<std::ranges::iterator_t<R>,
                                              std::ranges::iterator_t<C>> &&
                     detail::insertable<C>) {
    C c(std::forward<Args>(args)...);
    if constexpr (std::ranges::sized_range<R> && detail::reservable<C, R>) {
      c.reserve(std::ranges::size(r));
    }
    std::ranges::copy(r, std::inserter(c, std::end(c)));
    return c;
  }
  // Nested case
  else if constexpr (detail::matroshkable<C, R>) {
    C c(std::forward<Args...>(args)...);
    if constexpr (std::ranges::sized_range<R> && detail::reservable<C, R>) {
      c.reserve(std::ranges::size(r));
    }
    auto v = r | std::views::transform([](auto &&elem) {
               return rd::to<std::ranges::range_value_t<C>>(elem);
             });
    std::ranges::copy(v, std::inserter(c, std::end(c)));
    return c;
  }
  // Construct from iterators
  else if constexpr (std::constructible_from<C, std::ranges::iterator_t<R>,
                                             std::ranges::sentinel_t<R>,
                                             Args...>) {
    return C(std::ranges::begin(r), std::ranges::end(r),
             std::forward<Args>(args)...);
  } else {
    static_assert(detail::always_false<C>, "C is not constructible from R");
  }
}

template <
    template <typename...> typename C, std::ranges::input_range R,
    typename... Args,
    class ContainerType = typename detail::ctad_container<C, R, Args...>::type>
constexpr auto to(R &&r, Args &&...args) -> ContainerType {
  return rd::to<ContainerType>(std::forward<R>(r), std::forward<Args>(args)...);
}

namespace detail {
template <std::ranges::input_range C, class... Args> struct closure_range {
  template <class... A>
  closure_range(A &&...as) : args_(std::forward<A>(as)...) {}
  std::tuple<Args...> args_;
};

template <std::ranges::input_range R, std::ranges::input_range C, class... Args>
auto constexpr operator|(R &&r, closure_range<C, Args...> &&c) {
  return std::apply(
      [&r](auto &&...inner_args) {
        return rd::to<C>(std::forward<R>(r),
                         std::forward<decltype(inner_args)>(inner_args)...);
      },
      std::move(c.args_));
}

template <template <class...> class C, class... Args> struct closure_ctad {
  template <class... A>
  closure_ctad(A &&...as) : args_(std::forward<A>(as)...) {}
  std::tuple<Args...> args_;
};

template <std::ranges::input_range R, template <class...> class C,
          class... Args>
auto constexpr operator|(R &&r, closure_ctad<C, Args...> &&c) {
  return std::apply(
      [&r](auto &&...inner_args) { return rd::to<C>(std::forward<R>(r)); },
      std::move(c.args_));
}

} // namespace detail

template <template <typename...> typename C, class... Args>
constexpr auto to(Args &&...args) {
  return detail::closure_ctad<C, Args...>{std::forward<Args>(args)...};
}

template <std::ranges::input_range C, class... Args>
constexpr auto to(Args &&...args) {
  return detail::closure_range<C, Args...>{std::forward<Args>(args)...};
}
} // namespace rd
// }}}

// group by {{{
namespace rd {

namespace detail {
template <typename T> class wrapper {
  T val_;

public:
  wrapper() = default;
  wrapper(T val) : val_(std::move(val)) {}

  constexpr T const *operator->() const { return std::addressof(val_); }
  constexpr T *operator->() { return std::addressof(val_); }
  constexpr T const &operator*() const { return val_; }
  constexpr T &operator*() { return val_; }

  constexpr explicit operator bool() const noexcept { return true; }
  constexpr bool has_value() const noexcept { return true; }
};

template <typename T> class semiregular {
  std::optional<T> val_;

public:
  semiregular() : val_(std::in_place) {}
  constexpr semiregular(T t) : val_(std::move(t)) {}

  constexpr semiregular(semiregular const &) = default;
  constexpr semiregular(semiregular &&) = default;

  constexpr semiregular &operator=(semiregular const &other) {
    if (this != std::addressof(other)) {
      if (other)
        emplace(*other);
      else
        reset();
    }
    return *this;
  }

  constexpr semiregular &operator=(semiregular &&other) {
    if (this != std::addressof(other)) {
      if (other)
        emplace(std::move(*other));
      else
        reset();
    }
    return *this;
  }

  constexpr void reset() { val_.reset(); }

  constexpr T const *operator->() const { return std::addressof(val_.value()); }
  constexpr T *operator->() { return std::addressof(val_.value()); }
  constexpr T const &operator*() const { return val_.value(); }
  constexpr T &operator*() { return val_.value(); }

  constexpr explicit operator bool() const noexcept { return val_.has_value(); }
  constexpr bool has_value() const noexcept { return val_.has_value(); }

  template <typename... Args> constexpr T &emplace(Args &&...args) {
    val_.emplace(std::forward<Args>(args)...);
    return val_.value();
  }
};
} // namespace detail

template <typename T>
using semiregular_box_t =
    typename std::conditional<std::semiregular<T>, detail::wrapper<T>,
                              detail::semiregular<T>>::type;

namespace detail {
class group_by_sentinal_t {};

template <typename Iter, typename F> class group_by_iterator {
public:
  using iterator_category = std::forward_iterator_tag;
  using value_type = std::ranges::subrange<Iter, Iter>;
  using difference_type = long long;

  group_by_iterator(Iter begin, Iter end, F f) : begin(begin), end(end), f(f) {}
  // TODO: Bug in codeforces, this default initializable not required
  group_by_iterator() = default;

  value_type operator*() const { return {begin, compute_end()}; }

  group_by_iterator &operator++() {
    begin = compute_end();
    cached_end = std::nullopt;
    return *this;
  }

  group_by_iterator operator++(int) const {
    auto cur = *this;
    begin = compute_end();
    cached_end = std::nullopt;
    return cur;
  }

  bool operator==(group_by_iterator const &other) const {
    return begin == other.begin && end == other.end;
  }

  bool operator==(group_by_sentinal_t) const { return begin == end; }

private:
  Iter compute_end() const {
    if (cached_end.has_value())
      return cached_end.value();
    if (begin == end) {
      return end;
    }
    Iter prev = begin;
    Iter cur = std::next(prev);
    while (cur != end) {
      if ((*f)(*prev, *cur)) {
        prev = cur;
        ++cur;
      } else {
        break;
      }
    }
    cached_end = cur;
    return cur;
  }

  Iter begin;
  Iter end;
  mutable std::optional<Iter> cached_end;
  semiregular_box_t<F> f;
};

struct _group_by_fn {
  template <typename Iter, typename F>
  auto operator()(Iter begin, Iter end, F &&f) const {
    using namespace detail;
    return std::ranges::subrange{group_by_iterator<Iter, F>{begin, end, f},
                                 group_by_sentinal_t{}};
  }

  template <typename Range, typename F>
  auto operator()(Range &&rng, F f) const {
    using namespace detail;
    using Iter = decltype(begin(std::declval<Range>()));
    return std::ranges::subrange<group_by_iterator<Iter, F>,
                                 group_by_sentinal_t>(
        group_by_iterator<Iter, F>{begin(rng), end(rng), std::move(f)},
        group_by_sentinal_t{});
  }
};
} // namespace detail
constexpr auto group_by = rd::pipeable{detail::_group_by_fn{}};
} // namespace rd
// group by }}}

// mutation to transformation {{{
auto make_sorted =
    rd::pipeable([]<typename Container, typename Comparator = std::less<>>(
        Container vec, Comparator &&cmp = std::less<>{}) {
      rng::sort(vec, std::forward<Comparator>(cmp));
      return vec;
    });

auto make_reversed = rd::pipeable([]<typename Container>(Container vec) {
  rng::reverse(vec);
  return vec;
});
// }}}

// fold {{{
namespace rd {
namespace detail {
struct foldl_t {
  constexpr auto operator()(auto &&rng, auto &&init, auto &&op) const {
    return std::accumulate(
        std::begin(vw::common(rng)), std::end(vw::common(rng)),
        std::forward<decltype(init)>(init), std::forward<decltype(op)>(op));
  }
};
} // namespace detail
constexpr auto foldl = rd::pipeable{detail::foldl_t{}};

namespace detail {
struct sum_t {
  constexpr auto operator()(auto &&rng) const {
    return foldl(std::forward<decltype(rng)>(rng),
                 rng::range_value_t<decltype(rng)>(0), std::plus<>{});
  }
};
}; // namespace detail
constexpr auto sum = rd::pipeable{detail::sum_t{}};

} // namespace rd
// }}}

// codeforces template }}}

constexpr ll mod = 1e9 + 7;
using mii = ModInt::mod_int_t<mod>;

auto solve(ll _t) {}

int main() {
  std::ios_base::sync_with_stdio(0);
  std::cin.tie(0);
  auto t = read<ll>();
  std::set<ll> enabled_for;
  for (ll i = 0; i < t; ++i) {
    if (enabled_for.count(i) || enabled_for.size() == 0) {
      log_enabled = true;
    } else {
      log_enabled = false;
    }
    solve(i);
  }
}
