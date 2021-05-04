class GqlOperation {
  static final String REGISTER_QUERY = '''
    mutation registerAccount(\$data: CreateUserInput!) {
      register(data: \$data){
        token
        user{
          email
          username
          phonenumber
        }
      }
    }
  ''';

  static final String LOGIN_GQL_QUERY = '''
    mutation login(\$data: LoginInput!) {
        login(data: \$data) {
          user {
            username
            phonenumber
          }
          token
        }
      }
  ''';
}
