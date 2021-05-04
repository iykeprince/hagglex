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

  static final String SEND_VERIFICATION_CODE = ''' 
    query sendCode(\$data: EmailInput) {
      resendVerificationCode(data: \$data) 
      
    }
  ''';

  static final String VERIFY_CODE = '''
    mutation verifyCode(\$data:VerifyUserInput) {
      verifyUser(data:\$data){
        token
        user{
          username
          email
        }
      }
    }
  ''';
}
