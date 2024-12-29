import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column({ space: 10 }) {
      Button('前往登录页')
        .width('80%')
        .onClick(() => {
          router.pushUrl({ url: 'pages/Home' });
        });
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center);
  }
}