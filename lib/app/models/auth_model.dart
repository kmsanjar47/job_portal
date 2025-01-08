class LoginParamsModel {
    String? username;
    String? password;

    LoginParamsModel( {
        this.username, this.password
    });

  LoginParamsModel.fromJson(
    Map<String, dynamic> json)

    {
        username = json['username'];
        password = json['password'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['username'] = this.username;
        data['password'] = this.password;
        return data;
    }
}
