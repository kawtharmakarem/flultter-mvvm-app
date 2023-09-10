enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
}

class ResponseCode {
  static const String SUCCESS = "success";//success with data
  static const String BAD_REQUEST = "success"; //success with no data
  static const String NO_CONTENT = "Bad request,Try again later";  //failure Api rejected request
  static const String UNAUTHORISED = "User is unauthoriSed , Try again later";  //failure ,user is not authorized
  static const String INTERNAL_SERVER_ERROR = "Something went wrong ,Try again later"; //faliure crache in server
    static const String FORBIDDEN = "Forbidden , Try again later"; // failure api rejected request

//local status code
  static const String CONNECT_TIMEOUT = "Time out error ,Try again later";
  static const String CANCEL = "Request was cancelled ,Try again later";
  static const String RECIEVE_TIMEOUT = "Time out error ,Try again later";
  static const String SEND_TIMEOUT = "Time out error ,Try again later";
  static const String CACHE_ERROR = "Cache error ,Try again later";
  static const String NO_INTERNET_CONNECTION = "Please check your internet connection";
    static const String UNKNOWN = "Something went wrong ,Try again later";

}
class ResponseMessage{

}
