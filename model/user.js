if (typeof _$jscoverage === 'undefined') _$jscoverage = {};
if ((typeof global !== 'undefined') && (typeof global._$jscoverage === 'undefined')) {
    global._$jscoverage = _$jscoverage
} else if ((typeof window !== 'undefined') && (typeof window._$jscoverage === 'undefined')) {
    window._$jscoverage = _$jscoverage
}
if (! _$jscoverage["src/model/user.coffee"]) {
    _$jscoverage["src/model/user.coffee"] = [];
    _$jscoverage["src/model/user.coffee"][1] = 0;
    _$jscoverage["src/model/user.coffee"][2] = 0;
    _$jscoverage["src/model/user.coffee"][5] = 0;
    _$jscoverage["src/model/user.coffee"][6] = 0;
    _$jscoverage["src/model/user.coffee"][9] = 0;
}

_$jscoverage["src/model/user.coffee"].source = ["class User", "  constructor: (@email) ->", "", "  login: (password) ->", "    return true if password is 'p4ss'", "    false", "", "", "module.exports = User"];

(function() {
  var User;

  _$jscoverage["src/model/user.coffee"][1]++;

  User = (function() {
    _$jscoverage["src/model/user.coffee"][2]++;

    function User(email) {
      this.email = email;
    }

    User.prototype.login = function(password) {
      _$jscoverage["src/model/user.coffee"][5]++;
      if (password === 'p4ss') {
        return true;
      }
      _$jscoverage["src/model/user.coffee"][6]++;
      return false;
    };

    return User;

  })();

  _$jscoverage["src/model/user.coffee"][9]++;

  module.exports = User;

}).call(this);
