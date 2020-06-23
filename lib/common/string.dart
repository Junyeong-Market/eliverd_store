class TitleStrings {
  static final title = '엘리버드';
  static final homeTitle = '상점용 엘리버드';
  static final signUpTitle = '회원가입';
  static final storeSelectionTitle = '님의 사업장을 선택해주세요.';
  static final registerStoreTitle = '사업장 등록';
  static final addProductTitle = '재고 등록';
  static final updateProductTitle = '재고 수정';
}

class ErrorMessages {
  static final realnameInvalidMessage = '이름은 영어나 한글로 128자 이내만 가능합니다.';
  static final nicknameInvalidMessage = '닉네임은 영어, 한글, 숫자를 조합하여 50자 이내만 가능합니다.';
  static final nicknameDuplicatedMessage = '이미 존재하는 닉네임입니다. 다른 닉네임을 입력하세요.';
  static final userIdInvalidMessage = '아이디는 영어, 숫자를 조합하여 50자 이내만 가능합니다.';
  static final userIdDuplicatedMessage = '이미 존재하는 아이디입니다. 다른 아이디를 입력하세요.';
  static final passwordInvalidMessage =
      '비밀번호는 영어, 숫자, 특수문자를 조합하여 256자 이내만 가능합니다.';
  static final loginErrorMessage =
      '입력하신 계정은 존재하지 않는 계정입니다. 아이디와 비밀번호를 다시 입력해주세요.';

  static final signUpErrorMessage = '회원가입 요청 중 오류가 발생했습니다. 나중에 다시 시도해주세요.';
  static final disallowedToManageStoreMessage = '이 계정은 사업장을 관리할 수 없는 계정입니다. 다른 계정으로 시도해주세요.';
  static final signInErrorMessage = '로그인 요청 중 오류가 발생했습니다. 나중에 다시 시도해주세요.';

  static final noRegisteredBusinessMessage = '먼저 사업장을 등록하세요!';

  static final stocksCannotbeFetched = '네트워크 오류로 재고를 불러올 수 없습니다. 나중에 다시 시도해주세요.';
}

class SignInStrings {
  static final idText = '아이디';
  static final passwordText = '비밀번호';
  static final login = '로그인';
  static final notSignUp = '아직 회원이 아니십니까?';
}

class SignUpStrings {
  static final signUpButtonDesc = '가입하기';

  static final realnameHelperText = '영어나 한글로 128자 이내만 가능합니다.';
  static final nicknameHelperText = '영어, 한글, 숫자를 조합하여 50자 이내만 가능합니다.';
  static final userIdHelperText = '영어, 숫자를 조합하여 50자 이내만 가능합니다.';
  static final passwordHelperText = '영어, 숫자, 특수문자를 조합하여 256자 이내만 가능합니다.';

  static final realnameDescWhenImcompleted = '이름을 입력하세요.';
  static final nicknameDescWhenImcompleted = '닉네임을 입력하세요.';
  static final idDescWhenImcompleted = '아이디를 입력하세요.';
  static final passwordDescWhenImcompleted = '비밀번호를 입력하세요.';

  static final realnameDesc = '이름';
  static final nicknameDesc = '닉네임';
  static final idDesc = '아이디';
  static final passwordDesc = '비밀번호';
  static final isSellerDesc = '사업자이신가요?';
}

class StoreSelectionStrings {
  static final registerBtnDesc = '등록하러 가기';
}

class RegisterStoreStrings {
  static final registerBtnDesc = '등록하기';
}

class HomePageStrings {
  static final searchProductDesc = '재고 검색';
  static final addProductDesc = '재고 등록';
  static final updateProductDesc = '재고 수정';
  static final checkOutProductDesc = '상품 결제';
  static final deleteProductDesc = '재고 폐기';
}

class ProductStrings {
  static final barcodeDescWhenImcompleted = '바코드가 있다면 등록하세요.';
  static final nameDescWhenImcompleted = '상품 이름을 입력하세요.';
  static final priceDescWhenImcompleted = '상품 가격을 입력하세요.';
  static final manufacturerDescWhenImcompleted = '제조사를 입력하세요.';
  static final amountDescWhenImcompleted = '현재 재고 수를 입력하세요.';

  static final barcodeDescWhenUpdate = '바코드 수정 시 클릭하세요.';
  static final nameDescWhenUpdate = '상품 이름을 수정하세요.';
  static final priceDescWhenUpdate = '상품 가격을 수정하세요.';
  static final manufacturerDescWhenUpdate = '제조사를 수정하세요.';
  static final amountDescWhenUpdate = '재고 수를 수정하세요.';

  static final noBarcodeDesc = '바코드 없음';
  static final barcodeDesc = '바코드';
  static final nameDesc = '상품 이름';
  static final priceDesc = '상품 가격';
  static final manufacturerDesc = '제조사';
  static final amountDesc = '재고 수';

  static final deleteWarningContent = '한 번 삭제하면 영원히 복구할 수 없습니다.';
  static final cancel = '취소';
  static final next = '다음';
  static final submit = '완료';
  static final delete = '삭제';
}
